# RES-006 — Microsite Date Rollover: Problem and Plan

**Status:** proposal, no code changed yet
**Related:** `RES-005-plan-year-gap.md`, `plan_gap.md`

## TL;DR

- Our microsite is pre-built HTML. Which plan year shows as "Current" or "Upcoming" is decided **when Lambda 2 runs**, using that day's date.
- Lambda 2 only runs when a new ZIP arrives. So nothing updates the site on the day a plan year actually starts or ends.
- Recommended fix: a **small daily scheduled job** that re-generates **only the employers whose menu would change today**. No invalidation needed for HTML.
- Each employer gets a tiny **state file** recording which menu its HTML was built with. The nightly job compares that with today's menu and regenerates only on a mismatch.
- Doing it "on the fly" at request time is not recommended. It is heavy and a poor fit for our static, private-S3 design.

## The problem

Take an employer with these plan years on 2026-09-25:

| Plan year | Dates | Menu today |
|---|---|---|
| Year 2 | 2025-11-01 to 2026-10-31 | Current |
| Year 3 | 2026-11-01 to 2027-10-31 | Upcoming |

On 2026-11-01 the site should show only Year 3, as "Current". But:

1. Lambda 2 decides current/upcoming from today's date (`lambda2-generate-site/src/navigation.py`), at generation time.
2. It runs only after a ZIP arrives (S3 upload -> Step Functions -> Lambda 1 -> Lambda 2).
3. No ZIP arrives on 2026-11-01. The HTML in S3 stays frozen, so members keep seeing Year 2 as "Current" and Year 3 as "Upcoming".

The old Symfony app built pages on each request, so it never had this problem.

This affects every employer, not only plan-year gaps. It also means the gap options (C1/D/B+guard) only look right on the day of the ZIP. Whichever gap option we choose, this problem has to be solved too.

There are three dates per plan year where the menu changes:

- 365 days before start: "Upcoming" appears
- Start date: "Upcoming" becomes "Current"
- Day after end date: "Current" expires

## What already helps

- HTML cache is 0 to 300 seconds in CloudFront (`module/aws/vbe_cdn/main.tf`, `vbe-html-cache`). Overwriting HTML in S3 shows up in at most ~5 minutes. **No invalidation needed for HTML.**
- PDFs under `files/` cache for 24 hours by default. A rollover job doesn't change PDFs, so this doesn't matter here.
- Lambda 2 already regenerates one employer from `data.json` alone (`generate.py:lambda_handler`, input `{ "employer_id": ... }`). We can reuse it as is.

## Options

### Option 1 — Daily batch job

An EventBridge schedule runs once a day and re-generates employers.

- **1a. Regenerate every employer daily.** Simplest.
  - Pros: easy to build and reason about, and it fixes drift of any kind.
  - Cons: wasted work, since most employers don't change on most days. Cost and run time grow with the number of employers. A single Lambda has a 15-minute limit, so it needs fan-out.
- **1b. Regenerate only employers whose menu changes today (recommended).**
  - Each night, for every employer, compute the menu for today (date math only, no rendering) and compare it with the menu the employer's HTML was **actually built with**, which is recorded in a small per-employer state file. If they differ, re-generate that employer.
  - Pros: little work per day, exact (no guessing from dates), a missed night fixes itself the next night, uses the same Lambda 2.
  - Cons: slightly more code, plus one small file per employer that Lambda 2 must write (see "Per-employer state").

### Option 2 — Fix it when someone visits

Re-generate or adjust the page at request time.

- Our site is private S3 behind CloudFront (OAC). There is no server in the request path.
- It would need Lambda@Edge or a Lambda origin. That is a new moving part, a new IAM and security surface, and cold-start latency on the first hit.
- The generated page is cached up to 5 minutes anyway, so "on the fly" would not be instant either.
- It costs compute on every request or cache miss, and it turns a static site into a dynamic one.
- CloudFront Functions can't read S3 or run our generator, so they can't do this.
- **Verdict:** possible, but heavy and risky for a problem that is predictable by date. Not recommended. See "Why not on-the-fly" below for the full reasoning.

