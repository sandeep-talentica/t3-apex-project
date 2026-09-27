// ============================================================================
//  ANN — Condensed Revision Notes (exam cram sheet)
//  Source: ANN_Claude.pdf (Modules / Weeks 1-13)
// ============================================================================

#set page(
  paper: "a4",
  margin: 2.2cm,
  header: [
    #set text(font: "Helvetica", size: 8pt, fill: luma(110))
    #align(center)[BITS Pilani M.Tech DS & AI | Artificial Neural Networks]
    #line(length: 100%, stroke: 0.4pt + luma(200))
  ],
  footer: context {
    set text(font: "Helvetica", size: 8pt, fill: luma(110))
    line(length: 100%, stroke: 0.4pt + luma(200))
    v(-2pt)
    align(center)[
      Revision Notes #h(1fr) Page #counter(page).display("1") of #counter(page).final().first() #h(1fr) ANN
    ]
  },
)

#set text(font: "Georgia", size: 9.8pt, lang: "en")
#set par(justify: false, leading: 0.68em, spacing: 0.92em)
#set heading(numbering: "1.1")

// ---------------------------------------------------------------- headings --
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  block(width: 100%, above: 0pt, below: 12pt)[
    #set text(font: "Helvetica", size: 15pt, fill: rgb("#1a3c6e"), weight: "bold")
    #block(fill: rgb("#eef4fb"), radius: 3pt, inset: (x: 9pt, y: 8pt), width: 100%)[
      #counter(heading).display() #h(6pt) #it.body
    ]
  ]
}
#show heading.where(level: 2): it => block(above: 12pt, below: 6pt)[
  #set text(font: "Helvetica", size: 11pt, fill: rgb("#2d5a94"), weight: "bold")
  #counter(heading).display() #h(4pt) #it.body
]
#show heading.where(level: 3): it => block(above: 9pt, below: 5pt)[
  #set text(font: "Helvetica", size: 9.5pt, fill: rgb("#4a7ab5"), weight: "bold")
  #counter(heading).display() #h(4pt) #it.body
]

// ------------------------------------------------------------------ tables --
#set table(
  stroke: 0.4pt + luma(190),
  inset: (x: 6pt, y: 4.5pt),
  fill: (x, y) => if y == 0 { luma(228) },
)
#show table.cell.where(y: 0): set text(font: "Helvetica", size: 8.5pt, weight: "bold", fill: rgb("#1a3c6e"))
#show table: set text(size: 8.7pt)
#show table: set par(leading: 0.55em)

// ------------------------------------------------------------- raw / code ---
#show raw.where(block: true): it => block(
  fill: luma(243), radius: 3pt, inset: 7pt, width: 100%,
  text(font: "DejaVu Sans Mono", size: 8pt, it),
)
#show raw.where(block: false): it => box(
  fill: luma(238), radius: 2pt, outset: (y: 2pt), inset: (x: 2pt),
  text(font: "DejaVu Sans Mono", size: 8.3pt, it),
)

// -------------------------------------------------------------- callouts ----
#let keybox(title: none, body) = block(
  fill: luma(240), radius: 4pt, inset: 9pt, width: 100%, above: 8pt, below: 8pt,
)[
  #if title != none [
    #text(font: "Helvetica", size: 9pt, weight: "bold", fill: rgb("#1a3c6e"))[#title]
    #v(3pt, weak: true)
  ]
  #body
]

#let qcompare(body) = block(
  fill: rgb("#eef4fb"), radius: 4pt, inset: 9pt, width: 100%, above: 8pt, below: 8pt,
)[#body]

#let proscons(pros, cons) = grid(columns: (1fr, 1fr), gutter: 7pt,
  block(fill: rgb("#eef6ee"), radius: 4pt, inset: 8pt, width: 100%)[
    #text(font: "Helvetica", size: 8.5pt, weight: "bold", fill: rgb("#2e6b2e"))[PROS]
    #v(2pt, weak: true) #pros],
  block(fill: rgb("#fbeeee"), radius: 4pt, inset: 8pt, width: 100%)[
    #text(font: "Helvetica", size: 8.5pt, weight: "bold", fill: rgb("#8b2e2e"))[CONS]
    #v(2pt, weak: true) #cons],
)

// small helper: a "one-line definition" run-in
#let dfn(term, body) = [*#term* — #body]
// cross reference marker
#let xref(body) = text(size: 8.3pt, style: "italic", fill: rgb("#2d5a94"))[(#body)]

// end-of-week distilled recall box
#let recall(body) = block(
  fill: rgb("#f4f8ef"),
  stroke: (left: 3pt + rgb("#5f8f3e")),
  radius: (right: 3pt),
  inset: (x: 10pt, y: 9pt), width: 100%, above: 12pt, below: 4pt,
  breakable: false,
)[
  #text(font: "Helvetica", size: 8.8pt, weight: "bold", fill: rgb("#3f6b28"), tracking: 0.6pt)[MUST REMEMBER]
  #v(3pt, weak: true)
  #set text(size: 8.9pt)
  #set par(leading: 0.58em, spacing: 0.5em)
  #body
]

// ============================================================================
//  TITLE PAGE
// ============================================================================
#set page(header: none, footer: none)
#v(1fr)
#align(center)[
  #text(font: "Helvetica", size: 10pt, fill: luma(100), tracking: 2pt)[BITS PILANI]
  #v(4pt)
  #text(font: "Helvetica", size: 12pt, fill: luma(80))[M.Tech in Data Science & Artificial Intelligence]
  #v(28pt)
  #line(length: 55%, stroke: 1pt + rgb("#1a3c6e"))
  #v(16pt)
  #text(font: "Helvetica", size: 30pt, weight: "bold", fill: rgb("#1a3c6e"))[
    Artificial Neural Networks
  ]
  #v(8pt)
  #text(font: "Helvetica", size: 19pt, fill: rgb("#2d5a94"))[Condensed Revision Notes]
  #v(16pt)
  #line(length: 55%, stroke: 1pt + rgb("#1a3c6e"))
  #v(22pt)
  #text(size: 11pt, fill: luma(70))[Complete Course Cram Sheet — Modules 1 to 13]
  #v(50pt)
  #block(fill: luma(240), radius: 5pt, inset: 14pt, width: 68%)[
    #set text(size: 9.5pt)
    #grid(columns: (auto, 1fr), gutter: 9pt, align: left,
      text(font: "Helvetica", weight: "bold")[Course], [M.Tech Data Science & AI, BITS Pilani],
      text(font: "Helvetica", weight: "bold")[Subject], [Artificial Neural Networks (ANN)],
      text(font: "Helvetica", weight: "bold")[Scope], [Weeks 1–13, all modules],
      text(font: "Helvetica", weight: "bold")[Format], [Definitions, formulas, tables, checklists],
      text(font: "Helvetica", weight: "bold")[Date], [#datetime.today().display("[day] [month repr:long] [year]")],
    )
  ]
]
#v(1fr)

// ============================================================================
//  TABLE OF CONTENTS
// ============================================================================
#pagebreak()
#set page(
  header: [
    #set text(font: "Helvetica", size: 8pt, fill: luma(110))
    #align(center)[BITS Pilani M.Tech DS & AI | Artificial Neural Networks]
    #line(length: 100%, stroke: 0.4pt + luma(200))
  ],
  footer: context {
    set text(font: "Helvetica", size: 8pt, fill: luma(110))
    line(length: 100%, stroke: 0.4pt + luma(200))
    v(-2pt)
    align(center)[
      Revision Notes #h(1fr) Page #counter(page).display("1") of #counter(page).final().first() #h(1fr) ANN
    ]
  },
)
#counter(page).update(1)

#text(font: "Helvetica", size: 17pt, weight: "bold", fill: rgb("#1a3c6e"))[Table of Contents]
#v(8pt)
#show outline.entry.where(level: 1): it => {
  v(3pt, weak: true)
  text(font: "Helvetica", size: 8.6pt, weight: "bold", fill: rgb("#1a3c6e"), it)
}
#show outline.entry.where(level: 2): it => text(size: 7.6pt, fill: luma(60), it)
#columns(2, gutter: 14pt)[
  #set par(leading: 0.5em, spacing: 0.5em)
  #outline(title: none, depth: 2, indent: 0.9em)
]

// ============================================================================
= Foundations: AI, ML, DL and the Artificial Neuron
// ============================================================================

== AI vs. ML vs. DL

#keybox(title: "The Nested Relationship: AI ⊃ ML ⊃ DL")[
- #dfn("AI")[any goal-driven system that perceives, decides, and acts. Even if-then rules count.]
- #dfn("ML")[data-driven AI. Learns a function $f(x; theta)$ from data instead of being given rules.]
- #dfn("DL")[ML using deep neural networks. Features *and* parameters are learned jointly.]
]

*Every ML system has 4 components:* data, model, loss function, optimisation method.

#dfn("Feature engineering bottleneck")[in classical ML humans hand-design features (edges, TF-IDF, MFCC) and the model only learns weights on top. Performance is capped by feature quality, not the algorithm. Does not scale to high-dimensional data.]

#table(columns: (1fr, 1.3fr, 1.3fr),
  table.header([Aspect], [Classical ML], [Deep Learning]),
  [Features], [Hand-designed by humans], [Learned from data],
  [What is learned], [Parameters only], [Features + representations + parameters],
  [Structure], [One fixed function], [Composition of many layers],
  [Scales to complex data?], [Poorly], [Very well],
  [Best data type], [Structured / tabular], [Unstructured (image, audio, text)],
)

== Why Deep Learning Works Today — the 4 Pillars

All four are needed *simultaneously*; no single one is sufficient.

#table(columns: (0.8fr, 2.4fr),
  table.header([Pillar], [Why it matters]),
  [Large-scale data], [Millions of images / billions of words; reduces estimation error, stabilises very large models.],
  [Massive compute], [GPUs/TPUs parallelise the matrix multiplications that dominate training.],
  [Robust optimisation], [ReLU (better gradient flow), Xavier/He init (stable signal), Adam/RMSProp (faster convergence) — together solved vanishing/exploding gradients.],
  [Powerful architectures], [CNN (spatial locality), RNN (temporal structure), Transformer (long-range attention) act as structural priors → far more sample-efficient.],
)

== The Artificial Neuron

#table(columns: (1fr, 1fr),
  table.header([Biological neuron], [Artificial neuron]),
  [Dendrites (receive signals)], [Input features $x_i$],
  [Soma (integrates signals)], [Weighted sum $z = sum w_i x_i + b$],
  [Firing / action potential], [Activation function $a = phi(z)$],
)

#keybox(title: "Core Equation of an Artificial Neuron")[
$ z = sum_(i=1)^(n) w_i x_i + b, quad quad a = phi(z) $
$x_i$ = inputs, $w_i$ = weights (learned), $b$ = bias (learned), $phi$ = non-linear activation.
]

- A neuron does *one* thing: weighted evidence aggregation, then a non-linearity.
- The weight vector acts like a *template*; strong response when input matches the template.
- *Key limitation:* a single neuron detects only one simple linear pattern → one simple decision boundary, very limited expressive power.

== Weights, Bias, Layers

- #dfn("Weight")[importance/influence of one input. Larger $|w_i|$ → matters more; negative $w_i$ → input reduces output.]
- #dfn("Bias")[baseline output; shifts *when* the neuron starts to activate. Lets a neuron respond even when inputs are zero.]
- #dfn("Layer")[a group of neurons at the same depth.]

#table(columns: (0.7fr, 2.5fr),
  table.header([Layer type], [Role]),
  [Input], [Holds raw features. No computation.],
  [Hidden], [Computes intermediate/abstract representations. The real transformation.],
  [Output], [Produces the final task-specific prediction.],
)

== Feed-Forward Neural Network (FFN)

#keybox(title: "Definition")[
A feed-forward network forms a *Directed Acyclic Graph (DAG)*: information flows one way only (input → hidden → output). No loops, no feedback, no dependence on past outputs. Each layer depends only on the previous layer's output.
]

- Simplifies forward computation (no circular dependencies).
- Enables efficient learning via backpropagation.
- Stacking simple layers represents highly complex non-linear functions.

#dfn("Universal Approximation Theorem (intuition)")[a feed-forward network with enough neurons/layers can approximate any continuous function mapping inputs to outputs. #xref[full statement in W4]]

== Where Neural Networks Are Used

- *Computer vision* — pixels → labels / boxes / segmentation. Early layers: edges; deep layers: objects.
- *Speech & NLP* — speech-to-text, translation, chatbots, LLMs (RNNs, Transformers).
- *Recommenders* — learned user/item representations predict engagement.
- *Finance, healthcare, robotics, manufacturing* — fraud detection, medical imaging, navigation, predictive maintenance.

#qcompare[
*When to use a neural network:* unstructured data (images, audio, raw text), very large datasets, and problems needing end-to-end representation learning. \
*When NOT to:* small structured/tabular data — XGBoost / Random Forest / logistic regression are often as good, and are cheaper, faster, lower-latency and more interpretable. Deep models cost compute, add latency, and are black-box.
]

== Limitations of Shallow Networks → Motivation for Depth

#table(columns: (0.9fr, 2.3fr),
  table.header([Limitation], [Explanation]),
  [Limited representational power], [Few transformations → cannot capture complex non-linear relations or variable interactions.],
  [Feature engineering bottleneck], [Performance capped by hand-designed feature quality; does not scale.],
  [No hierarchical structure], [Treats data "flatly", but real data is hierarchical (pixels→edges→shapes→objects).],
)

#table(columns: (1fr, 1fr),
  table.header([Wide network], [Deep network]),
  [More neurons in one layer], [More layers stacked],
  [Many features at one abstraction level], [Features built gradually across levels],
  [Can need exponentially many neurons], [Usually far fewer parameters],
  [No match to data hierarchy], [Natural fit for vision/language],
)

*Rule:* no fixed formula for right depth/width — decided experimentally. Start simple and small (avoids high variance / overfitting), increase depth only if needed.

#recall[
- AI ⊃ ML ⊃ DL. DL learns *features and parameters jointly*; classical ML only learns parameters on hand-made features (the feature-engineering bottleneck).
- 4 pillars of modern DL, all needed together: *data, compute, optimisation, architecture*.
- Every ML system has 4 components: *data, model, loss, optimiser*.
- A neuron: $z = sum w_i x_i + b$, then $a = phi(z)$ — weighted aggregation plus a non-linearity.
- A single neuron = one simple linear pattern detector, very limited expressive power.
- Weights = feature importance; bias = baseline / activation-threshold shift; layers = hierarchical abstraction.
- Feed-forward network = one-directional flow, a *DAG*, no loops or feedback.
- Shallow nets fail on complex data: limited representational power, feature-engineering bottleneck, no hierarchy.
- Depth beats width for complex tasks because deeper layers *reuse and compose* what earlier layers learned.
]

// ============================================================================
= Mathematical Foundations
// ============================================================================

== Vectors, Matrices, Tensors

- #dfn("Vector")[ordered list of numbers = 1st-order tensor. $n$ elements → shape $(n,)$.]
- #dfn("Matrix")[2D grid of numbers = 2nd-order tensor. Shape $(m times n)$ = rows × columns.]
- #dfn("Tensor")[general multi-dimensional array. 3+ dimensions (e.g. an RGB image: height × width × channels).]

In a network: one sample = vector; layer weights = matrix; RGB image = tensor. PyTorch/TensorFlow store everything as one "tensor" type.

== Shape Consistency and Matrix Multiplication

#keybox(title: "The Matrix Multiplication Rule")[
$ A in RR^(m times n), quad B in RR^(n times p) quad ==> quad A B in RR^(m times p) $
*Inner dimensions must match.* Output takes the two *outer* dimensions. If inner dimensions differ, multiplication is invalid and fails in code.
]

*Exam note:* shape mismatches are the single most common neural-network implementation bug.

== Dot Product

#keybox(title: "Dot Product — Algebraic and Geometric")[
$ a dot b = sum_(i=1)^(n) a_i b_i quad quad quad a dot b = ||a|| space ||b|| cos theta $
]

#table(columns: (1fr, 1fr, 1.2fr),
  table.header([Angle $theta$], [Dot product], [Meaning]),
  [$0degree$ (same direction)], [Large positive], [Strongly aligned / similar],
  [$180degree$ (opposite)], [Large negative], [Opposed],
  [$90degree$ (perpendicular)], [Exactly $0$], [No similarity],
)

This is the idea behind *cosine similarity*. Every neuron computes a dot product between the input and its weight vector: it measures *how similar the input is to the pattern the neuron seeks*; the bias shifts where activation begins.

== Layer Computation with Matrices

#keybox(title: "Full Layer Forward Computation")[
$ z = W x + b $
- $W in RR^(m times n)$: $m$ = neurons in layer, $n$ = input features (one row per neuron).
- $x in RR^(n)$: input vector. $b in RR^(m)$: one bias per neuron. $z in RR^(m)$: one raw output per neuron.
]

For a *batch*, stack input vectors as columns of $X$; one multiplication $W X$ computes the whole batch at once. This parallelism is exactly why GPUs accelerate deep learning.

