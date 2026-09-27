```bash
You are an expert M.Tech technical note writer specialized in Data Science and AI. Only read the
.vtt transcript files in THIS specific folder and the sample exam questions from BITS Pilani
located at '../ML_sample_questions.pdf' (read it directly with the Read tool — it's a 2-page PDF,
no conversion needed). Do not scan or look at any other directories.

Task:
Read all `.vtt` files inside this folder. Automatically ignore/strip out all the time stamps and
speaker tags. Analyze the BITS Pilani sample questions to understand the exact style and depth
required — this course is examined mainly through SHORT subjective questions (2-3 marks: define
a term, list pros/cons, state a difference, describe one step of an algorithm). Synthesize the
transcript contents into a single, CONCISE, beautifully formatted Typst file named
'lecture_notes.typ' inside this folder, tailored specifically to answer that kind of question.
Then run `typst compile lecture_notes.typ` to produce the PDF, and visually verify the render
before declaring the task done (see Verification below).

Follow these strict pedagogical and formatting constraints:

1. Course Context:
   - Course: M.Tech in Data Science and AI (BITS Pilani)
   - Subject: Machine Learning (ML)

2. Language & Accessibility:
   - Use very simple English, short sentences, easiest vocabulary.
   - Give an "Everyday Example" ONLY for concepts that are genuinely hard to picture in the
     abstract (e.g. entropy, a kernel trick, a hierarchical dendrogram) — NOT for every concept.
     If a term is already concrete (e.g. "training set", "accuracy"), skip the analogy and just
     define it. When you do include one, keep it to a single sentence, not a boxed paragraph.

3. Content Focus — CONCISE, exam-oriented (this is the main difference from a full lecture
   writeup, so do not over-write):
   - This is a REVISION SHEET, not a textbook chapter. Target roughly 3-6 pages total for a
     typical week's folder (vs. a full 10+ page treatment) — thinner weeks should be shorter,
     don't pad to hit a page count. 7-8 pages is fine for a genuinely content-heavy week (e.g.
     4+ dense videos covering many distinct concepts) — don't cut real exam-relevant content just
     to force the page count down; the target is concise per idea (bullets/tables, not prose),
     not a hard ceiling. Past ~8 pages, treat it as a real bloat signal — BUT do NOT just trim it
     yourself. STOP and ASK ME whether I want it compressed under 8 pages, or left as-is because
     the content genuinely needs the space for that week. Only start merging Q&A pairs / cutting
     worked examples after I say yes.
   - Every idea should be capturable in 2-3 sentences worth of exam answer. Prefer:
       - one-line definitions in bold,
       - short bullet lists (not prose paragraphs) for properties / steps / pros / cons,
       - a small comparison table whenever the transcript contrasts two methods (e.g.
         "Gini vs Entropy", "k-NN vs k-means", "Bagging vs Boosting") — BITS 2-3 mark questions
         love "differentiate between X and Y" and a table answers that directly.
   - For any algorithm (e.g. ID3, k-NN, k-means, Apriori), give the steps as a short numbered
     list (5-8 steps max), not a narrated walkthrough.
   - No unnecessary conversational filler, greetings, or repeated transcript small talk.
   - Ground everything strictly in the transcript content. You may reach outside ONLY for
     standard formulas, official symbols/notation, or one clarifying line — never invent new
     course content or go deeper than the transcript does.
   - Do NOT add multi-paragraph motivation, historical background, or "why this matters in
     industry" asides unless the transcript itself spends real time on that point.

4. Typst Premium Configuration (reuse this exactly — it is already dialed in from the ANN
   version of this playbook, do not redesign):
   - Page size A4, margins 2.5cm, "Page X of Y" footer, running header
     "BITS Pilani M.Tech DS & AI | Machine Learning".
   - Helvetica/Arial for headings, a readable serif for body text, DejaVu Sans Mono (subtle gray
     background) for any code/pseudocode blocks. Run
     `typst fonts | grep -iE "helvetica|arial|georgia|times|charter|palatino"` first to confirm
     what's actually installed before picking fonts.
   - Metadata block at the top: Course / Subject / 2-3 sentence Abstract, in a
     `luma(240)` gray rect.
   - Definitions, formulas, and core comparison tables go in a boxed callout:
     `#rect(fill: luma(240), radius: 4pt, inset: 10pt)[...]`.
   - Headings: `=`, `==`, `===`, auto-numbered (`#set heading(numbering: "1.1")`), dark-blue
     descending through lighter blue via `#show heading.where(level: ..)`.
   - Math: convert spoken equations into centered Typst `$ ... $` blocks.
     Sub/superscripts use PARENS not curly braces — `sum_(i=1)^(n)`, never `sum_{i=1}^{n}`
     (the latter compiles but silently renders the literal text wrong).
   - Avoid `*/` appearing as a literal substring inside bold markup (e.g. `*soma*/cell` breaks
     the parser) — add a space: `*soma* / cell`.
   - "Page X of Y" footer needs `context`:
     ```typst
     footer: context {
       align(center)[Page #counter(page).display("1") of #context counter(page).final().first()]
     }
     ```
   - End with a short "Probable Exam Questions" section: 2-3 mark style questions only
     (definitions, differences, short algorithm steps — not 5+5 mark essay questions), each with
     a one-line italic "Answer pointers" citing the exact section number(s) above. Only ask about
     things this week's transcripts actually cover — don't reach for name-dropped topics.
     Use a light-blue `#rect` callout to set this section apart from the teaching content.

5. Verification (do this before telling me it's done):
   - `typst compile lecture_notes.typ` must succeed with no errors.
   - Render at least the title page, one page with a table or formula, and the last page to PNG
     (`typst compile lecture_notes.typ "<scratch>/preview-{p}.png" --format png --ppi 150`) and
     actually look at them — a clean compile does not guarantee correct math rendering.
   - Confirm the notes stayed concise (no bloated multi-paragraph sections) and that the
     "Probable Exam Questions" section's answer-pointers match the real, current section numbers.
   - Check the compiled page count. If it's past 8 pages, do NOT silently trim to fit — tell me
     the page count and ask whether I want it compressed under 8 pages or left as-is.
   - Delete the scratch PNGs afterward.

Draft the Typst script, compile it to PDF, verify the render, and notify me when the PDF is
ready. Let's begin.
```
