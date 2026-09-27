# instruction.md — Rules for Building the ANN Last-Minute Exam Notes

> **Read this file completely before generating any week's note.**
> Goal: a note a student can read in the **last 2 hours before the exam** and still
> score well. Highest value per line. Zero filler.

---

## 0. Rule 0 — Say the Literal Thing  *(RANKS ABOVE EVERY OTHER RULE)*

Short is **not** the same as simple. A line can be very short and still be impossible
to understand. This rule exists because short-but-vague lines were the single biggest
problem in the first draft of Week 1.

### 0.1 No naked metaphor
A picture-word (*bend, evidence, shout, template, flat, hint*) is **new jargon** unless
it is explained. **Do not use picture-words at all.** Say the literal, mechanical thing.

| Do not write | Write instead |
|---|---|
| add up the evidence, then bend it | Step 1: multiply each input by its weight and add them into one number. Step 2: put that number through the activation function |
| the neuron shouts loudly | the output is large |
| the weight vector is a template | the output is large when the input matches the pattern stored in the weights |
| bent patterns | curved splits between classes (a curved line, not a straight line) |
| built-in hints | the design already matches the shape of the data |
| treats the data flatly | looks at the whole input at one level only |
| step-by-step abstraction | features built level by level |

*Straight line* vs *curved line* is allowed — that is literal geometry, not a metaphor.
A real technical term that the exam expects (`black-box`, `DAG`, `bottleneck`) is kept,
but its meaning is written next to it the first time: `black-box — you cannot easily see
why it gave that answer`.

### 0.5 Plain factual words only — no colour, no feelings

A word can be simple *and* still be wrong for a note, because it describes a **picture or a
feeling** instead of the **fact**. Always write the fact.

**0.5a — A machine has no feelings.** A model is not surprised. A loss feels no pain.
Never give a human feeling to a model, a loss, a gradient or a layer.

| Do not write | Write instead |
|---|---|
| how *surprised* the model is that the true class happened | it looks at one number: the probability the model gave to the correct class |
| the loss falls *painfully* slowly | the loss goes down very slowly |
| training *wants* the loss to get smaller | training must make the loss smaller |
| updates look *wild* | the updates are unstable |

*Exception:* a term with a precise technical meaning is kept even if it sounds human —
`confidence`, `confidently wrong`, `dying ReLU`, `dead neuron`. These are defined terms
from the source, not decoration.

**0.5b — No colourful word where a plain one exists.**

| Do not write | Write instead |
|---|---|
| puts a *cap* on a *runaway* gradient | sets a maximum size for the gradient; any gradient above that limit is scaled back down |
| *nudge* each weight | change each weight by a small amount |
| squaring *punishes* big errors | squaring makes big errors count far more |
| how much this weight is to *blame* | how much this weight added to the error |
| keeps values in a *healthy* range | stops values becoming too large or too small |
| the network *quietly* lost capacity | the network has lost part of its learning power |

**0.5c — Read every line aloud. If you stumble, rewrite it.**
This catches clumsy phrasing that no word list will find — stacked prepositions, passive
constructions, and vague noun phrases.

- Bad: "the form the data is held in inside the network" (*held in inside* — two prepositions).
- Good: "the way the network stores the data at each step."

### 0.2 No naked noun
Never use an abstract noun without saying **of what**, and **what actually breaks**.

| Do not write | Write instead |
|---|---|
| the score is capped | the **accuracy of the model** can never be better than the features the human made |
| it does not scale | a human cannot hand-make features for a million images, so this fails on large data |
| too few transforms | the network reshapes the data only once or twice |
| limited representational power | it can only split the data with a straight line |
| cannot capture variable interactions | it cannot learn a rule like "true only when input A and input B are both high" |

### 0.3 Same-unit comparison
In any compare table, **both sides of a row must measure the same thing.**
Mixing units is not a comparison, it is a confusing pair of unrelated facts.