== Derivatives, Partial Derivatives, Gradients

- #dfn("Derivative")[rate of change / sensitivity — slope of a function at a point. $ (d y)/(d x) = lim_(h -> 0) (f(x+h) - f(x))/h $]
- #dfn("Partial derivative")[sensitivity of the output to *one* variable while all others are held fixed. "Turn one knob at a time."]
- #dfn("Gradient vector")[collects every partial derivative into one vector.]

#keybox(title: "Gradient Vector")[
$ nabla f = [(partial f)/(partial x_1), (partial f)/(partial x_2), ..., (partial f)/(partial x_n)] $
Same dimension as the input — one sensitivity value per input.
]

*Geometric meaning:*
- Points in the direction of *steepest increase*.
- Magnitude = how fast the function changes (large = steep, near zero = locally flat).
- Gradient $= 0$ → stationary point (minimum, maximum, or saddle).
- Always perpendicular to level curves.

*Learning uses $-nabla f$*, the direction of steepest *decrease*, because we minimise loss.

== The Chain Rule

#keybox(title: "Chain Rule")[
If $y$ depends on $x$ only through an intermediate $u$, i.e. $u = g(x)$ and $y = f(u)$:
$ (d y)/(d x) = (d y)/(d u) dot (d u)/(d x) $
Total sensitivity = *product of local sensitivities* along the chain.
]

In a deep network, the loss reaches an early-layer weight only through every layer in between, so its gradient is a product of local derivatives across all of them. Repeated application of this rule, layer by layer, *is* backpropagation. #xref[full algorithm in W5]

== Numerical Stability

#table(columns: (0.7fr, 2.5fr),
  table.header([Problem], [Description]),
  [Overflow], [Number too large to represent → stored as $infinity$. Every later computation using it becomes meaningless.],
  [Underflow], [Number too small → rounded to exactly $0$. Gradient/probability information is permanently lost.],
)

*Deep learning is prone to instability because of:* (1) long chains of multiplications, (2) heavy use of exponentials, (3) extremely small probabilities.

#keybox(title: "Log-Sum-Exp Trick")[
$ log sum_(i) e^(x_i) = c + log sum_(i) e^(x_i - c), quad quad c = max_i x_i $
After subtracting the max, the largest term becomes $e^0 = 1$ and all others lie in $(0, 1]$ — nothing overflows, nothing vanishes. Applied automatically inside softmax and cross-entropy.
]

*Other stabilisation techniques:* work in log domain; subtract the max before exponentiating; add a small $epsilon$ to denominators; replace long products of small probabilities with log-sums.

#recall[
- Vector = 1st-order tensor; matrix = 2nd-order; tensor = general multi-dimensional array.
- Matrix multiplication needs *matching inner dimensions*; output takes the outer two. Shape mismatch is the #1 implementation bug.
- Dot product $a dot b = sum a_i b_i = ||a|| ||b|| cos theta$ — positive if aligned, negative if opposite, *exactly zero if perpendicular*.
- A neuron computes $w^T x + b$; a full layer computes $W x + b$ for all neurons at once; batches stack inputs for parallel GPU computation.
- Derivative = sensitivity; partial derivative = sensitivity to one variable with the rest fixed.
- Gradient $nabla f$ = vector of all partials; points toward *steepest increase*; $-nabla f$ drives learning; zero gradient = stationary point.
- Chain rule $(d y)/(d x) = (d y)/(d u) (d u)/(d x)$ — required whenever a variable affects the output only through an intermediate. *Backbone of backpropagation.*
- Overflow → $infinity$; underflow → $0$. The *log-sum-exp trick* (subtract the max before exponentiating) keeps softmax/cross-entropy safe.
]

// ============================================================================
= Perceptron and Logistic Neuron
// ============================================================================

== The Perceptron

The simplest computational neuron model (Rosenblatt, late 1950s); the first true neural network model. Job: *binary classification*.

#keybox(title: "Perceptron Equation")[
$ z = w^T x + b, quad quad hat(y) = "sign"(z) = cases(+1 &"if " z >= 0, -1 &"if " z < 0) $
]

Two steps: (1) compute a linear score $z$; (2) hard-threshold it into a class. Because step 1 is linear, $w^T x + b = 0$ is a *line* in 2D, a *plane* in 3D, a *hyperplane* in higher dimensions.

== Geometric Interpretation

#table(columns: (0.7fr, 2.5fr),
  table.header([Element], [Geometric role]),
  [Weight vector $w$], [*Perpendicular (normal)* to the decision boundary. Sets its *orientation* (rotation). Points toward the $+1$ region.],
  [Bias $b$], [Sets the *position*. Shifts the boundary parallel to itself, without rotating it.],
)

- 2D boundary: $w_1 x_1 + w_2 x_2 + b = 0$.
- Classification is a pure *sign test*: which side of the line does the point fall on?
- No distance, no probability, no confidence — only side-of-line membership.

== The Perceptron Learning Rule

#keybox(title: "Mistake Condition and Update")[
Mistake occurs when $ y_i (w^T x_i + b) <= 0 $
Then, and *only* then, update:
$ w <- w + eta y_i x_i, quad quad b <- b + eta y_i $
$eta$ = learning rate (step size).
]

*Why it works:* a wrongly-negative positive example adds a positive multiple of $x$ to $w$, increasing alignment; a wrongly-positive negative example subtracts it, reducing alignment. Every update nudges the boundary to fix the mistake just seen.

*Properties:*
- *Mistake-driven*, not continuously optimising on every example.
- Starts from random weights; stops when zero mistakes on the training set.
- Does *not* minimise a smooth loss, does *not* use gradients, does *not* give probabilities.

#keybox(title: "Perceptron Convergence Theorem")[
If the training data is *linearly separable*, the algorithm is guaranteed to converge in a *finite* number of updates. If the data is *not* linearly separable, it *never* converges — weights keep updating indefinitely.
]

== Linear Separability and XOR

#dfn("Linear separability")[a data set is linearly separable if $exists w, b$ such that $y_i (w^T x_i + b) > 0$ for every training example — all positives on one side of some hyperplane, all negatives on the other.]

Whether a perceptron can succeed is a *geometric property of the data*, not of how well it is trained.

#grid(columns: (1fr, 1.6fr), gutter: 10pt,
  table(columns: (auto, auto, auto),
    table.header([$x_1$], [$x_2$], [XOR]),
    [0], [0], [0], [0], [1], [1], [1], [0], [1], [1], [1], [0],
  ),
  [
    *The XOR problem.* Output is 1 when inputs differ, 0 when they are the same. Plotted in the $x_1 x_2$ plane, the two class-1 points sit *diagonally opposite* each other, as do the two class-0 points. No single straight line can separate diagonal pairs. XOR is the clearest demonstration of the single-layer perceptron's fundamental limit.
  ],
)

== Multi-Layer Networks Solve XOR

#keybox(title: "The Key Idea")[
A hidden layer creates *multiple* linear splits instead of one. Each hidden neuron learns its own linear separator; the output neuron *recombines* them into a final decision. Composing multiple linear cuts forms *non-linear decision regions*, even though each individual neuron is still linear.
]

For XOR: two hidden neurons create two lines; points *between* the lines get one class, points outside get the other. Requires at least one hidden layer. Multilayer networks are *strictly more expressive* than single perceptrons — this jump in expressive power (not a better learning rule) is why deeper networks beat shallow ones.

== The Logistic Neuron

The perceptron's hard threshold gives a label but never a *confidence*: no uncertainty, no probabilistic interpretation, no smooth optimisation. The logistic neuron replaces the step with a smooth sigmoid.

#keybox(title: "Sigmoid (Logistic) Function")[
$ sigma(z) = 1/(1 + e^(-z)), quad quad hat(y) = sigma(w^T x + b) $
Key values: $sigma(0) = 0.5$, $sigma(z) -> 1$ as $z -> +infinity$, $sigma(z) -> 0$ as $z -> -infinity$. Range $(0, 1)$.
]

*Probabilistic interpretation:* $hat(y) = P(y = 1 | x)$. Near 1 → confident class 1; near 0 → confident class 0; near 0.5 → uncertain.

*Crucially, the decision boundary stays linear:* $hat(y) = 0.5 <==> w^T x + b = 0$ — the same hyperplane as the perceptron. What changes is not *where* the boundary is, but *how sharply* the output transitions across it.

== Perceptron vs. Logistic Neuron

#table(columns: (0.85fr, 1.1fr, 1.15fr),
  table.header([Aspect], [Perceptron], [Logistic Neuron]),
  [Activation], [Hard step / sign], [Smooth sigmoid],
  [Output range], [Discrete $\{-1, +1\}$], [Continuous $(0, 1)$],
  [Interpretation], [Class label only], [Probability $P(y=1|x)$ + confidence],
  [Transition at boundary], [Abrupt jump], [Smooth, gradual],
  [Differentiable?], [No], [Yes — enables gradient-based training],
  [Decision boundary], [$w^T x + b = 0$ (linear)], [$w^T x + b = 0$ (linear — identical)],
  [Near the boundary], [Confidently $plus.minus 1$ even for borderline points], [Output near $0.5$, explicitly shows uncertainty],
)

*Why logistic neurons win in practice:* differentiability enables gradient-based training; probabilistic outputs let us rank by confidence, tune decision thresholds per application, and reason about uncertainty. This makes the logistic neuron the building block of modern multilayer networks.

#recall[
- Perceptron: $z = w^T x + b$, $hat(y) = "sign"(z)$ — a hard-threshold *linear* classifier.
- Weight vector $w$ sets the boundary's *orientation*; bias $b$ sets its *position*.
- Learning rule is *mistake-driven*: update only when $y_i (w^T x_i + b) <= 0$.
- Convergence theorem: guaranteed convergence *only if* the data is linearly separable; otherwise never converges.
- XOR is the classic non-linearly-separable problem — the two classes sit diagonally opposite, so no single line works.
- A hidden layer creates *multiple* linear splits which recombine into non-linear regions — this solves XOR and makes multilayer nets strictly more expressive.
- Logistic neuron: same $z$, but $hat(y) = sigma(z)$, read as $P(y=1|x)$.
- *The decision boundary is identical (linear) for both* — only the smoothness of the output transition differs.
- Logistic neurons win because they are *differentiable* (gradient training) and give *confidence*, not just a label.
]

// ============================================================================
= Multi-Layer Perceptrons and Activation Functions
// ============================================================================

== What is an MLP?

#dfn("MLP")[a feed-forward, *fully connected (dense)* neural network with one or more hidden layers. Every neuron in a layer connects to every neuron in the next.]

- *Input layer* — holds the raw feature vector. No computation.
- *Hidden layer(s)* — where the actual transformation happens. Called "hidden" only because we do not directly observe their values.
- *Output layer* — converts the last hidden representation into the final prediction.

MLPs are the conceptual foundation of deep learning; CNNs, RNNs and Transformers reuse the same layered-computation + non-linearity ideas.

== Layer Parameters and the Forward Pass

#keybox(title: "Layer Equation")[
$ z^((l)) = W^((l)) a^((l-1)) + b^((l)), quad quad a^((l)) = phi^((l)) (z^((l))) $
An MLP is a *composition of simple functions*, one per layer, not one giant formula.
]

#keybox(title: "4 Steps Inside One Neuron (the Forward Pass)")[
+ Multiply each input by its corresponding weight.
+ Sum all weighted inputs.
+ Add the bias term.
+ Apply the activation function.
]

*No learning happens during a forward pass* — it is pure computation. Each layer sees only the *transformed* representation from the previous layer, never the original input again.

#keybox(title: "Parameter Count")[
A fully connected layer from $n$ inputs to $m$ neurons has $n times m$ weights $+ m$ biases.
More connections → more capacity, but also more compute and higher overfitting risk.
]

*Worked shapes* (2 features → 3 hidden neurons → 1 output):

#table(columns: (1fr, 0.8fr, 1.6fr),
  table.header([Quantity], [Shape], [Meaning]),
  [$x$], [$(2,)$], [2 raw features],
  [$W^((1))$], [$(3 times 2)$], [3 neurons, each sees 2 inputs],
  [$b^((1))$], [$(3,)$], [one bias per neuron],
  [$a^((1))$], [$(3,)$], [output of hidden layer 1],
  [$W^((2))$], [$(1 times 3)$], [1 output neuron, sees 3 hidden values],
  [$hat(y)$], [$(1,)$], [final prediction],
)

== Hidden Layers and Representation Learning

- #dfn("Representation")[how the data is encoded inside the network. Raw input is the first representation; each hidden layer produces a new transformed version.]
- A hidden neuron computes $phi(w^T x + b)$ → it behaves as a *feature detector*, responding strongly to a specific pattern. A layer is a *bank* of feature detectors.
- *Hierarchical abstraction:* pixels → edges → corners/contours → shapes/object parts → object identity.
- Width = more feature detectors at one level. Depth = more levels of abstraction. Both raise capacity, compute, and overfitting risk.

== Expressive Power: Depth vs. Width

#keybox(title: "Universal Approximation Theorem (UAT)")[
A feed-forward network with *even one hidden layer* can approximate any continuous function on a compact domain, provided it has *enough neurons*.
*The catch:* a wide-but-shallow network may need an exponentially large number of neurons. Deep networks represent the same functions with far fewer total parameters, because depth allows re-use and composition of simpler features.
]

Real data is hierarchical (edges→shapes→objects; characters→words→meaning), so depth matches the structure of the problem — this is why modern design favours depth over extreme width.

== Why We Need Activation Functions

#keybox(title: "The Linear Collapse Problem")[
With purely linear layers, $z^((2)) = W^((2))(W^((1)) x + b^((1))) + b^((2)) = W' x + b'$.
*No matter how many linear layers are stacked, the whole network collapses to one linear model.* It can only learn straight-line boundaries and can never solve XOR.
]

Activation functions break the collapse: each layer becomes a genuinely non-linear transformation of the previous one, so layer 1 learns non-linear features of the input, layer 2 learns non-linear combinations of those, and so on. *Activation functions are the true source of expressive power.*

== Sigmoid and Tanh

#keybox(title: "Sigmoid and Tanh")[
$ sigma(z) = 1/(1+e^(-z)), quad "range " (0,1), quad sigma(0) = 0.5 $
$ tanh(z) = (e^z - e^(-z))/(e^z + e^(-z)), quad "range " (-1,1), quad tanh(0) = 0 $
]

- Sigmoid: S-shaped, output readable as a probability → standard for the *binary classification output layer*.
- Tanh: rescaled/shifted sigmoid, *zero-centered*; historically preferred over sigmoid in hidden layers because balanced positive/negative activations optimise better.
- Different layers of the same network may use different activations.

#dfn("Saturation")[for very large $|z|$ the curve flattens, so a big change in input produces almost no change in output. Gradients there become tiny → a main contributor to *vanishing gradients*. This is also why we normalise/standardise inputs — to keep values out of the flat region.]

== The ReLU Family

#keybox(title: "ReLU (Rectified Linear Unit)")[
$ "ReLU"(z) = max(0, z) $
Derivative is exactly $1$ for $z > 0$ and $0$ for $z < 0$ — piecewise-linear and very cheap.
]

*Why ReLU is the default hidden activation:*
- Does not saturate for positive inputs → information flows through many layers.
- Much faster, more stable training than sigmoid/tanh.
- Produces *sparse* activations (many exact zeros) → often better generalisation and efficiency.
- Extremely cheap to evaluate.

#dfn("Dying ReLU")[if training pushes a neuron so that $z < 0$ for (almost) every input, it outputs 0 always. Since the gradient is also 0 there, it receives *no* gradient signal and can *never recover* — a permanently dead neuron that reduces effective capacity.]

#keybox(title: "Variants that Fix Dying ReLU")[
$ "LeakyReLU"(z) = cases(z &"if " z > 0, alpha z &"if " z <= 0), quad alpha approx 0.01 "(fixed)" $
*PReLU*: same form, but $alpha$ is a *learnable* parameter tuned during training. More flexible, a few extra parameters; used in some high-performance vision models.
]

== Softmax for Multi-Class Outputs

#dfn("Logits")[raw, unnormalised real-valued class scores from the last linear layer (can be any sign or size).]

#keybox(title: "Softmax Definition")[
$ "softmax"(z_i) = e^(z_i) / (sum_(j=1)^(K) e^(z_j)) $
Every output lies in $(0,1)$; all outputs sum to exactly $1$; larger logits get larger probabilities.
]

*Worked example.* Logits $[2, 1, 0.1]$ → exponentials $approx [7.4, 2.7, 1.1]$, sum $approx 11.2$ → probabilities $approx [0.66, 0.24, 0.10]$. Predicted class = highest probability (Class 1).

#table(columns: (0.75fr, 1.2fr, 1.4fr),
  table.header([], [Sigmoid], [Softmax]),
  [Output], [One probability], [A vector of probabilities, one per class],
  [Constraint], [Value in $(0,1)$], [All values sum to exactly 1 (classes compete)],
  [Used for], [Binary classification], [Mutually-exclusive multi-class classification],
  [Location], [Output layer only], [Output layer only, never a hidden layer],
)

== Choosing Activations — Practical Guidelines