### Option 3 — Per-employer scheduled events

Create one schedule per employer boundary date.

- Pros: runs exactly when needed.
- Cons: thousands of schedules to create, update and clean up whenever data changes. Fragile. Not recommended.

## Comparison

| | Complexity | Cost | Reliability | Fits our static design |
|---|---|---|---|---|
| 1a. Daily, all employers | Low | Grows with employer count | High | Yes |
| **1b. Daily, only changed** | **Medium** | **Low** | **High, with alarm** | **Yes** |
| 2. On request | High | Per request | Medium (cold starts, cache) | No |
| 3. Per-employer schedules | High | Low | Low | Partly |

## Why not on-the-fly (Option 2)

It is possible, but it is a poor fit. In short: it adds a new runtime to the request path, and still doesn't give an instant change.

### How the site works today

```
Member -> CloudFront -> (OAC, signed) -> private S3 bucket -> ready-made index.html
```

- S3 only returns files that already exist. No code runs per request.
- The bucket is private. Only CloudFront can read it (Origin Access Control, `module/aws/vbe_cdn/main.tf`).
- All decisions are made ahead of time, when Lambda 2 writes the HTML.
- The only code at the edge is the `append_index` CloudFront Function. It just adds `/index.html` to URLs. It can't read S3, read `data.json` or render templates.

### What on-the-fly would need

One of these, because something must run on each request:

1. **Lambda@Edge** (origin-request or origin-response). It must read `data.json`, work out current/upcoming for today and render the page.
2. **Lambda Function URL or API Gateway as a second origin.** Same rendering code, plus a new entry point to secure.

### Reasons it is a bad fit

1. **It doesn't fix the delay.** HTML is cached up to 300 seconds. Only the first request after a cache miss would run the code. Everyone else gets the cached copy. We pay for the complexity and still don't get "changes exactly at midnight".
2. **It adds new infrastructure.** Lambda@Edge must be deployed in us-east-1, has its own IAM role, size and time limits, and logs in many regions. The batch job uses the Lambda and Step Functions we already run.
3. **Members pay for it.** Cold starts and rendering time land on a real visitor's request. Today a visit is just a file read.
4. **Two code paths for one page.** Lambda 2 would build pages on a ZIP, and the edge code would build them on a visit. They can drift apart. Our golden fixtures (ADR-018) protect Lambda 2's output, not a second renderer.
5. **We'd have to ship the generator to the edge.** Jinja templates, `navigation.py`, the S3 storage layer and `data.json` reading would all need to be packaged and kept in sync. That cuts against the repo's "independent Lambdas" design.
6. **More cost, and it scales with traffic.** Compute runs per request or cache miss. A daily job runs once, for only the employers that changed.
7. **More to secure.** New IAM, a new public entry point (for option 2) and a larger attack surface, on a site that today has none.
8. **Harder to test and debug.** Behaviour depends on request time and cache state. A daily job is deterministic and can be replayed with a given date.
9. **Harder to roll back.** Removing edge code means changing the CloudFront distribution. Turning off a schedule is instant and leaves existing HTML as it is.
10. **The problem is predictable.** We know the exact dates when menus change. Work that can be scheduled doesn't need to run on every request.

### When on-the-fly would make sense

If content depended on something we can't know ahead of time, such as the logged-in user, an A/B test or live data. A date flip is not one of those.

### Verdict

The daily job gives the same visible result (within the cache window, a few hours of midnight at worst) with no new code in the request path. It is cheaper, simpler to run and easier to undo.

## Recommended plan: Option 1b

1. **Scheduler:** EventBridge Scheduler triggers a small "rollover" Lambda once a day, shortly after midnight.
2. **Fan-out check (20k+ employers):** a Step Functions Distributed Map splits the employer list into batches. Each worker Lambda, per employer:
   - reads `data.json` and the employer's `generation-state.json`,
   - builds today's menu with `Navigation(data, today)` and takes its current and upcoming plan years,
   - if they differ from the plan years in the state file (or the state file is missing), marks that employer for regeneration.