- Wrong: `Wide: needs many neurons` vs `Deep: needs fewer weights` (neurons vs weights).
- Right: `Wide: the number of neurons needed can grow explosively` vs `Deep: does the same
  task with far fewer neurons and far fewer weights in total`.
- This applies even when the **source itself** mixes units — the source does this in the
  wide-vs-deep table. Fix it; do not copy the mistake.

### 0.4 The self-test — run on every single line
> Read the line as if you know nothing about the subject.
> If you would ask **"what is that?"** or **"of what?"** — the line is not finished.

If a concept has steps, write it as **numbered steps**, not as one compressed line.

---

## 0B. Rule 0B — Simple Sentence Shapes  *(sits beside Rule 0)*

Rule 0 fixes **hard words**. This rule fixes **hard sentences**. A sentence can use only
easy words and still be hard to read, because of its *shape*. Both must be checked.

### 0B.1 One idea per sentence. Aim for 15 words, stop at 20.
If a sentence has two ideas joined by "and", "so", "but" or a colon, **split it into two
sentences**. Two short sentences are always easier than one correct long one.

### 0B.2 No phrasal verbs, no idioms — use the plain single verb
A phrasal verb is a verb plus a small word, and it usually has several meanings.

| Do not write | Write instead |
|---|---|
| work out the value | **calculate** the value |
| come up with a rule | **create** a rule |
| carry out training | **do** / **run** training |
| reason about the uncertainty | **see** how unsure the model is |
| after allowing for their lengths | whatever their lengths |
| account for / result in | explain / cause |

### 0B.3 Never interrupt a sentence in the middle
Do **not** split the subject from its verb with a dash-aside or a long comma clause.
The reader has to hold the first half in memory while reading the interruption.

- Bad: "This jump in what it can represent — not a cleverer learning rule — is why deeper networks beat shallow ones."
- Good: "Deeper networks beat shallow ones. The reason is the extra shapes they can make. It is **not** that they learn in a cleverer way."

A dash is fine at the **end** of a sentence (`term — meaning`). It is not fine in the middle.

### 0B.4 No "What X is, is Y" constructions (clefts)
State the thing directly. Never build a sentence around a negation plus a contrast.

- Bad: "What changes is not *where* the boundary is, but *how sharply* the output flips as you cross it."
- Good: "The boundary does not move. Only one thing changes: the perceptron jumps straight from −1 to +1, while the logistic neuron slides gradually from near 0 to near 1."

### 0B.5 Do not stack three ideas in one bullet
Each idea gets its own bullet. Three short bullets beat one long bullet every time.

**The one case that is allowed: parallel repetition.** If every item repeats the *same*
verb form, the reader only has to parse it once, so it stays easy:
- Allowed: "It does **not** use a smooth loss, does **not** use gradients, and does **not** give probabilities."
- Allowed: "how **fast** training settles, how **accurate** the final model is, how **stable** the run is."

**Different verbs stacked are NOT allowed** — the reader must re-parse at every comma:
- Banned: "it **limits** how complex the model can become, **stops** weights growing too large, and **reduces** memorising of noise."
- Fixed: three bullets — "It stops the model becoming too complex." / "It stops the weights growing too large." / "It gives the model less time to memorise the noise."

- Bad: "Its output is a probability, so you can rank cases by confidence, move the deciding cut-off to suit the job, and reason about how unsure the model is."
- Good: three separate bullets — sort the cases / change the cut-off (usual value 0.5) / see when the model is unsure (near 0.5 means "not sure").

### 0B.8 No nested "how + adjective + noun" phrases
`how much` and `how well` are fine — they are everyday. The hard shape is
**`how <adjective> a/the <noun> <subject> <verb>`**. The reader has to unpack it before it
means anything.

| Do not write | Write instead |
|---|---|
| how *complex a pattern* the model is able to fit | how much the model is able to learn. A model with more capacity can learn more complicated patterns |
| it limits how *complex the learned model* can become | it stops the model from becoming too complex |