#table(columns: (0.8fr, 2.4fr),
  table.header([Problem], [Cause and effect]),
  [Saturation], [Sigmoid/tanh flatten for large $|z|$ → very weak learning signals.],
  [Vanishing gradients], [Saturation compounds backward through layers; small values multiply and shrink → early layers barely learn.],
  [Dying ReLU], [Neurons permanently output 0 → reduced effective capacity.],
  [Exploding activations], [Activations grow huge from poor init, excess depth, or unstable weight interaction → numerical overflow, training failure.],
)

*Hidden layers:* use ReLU by default → if many neurons appear dead, try Leaky ReLU → for very deep networks always prefer a ReLU-family activation → avoid sigmoid in deep hidden layers.

#keybox(title: "Output Layer Activation by Task")[
#table(columns: (1.1fr, 0.9fr, 1.3fr),
  table.header([Task], [Output neurons], [Activation]),
  [Binary classification], [1], [Sigmoid — one probability],
  [Multi-class classification], [$K$], [Softmax — probability vector],
  [Regression], [1 per predicted value], [Linear (no activation)],
)
Chosen for *correct interpretation* of predictions, not for training speed.
]

#recall[
- MLP = input + hidden layer(s) + output, feed-forward, fully connected. Each layer: $z = W a + b$, then $a = phi(z)$.
- Forward pass = 4 steps per neuron (multiply, sum, add bias, activate). *No learning happens during it.*
- Hidden layers do *representation learning* — each neuron is a feature detector; raw → derived → hierarchical features.
- Width = more detectors per level; depth = more levels. Depth is usually far more parameter-efficient (UAT caveat: one hidden layer suffices *in theory*, but may need exponentially many neurons).
- *Without activations, stacked linear layers collapse into one linear model, no matter how deep.*
- Sigmoid $(0,1)$ for binary output; tanh $(-1,1)$ zero-centered; *both saturate → vanishing gradients*.
- ReLU $= max(0,z)$ is the default hidden activation — fast, sparse, non-saturating for $z>0$; risk = *dying ReLU*; Leaky ReLU / PReLU fix it with a small negative slope.
- Softmax turns logits into a probability distribution over $K$ mutually exclusive classes — *output layer only*.
- Output activation is chosen *by task*: sigmoid (binary), softmax (multi-class), linear (regression).
]

// ============================================================================
= Backpropagation and Training Dynamics
// ============================================================================

== The Training Pipeline

#keybox(title: "The 4 Steps of Training")[
+ *Forward pass* — compute prediction from current weights and biases.
+ *Loss computation* — compare prediction with truth to get an error number.
+ *Gradient computation* — find how much each parameter contributed to that error. *This step is backpropagation.*
+ *Parameter update* — nudge each parameter to reduce the error. *This is optimisation, not backprop.*
]

*Critical distinction:* backpropagation only *computes gradients*. It does not choose a step size and does not move the weights — that is the optimiser's job, using a learning rate. #xref[W6]

== What a Gradient Means

#table(columns: (1fr, 1.7fr),
  table.header([Gradient], [Interpretation]),
  [Positive], [Increasing the parameter increases the error → decrease it.],
  [Negative], [Increasing the parameter decreases the error → increase it.],
  [Near zero], [This parameter has almost no local effect on the error.],
  [Large magnitude], [Strong influence → a big correction is justified.],
)

Sign = *direction*; magnitude = *strength*. A gradient is a per-parameter "responsibility report".

== Computational Graphs

#dfn("Computational graph")[a picture of a mathematical expression: nodes are variables/intermediate values, edges are operations. Shows exactly how the output is built from the input.]

- #dfn("Local gradient")[derivative of a node's output w.r.t. its *direct* input only.]
- *Global gradient = product of local gradients* along the path from input to output (chain rule).
- The *same graph is reused for both passes*: forward pass evaluates and *caches* every intermediate value; backward pass walks backward multiplying local gradients using the cached values — no recomputation.
- Backpropagation is simply the systematic backward traversal of this graph.

== Backpropagation Step by Step (Two-Layer Network)

Forward: $z_1 = w_1 x + b_1$, $a_1 = phi(z_1)$, $z_2 = w_2 a_1 + b_2$, $hat(y) = z_2$, $L = 1/2 (hat(y) - y)^2$. Cache $x, z_1, a_1, z_2, hat(y)$.

#keybox(title: "Backward Pass — 5 Steps")[
+ *Start at the output:* $ (partial L)/(partial hat(y)) = hat(y) - y $
+ *Output-layer parameters:* $ (partial L)/(partial w_2) = (partial L)/(partial hat(y)) dot a_1, quad quad (partial L)/(partial b_2) = (partial L)/(partial hat(y)) $
+ *Propagate into the hidden activation:* $ (partial L)/(partial a_1) = (partial L)/(partial hat(y)) dot w_2 $
+ *Pass through the activation:* $ (partial L)/(partial z_1) = (partial L)/(partial a_1) dot phi'(z_1) $
+ *First-layer parameters:* $ (partial L)/(partial w_1) = (partial L)/(partial z_1) dot x, quad quad (partial L)/(partial b_1) = (partial L)/(partial z_1) $
]

*Key points:* output-layer gradients are computed *first and directly* from the error; hidden-layer gradients arrive only *indirectly*, via the propagated signal — the hidden layer never sees the error directly. Every deep network is this same pattern repeated layer after layer.

== Loss Functions

#keybox(title: "Mean Squared Error (MSE) — Regression")[
$ "MSE" = 1/N sum_(i=1)^(N) (y_i - hat(y)_i)^2 $
Smooth, always non-negative. Squaring punishes large errors far more than small ones. Default for regression (prices, temperature, sensor values, autoencoder reconstruction).
]

#keybox(title: "Cross-Entropy — Classification")[
$ L_"CE" = - log(hat(p)_c) quad "for true class " c $
Combined numerically-stable form (what PyTorch/TensorFlow implement internally):
$ L = - z_c + log sum_(j) e^(z_j) $
Measures how "surprised" the model is that the true class occurred. High probability on the correct class → small loss; low probability → large loss. #xref[softmax defined in W4]
]

*Why MSE fails for classification:*
+ Class labels have no numeric distance — "Class 2" is not twice "Class 1".
+ MSE does not punish *confidently wrong* predictions strongly enough.
+ Combined with sigmoid/softmax, MSE gradients shrink to almost nothing when the activation saturates — no corrective signal exactly when the model is most wrong.

#table(columns: (1.1fr, 1.1fr, 1.1fr),
  table.header([Situation], [MSE gradient], [Cross-entropy gradient $(hat(p) - y)$]),
  [Unsure, $hat(p) approx 0.5$], [Moderate], [Moderate — healthy push],
  [Confidently wrong, $hat(p) approx 0.01$], [Almost zero (saturation)], [Very large, strongly corrective],
  [Confidently correct], [Small], [Small],
)

*Key result:* softmax + cross-entropy gives gradient $= hat(p) - y$ with *no extra shrinking multiplier*, so it aggressively corrects confident mistakes. This is why classifiers with cross-entropy converge faster and more reliably than the same model with MSE.

== Vanishing and Exploding Gradients (Canonical Treatment)

#keybox(title: "Why Depth Causes This")[
For an early layer, the gradient is a *product* of many local derivatives:
$ (partial L)/(partial w^((1))) = (partial L)/(partial a^((L))) dot product_(l=2)^(L) (partial a^((l)))/(partial a^((l-1))) dot (partial a^((1)))/(partial w^((1))) $
- Most local derivatives $< 1$ → gradient shrinks *exponentially* → *vanishing gradients*.
- Most local derivatives $> 1$ → gradient grows *exponentially* → *exploding gradients*.
This is a mathematical consequence of depth, not a bug.
]

#table(columns: (1fr, 1fr),
  table.header([Vanishing gradients], [Exploding gradients]),
  [Cause: saturating activations (sigmoid, tanh), or weights initialised too small],
  [Cause: weights too large, or activations amplifying signals],
  [$0.5^20 approx 10^(-6)$ (almost zero)], [$1.5^20 approx 3300$ (huge)],
  [Symptom: early layers barely change; loss decreases painfully slowly; training plateaus early],
  [Symptom: loss spikes or becomes NaN; weights grow huge; updates look chaotic],
)

*Role of activations:* sigmoid's derivative never exceeds $0.25$ and nears zero at saturation → strongly encourages vanishing. Tanh is centred but still saturates. ReLU's derivative is $0$ or $1$, so it does not shrink gradients by itself — but very large weights can still explode even with ReLU.

*Common failure mode:* a deep network's early layers never truly learn, so it behaves like a shallow network despite having many layers.

== Weight and Bias Initialization

#keybox(title: "Why Zero Initialization Fails — Symmetry Breaking")[
If all weights start at zero, every neuron in a layer gets the same input, produces the same output, and receives the same gradient. They stay *identical forever* — the network can never learn different features. *Weights must never be initialised to zero.*
Bias is different (it does not multiply inputs, so no symmetry problem): $b = 0$ is standard, though ReLU nets sometimes use a small positive bias to avoid dead neurons.
]

*Naive random init is also risky:* with variance too small, activations and gradients shrink across layers; too large, they explode. Variance keeps multiplying with depth.

#keybox(title: "Xavier and He Initialization")[
Both keep the *variance of activations and gradients stable across all layers*, for both forward and backward passes.
$ "Xavier / Glorot": quad "Var"(W) = 2/(n_"in" + n_"out") quad quad "He": quad "Var"(W) = 2/n_"in" $
He uses a larger variance because ReLU zeroes roughly half its inputs, halving the effective signal variance.
]

#table(columns: (1fr, 1.2fr, 1fr),
  table.header([Method], [Best suited for], [Variance]),
  [Xavier / Glorot], [Sigmoid, tanh], [$2 \/ (n_"in" + n_"out")$],
  [He], [ReLU and variants], [$2 \/ n_"in"$],
)

== Mitigating Vanishing / Exploding Gradients

#keybox(title: "The Four Categories — Used Together")[
+ *Weight initialization* — Xavier (sigmoid/tanh) or He (ReLU).
+ *Activation choice* — ReLU family; derivative is exactly 1 for positive inputs, so gradients pass cleanly.
+ *Gradient clipping* — caps runaway gradient magnitude. Widely used in RNNs, LSTMs, Transformers. #xref[full treatment in W6]
+ *Normalization layers* — BatchNorm (per mini-batch) or LayerNorm (per feature, preferred in Transformers) keep activations and derivatives in a healthy range. #xref[W7]
]

#recall[
- Training = forward pass → loss → gradient computation (backprop) → parameter update. *Backprop only computes gradients.*
- A gradient is a *responsibility signal*: sign = direction, magnitude = strength.
- Computational graphs make backprop systematic: global gradient = *product of local gradients*; the forward pass caches values reused backward.
- Output-layer gradients are computed first and directly; hidden-layer gradients arrive only via propagation.
- MSE for regression; *softmax + cross-entropy* for classification, because its gradient $hat(p) - y$ does *not* vanish under saturation, unlike MSE's.
- Vanishing/exploding gradients come from *repeated multiplication of local derivatives with depth* — a mathematical consequence, not a bug.
- Zero weight init fails by *symmetry breaking*. Xavier suits sigmoid/tanh $(2\/(n_"in"+n_"out"))$; He suits ReLU $(2\/n_"in")$.
- Stable training = good init + ReLU-family activations + gradient clipping + normalisation layers, *used together*.
]

// ============================================================================
= Optimisation Algorithms
// ============================================================================

== What is Optimisation?

#dfn("Optimisation")[adjusting weights and biases so the loss becomes as small as possible — a search over a very complicated, high-dimensional loss landscape with valleys, hills, plateaus, ridges and saddle points.]

The optimiser controls: *step size* (learning rate), *directional smoothing* (momentum), *per-parameter adjustment* (adaptive methods), and *stability* (clipping, normalisation). Together these decide convergence speed, final accuracy, and training stability.

== Gradient Descent

#keybox(title: "Gradient Descent Update Rule")[
$ theta <- theta - eta (partial L)/(partial theta) $
$theta$ = parameter, $eta$ = learning rate, $(partial L)/(partial theta)$ = gradient (the slope). We always move *opposite* to the gradient because the gradient points toward steepest *increase*.
]

#table(columns: (0.9fr, 2.4fr),
  table.header([Learning rate], [Behaviour]),
  [Too small], [Tiny steps; extremely slow. Stable, but wastes time and compute.],
  [Too large], [Overshoots the minimum, bounces back and forth; loss oscillates or diverges.],
  [Well chosen], [Smooth, efficient progress downhill.],
)

== Variants of Gradient Descent

The three variants differ *only* in how much data is used per update.

#table(columns: (0.85fr, 0.95fr, 1.9fr),
  table.header([Method], [Data per update], [Trade-off]),
  [Batch GD], [Whole dataset], [Stable and correct direction, but very slow and memory-heavy. Almost never used except on tiny datasets.],
  [Stochastic GD (SGD)], [1 sample], [Very fast per step; noise helps escape saddle points/sharp minima. But noisy, unpredictable convergence. Used for online/streaming learning.],
  [Mini-batch GD], [32–512 typically], [Best of both: good GPU parallelism, reasonably accurate gradient, just enough noise to help generalisation. *The practical default.*],
)

*Batch size effect:* small batches (16–32) add noise → help escape bad regions, improve generalisation. Large batches (1024+) give smoother gradients but may converge to sharp minima and need LR tuning or warm-up.

== Momentum

Plain GD *zig-zags* in narrow valleys: the gradient keeps pointing sideways across the valley walls, wasting time correcting direction instead of progressing.

#keybox(title: "Momentum Update Rule")[
$ v_t = beta v_(t-1) + nabla_theta L, quad quad theta <- theta - eta v_t $
$v$ = velocity (running average of past gradients); $beta approx 0.9$ (90% of previous direction retained).
]

*Effects:* smooths oscillating gradients; builds speed when gradients keep pointing the same way; carries the update forward even when gradients temporarily go small.

*Benefits:* accelerates convergence in long narrow valleys; reduces zig-zag; helps escape shallow local minima; more stable training. Many adaptive optimisers embed a form of momentum.

== Why Adaptive Optimizers Were Needed

Plain SGD uses *one global learning rate* for every parameter, but parameters behave very differently.

#table(columns: (0.9fr, 2.4fr),
  table.header([Problem], [Explanation]),
  [Uneven parameter sensitivity], [One shared LR makes some parameters learn too slowly and others become unstable; worsens with depth.],
  [Sparse gradients], [Common in NLP/recommenders where features are mostly zero. Those weights get gradients rarely → learn far slower.],
  [Saddle points and plateaus], [Gradient near zero in some directions, steep in others. An LR safe in one direction is wrong in another.],
)

*Solution:* give each parameter its *own effective learning rate* from its own gradient history — dampen noisy parameters, boost rarely-updated ones, accelerate stable directions.

== RMSProp

#keybox(title: "RMSProp")[
$ E[g^2]_t = beta E[g^2]_(t-1) + (1 - beta) g_t^2 $
$ theta <- theta - eta/(sqrt(E[g^2]_t) + epsilon) g_t $
Typical defaults: $beta = 0.9$, $epsilon = 10^(-8)$.
]

- Recent gradients *large* → denominator grows → *smaller* effective step (dampens instability).
- Recent gradients *small* → denominator shrinks → *larger* effective step (boosts slow learning).
- Reduces oscillation in steep directions, handles noisy mini-batch gradients, speeds up sparse parameters, needs little tuning → popular for RNNs and early deep models.
- *Limitation:* no explicit momentum, so it can still move slowly where gradients are consistent but small. This motivated Adam.

== Adam (Adaptive Moment Estimation)

Adam = *momentum (direction)* + *RMSProp-style adaptive scaling (step size)*.

#keybox(title: "Adam")[
$ m_t = beta_1 m_(t-1) + (1-beta_1) g_t quad quad "(1st moment — direction)" $
$ v_t = beta_2 v_(t-1) + (1-beta_2) g_t^2 quad quad "(2nd moment — step size)" $
$ hat(m)_t = m_t/(1 - beta_1^t), quad hat(v)_t = v_t/(1 - beta_2^t) quad quad "(bias correction)" $
$ theta <- theta - eta hat(m)_t/(sqrt(hat(v)_t) + epsilon) $
Bias correction is needed because both averages start at zero and would otherwise be systematically underestimated early in training.
]

#proscons[
- Handles noisy mini-batch gradients.
- Works well with sparse gradients.
- Minimal hyperparameter tuning.
- Converges quickly across many architectures.
][
- Can converge to *sharp minima* → may generalise worse than SGD.
- Can *hide* a poor learning-rate choice, making debugging harder.
]

#table(columns: (1fr, 1.6fr),
  table.header([Adam is a strong choice when…], [Adam may not be ideal when…]),
  [Training is difficult/unstable; architectures are deep or complex; gradients are sparse or noisy; early experimentation needing fast feedback with minimal tuning.],
  [Final generalisation is critical (sharp-minima risk); fine-tuning a pre-trained model; a well-conditioned problem — here SGD + momentum often reaches better final accuracy.],
)