3. **Regenerate:** invoke the existing Lambda 2 with `{ "employer_id": ... }` for the marked employers only. Skip Lambda 1, since no new ZIP is involved. Cap concurrency (about 100 until the real peak-day number is known, see "Capacity plan") and retry failures.
4. **State write:** after Lambda 2 finishes writing all pages for an employer, it writes that employer's `generation-state.json`. This applies to every run, whether triggered by a ZIP or by the rollover job. No separate catch-up logic is needed: a missed night is caught the next night, because the stored menu still differs from today's. Optionally add a rare full regeneration as a safety net.
5. **No CloudFront invalidation for HTML.** Wait up to 5 minutes. Do not add invalidation for this job.
6. **Alerts:** CloudWatch alarm if the job fails or hasn't run in 25 hours. Log which employers were regenerated and why.
7. **Manual trigger:** expose the same job as an admin action in Lambda 3 for re-runs and testing.

## Decisions made

| Question | Decision | What it means |
|---|---|---|
| Scale | **20,000+ employers** | Option 1a (regenerate everyone daily) is ruled out. 1b is the plan. The nightly check itself must also fan out (see below). |
| "Today" boundary | **UTC** | Use `date.today()` in Lambda. Menus flip at 00:00 UTC, which is the evening before for US employers. Accepted. |
| Orphaned pages | **Do not delete, for now** | Revisit later (see risk below). |
| Ownership | **We own the scheduler and alarms** | IAM is handled in the separate RaaS repo. Out of scope here. |
| State | **Per-employer state file** | One small `generation-state.json` per employer, written by Lambda 2. No global "last run" file. See next section. |

Always: **never set `GENERATE_TODAY` in production.** The rollover job must use the real date.

## Per-employer state

### What it is

One small JSON file per employer, saying which menu the current HTML was built with:

```json
{
  "generated_on": "2026-10-31",
  "current_plan_year": "2025-11-01>2026-10-31",
  "upcoming_plan_year": "2026-11-01>2027-10-31"
}
```

- `generated_on`: the date Lambda 2 used as "today" (UTC). For information and debugging.
- `current_plan_year` / `upcoming_plan_year`: exactly what `Navigation` chose at that time. `upcoming_plan_year` is `null` when there is none.

### Where it lives

`<employerId>/generation-state.json` in the **assets bucket**, next to `data.json`.

- Not in the site (output) bucket. That bucket is served by CloudFront, so the file would be publicly readable.
- Lambda 2 only copies `<employerId>/files/` to the site bucket, so a file in the assets bucket is never published.

### Who writes it

Lambda 2, as the **last step** of `generate_employer`, after every page is written. If Lambda 2 fails part-way, the state file stays old, so the next nightly run retries that employer.

### How the nightly job uses it

For each employer:

1. Compute today's (current, upcoming) from `data.json`.
2. Read `generation-state.json`.
3. Same values: skip. Different values or no file: regenerate.

### Example

Same employer as before (Year A 2025-11-01 to 2026-10-31, Year B 2026-11-01 to 2027-10-31):

| Night | Today's menu | State file says | Action |
|---|---|---|---|
| 2026-10-31 | A, B | A, B | Skip |
| **2026-11-01** | **B, none** | A, B | **Regenerate.** Lambda 2 then writes state "B, none" |
| 2026-11-02 | B, none | B, none | Skip |

If the 11-01 run fails, the state still says "A, B". On 11-02 today's menu is still "B, none", so it mismatches and gets regenerated then. No extra catch-up logic.

### Why this beats a single global date

- Exact: it compares against what the HTML really shows, not against a guess from dates.
- No repeat work after a partial failure. Only the employers that failed get retried.
- A ZIP-triggered regeneration also updates the state, so the state is always right.
- It also catches employers that were missed for any other reason.