**Where the boundary actually is — the noun's ROLE.** The shape is hard only when the noun
has been **moved to the front from being the object** of the later verb:
- Hard: "how complex **a pattern** the model is able to fit" — *pattern* is what the model
  *fits*. It has jumped in front of its own verb, so the reader must put it back.
- Fine: "how sure **the model** is", "how steady **the model's predictions** are", "how much
  **the output** changes" — the noun is the plain **subject** of the sentence. Nothing has moved.

So `how sure / how steady / how well / how much + subject + verb` all pass. Only a fronted
**object** needs rewriting.

### 0B.9 Never use a command to state a condition
An imperative ("Move…", "Start…", "Take…") reads as an *instruction to the reader*. If it
is really a **condition**, the reader must first work out that no action is being asked
for. Write **"If X, then Y"** instead.

| Do not write | Write instead |
|---|---|
| *Move* a pattern a few pixels across, and the model sees a completely different input | **If** a pattern moves even a few pixels sideways, the model sees it as a completely different input |
| *Start* every weight at zero. Then every neuron gets the same input… | **If** every weight starts at zero, **then** every neuron gets the same input… |
| *Take away* the largest value $c$ first. Then the biggest term becomes $e^0 = 1$ | **After you take away** the largest value $c$, the biggest term becomes $e^0 = 1$ |

*Imperatives are allowed in exactly two places:* a genuine numbered **procedure step**
("Apply a hard cut-off: …", "Watch performance on a validation set"), and direct **advice**
to the reader ("Start small and simple", "Use it carefully").

### 0B.10 No vague direction or motion words
A direction word needs to say *which way*, and a motion word needs to say *what the motion
looks like*.

| Do not write | Write instead |
|---|---|
| a few pixels *across* | a few pixels **sideways** |
| the loss *jumps around* | the loss **moves up and down without settling** |
| accuracy *jumps around* between epochs | accuracy **changes a lot from one epoch to the next** |
| rescaled to sit *around* zero | rescaled so it is **centred on** zero |
| there is no way *around* it | you **cannot avoid** this |

### 0B.7 What is exempt from the 20-word limit
Three places are **deliberately dense** and are not counted:
- **MUST REMEMBER** lines — these are compressed recall triggers, not teaching sentences.
  The concept is already explained in full above; this block only jogs the memory.
- **Table cells** — a table row is read as a column-by-column comparison, not as prose.
- **A list of SHORT parallel items after a colon** — "Use it when: A, B, and C", where each
  item is a few words and shares the same grammatical form. This exemption does **not**
  cover three full clauses with different verbs; those fall under 0B.5 and must be split.

Everywhere else, the limit applies.

### 0B.6 The check — run it on the finished `.typ`
**A flagged line is rewritten, not waved through.** Only the exemptions in 0B.7 excuse a
flag, and they must be checked against the exact wording there. Deciding a flagged line
"reads fine really" is exactly how defects reach the user — it has already happened once
(see the Correction Log, Week 7).
Scan for: any sentence of 20+ words, any phrasal verb from the list, any sentence with two
`—` dashes in it, and any sentence starting "What ". Each hit is rewritten, not shortened.

---

## 1. The Mission

Turn `revision_notes_51_page.pdf` into **13 week-wise notes**, each **1–2 pages**,
that are:
- **Complete** — every idea from that week's section is present in some form.
- **Concise** — bullet points, no paragraphs, no story-telling.
- **Simple** — a 5th-grade student can read it and understand the concept.
- **Exam-shaped** — organised the way questions are actually asked.

---

## 2. Rule 1 — Answer Length Matches the Exam

The exam does **not** reward long writing. It rewards **correct, to-the-point** points.

- Write every idea as **one bullet = one scoring point**.
- Target **one line per bullet**. Two lines maximum. Never three.
- Use `—` (em dash) to join a term to its meaning: `**Bias** — the starting value; it decides when the neuron turns on.`
- **No** introductions, **no** "in this section we will see", **no** closing summaries.
- Prefer a **table** whenever the source compares two or more things. Tables are faster
  to revise and directly match "compare X and Y" questions.

---