#qcompare[
*The standard effective strategy:* start with *Adam* to reach a good region of the loss landscape quickly; once training stabilises, switch to *SGD with momentum* (often with an LR schedule) to fine-tune and improve final generalisation.
]

*Common mistakes:* using Adam blindly for every task; never adjusting the LR; using Adam for final fine-tuning without checking; assuming Adam always beats everything else.

== Learning Rate Scheduling

A *fixed* LR assumes the same step size is right at every training stage. Early training is far from the optimum with large gradients (bigger steps help); late training is near a minimum with small gradients (large steps now cause oscillation). A fixed LR forces a bad compromise: fast-but-poor-finish, or stable-but-extremely-slow.

#table(columns: (0.8fr, 2.5fr),
  table.header([Schedule], [Behaviour and notes]),
  [Step decay], [LR constant for a while, then drops sharply at predefined epochs (e.g. $times 0.1$). Simple, but needs manual tuning of when/how much.],
  [Exponential decay], [LR multiplied by a fixed factor each step/epoch — smooth continuous reduction. Risk: too aggressive → LR too small too early.],
  [Cosine annealing], [LR follows a cosine curve: high → smoothly decreasing → very small at the end. Very popular for large models; avoids sudden changes; often used with warm restarts.],
  [Warm-up], [Start with a very small LR, increase gradually over a few epochs, then switch to a decay schedule. Prevents unstable early updates; important for large batches and Transformers.],
)

*Common pattern:* short warm-up → main decay schedule (cosine or step). Stability at the start, fast progress in the middle, precise fine-tuning at the end.

#table(columns: (0.65fr, 1.25fr, 1.25fr),
  table.header([], [Adaptive (RMSProp, Adam)], [Scheduled (step/cosine/warm-up)]),
  [How it works], [Optimizer auto-adjusts step size *per parameter* from gradient history], [We explicitly change the *global* LR over time by a predefined plan],
  [Strength], [Powerful early; handles noisy/sparse gradients; little tuning; robust to varying gradient magnitudes across layers], [Precise control of step size; good for careful late-stage fine-tuning; often improves final generalisation],
  [Limitation], [Can converge to sharp minima; less explicit control late in training], [Requires manual design/tuning; does not adapt per parameter; sensitive to initial LR],
)

*Rule of thumb:* adaptive when training is difficult/noisy/exploratory; scheduled when training is stable and final performance matters most. Many pipelines combine both.

== Gradient Clipping (Full Treatment)

#keybox(title: "What Gradient Clipping Does")[
Before applying an update, check the gradient size. If within range, leave it. If too large, *scale it down*. Ensures no single update can be catastrophically large.
- *Clipping by value* — limits each individual gradient component to a fixed range. Simple, but can distort the gradient *direction*.
- *Clipping by norm* — scales the whole gradient vector if its norm exceeds a threshold. More common, because it *preserves direction* while limiting magnitude.
]

*It is a safeguard, not a cure-all:* it does not improve generalisation, does not fix vanishing gradients, and does not replace good LR choice or good initialization. Most useful for RNNs, very deep networks, and large learning rates.

== Common Optimisation Pitfalls

#table(columns: (0.8fr, 2.5fr),
  table.header([Pitfall], [Description]),
  [Saddle points], [Gradient near zero but not a minimum (downhill in some directions, uphill in others). *In high dimensions, far more common than bad local minima.* Optimizers stall — looks like convergence when it is not.],
  [Plateaus], [Extremely flat regions; tiny gradients, very slow learning. Common in deep nets and with saturating activations.],
  [Noisy gradients], [Mini-batch randomness. Helps escape saddle points, but makes the loss fluctuate and convergence harder to read.],
  [Poor conditioning], [Very different curvature in different directions → zig-zag updates, slow progress, high LR sensitivity. Fixed by momentum, adaptive methods, normalisation.],
)

#keybox(title: "Diagnosing the Real Problem")[
- Loss does *not decrease* or behaves erratically → an *optimisation* issue (fix: LR, optimizer, momentum, clipping, initialization).
- Loss *decreases but performance stays poor* → a *model capacity or data* issue.
]

*Reading loss curves:* smooth convergence (large batches) is easy to interpret but can settle in sharper minima. Noisy convergence (small batches, higher LR) is *normal, not failure* — noise helps escape saddle points and often finds flatter, better-generalising minima. Judge by the *long-term trend*, not short-term spikes.

#recall[
- Optimisation decides *how to use* gradients; it navigates a high-dimensional loss landscape.
- Update: $theta <- theta - eta (partial L)/(partial theta)$. LR too big → diverges; too small → painfully slow.
- Batch GD (whole dataset, stable/slow), SGD (1 sample, fast/noisy), *Mini-batch GD (32–512, the practical default)*.
- Momentum ($v <- beta v + nabla L$, $beta approx 0.9$) smooths zig-zag and builds speed in consistent directions.
- RMSProp adapts the LR *per parameter* from squared-gradient history. *Adam = momentum + RMSProp + bias correction* — fast, low-tuning, but can favour sharp minima; often switch to SGD+momentum for fine-tuning.
- Schedules (step, exponential, cosine annealing, warm-up) match step size to the training phase; adaptive is best early/noisy, scheduled best for stable precise finishing. Many pipelines combine both.
- Gradient clipping (by value or *by norm*) guards against exploding gradients *only*.
- Main pitfalls: *saddle points* (far more common than local minima in high dimensions), plateaus, gradient noise, poor conditioning.
- Diagnose: loss not decreasing → optimisation issue; loss decreasing but performance poor → capacity/data issue.
- Noisy loss curves are often *normal and beneficial* — judge by long-term trend.
]

// ============================================================================
= Regularisation and Generalisation
// ============================================================================

== Generalisation

- #dfn("Training error")[how well the model fits the data it was trained on.]
- #dfn("Generalisation error")[how well the model performs on unseen data (validation/test).]

A model can have very low training error and high generalisation error. Modern networks have such high capacity that they *can fit pure noise* — so good training performance alone guarantees nothing.

== Underfitting, Overfitting, Capacity

#table(columns: (1fr, 1fr, 1fr),
  table.header([Situation], [Training error], [Generalisation error]),
  [Underfitting], [High], [High],
  [Good fit], [Low], [Low],
  [Overfitting], [Low], [High],
)

- #dfn("Underfitting")[model too simple for the task. Causes: insufficient capacity, overly restrictive assumptions, inadequate features, *excessive regularisation*.]
- #dfn("Overfitting")[model too complex relative to the data. Memorises noise and quirks of the training set instead of general patterns.]
- #dfn("Model capacity")[expressive power. The *same* model can underfit or overfit depending on the data — these are properties of the model-and-data *combination*, not the model alone.]

== Bias-Variance Trade-off

#keybox(title: "Definitions")[
- *Bias* — error from overly simple assumptions. A high-bias model is too rigid; it makes systematic errors no matter how much data it sees. → *underfitting*.
- *Variance* — sensitivity to the specific training data. A high-variance model changes a lot with slightly different data and fits noise. → *overfitting*.
]

- Complexity *up* → bias down, variance up. Complexity *down* → bias up, variance down.
- Underfitting = high bias, low variance. Overfitting = low bias, high variance.
- Good generalisation lies in between: flexible enough for real patterns, stable enough to ignore noise.

== Detecting Overfitting

#keybox(title: "Three Key Symptoms")[
+ *Growing train–validation gap* — training loss keeps decreasing but validation loss stops improving or starts rising.
+ *Unstable validation metrics* — validation accuracy fluctuates a lot between epochs; small data/seed changes give noticeably different results.
+ *Poor behaviour on shifted inputs* — highly confident on training-like inputs, poor on slightly different ones. This reflects *memorisation*, not learning.
]

*Conditions that raise the risk:* high-capacity model on a small/noisy dataset; training too many epochs without monitoring; complex architectures with no constraints.

== L1 and L2 Regularisation

#keybox(title: "Regularised Objective")[
$ L_"total" = L_"data" + lambda space Omega(w) $
$lambda$ controls the trade-off: larger $lambda$ → simplicity; smaller $lambda$ → fit the data.
$ "L2 penalty": quad Omega(w) = sum_i w_i^2 quad quad quad "L1 penalty": quad Omega(w) = sum_i |w_i| $
]

*Geometric picture.* The unregularised loss forms concentric ellipses. L2 restricts the solution to a *circle*; because the boundary is smooth (no corners), L2 shrinks weights continuously toward zero but almost never *to* zero. L1's region is a *diamond* with sharp corners on the axes; the ellipse very often first touches a *corner*, driving some weights *exactly* to zero.

#table(columns: (0.85fr, 1.2fr, 1.2fr),
  table.header([Aspect], [L2 (Weight Decay)], [L1 (Sparsity)]),
  [Penalty], [$sum w_i^2$ (squared)], [$sum |w_i|$ (absolute)],
  [Constraint shape], [Circle (smooth)], [Diamond (sharp corners)],
  [Effect on weights], [Shrinks smoothly toward zero], [Drives some weights exactly to zero],
  [Result], [Smoother, more stable models; less noise-sensitive], [Sparse model; automatic feature selection],
  [Typical use], [Most common regulariser in deep nets], [When sparsity / feature selection is desired],
)

== Dropout

#dfn("Co-adaptation")[neurons relying heavily on other specific neurons, making the model fragile. Dropout removes this reliance.]

#keybox(title: "Dropout")[
During training, a *random subset* of neurons is deactivated for each mini-batch; a different subset each iteration. Dropped neurons take no part in the forward or backward pass for that step.
$ tilde(y) = (m ⊙ y) / p $
$y$ = normal output, $m$ = random binary mask (1 = keep, 0 = drop), $p$ = keep probability.
]

- Forces *redundant, distributed* representations — no fixed combination of features can be relied on.
- Also injects noise, which itself acts as a regulariser.
- *Training vs. inference:* applied *only during training*; at test time all neurons are active. Scaling is done during training (*inverted dropout*) to keep expected activations consistent.
- *Practical rates:* $0.1$–$0.3$ for input layers, $0.3$–$0.5$ for hidden layers. Less effective in very small networks; the rate needs tuning like any hyperparameter.

== Batch Normalisation

#keybox(title: "Batch Normalisation")[
For each mini-batch compute mean $mu_B$ and variance $sigma_B^2$ of the activations, then:
$ hat(x) = (x - mu_B) / sqrt(sigma_B^2 + epsilon), quad quad y = gamma hat(x) + beta $
$epsilon$ = small stability constant. $gamma$ (scale) and $beta$ (shift) are *learnable* — they let the network undo the normalisation if needed, so BN stabilises training without limiting what the network can represent.
]

*Benefits:* stabilises the distribution of layer inputs; allows *higher learning rates*; reduces sensitivity to weight initialisation; speeds up convergence; reduces "internal covariate shift".

*Why it also regularises:* it was not designed as a regulariser, but mini-batch statistics differ slightly batch to batch → this injects noise → an *implicit* regulariser, similar in spirit to dropout. It can therefore reduce the need for other regularisation.

== Early Stopping

#keybox(title: "How Early Stopping Works")[
+ Continuously monitor performance on a *validation set* during training.
+ When validation performance stops improving for a set number of epochs (the *patience*), stop.
+ *Restore the parameters from the best-validation epoch*, not the last epoch.
]

Training loss decreases steadily; validation loss decreases, hits a minimum, then rises as overfitting sets in. Early stopping picks that minimum. *Why it regularises:* it limits how complex the learned model can become, prevents weights from growing too large, and reduces memorisation of noise.

*Practical notes:* use patience so minor fluctuations do not trigger a stop; make sure the validation set is representative; needs no architecture change; combines well with other regularisers.

== Data Augmentation

#dfn("Data augmentation")[artificially increases the size and diversity of the training set by applying *label-preserving transformations*. Each transformed sample is treated as a new example.]

#table(columns: (0.6fr, 2.6fr),
  table.header([Data type], [Common transformations]),
  [Images], [Rotation, flipping, cropping, colour/contrast/exposure adjustment, blurring],
  [Text], [Synonym replacement, paraphrasing],
  [Audio], [Noise injection, time shifting],
)

The model learns *invariance* to small realistic changes. Must be applied carefully — augmentations that do not reflect real-world variation confuse the model and hurt performance. Domain knowledge decides what is appropriate.

== Implicit Regularisation from the Training Setup

#table(columns: (0.8fr, 2.5fr),
  table.header([Choice], [Effect on generalisation]),
  [Batch size], [Smaller batches add gradient noise → help avoid sharp minima → often generalise better. Larger batches are smoother/more stable but may generalise less well.],
  [Learning rate], [Very large → unstable training. Very small → fits training data extremely precisely, raising memorisation risk. Must be considered together with the number of epochs.],
  [Model capacity], [Too little → underfit; too much → overfit. Strategy: start simple, increase complexity only if needed.],
)

== Combining Regularisation Methods

#table(columns: (1.1fr, 1.7fr),
  table.header([Common combination], [Why]),
  [L2 + data augmentation], [Controls complexity while increasing data diversity],
  [BatchNorm + moderate dropout], [Used together but *carefully* — BN already adds noise],
  [Early stopping + LR scheduling], [Both control effective training duration],
  [Smaller batch size + L2], [Noise plus explicit weight constraint],
)

#keybox(title: "Pitfalls When Combining")[
- BatchNorm already introduces noise → reduces the need for strong dropout.
- Very strong dropout + very small batch sizes → unstable training.
- Too many regularisers at once → *underfitting*.
- *Goal: balance regularisation strength — not maximise it.*
]

*Recommended approach:* start from a simple baseline; add *one* technique at a time; monitor validation performance; adjust strength gradually.

== Practical Checklist for Preventing Overfitting

#keybox(title: "4-Step Checklist")[
+ *Diagnose first* — compare training vs. validation. Look for a large gap, rising validation loss, or highly unstable validation. Always ask "underfitting or overfitting?" *before* changing anything.
+ *Check the data* — is it large and diverse enough? Is the validation set representative? Any data leakage? If limited, consider augmentation.
+ *Revisit model complexity* — too large for the data? Reduce depth/width or add L2/dropout. Goal: the *simplest* model that performs well.
+ *Check training configuration* — batch size too large? LR too small? Too many epochs? Is early stopping enabled with validation monitoring?
]

#recall[
- Generalisation = performing well on *unseen* data. Training error $!=$ generalisation error.
- Underfitting = *high bias*, high train + high validation error. Overfitting = *high variance*, low train + high validation error.
- Complexity up → bias down, variance up (and vice versa) — the bias-variance trade-off.
- L2 shrinks weights *smoothly* toward zero (circular constraint); L1 drives some weights *exactly* to zero (diamond constraint → sparsity/feature selection).
- Dropout randomly deactivates neurons during training to stop *co-adaptation*; the full network is used at inference (inverted dropout scales during training).
- BatchNorm normalises activations per mini-batch with learnable $gamma, beta$; stabilises training, allows higher LRs, and acts as an *implicit* regulariser via mini-batch noise.
- Early stopping halts at the *best-validation* epoch (with patience) and restores those weights.
- Data augmentation = *label-preserving* transformations to increase diversity.
- Batch size, learning rate and model capacity regularise *implicitly* through the training setup.
- Combine regularisers *incrementally*; more is not better — too many at once causes underfitting. *Diagnose before intervening.*
]

// ============================================================================
= Convolutional Neural Networks
// ============================================================================

== Why Fully Connected Networks Fail on Images

#keybox(title: "Two Big Problems")[
+ *No use of spatial structure* — the model does not know two pixels are neighbours. A pattern shifted a few pixels looks like a totally different input.
+ *Parameter explosion* — every pixel connects to every neuron → an enormous number of weights → needs huge data and compute.
]

Nearby pixels are highly correlated, meaningful patterns are *local*, and the same pattern *repeats* at many locations. A good image model must exploit *spatial locality* and *repetition* — exactly what CNNs do.

== The Convolution Operation

#dfn("Convolution")[a local pattern-matching operation. A small grid of learnable weights (a *filter* / *kernel*) is applied to small regions of the input, one region at a time. The *same* filter is reused at every location — this is *weight sharing*.]

#keybox(title: "Convolution at One Location")[
$ y = sum_(i) sum_(j) w_(i j) space x_(i j) $
Each filter value is multiplied with the pixel under it; all products are summed into *one* output number = how strongly the filter matches that local region.
]

*How it slides:* start at the top-left block → compute one output → slide one step right → repeat → when out of room, move down a row and continue from the left. Filter weights never change while sliding. Collecting all outputs gives the *feature map*.

#keybox(title: "Why Convolution is Powerful")[
+ *Local connectivity* — captures spatial structure.
+ *Weight sharing* — drastically fewer parameters than a fully connected layer.
+ *Translation robustness* — the same filter applies everywhere, so a pattern is detected wherever it appears.
]

== Filters and Feature Maps

- #dfn("Filter")[a small set of *learnable* weights defining a pattern the network searches for. Learned by backpropagation from random initial values — never hand-designed.]
- #dfn("Feature map")[the grid of outputs from convolving *one* filter across the whole input. A *spatial response map*: high values = pattern strongly detected there.]