### What we must change

- **Lambda 2 code:** write the state file at the end of `generate_employer`.
- **Lambda 2 permissions:** today Lambda 2's role can only **read** the assets bucket (`ReadAssetBucket` in `module/aws/vbe_lambda/main.tf`). It needs `s3:PutObject` on the assets bucket. Scope it narrowly, for example to `*/generation-state.json`. This is the Lambda execution role in this repo, not the deployer role handled in the RaaS repo.
- **Golden tests:** the state file is not site output, so golden HTML is unaffected. Add a unit test that the state file is written, with the right values, after generation.
- **Local mode:** the same file is written under `local_data/assets/<eid>/`. It is git-ignored with the rest of `local_data/`.

### Cost

About 22,000 extra small reads per night, plus a write for each regeneration. S3 request charges for this are negligible (cents per month). The extra files are a few hundred bytes each.

### First rollout (backfill)

No employer has a state file at first. The job treats "no file" as "regenerate", which means one-time regeneration of everything:

- 22,000 x 20s = about 440,000 Lambda-seconds. At concurrency 100, about **73 minutes**.
- Recommended: run it off-peak, and either run it once manually or cap each night's missing-state regenerations (for example, 5,000 a night) so it drains over a few nights without competing with ZIP-driven runs.
- A side benefit: afterwards every employer's HTML is rebuilt with today's date and a state file.

## What 20,000+ employers changes

- **1a is too expensive.** 20k Lambda 2 runs a day, most of them producing identical pages. Each run also copies the employer's whole `files/` tree to the output bucket (`generate_employer` calls `copy_tree`). That is a lot of pointless S3 traffic.
- **The nightly check must fan out.** Reading 20k `data.json` files in one Lambda will not fit in its 15-minute limit. Use Step Functions Distributed Map over the employer list (or SQS with batches). Each worker checks a batch of employers and only regenerates those whose menu changed.
- **Regeneration should be bounded.** Limit concurrency (see "Capacity plan") so the S3 output bucket and Lambda concurrency are not flooded. Many employers share the same plan-year dates (for example, 1 Jan or 1 Nov renewals), so the first of a month can be heavy. Plan for a spike on those days.
- **Possible later optimisation (not for v1):** keep a small index of "next menu-change date" per employer, updated by Lambda 1 when `data.json` changes. The nightly job then reads the index instead of 20k `data.json` files. Only build this if the nightly scan proves slow or costly.
- **Possible later optimisation:** let a rollover regeneration skip the `files/` copy, since PDFs haven't changed. This needs a small flag on the Lambda 2 call. Measure first.

## Known risks we are accepting

- **Orphaned pages remain.** Lambda 2 only overwrites. When the menu shrinks (for example, "Upcoming" disappears on 2026-11-01), the old `/upcomingBenefits/...` HTML stays in S3. Nothing links to it, but it is reachable by direct URL and will show outdated content. We chose not to delete for now. Revisit if this causes confusion or a compliance concern.
- **UTC flip.** For about 5-8 hours around midnight UTC, a US member may see the new year a few hours "early". Accepted.

## Rollout and safety

- Start in dry-run mode: log which employers would be regenerated, change nothing.
- Then enable for one test employer, then all.
- **Must stop rollout if:** the job regenerates employers without a menu change, or any regeneration fails to write `index.html` pages.
- **Rollback:** disable the schedule. Existing HTML stays as it is. Re-uploading a ZIP regenerates normally.

## Tests to add

- A menu change at each of the three boundary dates, for one employer.
- No change on an ordinary day, so no regeneration.
- A failed night, followed by a successful one: the employer is regenerated on the second night.
- Missing state file: the employer is regenerated, and the file is written.
- Lambda 2 writes the state file with the correct values after a ZIP-triggered run.
- A partial Lambda 2 failure leaves the state file unchanged.
- The rollover result for the gap options (D, B+guard), to check that the flip on 2026-11-01 is correct.