## 3. Rule 2 — Very Simple English  *(second only to Rule 0)*

This rule beats every rule except Rule 0. If simple wording and textbook wording conflict,
**simple wording wins** — but the technical term must still appear at least once,
because the exam expects the correct term.

**How to write:**
- Short sentences. One idea per sentence.
- Everyday words instead of academic words:

| Do not write | Write instead |
|---|---|
| utilise, leverage | use |
| approximate | copy closely, get close to |
| representational power | how much it can learn |
| hierarchical | step by step, level by level |
| optimisation | training / finding the best weights |
| non-linear | bent / not a straight line |
| aggregation | adding up |
| propagate | pass along |
| converge | settle down, stop changing |
| degrade | get worse |

- **Keep the real term, then explain it in brackets.** Example:
  `Feed-forward network (data moves one way only, never backwards).`
- Use small, concrete pictures where the source allows: a neuron is "a voter that adds
  up evidence", weights are "how loud each input shouts".
- Never use a word the student would have to look up, unless it is a syllabus term.

---

## 4. Rule 3 — Follow the Exam Pattern

From `ANN_sample_paper.pdf`:

- **4 questions, 10 marks each.** Split as **5+5** or **6+4**. Total 40.
- Every part is 2–4 bullet-sized ideas. Nothing needs an essay.
- The question verbs are almost always one of these four shapes:

| Question shape | Sample paper example | What the note must carry |
|---|---|---|
| **Compare / difference between** | "Compare any two optimisation methods", "difference between underfitting, good fit, overfitting" | A **compare table** for every pair the source contrasts |
| **Why does it fail?** | "Explain why a single-layer perceptron fails", "the dying ReLU problem" | A **limitation / what breaks** line for every method |
| **What happens if too high / too low?** | "gradient descent under very high and very low learning rate" | A **too high vs too low** row for every knob |
| **How does X fix Y?** | "how a hidden layer solves this", "how LSTM gates fix RNN problems" | A **problem → fix** pairing |

**Therefore, in every week's note:**
- Never list a method without its **weakness**.
- Never list a knob (learning rate, batch size, depth) without **too high / too low**.
- Never describe a fix without naming the **problem it fixes**.
- End each note with **"Likely Exam Questions"** — 3–5 one-line question stubs taken from
  that week's content, each with a 3–6 word answer hint.

---

## 5. Rule 4 — Source Discipline

- `revision_notes_51_page.pdf` is the **only** source of facts, formulas, numbers,
  and claims.
- Outside knowledge is allowed for **exactly one purpose**: making an idea already in
  the source **easier to say** (a simpler word, a small everyday example).
- **Never add** a new method, new formula, new architecture, or new comparison that the
  source does not contain.
- Keep every formula the source puts in a highlighted box — those are exam-critical.
- Keep the source's **"MUST REMEMBER"** block for each section. It is the single highest
  value content on the page. Reword it simply; do not drop items.

---

## 6. Rule 5 — Typst Build

- Each week is one file: `notes/weekNN.typ` → `notes/weekNN.pdf`.
- All weeks import `notes/template.typ` so the look never changes between weeks.
- Build: `typst compile notes/weekNN.typ notes/weekNN.pdf`
- Layout settings that make 1–2 pages possible:
  - A4, margins ~1.1 cm
  - Body text 8.5 pt, two columns
  - Tight bullet spacing, compact tables
  - Colour used only to **guide the eye** (headers, boxes) — never for decoration

---

## 7. Rule 6 — The Page Limit is a CEILING, Not a Target

**2 pages is the maximum. It is not a goal to chase.**
**1 page is not a prize.** A note that is 1.5 or 2 pages and easy to read is *better*
than the same note squeezed onto 1 page.

### 7.1 Never compress to hit a page number  *(this rule exists because it was broken)*
The following are **banned** when done only to save space:

| Banned | Why |
|---|---|
| Shrinking the body font below **8.4 pt** | Makes a last-minute note tiring to read — the exact opposite of the point |
| Shrinking margins below **1.1 cm × 1.0 cm** | Same |
| Tightening leading / spacing below the template baseline | Same |
| Cutting an exam-question hint down to a fragment | The hints *are* the revision value; a fragment recalls nothing |
| Dropping exam questions to free up lines | Same |
| Removing the subject of a sentence ("the model learns…" → "learns…") | Breaks Rule 0.2 — it creates a naked noun |
| Shortening an explanation until it is vague again | Undoes Rule 0, which outranks everything |

The template's typography is a **fixed baseline**. Do not touch it to make something fit.

### 7.2 What you may do
- Cut words that genuinely repeat, where the meaning is untouched.
- Turn a long bullet list into a table when the table is *also* clearer.
- These are done for **quality**, never for page count. If the page count does not move,
  that is fine — leave it.

### 7.3 When it goes past 2 pages
**Stop and ask the user.** Report the current page count and exactly what would have to go.
Do not silently trim, and do not shrink the type.

### 7.4 Plain English costs space — accept it
Rule 0 wording is longer than compressed wording. That is the deliberate trade.
Expect most weeks to be **1.5–2 pages**. This is the expected outcome, not a failure.

## 8. Fixed Section Order in Every Week's Note

Keep the same skeleton every week so revision feels the same each time:

1. **Title bar** — `Week N — <Topic>` + a one-line "what this week is really about".
2. **Core idea boxes** — the 2–4 definitions or formulas that must be memorised.
3. **Main content** — headed bullet groups, in the source's own order.
4. **Compare tables** — every contrast the source makes.
5. **Weak points / what breaks** — limitations, failure cases, traps.
6. **Must Remember** — the source's own must-remember list, simplified.
7. **Likely Exam Questions** — 3–5 stubs with short answer hints.

---

## 9. Quality Checklist — run before saying "done"

- [ ] PDF is **at most 2 pages** (verified, not assumed). 1.5–2 pages is perfectly fine.
- [ ] Every fact traces back to the 51-page note.
- [ ] No sentence needs a dictionary.
- [ ] **Rule 0 self-test passed on every line** — no naked metaphor, no naked noun.
- [ ] **Rule 0.5 scan run** — no feelings given to machines, no colourful word where a plain one exists, every line survives being read aloud.
- [ ] **Rule 0B check run** — no command-as-condition, no vague direction words, no sentence over 20 words, no phrasal verbs, no mid-sentence dash-asides, no cleft sentences, no bullet holding three ideas.
- [ ] **Every compare row measures the same thing on both sides.**
- [ ] No paragraph longer than 2 lines. No sentence longer than 20 words.
- [ ] Every method has a stated weakness.
- [ ] Every tunable knob has too-high / too-low behaviour.
- [ ] All boxed formulas from the source are present.
- [ ] The source's MUST REMEMBER items are all covered.
- [ ] "Likely Exam Questions" section exists and matches the 5+5 / 6+4 pattern.
- [ ] **Typography is untouched at the baseline** — nothing was shrunk to save space.
- [ ] **Exam hints are full phrases, not fragments.**
- [ ] Compiles with no Typst warnings.
- [ ] **If the user gave any correction this round, the Correction Log (§10) has a new entry AND the rule above was updated.**

---

## 10. Correction Log

Every line the user flagged as unclear, what was actually wrong with it, and the rule it
produced. **Read this before writing a new week** — these are real examples of this user's
standard, which is more useful than the abstract rules alone.

**How to use it:** when a new correction comes in, add a row here *and* fix the rule above.
A correction that lives only in chat is lost at the end of the session.

### 2026-08-20 — Week 1, round 1: short is not the same as simple

The user flagged four lines. All four had the same cause: wording that was **compressed
until it stopped carrying meaning**. The words were short, so they looked simple, but the
reader could not decode them.