#keybox(title: "Key Rule")[
*One filter produces exactly one feature map.* Feature maps are *learned representations*, not images — they answer "how much does my learned pattern show up here?"
]

#table(columns: (0.7fr, 2.5fr),
  table.header([Depth], [What filters learn]),
  [Early layers], [See raw pixels → simple fundamental patterns: edges, corners, basic colour transitions.],
  [Middle layers], [Textures, repeated motifs.],
  [Deeper layers], [See feature maps (not pixels) → object parts and complex structures.],
)

== Channels and Multiple Filters

#keybox(title: "Convolution with Multiple Input Channels")[
An image is a 3D volume: height × width × channels (grayscale = 1, RGB = 3). A filter *spans all input channels* — separate weights per channel. At each location it convolves independently per channel, then *sums across channels* into one output number.
*Still one filter → one feature map.* Multiple channels change *how* the filter computes, not how many maps it produces.
]

A single filter detects one pattern type, so layers use *many* filters; each produces its own feature map, and the layer's output is a *stack* of feature maps.

#keybox(title: "Depth in a CNN")[
Depth here = *number of feature maps* at a layer (not the number of layers). Going deeper into a CNN:
- Spatial dimensions (height, width) usually *decrease*.
- Depth (channels/feature maps) usually *increases*.
A trade of precise spatial detail for richer, more abstract representation.
]

== Stride, Padding, Pooling

#table(columns: (0.7fr, 2.5fr),
  table.header([Control], [Effect]),
  [Stride], [How far the filter moves each step. Stride 1 = dense sampling, larger output. Larger stride = skips positions, smaller output, less compute, less spatial detail. *Example:* $7 times 7$ input, $3 times 3$ filter → $5 times 5$ at stride 1, but $3 times 3$ at stride 2.],
  [Padding], [Adds extra pixels (usually zeros) around the border, so the filter applies uniformly and border information is not lost. Controls output size. Choices: *no padding* (shrinks) or *same padding* (output size = input size).],
  [Pooling], [Summarises a small local region into one value. *No learnable parameters*; applied independently to each channel. $2 times 2$ pooling with stride 2 halves height and width, depth unchanged.],
)

- *Max pooling* — takes the maximum value in the region. *Average pooling* — takes the mean.
- Pooling makes the network robust to *small spatial shifts*: it emphasises *whether* a pattern is present over its exact location.

#table(columns: (1fr, 1fr),
  table.header([Pooling], [Strided convolution]),
  [Fixed operation (max/average), *no learning*], [*Learns* new filter weights while subsampling],
  [Adds robustness / invariance], [Combines down-sampling with feature learning],
)

== The Standard CNN Block and Full Pipeline

#keybox(title: "The Standard Repeating Block")[
*Convolution → Batch Normalisation → Activation → (sometimes) Pooling*
- *Activation (ReLU / Leaky ReLU)* — without it, stacked convolutions collapse into one linear transform.
- *BatchNorm* — normalises activations per mini-batch → faster, more stable training. Placed *after convolution, before activation*. Regularising side-benefit. #xref[formula in W7]
- *Dropout* — used mostly in the *fully connected* layers of a CNN; used cautiously in conv layers (can disrupt spatial feature learning).
]

#keybox(title: "End-to-End CNN Pipeline")[
+ Input image enters the network.
+ Conv + BN + Activation (repeated) — detect local patterns (edges, corners, textures).
+ Pooling — reduce spatial size, keep the important information, add shift robustness.
+ Steps 2–3 repeat, building increasingly abstract, less spatially precise feature maps.
+ *Flatten* — reshape the final feature maps ($H times W times C$) into one 1D vector. Pure structural step, no learning.
+ *Fully connected layers* — combine all features, learn *global* decision boundaries, output the prediction.
]

*In short:* convolutional layers = *feature extractor*; fully connected layers = *final reasoning / classifier*.

#keybox(title: "Shape Arithmetic Through a Block")[
Input $H times W times C$, apply $F$ filters of size $3 times 3$, stride 1, padding 1:
- After convolution: $H times W times F$ — spatial size preserved, depth becomes $F$.
- After $2 times 2$ pooling with stride 2: $H/2 times W/2 times F$ — spatial size halved, depth unchanged.
]

*Design trade-offs:* more filters → richer patterns, higher compute. Larger stride / aggressive pooling → faster and cheaper, but coarser spatial detail.

== Evolution of CNN Architectures

#table(columns: (0.7fr, 2.5fr),
  table.header([Architecture], [Key idea and contribution]),
  [LeNet], [One of the earliest successful CNNs (handwritten digits). Alternates convolution and pooling, then FC layers. *Proved conv + pool + FC can be trained end to end as one model.* Held back by small datasets and limited compute.],
  [AlexNet], [Same structure, *much larger scale*. Turning point: showed CNNs scale to real-world image datasets and beat traditional CV by a wide margin. Key ingredients: heavy *ReLU* use, *GPUs*, *dropout*.],
  [VGG], [Very uniform design: repeatedly stack small $3 times 3$ convolutions + pooling at regular intervals. Lessons: *depth matters*, and *stacking small filters beats fewer large filters*. Exposed the *degradation problem* — adding layers sometimes *increased* training error.],
  [ResNet], [*Skip / shortcut connections* let information bypass layers; a block learns only the *residual* (how output should differ from input). Gradients and information flow directly → reduces vanishing-gradient risk → networks of dozens/hundreds of layers become trainable. *Lesson: architectural design, not raw depth, makes very deep networks work.*],
  [MobileNets], [For resource-constrained deployment. *Separates spatial computation from channel-wise computation*, breaking one expensive convolution into much cheaper operations. Enables CNNs on phones and edge devices.],
  [EfficientNet], [Studies *how models should be scaled*. Scales depth, width and input resolution *together in a balanced, principled way*, achieving strong accuracy with fewer parameters and less compute for a given budget.],
)

#recall[
- FC networks fail on images: they ignore *spatial structure* and suffer *parameter explosion*. CNNs fix this with *local connectivity* and *weight sharing*.
- Convolution = local pattern matching: a filter slides over the input, multiplying and summing at each location to build a *feature map*.
- Filters are *learned* pattern detectors: edges/corners early, textures/parts/objects deeper.
- Multi-channel: one filter spans *all* channels and sums across them — *still one filter → one feature map*. Multiple filters → multiple feature maps → depth.
- Going deeper: spatial size *decreases*, depth (channels) *increases*.
- Stride controls sampling density/output size; padding controls border handling and output size; pooling (max/avg) reduces spatial size and adds shift robustness with *no learned parameters*.
- Standard block: *Conv → BatchNorm → Activation → (Pooling)*. Flatten converts feature maps into a vector; FC layers give the final prediction.
- Architecture evolution: LeNet (proof of concept) → AlexNet (scale + ReLU + GPU + dropout) → VGG (uniform depth via small $3 times 3$ filters, exposed the degradation problem) → ResNet (*skip connections*) → MobileNet/EfficientNet (efficiency and balanced scaling).
]

// ============================================================================
= Sequence Models: RNN, LSTM, GRU, Attention
// ============================================================================

== Why We Need Sequence Models

#dfn("Sequential data")[arrives in an *ordered* stream where each element depends on what came before. Text, speech, time series, user behaviour. Changing the order can completely change the meaning.]

#dfn("Sequence model")[a network that processes inputs one step at a time and keeps an internal *state* summarising everything seen so far. The output depends on the current input *and* the history.]

#table(columns: (0.9fr, 2.4fr),
  table.header([Task category], [Example]),
  [Sequence-to-one], [Whole sequence → one output (sentiment analysis, time-series forecasting)],
  [Sequence-to-sequence], [One sequence → another (machine translation, speech recognition)],
  [Sequence labelling], [Every element gets its own label (part-of-speech tagging)],
)

#keybox(title: "Why Feed-Forward Networks Fail — a Structural Problem")[
FFNs take a fixed-length input and process every input *independently*, assuming i.i.d. data. They have *no built-in memory*, so they cannot accumulate context over time.
This is *structural*, not a training problem: even a perfectly trained FFN cannot model sequences, because the architecture has no recurrence. Flattening a sequence into one fixed vector destroys order and timing information.
]

== Recurrent Neural Networks (RNNs)

#keybox(title: "Core RNN Equations")[
$ h_t = phi(W_"hh" h_(t-1) + W_"xh" x_t + b_h) $
$ y_t = psi(W_"hy" h_t + b_y) $
$x_t$ = input at time $t$, $h_t$ = hidden state (memory), $phi$ = usually $tanh$, $psi$ = output activation (e.g. softmax). *The same weight matrices are reused at every time step.*
]

- $h_t$ is a compact *running summary* of everything seen so far.
- *Parameter sharing* across time lets one model generalise to sequences of any length.
- #dfn("Unrolling")[drawing the RNN as a chain of repeated blocks, one per time step. It is the *same* cell with the *same* weights — unrolling only makes the flow of time explicit. Useful to (1) see temporal dependencies, (2) reason about gradient flow, (3) picture step-by-step processing.]

*Sequence classification example* — "The movie was not good.": the hidden state accumulates neutral context, then must *remember the negation* at "not", and combine it with "good" to reach the correct negative sentiment. The final hidden state goes through a classification layer. If the model forgets "not", it predicts the wrong sentiment.

== BPTT and the Vanishing Gradient in RNNs

#dfn("Backpropagation Through Time (BPTT)")[the RNN is unrolled across all time steps and error from later steps is propagated backward to earlier ones. Because weights are shared, gradients flow through many *repeated* computations.]

#keybox(title: "Vanishing Gradients in RNNs — the Delta vs. Deep FFNs")[
During BPTT, gradients are repeatedly multiplied by the *same* weight matrices and the *same* activation derivatives at every time step. Multiplying many values $< 1$ drives the product toward 0.
*Consequence:* early time steps receive almost no learning signal → the model becomes biased toward *recent* inputs and cannot learn long-term dependencies.
*Why it is worse than in FFNs:* the effective depth equals the *sequence length*, so the longer the sequence, the unavoidably worse the problem. #xref[general mechanism in W5]
]

== Limitations of RNNs Beyond Vanishing Gradients

#keybox(title: "Three Persistent Structural Limitations")[
+ *Sequential computation (no parallelism)* — each step depends on the previous hidden state, so time steps cannot be computed in parallel → slow on GPUs, especially for long sequences.
+ *Fixed-size hidden state (information bottleneck)* — the entire history is compressed into one fixed-size vector; longer/more complex sequences lose detail.
+ *Difficulty with global / long-range context* — information from early steps must pass through many intermediate states, so directly relating far-apart elements stays hard even with LSTM/GRU.
]

== Long Short-Term Memory (LSTM)

LSTMs add an explicit *memory cell* that carries information forward with only minimal modification, instead of being recomputed every step. Crucially, they *separate memory storage from memory updates*.

Two states per time step: the *cell state* $C_t$ (long-term memory) and the *hidden state* $h_t$ (current output). Three learned gates, each with a *sigmoid* (0 = block completely, 1 = let everything through).

#keybox(title: "The Three LSTM Gates")[
*Forget gate* — what to remove from the cell state:
$ f_t = sigma(W_f dot [h_(t-1), x_t] + b_f) $
*Input gate* — what new information to add:
$ i_t = sigma(W_i dot [h_(t-1), x_t] + b_i), quad quad tilde(C)_t = tanh(W_C dot [h_(t-1), x_t] + b_C) $
*Cell state update* — combine what we keep with what we add:
$ C_t = f_t ⊙ C_(t-1) + i_t ⊙ tilde(C)_t $
*Output gate* — how much of the cell state becomes the visible hidden state:
$ o_t = sigma(W_o dot [h_(t-1), x_t] + b_o), quad quad h_t = o_t ⊙ tanh(C_t) $
]

#keybox(title: "How LSTM Solves the Vanishing Gradient Problem")[
The cell state is updated mostly by *addition* (via the forget/input gates), *not* by repeated matrix multiplication and squashing at every step. Gradients therefore flow across many time steps with much less shrinkage, and the gates give smooth, controlled updates.
]

== Gated Recurrent Units (GRU)

GRUs simplify LSTM: *one* combined hidden state instead of a separate cell state, and *two* gates instead of three.

#keybox(title: "The Two GRU Gates")[
*Update gate* $z_t$ — combined role of LSTM's forget + input gates: how much past to keep vs. new information to bring in.
$ z_t = sigma(W_z dot [h_(t-1), x_t]) $
*Reset gate* $r_t$ — how much of the past hidden state to use when computing the candidate. When $r_t approx 0$, the model mostly ignores the past.
$ r_t = sigma(W_r dot [h_(t-1), x_t]) $
*Candidate and final hidden state:*
$ tilde(h)_t = tanh(W dot [r_t ⊙ h_(t-1), x_t]), quad quad h_t = (1 - z_t) ⊙ h_(t-1) + z_t ⊙ tilde(h)_t $
]

#table(columns: (0.85fr, 1.2fr, 1.2fr),
  table.header([Aspect], [LSTM], [GRU]),
  [States], [Separate cell state + hidden state], [Single combined hidden state],
  [Gates], [3 (forget, input, output)], [2 (update, reset)],
  [Parameters], [More], [Fewer],
  [Expressiveness], [Higher — finer memory control], [Slightly lower, but often close],
  [Training speed], [Slower], [Faster, easier on small data],
  [Best suited for], [Very long / complex sequences (long-range language modelling)], [Smaller datasets, shorter sequences, rapid prototyping],
)

*Rule of thumb:* start with the simpler GRU; move to LSTM only if you need more expressiveness.

== Attention

Instead of compressing everything into one hidden state, attention gives *direct access to all parts of the sequence*, weighting each by current relevance.

#keybox(title: "Attention — Core Idea")[
$ alpha_i = "softmax"("score"(q, k_i)), quad quad "context" = sum_i alpha_i h_i $
$alpha_i$ = attention weight for position $i$ (how relevant it is right now). The context vector is a *weighted focus over the whole sequence*, not a single fixed summary.
]

*Why attention helps:* direct access to distant elements → long-range dependencies become easy; removes the fixed-size hidden-state bottleneck; captures global relationships.

*Attention vs. recurrence:* RNNs rely on *memory compression* (squeeze the past into one evolving state). Attention relies on *selective access* — instead of remembering everything, the model learns *where to look*.

== Transformers

#dfn("Transformer")[a sequence model built entirely on attention — *no recurrence, no convolution*. It processes all elements of a sequence *in parallel*.]

#dfn("Self-attention")[lets each element directly consider *all* other elements at once, instead of passing information step by step through time. The model learns which parts are relevant to each other, capturing global dependencies directly.]

#keybox(title: "Why Transformers Dominate")[
+ *Parallel processing* — no step-by-step dependency → far faster training on long sequences.
+ *Direct long-range modelling* — no memory-compression bottleneck; any two positions interact directly.
+ *Scales extremely well* — performance keeps improving with more data and larger models.
]

#table(columns: (0.85fr, 1.2fr, 1.2fr),
  table.header([Aspect], [RNN (incl. LSTM/GRU)], [Transformer]),
  [Processing], [Sequential, step by step], [Parallel, all positions at once],
  [Memory of past], [Compressed into one hidden state], [Directly accessed via attention],
  [Long-range dependency], [Hard — must pass through many steps], [Easy — direct connection between any two positions],
  [Training speed (long seq.)], [Slow], [Fast],
)

Now used in machine translation, language modelling, speech, computer vision, and multimodal tasks. #xref[future trends in W13]

#recall[
- Sequential data has *order-dependent* meaning; feed-forward nets fail because they assume i.i.d. inputs and have *no memory* — a structural, not a training, limitation.
- RNN: $h_t = phi(W_"hh" h_(t-1) + W_"xh" x_t + b_h)$, with the *same shared weights at every time step* (parameter sharing).
- Trained with *BPTT*; repeated multiplication of small values across time causes vanishing gradients, biasing learning toward *recent* inputs. Effective depth = sequence length.
- Even gated models keep 3 limits: *no parallelism*, a *fixed-size hidden-state bottleneck*, and difficulty with *global/long-range* context.
- LSTM = explicit *cell state* + 3 gates (forget, input, output); the cell state is updated mostly by *addition*, so gradients survive long sequences.
- GRU = single hidden state + 2 gates (update, reset) — fewer parameters, faster, often comparable. *Start with GRU; move to LSTM if you need more expressiveness.*
- Attention replaces *memory compression* with *selective access*: a weighted focus over the whole sequence.
- Transformers are built entirely on *self-attention*, process all positions *in parallel*, and dominate modern sequence modelling.
]

// ============================================================================
= Model Evaluation and Performance Metrics
// ============================================================================

== Why Accuracy Alone Is Not Enough

- Deep networks are highly expressive — they can fit extremely complex patterns and even *pure random noise*, so strong training performance can be misleading.
- A model may exploit *spurious correlations* (shortcuts) — e.g. detecting "green grass" instead of "cow" — scoring high on the test set but failing in the real world.
- Neural networks output a full *probability distribution*; two models with the *same accuracy* can behave very differently in confidence. In healthcare or fraud detection, confidence matters as much as the prediction.