## Capacity plan

### Inputs (from the team)

| Input | Value |
|---|---|
| Employers today | ~20,000 |
| Growth | ~2,000 new per year (about 10%) |
| One Lambda 2 run | ~20 seconds (observed; to be re-measured, see below) |
| Target | The whole job finishes within ~15 minutes |
| Employers changing on a normal day | Small. Not every employer changes every day. |

### Why a normal day is light

A menu only changes on an employer's plan-year boundary dates: when "Upcoming" first appears, when it becomes "Current", and when the old year expires. For normally renewing employers these fall around the same time of year, so each employer has roughly **one change day per year**.

Rough estimate (assumption, not measured): 22,000 employers / 365 days = **~60 employers on an average day**.

- 60 runs x 20s = 1,200 seconds of Lambda time.
- At a concurrency of 10, that is about **2 minutes**.

### Why peak days matter

Renewals cluster (1 January, 1 July, 1 November and similar). Suppose 4,000 employers change on one day (an assumption; we need the real number):

| Concurrency | Time for 4,000 runs at 20s each |
|---|---|
| 20 | ~67 min |
| 50 | ~27 min |
| 100 | ~13 min |
| 200 | ~7 min |

So to stay inside the 15-minute target on a peak day of that size, the regeneration step needs a concurrency of about **100**. If the real peak is 1,000 employers, a concurrency of 25-30 is enough.

### The nightly check is cheap

Reading and classifying ~22,000 `data.json` files is small work. In batches of ~500 employers (about 45 batches), run in parallel, this should take **about a minute** (estimate). It is not a bottleneck.

### "15 minutes" - what it means

- **One Lambda run:** 20s, far below the 15-minute Lambda limit. No issue.
- **The whole job:** not bound by the Lambda limit, because Step Functions drives it. The 15-minute target is a goal we meet by choosing enough concurrency, as above.

### Recommended settings

- Schedule: once a day at **00:15 UTC** (a small buffer after midnight).
- Check step: Distributed Map, batches of ~500, concurrency ~20.
- Regeneration step: cap concurrency from the real peak (about 100 for a 4,000-employer peak).
- Reserve Lambda concurrency for Lambda 2 so a heavy rollover cannot starve ZIP-driven runs, and vice versa. Check the account's total Lambda concurrency limit first.
- Alarm if the whole job takes longer than 20 minutes or fails.

### Growth

About 2,000 new employers a year adds about 10% a year. At ~24,000 next year, nothing in this design changes.

## Answered questions

1. **Employers expected (now and in a year):** ~20,000 today, +2,000 per year. -> 1b with fan-out.
2. **UTC acceptable for "today"?** Yes.
3. **Should Lambda 2 delete orphaned pages?** Unsure, so **no for now**. Revisit later.
4. **Who owns the new scheduler and alarms?** We do.
5. **Deployer IAM:** handled by the team in the separate RaaS repo. Out of scope for this repo.
6. **Time to complete:** within ~15 minutes. Not every employer changes every day.
7. **Cost of one regeneration:** about 20 seconds.
8. **State approach:** per-employer state file (not a single global date).

## Still open

1. **Peak-day number.** How many employers share the busiest renewal date (for example, 1 January or 1 November)? A quick count of `EffDate` values across all `data.json` files gives this and sets the final concurrency cap. Until then, plan for ~100.
2. **What the 20s includes.** Does it include the `files/` copy? If yes, a rollover-only regeneration that skips the copy could be much faster, which lowers the concurrency needed. Worth measuring once.
3. **Account Lambda concurrency limit.** Confirm there is room for ~100 extra concurrent Lambda 2 runs next to normal pipeline traffic.
4. **Backfill plan.** One manual full run, or a throttled drain over several nights (see "First rollout")?
5. **Lambda 2 write access.** Confirm the team is happy to grant Lambda 2 `PutObject` on the assets bucket, scoped to the state file.