| # | Flagged line | What was actually wrong | Rewritten as |
|---|---|---|---|
| 1 | "Too few transforms → cannot catch bent patterns or inputs that interact" | `transforms` = naked noun, never defined. `bent patterns` = a private metaphor for non-linear. `inputs that interact` = vague. | "A shallow network reshapes the data only once or twice. So it can only split the data with a straight line. It cannot learn a curved split, and it cannot learn a rule like *true only when input A and input B are both high*." |
| 2 | "Score is capped by hand-made features; does not scale" | User asked directly: **"what is this score"**. Never said score *of what* (accuracy), or what breaks when it "does not scale". | "The accuracy can never beat the quality of the hand-made features, and a human cannot make features for very large data." |
| 3 | "May need hugely many neurons" vs "Usually far fewer weights" | A real inconsistency: left side counts **neurons**, right side counts **weights**. Two different units is not a comparison. *The source itself makes this mistake.* | Both sides now count the same thing: "the number of neurons needed can grow explosively" / "does the same task with far fewer neurons and far fewer weights in total". |
| 4 | "add up the evidence, then bend it" | `evidence` and `bend` are invented picture-words, never explained. A metaphor you do not explain is just new jargon. | Numbered steps: "**Step 1 — the sum.** Multiply each input by its weight and add them into one number *z*. **Step 2 — the activation.** Put *z* through φ … without it the whole network stays one straight line." |

**Nine more lines had the same disease** and were fixed at the same time, even though the
user had not seen them yet: `bent activation`, `the neuron shouts loudly`, `the weight
vector is a template`, `more abstract ideas`, `very bent, very complex functions`, `less
guessing error`, `built-in hints`, `black box` (kept, but its meaning now written beside
it), `treats data flatly`, `step-by-step abstraction`.

→ **Produced Rule 0** (Say the Literal Thing): no naked metaphor, no naked noun,
same-unit comparison, and the self-test.

**Lesson:** when the user flags examples, they are showing a **pattern**, not a list.
Scan the whole note for other instances before replying.

### 2026-08-20 — Week 1, round 2: do not compress to hit a page number

After the Rule 0 rewrite the note grew past one page, and the assistant chased a
single page by shrinking the body font 8.4→7.95 pt, cutting margins 1.1→0.8 cm,
tightening leading, dropping an exam question, and truncating the exam hints into
fragments ("→ small table data → XGBoost").

The user's words: *"you unnecessarily compressed the things in 1 page and likely exam
questions which was awesome earlier, become unnecessarily compressed."*

**The deeper failure:** compressing for space **re-introduced the very defect from round 1**.
"the model learns a description of each user…" had been shortened to "learns a description…"
— a naked subject. Adam/RMSProp "(reach a good answer faster)" had become "(faster)" —
faster than *what*. **Optimising for page count silently undoes Rule 0.**

→ **Rewrote Rule 6**: the page limit is a **ceiling, not a target**; typography is a fixed
readability floor; 1.5–2 pages is the expected result of writing in plain English.

**Lesson:** never trade clarity for a page number. If it does not fit, it does not fit —
ask, do not shrink.


### 2026-08-20 — Week 3, round 1: easy words are not enough — the sentence SHAPE must be easy too

The user flagged four lines. Every word in them was simple. They were still hard to read,
because of how the sentences were **built**. Rule 0 did not catch any of them.

| Flagged line | What was actually wrong | Rewritten as |
|---|---|---|
| "Work out one number $z$ (the weighted sum)." | **Phrasal verb.** "Work out" can mean calculate, exercise, or succeed. The reader must pick. | "Calculate one number $z$ (the weighted sum)." |
| "This jump in what it can represent — not a cleverer learning rule — is why deeper networks beat shallow ones." | **Mid-sentence interruption.** The dash-aside sits between the subject and its verb, so the first half must be held in memory across it. Also `jump in what it can represent` is an abstract noun phrase. | Three short sentences: "A multi-layer network can make strictly more shapes of boundary." / "This is why deeper networks beat shallow ones." / "It is **not** that they learn in a cleverer way." |
| "What changes is not *where* the boundary is, but *how sharply* the output flips from one side to the other as you cross it." | **Cleft construction**, 24 words, built on a negation plus a contrast. The actual point arrives last. | "The dividing line does not move… Only *one* thing changes. The perceptron jumps straight from −1 to +1 the moment you cross the line. The logistic neuron slides gradually from near 0 to near 1." |
| "…move the deciding cut-off to suit the job, and reason about how unsure the model is." | **Three ideas stacked in one bullet**, plus `reason about` (academic for *see*) and `deciding cut-off` / `to suit the job` (vague). | Split into three bullets, each one idea: sort the cases / change the cut-off (usual value 0.5) / see when the model is unsure — near 0.5 means "not sure". |