#keybox(title: "The Four Pillars of Neural Network Evaluation")[
+ *Predictive performance* — accuracy, precision, recall, F1.
+ *Generalisation behaviour* — overfitting patterns, training vs. validation curves.
+ *Confidence quality* — calibration: does confidence match reality?
+ *Robustness and uncertainty* — stability under small input changes; how the model says "I'm not sure".
]

== Confusion Matrix and Classical Metrics

#table(columns: (0.7fr, 2.5fr),
  table.header([Cell], [Meaning (fraud-detection example)]),
  [True Positive (TP)], [Actual fraud, correctly predicted as fraud],
  [False Negative (FN)], [Actual fraud, wrongly predicted as not fraud — *a miss*],
  [False Positive (FP)], [Not fraud, wrongly predicted as fraud — *a false alarm*],
  [True Negative (TN)], [Not fraud, correctly predicted as not fraud],
)

#keybox(title: "Core Formulas")[
$ "Accuracy" = ("TP" + "TN")/("TP" + "TN" + "FP" + "FN") quad quad "Precision" = "TP"/("TP" + "FP") $
$ "Recall" = "TP"/("TP" + "FN") quad quad F_1 = 2 dot ("Precision" dot "Recall")/("Precision" + "Recall") $
$F_1$ = *harmonic mean* of precision and recall — useful when classes are imbalanced and both error types matter.
]

*Worked example* (1000 predictions: TP = 60, FP = 40, FN = 20, TN = 880): Accuracy = 94%, Precision = 60%, Recall = 75%. Accuracy looks excellent while precision is poor — this is exactly why accuracy alone hides *what kind* of mistake is being made.

- *Precision/recall trade off:* a more sensitive model catches more true positives (higher recall) but raises more false alarms (lower precision).
- *Medical diagnosis* → prioritise *recall* (missing a disease is dangerous). *Spam filtering* → prioritise *precision* (blocking a real email is worse than letting spam through).

#keybox(title: "Metrics Depend on the Decision Threshold")[
Networks output probabilities; a threshold (commonly 0.5) turns them into labels. *The same trained model* gives very different confusion matrices — and hence very different accuracy/precision/recall/F1 — simply by changing that threshold. Metrics reflect *both* the model *and* our evaluation choices.
]

== Loss Surfaces and Optimisation Geometry

#dfn("Loss surface")[describes how the loss changes as the model's parameters vary. Each point = one setting of all weights; the height = the loss for that setting. Training moves across this surface in *parameter* space, not input space.]

#table(columns: (1fr, 2fr),
  table.header([Point type], [Definition]),
  [Local minimum], [Loss increases in *every* direction around this point.],
  [Saddle point], [Loss goes downhill in some directions and uphill in others *at the same time*. In high dimensions, saddle points are *far more common* than bad local minima and are a bigger source of optimisation difficulty.],
)

*Steepness and dynamics:* steep regions → large gradients → fast but potentially unstable updates. Flat regions → small gradients → slower but more stable updates. This is why training is so sensitive to the learning rate.

== Flat vs. Sharp Minima

#table(columns: (0.9fr, 1.2fr, 1.2fr),
  table.header([Aspect], [Flat minimum], [Sharp minimum]),
  [Geometry], [Wide valley], [Narrow pit / steep well],
  [Sensitivity to small parameter changes], [Low — robust], [High — fragile],
  [Typical generalisation], [Better on unseen data], [Prone to overfitting],
)

*What influences which minimum is reached:* learning rate, batch size, and the natural noise in SGD. *Noisier* optimisation explores wider regions → biases training toward *flatter* minima. This links training configuration directly to generalisation.

== Overfitting Patterns in Deep Models

#keybox(title: "The Most Reliable Overfitting Signal")[
Training loss keeps decreasing steadily, while validation loss improves at first then *plateaus or starts increasing*. What matters is *how the two curves move relative to each other*, not their absolute values.
]

- Overfitting in deep models is *progressive*, not sudden; it can appear late, develop gradually, or be partly hidden by noisy validation metrics.
- *Loss is a more reliable diagnostic than accuracy*: training accuracy keeps rising while validation accuracy just plateaus or fluctuates — the divergence is much harder to see. A *rising validation loss* means the model is becoming increasingly *confident in wrong predictions*, even when accuracy looks stable.

== Calibration

#dfn("Calibration")[honesty in confidence. If a well-calibrated model says it is 80% confident about a group of predictions, roughly 80% of those should actually be correct. Calibration is not about being *right* — it is about knowing *how sure* you should be.]

- *Overconfident* — predicted probabilities *higher* than true accuracy. Modern neural networks are usually overconfident.
- *Underconfident* — predicted probabilities *lower* than the true accuracy justifies.

#keybox(title: "Reliability Curve — How to Build One")[
+ Group predictions into *bins* by confidence (e.g. all predictions between 70% and 80%).
+ For each bin compute the *average confidence* and the *observed accuracy*.
+ Plot average confidence vs. observed accuracy per bin. A perfectly calibrated model lies exactly on the diagonal.
]

#keybox(title: "Expected Calibration Error (ECE)")[
$ "ECE" = sum_(m=1)^(M) (|B_m|)/n space |"acc"(B_m) - "conf"(B_m)| $
$M$ = number of bins, $|B_m|$ = predictions in bin $m$, $n$ = total predictions.
*Lower ECE = better calibration* — the average gap between what the model claims and what is true.
]

*Worked example:* a classifier at 95% accuracy had ECE = 4.5% (0.045) — i.e. stated confidence differs from true correctness by about 4.5 percentage points on average.

== Improving Calibration

#keybox(title: "Temperature Scaling")[
Divide the logits by a learned constant $T$ before softmax:
$ p_i = "softmax"(z_i \/ T) $
- $T > 1$ *softens* the distribution (reduces overconfidence). $T < 1$ *sharpens* it.
- Dividing all logits by the same constant *does not change which class scores highest* → *accuracy stays exactly the same*, only confidence changes.
]

*Worked example:* temperature scaling brought ECE from 4.5% down to ~2%, with accuracy unchanged at 95%.

#dfn("Ensembles")[combine predictions from multiple independently trained models. Individual models are overconfident in *different, inconsistent* ways, so averaging their probabilities smooths out the extremes.]

*Worked example:* a 5-model ensemble improved ECE only modestly (4.5% → ~4.1%) versus temperature scaling's 2% — ensembling helps calibration *indirectly*, and not always as strongly as directly rescaling confidence.

== Robustness

- #dfn("Perturbation")[a small, realistic change to an input (noise, measurement shift, natural variability) that does *not* change its true meaning or label.]
- #dfn("Robustness")[how *stable* a model's predictions are when the input is slightly perturbed. Two inputs that mean the same thing should get (roughly) the same answer.]

#keybox(title: "Three Reasons Neural Networks Are Fragile")[
+ They learn highly *nonlinear* decision boundaries.
+ Input spaces are *high-dimensional* — small changes along certain directions have a large output effect.
+ Standard training optimises *average* performance over the dataset, not *local stability* around each point.
]

Dangerously, the model often stays *highly confident while being wrong* — instability plus confidence is a particularly risky combination. (Demo: 85% confident "polar bear" → after an imperceptible perturbation, 100% confident "dishwasher".)

#table(columns: (0.8fr, 2.5fr),
  table.header([Property], [Question it answers]),
  [Generalisation], [How well does the model perform on new, unseen examples *overall*?],
  [Robustness], [How stable is the prediction *in the neighbourhood around one given example*?],
)

A model can generalise well on average and still be locally unstable. Standard test sets only check individual points and never probe their neighbourhood — so robustness issues stay invisible unless tested explicitly.

#dfn("Sensitivity curve")[plots accuracy (y-axis) against increasing perturbation/noise strength (x-axis).]

#table(columns: (0.8fr, 2.5fr),
  table.header([Curve shape], [Meaning]),
  [Flat], [*Robust* model — accuracy barely drops as noise increases.],
  [Gradual decline], [*Graceful degradation* — performance drops slowly and predictably.],
  [Sharp collapse], [*High sensitivity* — a small noise increase causes a sudden, large accuracy drop. Cannot be trusted in production.],
)

== Uncertainty and Softmax Entropy

- #dfn("Confidence")[the *highest* predicted probability — how sure the model is about its top choice.]
- #dfn("Uncertainty")[how *spread out* the probability mass is across all classes.]

A model can be confident about the *wrong* class and uncertain about the *right* one — related but distinct ideas.

#keybox(title: "Softmax Entropy")[
$ H(p) = - sum_(i=1)^(C) p_i log(p_i) $
*Low entropy* → probability mass concentrated on one class (confident). *High entropy* → mass spread across several classes (uncertain).
]

*Worked demo* (4-class, 86% accuracy): average entropy was much lower for *correct* predictions ($approx 0.17$) than for *incorrect* ones ($approx 0.49$) — entropy carries real diagnostic signal.

#keybox(title: "Important Caveat")[
Uncertainty is a *signal, not a guarantee*. Models can still be *confidently wrong* — low entropy does not prove correctness. This is exactly why calibration and robustness must be evaluated too.
]

#recall[
- Accuracy alone is not enough: high capacity lets deep nets memorise noise and hides confidence, generalisation and robustness problems.
- The confusion matrix (TP, FP, FN, TN) underlies accuracy, precision, recall and F1 — and *all of them change with the decision threshold*.
- Loss surfaces are complex, with many minima and (far more commonly) *saddle points*.
- *Flat minima* (wide valleys, robust to small parameter changes) generalise better than *sharp minima*. LR, batch size and SGD noise decide which you land in.
- Overfitting is *progressive*; the train/validation *loss* gap is more reliable than accuracy, which can plateau while the model quietly grows overconfident.
- *Calibration* asks whether confidence is honest; measured by *ECE*, visualised with reliability curves.
- *Temperature scaling* fixes confidence *without changing accuracy*; ensembles improve calibration indirectly by averaging out individual overconfidence.
- *Robustness* (local stability under perturbations) is separate from generalisation and must be tested explicitly with *sensitivity curves* (flat = robust, sharp collapse = fragile).
- *Softmax entropy* quantifies uncertainty — low = confident, high = uncertain — but confidence is a *signal, not a guarantee*.
]

// ============================================================================
= Model Diagnostics and Debugging
// ============================================================================

== From Evaluation to Diagnostics

*Evaluation* tells us *what* went wrong (the model performs poorly). *Diagnostics* tells us *where and why* it went wrong inside the model.

*Why debugging neural networks is hard:* failures are often *silent* — training runs without crashing but no real learning happens. Different problems (loss plateau, unstable loss, exploding loss, a layer that stops learning) look identical from outside, and surface metrics rarely reveal the cause. But failures are not random — they leave *internal signals*.

#keybox(title: "The Three Diagnostic Signals")[
- *Gradients* — are learning signals *flowing* through the network?
- *Activations* — are neurons *alive and responding*, or dead/saturated?
- *Parameters* — are weights and normalisation statistics *changing in a healthy way*?
Every failure mode shows up in at least one of these three.
]

== Gradient Flow Diagnostics

Gradient problems are usually inspected *first*, because they *propagate forward*: they affect weight updates → activations → outputs. Fixing gradient flow often resolves many downstream issues automatically.

#keybox(title: "Layerwise Gradient Norm")[
$ ||g^((l))||_2 = sqrt(sum_i (g_i^((l)))^2) $
Track this per layer, per training step. Plot against layer depth, or as a heat map over epochs, to see whether gradients reach everywhere.
]

#table(columns: (1fr, 1.5fr),
  table.header([Healthy gradient flow], [Unhealthy — warning signs]),
  [No layer has near-zero gradients (learning reaches every layer); gradients are not exploding; values stay in a reasonable, fairly stable range with some natural fluctuation.],
  [Early layers with near-zero gradients; sudden gradient explosions; highly unstable gradients swinging wildly across epochs.],
)

#table(columns: (0.75fr, 1.05fr, 1.5fr),
  table.header([Pathology], [Typical cause], [Diagnostic signature]),
  [Vanishing gradients], [Deep network + saturating activations (tanh) with standard init], [Gradients extremely small in early layers, increasing only near the output — *"early layers go dark"*],
  [Exploding gradients], [Excessively high learning rate on a deep network], [Gradients start small, grow rapidly in later layers, steeper near the output — *"large, unstable spikes"*],
  [Dead gradient paths], [Extremely small weight init, or a configuration/architecture error], [Gradient norm *exactly zero* across all layers — signal completely *blocked*, not just decaying],
)

#keybox(title: "Important Distinction")[
*Vanishing gradients* are a *numerical decay* problem — small but non-zero, shrinking with depth. A *dead gradient path* is a *configuration/architectural* issue — exact zeros everywhere (bad init, frozen layers, gradients explicitly blocked in the graph). #xref[underlying mechanism in W5]
]

*Key lessons:* most gradient issues come from *configuration choices* (init scale, learning rate), not code bugs. Debugging should start with *diagnostics*, not with guessing fixes.

== Activation Diagnostics

#dfn("Dead ReLU")[a ReLU neuron that always outputs 0 for all inputs. Its local gradient is 0, so its weights stop updating and it *typically cannot recover* — a permanent dead region.]

*Detection:* track the *fraction of activations that are exactly zero* in each ReLU layer over training. A layer quickly reaching 70–80% zeros has effectively gone dead.

*Common causes:* high learning rates (large updates push weights into an always-negative region); poor weight initialization; large negative biases; deep networks trained without normalisation.

#dfn("Saturation")[sigmoid/tanh outputs cluster near the flat limits (0/1 for sigmoid, −1/+1 for tanh). There the activation derivative is near zero, and since backprop *multiplies* by that derivative, the gradient shrinks drastically.]

#table(columns: (0.8fr, 1.3fr, 1.3fr),
  table.header([Aspect], [Dead ReLU], [Saturated Sigmoid / Tanh]),
  [Output], [Exact zero], [Constant near a limit (0/1 or −1/+1)],
  [Cause], [Weights pushed into always-negative-input region], [Large pre-activation values push outputs to the flat ends],
  [Effect on gradient], [Near-zero], [Near-zero],
  [Shared consequence], [Silently reduces the model's learning capacity], [Same],
)

#keybox(title: "Monitoring Activation Distributions — What to Look For")[
- *Across layers* (fixed point in training): similar spread and medians, no layer showing extreme collapse or saturation → stable, balanced behaviour across depth.
- *Across time* (one layer over epochs): stable distributions, no major drift or collapse → healthy, controlled learning.
- *Fraction of zero ReLU activations:* ~40–60% is *common and often healthy*. Watch the *trend*, not the absolute number — a slowly varying or stable curve is fine; a gradual, unbounded increase signals growing dead-neuron capacity loss.
*Caveat:* dead ReLUs can increase gradually *while training loss keeps decreasing* — the loss curve hides this completely.
]

== Parameter Diagnostics

*Why monitor weight distributions:* they reveal whether learning is balanced across layers, whether weights are collapsing or exploding, and whether some layers are effectively untrained — all invisible in loss curves.

- *Healthy across layers:* similar distributions, no extreme spread or collapse, no single layer dominating in magnitude.
- *Healthy across time:* distributions for a given layer remain largely stable epoch to epoch.

#dfn("Weight norm")[one norm value per layer per step — a compact "heartbeat" for training dynamics.]

#table(columns: (0.9fr, 2.4fr),
  table.header([Weight-norm behaviour], [Interpretation]),
  [Flat (barely changing)], [Layer may be *frozen* or undertrained],
  [Rapidly / inconsistently growing], [*Unstable* optimisation (e.g. LR too high); risk of divergence],
  [Smooth, gradual growth], [*Healthy* training],
)

*Note:* different layers are *expected* to show different norm dynamics — e.g. an output layer (fewer parameters, directly constrained by the loss) often has a smaller, more slowly growing norm. This is normal.

#table(columns: (0.8fr, 1.1fr, 1.5fr),
  table.header([Anomaly], [Typical cause], [Detection signature]),
  [Frozen layer], [`requires_grad = False` set by mistake, or optimizer misconfiguration], [Nearly flat weight norm across all epochs — no gradient updates reaching it],
  [Exploding weights], [Learning rate too high], [Weight norms grow rapidly and inconsistently across layers — risk of divergence/NaN],
  [Undertrained output layer], [A much smaller learning rate assigned to that layer], [That layer's norm grows much more slowly than others — a performance bottleneck],
)

== BatchNorm Diagnostics

BatchNorm layers maintain *running mean* and *running variance*. Monitoring them helps detect internal covariate shift, unstable feature distributions, or layers not learning properly — instabilities that may never show up in loss/accuracy curves.

#keybox(title: "Common Misconceptions")[
- BatchNorm statistics *do not* need to converge to the same value across layers.
- A small variance is *not* inherently bad.
- Different layers are *expected* to behave differently — deeper layers learn different feature scales, so differing running mean/variance magnitudes across layers is *normal*.
- These statistics are *diagnostic tools*, not pass/fail correctness tests.
]

== A Structured Debugging Workflow

#keybox(title: "Symptom-to-Diagnostic Mapping")[
- Loss is *stuck* → first check *gradients*.
- Loss is *unstable* → check *weight norms* and *batch norm statistics*.
- Model *underfits* → look at *activations*.
- Something feels *strange* → inspect *parameters* for frozen or broken layers.
]

#keybox(title: "Case Study — Diagnosing a Broken Network")[
Setup: excessive depth, a very high learning rate, no normalisation.
+ *Observe:* training loss jumps up then plateaus high; gradient norm spikes early then stabilises. Flat-high loss + flat-high gradient norm ⇒ *learning rate probably too large*.
+ *Inspect gradients:* despite large early gradients, final layer-wise gradients are near zero — gradient flow has *collapsed*.
+ *Inspect activations:* dead-ReLU fraction rises sharply to 80–90% in the final layers. High LR pushed activations permanently negative — a *silent failure*: loss looks stable but learning has stopped.
+ *Inspect parameters:* weight norms are stable across layers — rules out a parameter-level anomaly as root cause.
+ *Synthesise:* high LR → unstable early updates → dead ReLUs → blocked gradient flow → gradients collapse → training stalls *without any explicit divergence*. Not detectable from the loss curve alone.
+ *Apply fix and remeasure:* reduce the learning rate (here by 100×). Loss then decreases smoothly, gradient norms decay instead of exploding, and the dead-ReLU problem resolves — confirming the root cause.
]

*Key lessons:* the learning rate is often the *first* thing to debug — one root cause behind many seemingly unrelated symptoms. High LRs can *silently kill neurons*. Effective debugging combines *multiple* signals. Secondary fixes (He/Xavier init, BatchNorm, Leaky ReLU, gradient clipping) help but *none compensates for a fundamentally wrong learning rate*.

== Monitoring Tools and Experiment Tracking

#dfn("TensorBoard")[a visualisation dashboard for training: monitor in real time, compare experiments, inspect internal behaviour. A `SummaryWriter` logs *scalars* (loss, gradient norm) and *histograms* (weight/bias distributions) to a log directory.]

*Common TensorBoard mistakes:* watching too many signals at once; focusing on single points instead of trends; treating it as a *replacement* for debugging reasoning rather than a complement. *Good habit:* start with loss and gradients, drill deeper only if something looks wrong.

#keybox(title: "What Every Experiment Must Record")[
+ Model architecture
+ Dataset (and splits)
+ Hyperparameter configuration
+ Logged metrics / artefacts
+ A *unique identifier* (prevents overwriting logs, allows fair comparison)
*Key principle:* if an experiment cannot be reproduced, it effectively does not exist.
]

*Common tracking mistakes:* overwriting logs (no unique run ID); forgetting to record hyperparameters; relying on memory instead of a saved config file; keeping results only inside notebooks.

#recall[
- Diagnostics looks *inside* the model for *why* it fails. Three core signals: *gradients, activations, parameters*.
- Vanishing gradients (early layers go dark), exploding gradients (large unstable spikes) and *dead gradient paths* (uniform exact zeros) each have distinct signatures, measured via layerwise gradient L2 norms.
- *Dead ReLUs* output exact zero permanently and rarely recover; *saturated sigmoid/tanh* sit near their limits — both give near-zero gradients and silently reduce learning capacity.
- Healthy activation and weight distributions look *similar across layers* and *stable across time*. ~40–60% zero ReLU activation is normal — *watch the trend, not the number*.
- Weight norms are a compact "heartbeat": *flat = frozen*, *rapidly growing = unstable*, *smooth growth = healthy*.
- Parameter anomalies (frozen, exploding, undertrained layers) are found by comparing against a *healthy baseline*.
- BatchNorm running mean/variance *differing across layers is normal*, not a bug.
- Debugging workflow: stuck loss → gradients; unstable loss → norms/BatchNorm; underfitting → activations; strange behaviour → parameters. Then: observe → gradients → activations → parameters → fix → *remeasure*.
- *The learning rate is the most common root cause.* TensorBoard gives visibility; unique run IDs + logged configs give reproducibility.
]

// ============================================================================
= Hyperparameter Tuning and Experiment Control
// ============================================================================

== Why Manual Tuning Fails

Training a deep model is *not deterministic*: learning rate, batch size, initialisation, data order and randomness all influence the outcome. Two people training the same model can get very different results — training a network is *running an experiment*, not just running code.

#keybox(title: "Three Reasons Manual Tuning Breaks Down")[
+ *Highly non-linear dynamics* — a small change in LR or batch size can completely change behaviour; intuition becomes unreliable.
+ *Combinatorial explosion* — even 4 hyperparameters with 10 candidate values each gives $10^4$ combinations. Not feasible manually.
+ *Human bias* — people try familiar values, stick with early results, and miss better configurations elsewhere.
]

Automated search removes bias, explores systematically, and finds solutions a person would never try.

== The Hyperparameters That Matter

#keybox(title: "The Four Dominant Hyperparameters")[
- *Learning rate* — how fast the model learns and how stable training is.
- *Batch size* — how much noise/stability is in each gradient update.
- *Model capacity (depth and width)* — how much complexity can be represented.
- *Regularisation strength* — how much the model is constrained against overfitting.
If these four are badly chosen, *no optimizer or architecture can save the model*.
]

#keybox(title: "They Interact — Rules of Thumb")[
- A *large learning rate* may require a *smaller batch size* to stay stable.
- A *large model* needs *stronger regularisation* to avoid overfitting.
- A *small dataset* requires a *smaller model*, so it does not simply memorise the data.
Tuning is about balancing interacting forces, not tuning each knob in isolation.
]

== Learning Rate — Symptoms of a Bad Choice

The LR scales *every* change to *every* weight — even perfectly computed gradients get distorted by a bad learning rate. #xref[update rule in W6]

#table(columns: (0.85fr, 2.4fr),
  table.header([Learning rate], [Observed behaviour]),
  [Very low (e.g. $10^(-5)$)], [Loss decreases on a very gentle slope. Stable but inefficient; can also get stuck in suboptimal solutions, especially in deep networks.],
  [Moderate (e.g. $10^(-3)$)], [Loss decreases smoothly and converges — *healthy training*.],
  [High (e.g. $10^(-1)$)], [Loss *oscillates* and struggles to converge — parameters keep overshooting the minimum.],
  [Very high (e.g. $1$–$10$)], [Loss *diverges* or becomes unstable — training fails completely.],
)

*The LR interacts strongly with batch size and optimizer choice:* small batches, large models and strong regularisation all make training more LR-sensitive.

#qcompare[
*Practical rule:* always tune the *learning rate first*. If training diverges, reduce it. If training is too slow, increase it cautiously.
]

== Batch Size

Batch size does *not* change the objective function — it changes *how the model moves along the loss surface*.

#table(columns: (0.9fr, 2.4fr),
  table.header([Batch size], [Effect]),
  [Small], [Noisy but frequent updates (high gradient variance). Better *exploration* — can escape sharp, poor regions.],
  [Large], [Smooth, stable, less stochastic updates. Can converge to *sharper* minima.],
  [Full batch], [Smoothest and most stable gradients, but updates computed rarely and are almost deterministic.],
)

*Key takeaway:* batch size controls *gradient noise*, not the loss function. Batch size and learning rate must be tuned *together*.

== Automated Hyperparameter Search

#dfn("Grid search")[evaluates *all* combinations of a predefined set of values (e.g. 3 LRs × 3 batch sizes = 9 runs).]

#dfn("Random search")[samples hyperparameters *independently from distributions* rather than from a fixed grid. Key insight: not all hyperparameters matter equally, so it is more efficient to explore the important ones flexibly.]

#table(columns: (0.85fr, 1.2fr, 1.2fr),
  table.header([Aspect], [Grid Search], [Random Search]),
  [Sampling], [All fixed combinations], [Independent random samples from distributions],
  [Coverage], [Uniform, but wastes trials on low-impact dimensions], [More diverse; focuses effectively on important dimensions],
  [Efficiency (same budget)], [Lower — many uninformative configurations], [Higher — often finds better models sooner],
  [Scalability], [Poor with many hyperparameters], [Scales better with limited compute],
)

With the same budget, random search explores LR values never present in the grid and usually finds a better best-configuration — which is why it is *the default baseline in practice*.

== Bayesian Optimisation

#keybox(title: "Core Idea")[
Treat model performance as an *unknown function* of the hyperparameters. Each training run gives one *sample* of that function. Bayesian optimisation builds a *probabilistic model* of it and uses that to decide: "given what I have seen so far, where is the most promising place to try next?"
]

*Explore vs. exploit:*
- *Exploration* — try uncertain regions of the space to discover new possibilities.
- *Exploitation* — refine around known good regions to squeeze out better performance.

This balance makes it far more *sample-efficient* than blind search — good hyperparameters in far fewer trials, which matters because deep learning experiments are expensive, noisy and highly sensitive. In practice use libraries: *Optuna, Hyperopt, Ray Tune*.

== A Systematic Experimentation Workflow

#keybox(title: "The 5-Step Workflow")[
+ *Define the problem* — dataset, metric, what "success" means. Without this, all tuning is noise.
+ *Build a simple baseline* — confirms the pipeline works at all and gives a reference point.
+ *Decide what to tune and how* — which hyperparameters matter, what ranges, what validation strategy. This is where automated search becomes essential.
+ *Run controlled experiments* — fixed seeds, tracked parameters, saved checkpoints, logged metrics. *Most projects fail here* — without control you cannot compare or reproduce.
+ *Select the best model on validation data, then test once* — never select on the test set. Evaluate on test *only once*, for a clean unbiased estimate.
]

*Running a professional tuning experiment:* split train/validation explicitly so every configuration is compared on the same held-out data; keep the architecture *fixed* so only hyperparameters vary; define the search space as *distributions*, not fixed values; run multiple trials by sampling.

- *Early stopping* — define a *patience*; track the best validation score so far; stop if it does not improve for that many epochs. Saves compute on unpromising runs.
- *Checkpointing* — in each trial, store the model if it is the best seen so far. After all trials, the best configuration and its saved model are kept.

== Reproducibility

#keybox(title: "Sources of Randomness in Deep Learning")[
- Randomly initialised weights.
- Training data shuffled differently each run.
- Non-deterministic GPU operations.
- Techniques like dropout that deliberately inject randomness.
- Multi-threading / parallel execution changing computation order.
]

Any of these can change the final model even with identical code, data and architecture. In one demonstration, the exact same code run twice gave *different* validation accuracies — a real difference caused purely by uncontrolled randomness.

*Why it matters:* without reproducibility you cannot trust improvements (real gain or lucky randomness?), debugging becomes very hard, and experiments cannot be fairly compared.

#keybox(title: "Reproducibility Checklist")[
+ *Fix all random seeds* — NumPy, PyTorch, and every other library used.
+ *Fix train/validation/test splits* — the same split every run.
+ *Log all hyperparameters* — record and reuse them exactly.
+ *Save model checkpoints* — so a specific trained model can always be recovered.
+ *Track software/hardware versions* — frameworks, drivers, hardware.
+ *Avoid mixing multiple runs in the same logs* — keep records separate.
]

After fixing all seeds and recreating the splits from those seeds, re-running the same experiment twice gave *exactly* the same accuracy — reproducibility, once engineered, removes run-to-run variation entirely.

#recall[
- Manual tuning fails at scale: *non-linear dynamics, combinatorial explosion, human bias*.
- Only 4 hyperparameters dominate: *learning rate, batch size, model capacity, regularisation strength* — and they *interact*, so tune them together.
- Learning rate controls step size: too low → slow/stuck; too high → oscillation/divergence. *Tune it first.*
- Batch size controls *gradient noise*, not the objective: small = noisy but exploratory; large = smooth but can reach sharper minima.
- Grid search = exhaustive but wasteful. *Random search = same budget, better coverage of the dimensions that matter — the default baseline.*
- *Bayesian optimisation* models performance as a function of hyperparameters and balances *explore vs. exploit* to find good settings in far fewer trials (Optuna, Hyperopt, Ray Tune).
- Systematic workflow: define problem → baseline → decide search → controlled experiments → *validate, then test once*.
- Early stopping saves compute on bad runs; checkpointing preserves the best model found.
- *Reproducibility must be engineered*: fixed seeds, fixed splits, logged configs, tracked versions. If an experiment cannot be reproduced, it does not exist.
]

// ============================================================================
= Explainability, Responsible AI and Future Trends
// ============================================================================

== Why Explainability Matters

In high-stakes settings (healthcare, finance, hiring, legal), *why* a decision was made is as important as *what* the decision was.

#keybox(title: "The Black-Box Problem")[
Deep networks learn complex internal representations but do not explain themselves. A model can be *highly confident and highly accurate* while relying on patterns that are incorrect, biased, or unsafe. Because these are invisible, problems go unnoticed until real harm occurs.
*High accuracy does not guarantee correct reasoning.* A model may learn a *shortcut* — e.g. judging an X-ray by the hospital's scanner watermark instead of the disease.
]

*Explainability is a safety mechanism.* It lets us inspect behaviour and debug errors, detect bias before deployment, verify reasoning against domain knowledge, and satisfy regulators who increasingly demand justifications, not just predictions.

== Interpretability vs. Explainability

#table(columns: (1fr, 1.35fr, 1.35fr),
  table.header([], [Interpretability], [Explainability]),
  [Nature], [*Intrinsic* — the model is understandable by its own structure], [*Post-hoc / external* — extra methods explain an already-trained opaque model],
  [Transparency], [Human can directly reason about how inputs affect outputs], [Model stays a black box; a separate technique produces the explanation],
  [Scope], [*Global* understanding of the whole model], [Often *local*, instance-level (why this one prediction)],
  [Examples], [Linear regression, small decision trees, rule-based systems], [Feature attribution, saliency maps, LIME, SHAP],
  [Cost], [Usually limited model complexity/capacity], [Explanation is not guaranteed to be the model's true reasoning],
)

The choice is a *design decision*, not a preference. High-stakes domains with strict transparency rules may *require* an interpretable model; most modern applications need complex deep models, so *post-hoc explainability* is the practical route.

== Explainability Methods

#dfn("Feature importance")[which inputs mattered most — asked *globally* (across the dataset) or *locally* (for one prediction).]

#dfn("Saliency map")[assigns an importance score to each input pixel, highlighting the regions that most influenced a prediction. Gradient-based: if changing a pixel slightly causes a large output change, that pixel is important. Visualised as a heat map.]

Saliency maps are useful for debugging (does the model focus on meaningful regions or spurious patterns?), but they show *influence, not reasoning* — noisy, unstable, and not causal proof.

#keybox(title: "Perturbation-Based Methods")[
*Core idea:* if a small change to an input feature causes a large change in the prediction, that feature must be important. Systematically perturb the input and watch the output react.
- *LIME* (Local Interpretable Model-agnostic Explanations) — explains *one* prediction. Generates many perturbed versions around that point, queries the black box on each, and fits a simple *interpretable local surrogate* (e.g. a small linear model). The explanation comes from the surrogate, not the original model.
- *SHAP* (SHapley Additive exPlanations) — rooted in *game theory*. Each feature is a "player"; SHAP computes how much each contributes *on average across all possible feature combinations*, giving strong theoretical guarantees at higher computational cost.
]

#table(columns: (0.85fr, 1.2fr, 1.2fr),
  table.header([Aspect], [LIME], [SHAP]),
  [Basis], [Local linear surrogate model], [Game-theoretic (Shapley values)],
  [Speed], [Faster, more heuristic], [Slower, more computationally expensive],
  [Consistency], [Can vary across runs], [More consistent across runs and models],
  [Theoretical grounding], [Weak], [Strong],
)

Both are *model-agnostic* — they work on any black-box model. *Limitations:* computationally expensive; sensitive to how perturbations are generated; local explanations may not generalise; perturbed inputs can stray off the true data manifold and mislead.

#keybox(title: "Model-Specific Methods")[
- *Grad-CAM* (Gradient-weighted Class Activation Mapping) — for *CNNs*. Uses the gradients flowing into the *last convolutional layer* to find which feature maps matter for a class, combined into a heat map. Answers: "which *regions* of the image mattered for this class?"
- *Integrated Gradients* — instead of one gradient, *accumulates gradients along a path* from a baseline input (e.g. a black image) to the actual input. Principled feature attribution, but the result *depends on the baseline choice*.
]

- Grad-CAM: highly visual, best for CNNs/images, *spatial-region* explanations.
- Integrated Gradients: more general, *feature-level* attributions, baseline-dependent.
- Both are gradient-based → noisy, sensitive to design choices, *never causal proof*. Diagnostic tools, not ground truth.

#proscons[
- Improve transparency and trust in regulated/high-stakes domains.
- Help debug models and identify spurious correlations.
- Give insight into why a particular prediction was made.
][
- Most explanations are *local*, assumption-dependent, noise-sensitive.
- Can be *unstable* across very similar inputs.
- Provide *no causal guarantees* — highlighted features are not proven causes.
- No single method gives complete transparency.
]