**Scanning found more of the same**, fixed at the same time: a 30-word "why this works"
sentence in the learning rule, a 28-word definition of linear separability, and the
"depends on the shape of the data, not on how long you train it" sentence. **Weeks 1 and 2
had the same defect and were fixed too** — the 29-word feature-bottleneck bullet, the
black-box bullet, `after allowing for their lengths` (idiom), and the GPU bullet.

→ **Produced Rule 0B** (Simple Sentence Shapes): one idea per sentence, max 20 words;
no phrasal verbs; no mid-sentence dash-asides; no cleft sentences; no bullet with three
ideas; plus a mechanical scan to catch all of these.

**Lesson:** Rule 0 checks the **words**; Rule 0B checks the **shape**. Passing Rule 0 says
nothing about whether a sentence is readable. Run both.


### 2026-08-20 — Weeks 4 & 5, round 1: plain words, not colourful or emotional ones

The user flagged four lines. All passed Rule 0 (no hard words) and Rule 0B (fine sentence
shapes). They were still wrong, because the words described a **picture or a feeling**
rather than the **fact**.

| Flagged line | What was actually wrong | Rewritten as |
|---|---|---|
| "Representation — the form the data is held in inside the network." | **Clumsy phrasing.** `held in inside` stacks two prepositions. Passive and abstract. You stumble reading it aloud. | "Representation — the way the network stores the data at each step. The raw input is the first version. Each hidden layer builds a new, more useful version from the one before it." |
| "It measures how *surprised* the model is that the true class happened." | **A feeling given to a machine.** A model cannot be surprised. The metaphor hides a simple mechanical fact. | "It looks at *one number only*: the probability the model gave to the *correct* class. If that probability is high, the loss is small. If it is low, the loss is large." |
| "Loss falls *painfully* slowly." | **An emotional word.** A loss feels no pain. | "The loss goes down very slowly." |
| "puts a *cap* on a *runaway* gradient" | **Colourful words where plain ones exist.** Both are pictures, not descriptions. | "Sets a maximum size for the gradient. Any gradient above that limit is scaled back down." |

**A word scan across all five weeks found 16 instances** of the same class, all fixed:
`healthy` gradients/push/range (x3), training `wants`, `nudge` (x2), `blame` (x2),
`punish` (x2), `quietly` lost, `hurt`, `cleverer`, `wild`, `jumps about`.

→ **Produced Rule 0.5** (Plain factual words only): no feelings given to machines; no
colourful word where a plain one exists; read every line aloud and rewrite any stumble.
A defined technical term that merely sounds human (`confidence`, `dying ReLU`, `dead
neuron`) is kept — it is a term, not decoration.

**Lesson:** there are now **three** separate checks, and passing one says nothing about the
others. Rule 0 = the **words** are easy. Rule 0B = the **sentence shape** is easy.
Rule 0.5 = the words are **factual, not decorative**. Run all three.


### 2026-08-20 — Week 7, round 1: two rule violations and one new pattern

The user flagged four lines. **The honest split matters more than the fixes:**

**Two were rules that already existed and were broken anyway.**
- "Why it regularises: it *limits* how complex the model can become, *stops* weights growing
  too large, and *reduces* memorising of noise." — three ideas in one bullet, banned by
  Rule 0B.5. **The 0B scan flagged this line at 23 words. It was looked at and waved
  through as "a triple list, acceptable."** That judgement was wrong.
- "small *wobbles*" — a colourful word, banned by Rule 0.5. Written anyway.

**One was a genuinely new pattern.** `how <adjective> a/the <noun> <subject> <verb>`:
"how *complex a pattern* the model is able to fit", "how *complex the learned model* can
become". `how much` / `how well` are fine; a nested **adjective** is not.

**One was vocabulary and vagueness.** "the *oddities* of the training set" (uncommon word)
and "instead of the general pattern" (which pattern?). Also found by scanning:
"*representative*" (of what?) twice, "similar in *spirit* to dropout", "a simple *baseline*".

| Flagged line | Rewritten as |
|---|---|
| "It memorises the noise and the oddities of the training set instead of the general pattern." | "It remembers the noise and the small random details in the training set. It does not learn the real pattern, so it fails on new data." |
| "how complex a pattern the model is able to fit" | "how much the model is able to learn. A model with more capacity can learn more complicated patterns." |
| "it limits how complex… , stops… , and reduces…" | Three bullets, one idea each. |
| "use patience so small wobbles do not stop training too soon. Make sure the validation set is representative. It needs no change to the architecture, and it combines well…" | Four bullets: patience (one or two bad epochs) / the validation set must look like the real data / no change to the network design / works well with the other methods. |

Scanning also found a **four**-clause bullet in Week 6 (RMSProp benefits), now split.

→ **Changes made:** Rule 0B.5 now names the one allowed case — *parallel repetition*
(same verb form repeated, parsed once) — and bans *different verbs stacked*. New Rule 0B.8
bans nested `how + adjective + noun`. Rule 0B.7's colon-list exemption tightened to
**short parallel items only**, because it was being stretched to excuse three full clauses.
Rule 0B.6 now states: **a flagged line is rewritten, not waved through.**

**Lesson:** the checks were not the weak point this time — **the discipline of obeying them
was**. A flag that gets argued away is worse than no flag, because it creates false
confidence that the note was checked.


### 2026-08-21 — Week 8, round 1: a command is not a condition

The user flagged one line: *"Move a pattern a few pixels across, and the model sees a
completely different input."* It hid **two** separate defects.

| Defect | Why it is hard | Fix |
|---|---|---|
| **A command used to state a condition.** "Move…, and the model sees…" is really "*If* a pattern moves…, the model sees…". | The imperative reads as an instruction. The reader must first realise no action is being asked for, then re-read it as an if-then. | "**If** a pattern moves even a few pixels sideways, the model sees it as a completely different input." |
| **A bare direction word.** "a few pixels *across*" — across *what*? | `across` is carrying the meaning of "sideways" but never says so. | "a few pixels **sideways**" |

**Scanning all eight weeks found six more**, all fixed:
- Command-as-condition: "*Start* every weight at zero. Then every neuron…" (W5),
  "*Take away* the largest value $c$ first. Then…" (W2).
- Vague direction/motion: "loss *jumps around*" (W6), "accuracy *jumps around* between
  epochs" (W7), "rescaled to sit *around* zero" (W4), "there is no way *around* it" (W3 — an idiom).

The scan also confirmed which imperatives are **fine** and were left alone: numbered
procedure steps ("Apply a hard cut-off: …", "Watch performance on a validation set") and
direct advice ("Start small and simple", "Use it carefully"). The test is whether the
reader is genuinely being *told to do something*.

→ **Produced Rule 0B.9** (never use a command to state a condition — write "If X, then Y",
with the two allowed exceptions) and **Rule 0B.10** (no vague direction or motion words —
say *sideways*, *up and down*, *centred on zero*).

**Lesson:** one short line can carry two unrelated defects. Diagnose *every* fault in a
flagged line before rewriting it, or the rewrite fixes one and keeps the other.

### Template for a new entry

```
### YYYY-MM-DD — Week N, round R: <one-line name of the problem>

| Flagged line | What was actually wrong | Rewritten as |
|---|---|---|
|  |  |  |

→ Produced / changed Rule <n>.
**Lesson:** <the generalisation, so it applies to future weeks>
```