#qcompare[
*Correct use of explainability:* treat it as a *diagnostic and investigative* tool, not proof. Use *multiple* methods, look for *consistent patterns* across them, treat explanations as *hypotheses*, combine with rigorous evaluation and domain expertise, and focus on *patterns*, not single examples.
]

== Bias and Fairness

#dfn("Bias in AI")[*systematic differences in how a model behaves across different groups*. Not about opinions or intent. A model can be accurate overall while its errors are unevenly distributed — invisible if we look only at aggregate accuracy.]

#table(columns: (0.8fr, 2.5fr),
  table.header([Source of bias], [Description]),
  [Historical bias], [Training data reflects past unfair decisions (e.g. biased hiring history), so the model learns and repeats the pattern.],
  [Representation bias], [Some groups are under-represented in the data (e.g. few images of certain skin tones), so the model performs worse for them.],
  [Measurement bias], [A proxy variable unintentionally encodes sensitive information (e.g. ZIP code encoding race or socioeconomic status).],
  [Deployment bias], [The model is used in a different context than it was trained for (e.g. trained in one country, deployed in another).],
)

#keybox(title: "Accuracy ≠ Fairness")[
A medical model can be 95% accurate overall, yet if that 5% of errors falls mostly on one group (e.g. under-diagnosing a disease in women), the model is *unfair despite being accurate*. Optimising average accuracy hides such disparities. Fairness asks *who* the model is right or wrong for, not just *how often*.
]

*Detection:* identify *protected attributes* (gender, race, …), split the validation data by group, and compute metrics *separately per group*.

#table(columns: (0.9fr, 2.4fr),
  table.header([Fairness definition], [Question it asks]),
  [Demographic Parity], [Do different groups receive positive outcomes at similar *rates*? (e.g. equally frequent loan approvals)],
  [Equal Opportunity], [Among people who *truly deserve* a positive outcome, are all groups treated equally?],
  [Equalised Odds], [Goes further — are *both* correct approvals *and* incorrect rejections balanced across groups?],
)

#keybox(title: "The Impossibility Result")[
If two groups have *different base rates* (e.g. different disease prevalence), it can be *mathematically impossible* to satisfy demographic parity and equalised odds *simultaneously*. Fairness cannot simply be "optimised away" — it involves explicit trade-offs and value judgments.
]

Fairness evaluation is *not a one-time check* — it must be monitored continuously during validation *and* deployment.

#keybox(title: "Mitigation — Three Points in the Pipeline")[
+ *Pre-processing (fix the data, before training)* — resampling/reweighting to rebalance the dataset; correcting historically biased labels.
+ *In-processing (fix the training itself)* — add a *fairness constraint* to the loss penalising large error-rate gaps across groups; *adversarial debiasing*, training the model so another model cannot infer protected attributes from its representation.
+ *Post-processing (fix the outputs)* — different *decision thresholds per group* to equalise false-negative rates. Easier to implement, but raises transparency and policy-justification concerns.
]

*The unavoidable trade-off:* fairness interventions often *reduce overall accuracy*, and improving fairness for one group can worsen outcomes for another. There is no universal solution — mitigation requires explicit value judgments, is context-dependent, and needs conscious design, documentation, and ongoing monitoring.

== Future Directions

=== Transformers and Attention Everywhere

Transformers removed the sequential bottleneck entirely by *eliminating recurrence* and using attention as the core mechanism: not all parts of the input are equally important, so the model *dynamically focuses* on the most relevant parts ("Attention is all you need"). Now used in language models, vision, audio/speech, and combined text+image+audio systems. Their other key advantage is *scalability* — parallel computation trains efficiently on massive datasets, and performance keeps improving with more data and compute, making them the foundation of large-scale foundation models. #xref[mechanics in W9]

=== Diffusion Models and Generative AI

#keybox(title: "The Diffusion Idea")[
Take a clean image and gradually add random noise until it becomes pure static. Train a model to *reverse* this process — to slowly remove noise, step by step. Generation then means: start from pure noise and gradually denoise until a meaningful sample emerges.
]

*Why popular:* stable to train (generation is broken into many small manageable steps, unlike older failure-prone generative models) and produces high-quality, diverse samples. They power text-to-image systems, image editing, in-painting, and style transfer, and are typically *combined with transformers/attention* to condition generation on text.

=== Efficiency, Scaling, Multimodality

#table(columns: (0.75fr, 2.5fr),
  table.header([Force], [What it means]),
  [Efficiency], [Achieving more capability with *less compute*. A first-class design goal now that AI systems are products used by millions daily — they must respond quickly, run reliably, and be cost-efficient.],
  [Scaling], [Larger models on more data learn more general representations (*scaling laws*), enabling foundation models. But scaling is expensive and energy-intensive, so the field is shifting toward *smarter* scaling — better architectures and data quality, not just raw size.],
  [Multimodality], [Combining text, images and sound in one system — reading a document with text+images, answering across both, generating images from text.],
)

*Overall direction:* AI that is not just more powerful but *efficient*, scales *responsibly*, works across modalities, and deploys reliably — with *alignment* (interpretable, fair, trustworthy) as a central concern, not an afterthought.

#recall[
- High accuracy $!=$ trustworthy reasoning — explainability is a *safety and risk-reduction* tool.
- *Interpretability* = intrinsic, global, transparent by design. *Explainability* = post-hoc, usually local, applied to a black box after training.
- Saliency maps (gradient-based) show *influence*, not causal reasoning.
- *LIME* = fast local linear surrogate; *SHAP* = slower, game-theoretic (Shapley values), more consistent. Both are *model-agnostic*.
- *Grad-CAM* = CNN-specific spatial heat maps; *Integrated Gradients* = path-based feature attribution from a baseline. Both gradient-based, neither is causal proof.
- Use explainability as a *hypothesis-generating diagnostic*: multiple methods, consistent patterns, domain expertise.
- *Bias* = systematic group-wise differences, usually from the data: historical, representation, measurement, deployment.
- Fairness metrics: *demographic parity, equal opportunity, equalised odds* — and with different base rates they can be *mathematically impossible to satisfy together*.
- Mitigation at *pre-processing* (data), *in-processing* (loss/training), or *post-processing* (thresholds) — always with an accuracy/fairness trade-off.
- Future: *Transformers* (attention replaces recurrence, scales), *diffusion models* (denoise from noise), and the 3 forces of *efficiency, scaling, multimodality* — with responsibility as a central concern.
]

// ============================================================================
= Quick Reference Sheet
// ============================================================================

== Activation Functions at a Glance

#table(columns: (0.7fr, 1.15fr, 0.62fr, 0.95fr, 1.15fr),
  table.header([Name], [Formula], [Range], [Use where], [Main drawback]),
  [Step / sign], [$"sign"(z)$], [$\{-1,+1\}$], [Perceptron only], [Not differentiable; no confidence],
  [Sigmoid], [$1\/(1+e^(-z))$], [$(0,1)$], [Binary output layer], [Saturates → vanishing gradients; not zero-centered],
  [Tanh], [$(e^z - e^(-z))\/(e^z + e^(-z))$], [$(-1,1)$], [Hidden layers (older nets), RNNs], [Still saturates],
  [ReLU], [$max(0,z)$], [$[0, infinity)$], [*Default* hidden layers], [Dying ReLU (permanent dead neurons)],
  [Leaky ReLU], [$max(alpha z, z)$, $alpha approx 0.01$], [$(-infinity, infinity)$], [When ReLUs die], [Extra hyperparameter $alpha$],
  [PReLU], [Same, $alpha$ learnable], [$(-infinity, infinity)$], [High-performance vision models], [Extra parameters],
  [Softmax], [$e^(z_i)\/sum_j e^(z_j)$], [$(0,1)$, sums to 1], [Multi-class output layer], [Output layer only; can be overconfident],
  [Linear], [$z$], [$(-infinity, infinity)$], [Regression output layer], [No non-linearity],
)

== Optimizers at a Glance

#table(columns: (0.72fr, 1.35fr, 1.1fr, 1.1fr),
  table.header([Optimizer], [Update rule (core)], [Strengths], [Weaknesses]),
  [Batch GD], [$theta <- theta - eta nabla L$ over whole dataset], [Stable, correct direction], [Very slow, memory-heavy],
  [SGD], [Same, one sample], [Fast per step; noise escapes saddles], [Very noisy, unpredictable],
  [Mini-batch GD], [Same, 32–512 samples], [*Practical default*: fast + stable], [Still one global LR],
  [Momentum], [$v <- beta v + nabla L$; $theta <- theta - eta v$], [Kills zig-zag; builds speed; escapes shallow minima], [Extra hyperparameter $beta$],
  [RMSProp], [Divide step by $sqrt(E[g^2])$], [Per-parameter LR; good for RNNs, sparse gradients], [No momentum → slow on consistent small gradients],
  [Adam], [Momentum + RMSProp + bias correction], [Fast, low-tuning, robust; default choice], [Can find sharp minima; hides bad LR],
)

== Regularisation Techniques at a Glance

#table(columns: (0.75fr, 1.55fr, 1.5fr),
  table.header([Technique], [Mechanism], [When to use]),
  [L2 (weight decay)], [Penalty $lambda sum w_i^2$; circular constraint; shrinks weights smoothly toward 0], [*Default* regulariser in deep nets; smooth, stable models],
  [L1], [Penalty $lambda sum |w_i|$; diamond constraint; drives weights *exactly* to 0], [When sparsity / automatic feature selection is wanted],
  [Dropout], [Randomly deactivate neurons each mini-batch; prevents co-adaptation], [Large nets; 0.1–0.3 input, 0.3–0.5 hidden; FC layers of CNNs],
  [Batch normalisation], [Normalise activations per mini-batch, then rescale with learnable $gamma, beta$], [Deep nets; allows higher LR, faster convergence; implicit regulariser],
  [Early stopping], [Stop at the best-validation epoch (with patience); restore those weights], [Always — free, no architecture change],
  [Data augmentation], [Label-preserving transformations create new training samples], [Small datasets; images/text/audio],
  [Smaller batch size], [Adds gradient noise → biases toward flatter minima], [When generalisation matters more than throughput],
)

== Hyperparameter Cheat Sheet — Too High vs. Too Low

#table(columns: (0.85fr, 1.5fr, 1.5fr),
  table.header([Hyperparameter], [Too high], [Too low]),
  [Learning rate], [Loss oscillates, spikes, or diverges/NaN; overshoots the minimum; can silently kill ReLUs], [Painfully slow; stuck in poor solutions; wastes compute],
  [Batch size], [Smooth but may converge to sharp minima; needs LR retuning/warm-up; worse generalisation], [Very noisy updates; unstable; poor GPU utilisation],
  [Model capacity (depth/width)], [Overfits; memorises noise; expensive], [Underfits; high bias; cannot capture real patterns],
  [Regularisation strength $lambda$], [Underfits — model too constrained], [Overfits — no constraint on complexity],
  [Dropout rate], [Underfits; unstable with small batches], [Little regularising effect; co-adaptation persists],
  [Momentum $beta$], [Overshoots; oscillates past minima], [Loses the smoothing/acceleration benefit],
  [Number of epochs], [Overfits (fix with early stopping)], [Underfits; training stopped too soon],
)

== Symptom → Diagnosis → Fix

#table(columns: (0.95fr, 1.15fr, 1.6fr),
  table.header([Symptom], [Likely cause], [Fix]),
  [Loss does not decrease at all], [Gradient flow blocked / dead paths; LR far too small or too large], [Check layerwise gradient norms first; verify init; adjust LR],
  [Loss decreases then plateaus high], [Vanishing gradients; dead ReLUs], [ReLU-family activation, He init, BatchNorm, lower LR, Leaky ReLU],
  [Loss spikes / becomes NaN], [Exploding gradients; LR too high], [Gradient clipping *by norm*; reduce LR; better init; normalisation],
  [Training loss ↓ but validation loss ↑], [Overfitting], [Early stopping, L2, dropout, data augmentation, smaller model],
  [Both errors high], [Underfitting / too little capacity or too much regularisation], [Increase depth/width; reduce regularisation; train longer],
  [Loss fine, accuracy poor on new data], [Capacity or data issue, not optimisation], [More/better data; check for leakage and distribution shift],
  [Model confident but wrong], [Poor calibration], [Temperature scaling (accuracy unchanged); ensembles],
  [Prediction flips on tiny input change], [Poor robustness], [Perturbation tests, sensitivity curves, augmentation],
  [One layer's weight norm is flat], [Frozen layer (`requires_grad = False`) or optimizer misconfiguration], [Check optimizer parameter groups and grad flags],
  [Two runs give different results], [Uncontrolled randomness], [Fix all seeds, fix splits, log configs, track versions],
)

== Formula Sheet

#keybox(title: "Everything on One Page")[
#set text(size: 9pt)
*Neuron / layer* $ z = sum_i w_i x_i + b; quad a = phi(z); quad z^((l)) = W^((l)) a^((l-1)) + b^((l)) $
*Sigmoid / tanh / ReLU / softmax*
$ sigma(z) = 1/(1+e^(-z)); quad tanh(z) = (e^z - e^(-z))/(e^z + e^(-z)); quad "ReLU"(z) = max(0, z); quad "softmax"(z_i) = e^(z_i)/(sum_j e^(z_j)) $
*Losses* $ "MSE" = 1/N sum_(i=1)^(N) (y_i - hat(y)_i)^2; quad L_"CE" = - log(hat(p)_c); quad (partial L_"CE")/(partial z) = hat(p) - y $
*Chain rule / gradient descent* $ (d y)/(d x) = (d y)/(d u) (d u)/(d x); quad theta <- theta - eta (partial L)/(partial theta) $
*Momentum / RMSProp / Adam*
$ v_t = beta v_(t-1) + nabla L; quad E[g^2]_t = beta E[g^2]_(t-1) + (1-beta) g_t^2; quad theta <- theta - eta hat(m)_t/(sqrt(hat(v)_t)+epsilon) $
*Regularisation* $ L_"total" = L_"data" + lambda Omega(w); quad Omega_"L2" = sum_i w_i^2; quad Omega_"L1" = sum_i |w_i| $
*BatchNorm / Dropout* $ hat(x) = (x - mu_B)/sqrt(sigma_B^2 + epsilon), space y = gamma hat(x) + beta; quad tilde(y) = (m ⊙ y)/p $
*Initialization* $ "Xavier": "Var"(W) = 2/(n_"in" + n_"out"); quad "He": "Var"(W) = 2/n_"in" $
*RNN / LSTM cell* $ h_t = phi(W_"hh" h_(t-1) + W_"xh" x_t + b_h); quad C_t = f_t ⊙ C_(t-1) + i_t ⊙ tilde(C)_t $
*Attention* $ alpha_i = "softmax"("score"(q, k_i)); quad "context" = sum_i alpha_i h_i $
*Metrics* $ "Precision" = "TP"/("TP"+"FP"); quad "Recall" = "TP"/("TP"+"FN"); quad F_1 = (2 "P" "R")/("P" + "R") $
*Calibration / uncertainty* $ "ECE" = sum_(m=1)^(M) (|B_m|)/n |"acc"(B_m) - "conf"(B_m)|; quad H(p) = - sum_(i=1)^(C) p_i log p_i $
*Numerical stability* $ log sum_i e^(x_i) = c + log sum_i e^(x_i - c), quad c = max_i x_i $
*Gradient norm* $ ||g^((l))||_2 = sqrt(sum_i (g_i^((l)))^2) $
]

== Final Exam-Day Checklist

#qcompare[
+ *Structure:* neuron → layer → MLP → CNN/RNN/Transformer. Every one is "linear transform + non-linearity", repeated.
+ *Why non-linearity:* without it, any depth collapses into one linear model.
+ *Why depth:* hierarchical feature reuse — far more parameter-efficient than width (UAT caveat).
+ *Training loop:* forward → loss → backprop (gradients only) → optimiser update.
+ *Backprop = chain rule on a computational graph.* Forward pass caches; backward pass multiplies local gradients.
+ *Loss choice:* MSE for regression, softmax + cross-entropy for classification (gradient $hat(p)-y$ does not vanish).
+ *Gradient problems:* vanishing/exploding come from repeated multiplication with depth. Fix with He/Xavier init + ReLU + clipping + normalisation.
+ *Optimisers:* SGD → momentum → RMSProp → Adam. Adam is fast; SGD+momentum often generalises better.
+ *Generalisation:* bias-variance; L1 (sparse) vs L2 (smooth); dropout, BatchNorm, early stopping, augmentation.
+ *CNNs:* local connectivity + weight sharing + translation robustness. One filter = one feature map.
+ *Sequences:* RNN memory → vanishing gradient → LSTM (3 gates, additive cell state) → GRU (2 gates) → attention → Transformer.
+ *Evaluation:* accuracy is not enough — add calibration (ECE), robustness (sensitivity curves), uncertainty (entropy).
+ *Diagnostics:* gradients, activations, parameters. Learning rate is the usual root cause.
+ *Tuning:* LR first; random search beats grid; Bayesian optimisation is most sample-efficient; reproducibility must be engineered.
+ *Responsible AI:* interpretability vs explainability; LIME/SHAP/Grad-CAM; bias sources; fairness metrics conflict (impossibility result).
]
