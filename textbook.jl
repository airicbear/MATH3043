### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ e51df1be-23df-11ed-3d2a-41392648d60d
begin
	using PlutoUI
	
md"""
# Numerical Analysis (10th Edition)

By Richard L. Burden, Douglas J. Faires, and Annette M. Burden
"""
end

# ╔═╡ a901d416-c0e5-463c-a8a9-fb5b36188996
PlutoUI.TableOfContents()

# ╔═╡ 20caac3c-1438-41ac-8eda-d3fd8161198d
md"# Preface"

# ╔═╡ ea6233ff-0012-4068-981e-49e87afa809e
md"## About the Text"

# ╔═╡ 870c6c63-97e1-44a7-89dc-b19561159419
md"""
**Remark.**
This text was written for a sequence of courses on the theory and application of numerical approximation techniques.
It is designed primarily for junior-level mathematics, science, and engineering majors who have completed at least the first year of the standard college calculus sequence.
Familiarity with the fundamentals of matrix algebra and differential equations is useful, but there is sufficient introductory material on these topics so that courses in these subjects are not needed as prerequisites.
"""

# ╔═╡ 8cc829b1-0013-443b-89c0-880f1f9afc0e
md"""
**Remark.**
Previous editions of *Numerical Analysis* have been used in a wide variety of situations.
In some cases, the mathematical analysis underlying the development of approximation techniques was given more emphasis than the methods; in others, the emphasis was reversed.
The book has been used as a core reference for beginning graduate-level courses in engineering, mathematics, computer science programs, and in first-year courses in introductory analysis offered at international universities.
We have adapted the book to fit these diverse users without compromising our original purpose:

> *To introduce modern approximation techniques; to explain how, why, and when they can be expected to work; and to provide a foundation for further study of numerical analysis and scientific computing.*
"""

# ╔═╡ efc3dcf9-f411-439a-8394-76e592d568a5
md"""
**Remark.**
The book contains sufficient material for at least a full year of study, but we expect many people will use the text only for a single-term course.
In such a single-term course, students learn to identify the types of problems that require numerical techniques for their solution and see examples of the error propagation that can occur when numerical methods are applied.
They accurately approximate the solution of problems that cannot be solved exactly and learn typical techniques for estimating error bounds for their approximations.
The remainder of the text then serves as a reference for methods that are not considered in the course.
Either the full-year or the single-course treatment is consistent with the philosophy of the text.
"""

# ╔═╡ ef1f5730-754c-4591-a275-01e2620b53fe
md"""
**Remark.**
Virtually every concept in the text is illustrated by example, and this edition contains more than 2500 class-tested exercises from elementary applications of methods and algorithms to generalizations and extensions of the theory.
In addition, the exercise sets include numerous applied problems from diverse areas of engineering as well as from the physical, computer, biological, economic, and social sciences.
The applications, chosen clearly and concisely, demonstrate how numerical techniques can and often must be applied in real-life situations.
"""

# ╔═╡ 47600b32-a97f-4118-b061-632d0cac227e
md"""
**Remark.**
A number of software packages, known as Computer Algebra Systems (CAS), have been developed to produce symbolic mathematical computations.
Maple©, Mathematica©, and MATLAB© are predominant among these in the academic environment.
Student versions of these software packages are available at reasonable prices for most common computer systems.
In addition, Sage, a free open source system, is now available.
Information about this system can be found at the site

$(html"<center>http://www.sagemath.org</center>")
"""

# ╔═╡ 816a7c0e-1a3d-478d-9d25-13e0346f59ff
md"""
**Remark.**
Although there are differences among the packages, both in performance and in price, all can perform standard algebra and calculus operations.
"""

# ╔═╡ 44eb55d1-1e21-4c98-8817-db542809fdf4
md"""
**Remark.**
The results in most of our examples and exercises have been generated using problems for which exact values *can* be determined because this better permits the performance of the approximation method to be monitored.
In addition, for many numerical techniques, the error analysis requires bounding a higher ordinary or partial derivative of a function, which can be a tedious task and one that is not particularly instructive once the techniques of calculus have been mastered.
So having a symbolic computation package available can be very useful in the study of approximation techniques because exact solutions can often be obtained easily using symbolic computation.
Derivatives can be quickly obtained symbolically, and a little insight often permits a symbolic computation to aid in the bounding process as well.
"""

# ╔═╡ 9337e240-5683-48a0-81f6-fdee622aea1b
md"# 1 Mathematical Preliminaries and Error Analysis"

# ╔═╡ 7fcde527-d788-4454-bf12-f8ab400d341b
md"""
**Remark.**
In beginning chemistry courses, we see the *ideal gas law*,

$PV = NRT,$

which relates the pressure ``P``, volume ``V``, temperature ``T``, and number of moles ``N`` of an "ideal" gas.
In this equation, ``R`` is a constant that depends on the measurement system.
"""

# ╔═╡ c5ee3f0e-eb52-46a6-9add-ac3178693a4b
md"""
**Remark.**
Suppose two experiments are conducted to test this law, using the same gas as in each case.
In the first experiment,

$\begin{align*}
P &= 1.00 \text{ atm}, & V &= 1.00 \text{ m}^3, \\
N &= 0.00420 \text{ mol}, & R &= 0.08206. \\
\end{align*}$

The ideal gas law predicts the temperature of the gas to be

$T = \frac{PV}{NR} = \frac{(1.00)(0.100)}{(0.00420)(0.08206)} = 290.15 \text{ K} = 17^∘ \text{C}.$

When we measure the temperature of the gas, however, we find that the true temperature is ``15^∘\text{C}``.
"""

# ╔═╡ fa5e0ab8-f543-4fa4-adc3-5d3f8f0443ad
md"""
**Remark.**
We then repeat the experiment using the same values of ``R`` and ``N`` but increase the pressure by a factor of two and reduce the volume by the same factor.
The product ``PV`` remains the same, so the predicted temperature is still ``17^∘\text{C}``.
But now we find that the actual temperature of the gas is ``19^∘\text{C}``.
"""

# ╔═╡ cefd0c36-465f-44f3-b680-4c5aeda02b39
md"""
**Remark.**
Clearly, the ideal gas law is suspect, but before concluding that the law is invalid in this situation, we should examine the data to see whether the error could be attributed to the experimental results.
If so, we might be able to determine how much more accurate our experiments would need to be to ensure that an error of this magnitude does not occur.
"""

# ╔═╡ 723d7d56-5b20-48e9-a02c-c1b94777cd9f
md"""
**Remark.**
This chapter contains a short review of those topics from single-variable calculus that will be needed in later chapters.
A solid knowledge of calculus is essential for an understanding of the analysis of numerical techniques, and more thorough review might be needed for those who have been away from this subject for a while.
In addition there is an introduction to convergence, error analysis, the machine representation of numbers, and some techniques for categorizing and minimizing computational error.
"""

# ╔═╡ f95ab586-c39b-4e8f-b0cd-06b9837fff20
md"## 1.1 Review of Calculus"

# ╔═╡ 7f629d7c-2fd9-4b47-8fd4-52d39d00771e
md"### Limits and Continuity"

# ╔═╡ 03174326-bb3f-4687-a5af-f9ea160bae3b
md"""
**Remark.**
The concepts of *limit* and *continuity* of a function are fundamental to the study of calculus and form the basis for the analysis of numerical techniques.
"""

# ╔═╡ de43d124-5793-4326-b97c-f75aec9690d4
md"""
**Definition 1.1**
A function ``f`` defined on a set ``X`` of real numbers has the **limit** ``L`` at ``x_0``, written

$\lim_{x → x_0} f(x) = L,$

if, given any real number ``ϵ > 0``, there exists a real number ``δ > 0`` such that

$|f(x) - L| < ϵ, \quad \text{ whenever } \quad x ∈ X \quad \text{ and } \quad 0 < |x - x_0| < δ.$

(See Figure 1.1.)
"""

# ╔═╡ accf74aa-0337-4e3f-b8d1-39d400125a82
md"""
**Definition 1.2**
Let ``f`` be a function defined on a set ``X`` of real numbers and ``x_0 ∈ X``.
Then ``f`` is **continuous** at ``x_0`` if

$\lim_{x → x_0} f(x) = f(x_0).$

The function ``f`` is **continuous on the set ``X``** if it is continuous at each number in ``X``.
"""

# ╔═╡ 8ef6a807-8557-4fc5-9061-34a86132946e
md"""
**Remark.**
The set of all functions that are continuous on the set ``X`` is denoted ``C(X)``.
When ``X`` is an interval of the real line, the parentheses in this notation are omitted.
For example, the set of all functions continuous on the closed interval ``[a,b]`` is denoted ``C[a,b]``.
The symbol ``ℝ`` denotes the set of all real numbers, which also has the interval notation ``(-∞,∞)``.
So the set of all functions that are continuous at every real number is denoted by ``C(ℝ)`` or by ``C(-∞,∞)``.
"""

# ╔═╡ 488a8db4-0065-4b60-b1a6-caafd5b6df0a
md"""
**Remark.**
The *limit of a sequence* of real or complex numbers is defined in a similar manner.
"""

# ╔═╡ f28061d8-b242-446c-a452-9ba535f806f4
md"""
**Definition 1.3**
Let ``\{x_n\}_{n=1}^∞`` be an infinite sequence of real numbers.
This sequence has the **limit** ``x`` (**converges to ``x``**) if, for any ``ϵ > 0``, there exists a positive integer ``N(ϵ)`` such that ``|x_n - x| < ϵ`` whenever ``n > N(ϵ)``.
The notation

$\lim_{n→∞} x_n = x, \quad\text{ or }\quad x_n → x \quad\text{ as }\quad n → ∞,$

means that the sequence ``\{x_n\}_{n=1}^∞`` converges to ``x``.
"""

# ╔═╡ 21b9fa78-542d-4788-96fa-a2ec3ea3c6f3
md"""
**Theorem 1.4**
If ``f`` is a function defined on a set ``X`` of real numbers and ``x_0 ∈ X``, then the following statements are equivalent:

- **a.**  ``f`` is continuous at ``x_0``;

- **b.**  If ``\{x_n\}_{n=1}^∞`` is any sequence in ``X`` converging to ``x_0``, then ``\lim_{n→∞} f(x_n) = f(x_0)``.
"""

# ╔═╡ a4bb4444-8f5d-4f01-9d90-fe7470d7aa1b
md"""
**Remark.**
The functions we will consider when discussing numerical methods will be assumed to be continuous because this is a minimal requirement for predictable behavior.
Functions that are not continuous can skip over points of interest, which can cause difficulties in attempts to approximate a solution to a problem.
"""

# ╔═╡ 0e70fd60-47e8-4dbb-9b81-ea8db52cbc85
md"### Differentiability"

# ╔═╡ 3641840a-d501-45d4-8cb3-dec99f83ad2d
md"""
**Remark.**
More sophisticated assumptions about a function generally lead to better approximation results.
For example, a function with a smooth graph will normally behave more predictably than one with numerous jagged features.
The smoothness condition relies on the concept of the derivative.
"""

# ╔═╡ b8afaa05-2eef-4c35-b72a-326e4a6bf198
md"""
**Definition 1.5**
Let ``f`` be a function defined in an open interval containing ``x_0``.
The function ``f`` is **differentiable** at ``x_0`` if

$f'(x_0) = \lim_{x→x_0} \frac{f(x) - f(x_0)}{x - x_0}$

exists.
The number ``f'(x_0)`` is called the **derivative** of ``f`` at ``x_0``.
A function that has a derivative at each number in a set ``X`` is **differentiable on ``X``**.
"""

# ╔═╡ 708ba3e8-f0cc-45d4-a80c-93566d355ca0
md"""
**Remark.**
The derivative of ``f`` at ``x_0`` is the slope of the tangent line to the graph of ``f`` at ``(x_0, f(x_0))``, as shown in Figure 1.2.
"""

# ╔═╡ 85c9ff97-8444-4911-8d47-483fa4b72c67
md"""
**Theorem 1.6**
If the function ``f`` is differentiable at ``x_0``, then ``f`` is continuous at ``x_0``.
"""

# ╔═╡ 11e825df-9313-4fa2-85e5-e8f88527ae29
md"""
**Remark.**
The next theorems are of fundamental importance in deriving methods for error estimation.
The proofs of these theorems and the other unreferenced results in this section can be found in any standard calculus text.
"""

# ╔═╡ dac78d4d-f6f8-4439-8a27-4c583810064a
md"""
**Remark.**
The set of all functions that have ``n`` continuous derivatives on ``X`` is denoted ``C^n(X)``, and the set of functions that have derivatives of all orders on ``X`` is denoted ``C^∞(X)``.
Polynomial, rational, trigonometric, exponential, and logarithmic functions are in ``C^∞(X)``, where ``X`` consists of all numbers for which the functions are defined.
When ``X`` is an interval of the real line, we will again omit the parentheses in this notation.
"""

# ╔═╡ 3a896758-ed2d-4674-b3fa-69258a902b29
md"""
**Theorem 1.7 (Rolle's Theorem)**
Suppose ``f ∈ C[a,b]`` and ``f`` is differentiable on ``(a,b)``.
If ``f(a) = f(b)``, then a number ``c`` in ``(a,b)`` exists with ``f'(c) = 0``.
(See Figure 1.3.)
"""

# ╔═╡ 660e14b6-5160-4e6e-87c5-f49302cfd36f
md"""
**Theorem 1.8 (Mean Value Theorem)**
If ``f ∈ C[a,b]`` and ``f`` is differentiable on ``(a,b)``, then a number ``c`` in ``(a,b)`` exists with (See Figure 1.4.)

$f'(c) = \frac{f(b) - f(a)}{b - a}.$
"""

# ╔═╡ efd7f9f9-6886-4602-9043-6f421952d0bb
md"""
**Theorem 1.9 (Extreme Value Theorem)**
If ``f ∈ C[a,b]``, then ``c_1, c_2 ∈ [a,b]`` exist with ``f(c_1) ≤ f(x) ≤ f(c_2)``, for all ``x ∈ [a,b]``.
In addition, if ``f`` is differentiable on ``(a,b)``, then the numbers ``c_1`` and ``c_2`` occur either at the endpoints of ``[a,b]`` or where ``f'`` is zero.
(See Figure 1.5.)
"""

# ╔═╡ 25194b29-3142-4713-b96d-e9ac91204817
md"""
**Example 1**
Find the absolute minimum and absolute maximum values of

$f(x) = 2 - e^x + 2x$

on the intervals **(a)** ``[0,1]``, and **(b)** ``[1,2]``.

_**Solution**_
We begin by differentiating ``f(x)`` to obtain

$f'(x) = -e^x + 2.$

``f'(x) = 0`` when ``-e^x + 2 = 0`` or, equivalently, when ``e^x = 2``.
Taking the natural logarithm of both sides of the equation gives

$\ln(e^x) = \ln(2) \text{ or } x = \log(2) ≈ 0.69314718056$

- **(a)** When the interval is ``[0,1]``, the absolute extrema must occur at ``f(0)``, ``f(\ln(2))``, or ``f(1)``.
  Evaluating, we have

  $\begin{align*}
  f(0) &= 2 - e^0 + 2(0) = 1 \\
  f(\ln(2)) &= 2 - e^{\ln(2)} + 2 \ln(2) = 2 \ln(2) ≈ 1.38629436112 \\
  f(1) &= 2 - e + 2(1) = 4 - e ≈ 1.28171817154.
  \end{align*}$

  Thus, the absolute minimum of ``f(x)`` on ``[0,1]`` is ``f(0) = 1`` and the absolute maximum is ``f(\ln(2)) = 2 \ln(2)``.

- **(b)** When the interval is ``[1,2]``, we know that ``f'(x) ≠ 0`` so the absolute extrema occur at ``f(1)`` and ``f(2)``.
  Thus, ``f(2) = 2 - e^2 + 2(2) = 6 - e^2 ≈ -1.3890560983``.
  The absolute minimum on ``[1,2]`` is ``6 - e^2`` and the absolute maximum is 1.

  We note that

  $\max_{0 ≤ x ≤ 2} |f(x)| = |6 - e^2| ≈ 1.3890560983.$
"""

# ╔═╡ 61231ff4-ba80-4a46-b532-893db800f58f
md"""
**Remark.**
The following theorem is not generally presented in a basic calculus course but is derived by applying Rolle's Theorem successively to ``f``, ``f'``, ``…``, and finally, to ``f^{(n-1)}``.
This result is considered in Exercise 26.
"""

# ╔═╡ 404d0c2c-7e9e-45be-8608-6dbd43b4dab2
md"""
**Theorem 1.10 (Generalized Rolle's Theorem)**
Suppose ``f ∈ C[a,b]`` is ``n`` times differentiable on ``(a,b)``.
If ``f(x) = 0`` at the ``n + 1`` distinct numbers ``a ≤ x_0 < x_1 < … < x_n ≤ b``, then a number ``c`` in ``(x_0,x_n)`` and hence in ``(a,b)`` exists with ``f^{(n)}(c) = 0``.
"""

# ╔═╡ f0385459-c814-4054-adc6-b24a8737eb25
md"""
**Remark.**
We will also make frequent use of the Intermediate Value Theorem.
Although its statement seems reasonable, its proof is beyond the scope of the usual calculus course.
It can, however, be found in most analysis texts (see, for example, [Fu], p. 67).
"""

# ╔═╡ 01119851-540f-4648-a130-816726280a9d
md"""
**Theorem 1.11 (Intermediate Value Theorem)**
If ``f ∈ C[a,b]`` and ``K`` is any number between ``f(a)`` and ``f(b)``, then there exists a number ``c`` in ``(a,b)`` for which ``f(c) = K``.
"""

# ╔═╡ b3aa226e-1fb8-4eae-8a56-7a52496038ab
md"""
**Remark.**
Figure 1.6 shows one choice for the number that is guaranteed by the Intermediate Value Theorem.
In this example, there are two other possibilities.
"""

# ╔═╡ 8f21d2a6-d237-4e0f-ac93-39bad4d7cb40
md"""
**Example 2**
Show that ``x^5 - 2x^3 + 3x^2 - 1 = 0`` has a solution in the interval ``[0,1]``.

_**Solution**_
Consider the function defined by ``f(x) = x^5 - 2x^3 + 3x^2 - 1``.
The function ``f`` is continuous on ``[0,1]``.
In addition,

$f(0) = -1 < 0 \quad\text{and}\quad 0 < 1 = f(1).$

Hence, the Intermediate Value Theorem implies that a number ``c`` exists, with ``0 < c < 1``, for which ``c^5 - 2c^3 + 3c^2 - 1 = 0``.
"""

# ╔═╡ f7d64cda-9a58-45e3-99ac-e5f652d092c4
md"""
**Remark.**
As seen in Example 2, the Intermediate Value Theorem is used to determine when solutions to certain problems exist.
It does not, however, give an efficient means for finding these solutions.
This topic is considered in Chapter 2.
"""

# ╔═╡ be030eae-17b5-4028-baa8-656dcb76c160
md"### Integration"

# ╔═╡ 97f1671d-ad6e-435d-a996-9e425f3db92c
md"""
**Remark.**
The other basic concept of calculus that will be used extensively is the Riemann integral.
"""

# ╔═╡ 32da3ed2-d25f-46a8-a282-5365aff2bd4e
md"""
**Definition 1.12**
The **Riemann integral** of the function ``f`` on the interval ``[a,b]`` is the following limit, provided it exists:

$∫_a^b f(x) \,dx = \lim_{\max{\Delta x_i → 0}} \sum_{i=1}^n f(z_i) \,\Delta x_i,$

where the numbers ``x_0, x_1, …, x_n`` satisfy ``a = x_0 ≤ x_1 ≤ ⋯ ≤ x_n = b``, where ``\Delta x_i = x_i - x_{i - 1}``, for each ``i = 1,2,…,n``, and ``z_i`` is arbitrarily chosen in the interval ``[x_{i-1},x_i]``.
"""

# ╔═╡ 0c8a33b0-2995-49f6-96db-c2d133380be8
md"""
**Remark.**
A function ``f`` that is continuous on an interval ``[a,b]`` is also Riemann integrable on ``[a,b]``.
This permits us to choose, for computational convenience, the points ``x_i`` to be equally spaced in ``[a,b]`` and, for each ``i = 1,2,…,n``, to choose ``z_i = x_i``.
In this case,

$∫_a^b f(x) \,dx = \lim_{n→∞} \frac{b - a}{n} \sum_{i=1}^n f(x_i),$

where the numbers shown in Figure 1.7 as ``x_i`` are ``x_i = a + i(b - a)/n``.
"""

# ╔═╡ b40613fa-c635-4464-a0a4-62c422d591d2
md"""
**Remark.**
Two other results will be needed in our study of numerical analysis.
The first is a generalization of the usual Mean Value Theorem for Integrals.
"""

# ╔═╡ a698ba38-3547-4fef-8020-918c23083e6e
md"""
**Theorem 1.13 (Weighted Mean Value Theorem for Integrals)**
Suppose ``f ∈ C[a,b]``, the Riemann integral of ``g`` exists on ``[a,b]``, and ``g(x)`` does not change sign on ``[a,b]``.
Then there exists a number ``c`` in ``(a,b)`` with

$∫_a^b f(x) g(x) \,dx = f(c) ∫_a^b g(x) \,dx.$
"""

# ╔═╡ 8101b173-7522-4163-8b8a-a2b177e15171
md"""
**Remark.**
When ``g(x) ≡ 1``, Theorem 1.13 is the usual Mean Value Theorem for Integrals.
It gives the **average value** of the function ``f`` over the interval ``[a,b]`` as (See Figure 1.8.)

$f(c) = \frac{1}{b - a} ∫_a^b f(x) \,dx.$
"""

# ╔═╡ 9f553224-6ae6-42f8-81d3-ed27400a345b
md"""
**Remark.**
The proof of Theorem 1.13 is not generally given in a basic calculus course but can be found in most analysis texts (see, for example, [Fu], p. 162).
"""

# ╔═╡ 35cd137e-1f5d-4f85-9bfe-f1f865faf5ce
md"### Taylor Polynomials and Series"

# ╔═╡ d6834c90-8144-468f-9fec-9c34f1b59f94
md"""
**Remark.**
The final theorem in this review from calculus describes the Taylor polynomials.
These polynomials are used extensively in numerical analysis.
"""

# ╔═╡ 45c692a3-94cd-47e7-9473-24179692e08b
md"""
**Theorem 1.14 (Taylor's Theorem)**
Suppose ``f ∈ C^n [a,b]``, ``f^{(n + 1)}`` exists on ``[a,b]``, and ``x_0 ∈ [a,b]``.
For every ``x ∈ [a,b]``, there exists a number ``ξ(x)`` between ``x_0`` and ``x`` with

$f(x) = P_n(x) + R_n(x),$

where

$\begin{align*}
P_n(x) &= f(x_0) + f'(x_0) (x - x_0) + \frac{f''(x_0)}{2!}(x - x_0)^2 + ⋯ + \frac{f^{(n)}(x_0)}{n!} (x - x_0)^n \\
&= \sum_{k=0}^n \frac{f^{(k)}(x_0)}{k!} (x - x_0)^k
\end{align*}$

and

$R_n(x) = \frac{f^{(n+1)} (ξ(x))}{(n + 1)!} (x - x_0)^{n+1}.$
"""

# ╔═╡ a15befb5-4a87-4d0f-b06e-3dd0cd061803
md"""
**Remark.**
Here the ``P_n(x)`` is called the **``n``th Taylor polynomial** for ``f`` about ``x_0``, and ``R_n(x)`` is called the **remainder term** (or **truncation error**) associated with ``P_n(x)``.
Since the number ``ξ(x)`` in the truncation error ``R_n(x)`` depends on the value of ``x`` at which the polynomial ``P_n(x)`` is being evaluated, it is a function of the variable ``x``.
However, we should not expect to be able to explicitly determine the function ``ξ(x)``.
Taylor's Theorem simply ensures that such a function exists and that its value lies between ``x`` and ``x_0``.
In fact, one of the common problems in numerical methods is to try to determine a realistic bound for the value of ``f^{(n+1)} (ξ(x))`` when ``x`` is in some specified interval.
"""

# ╔═╡ 9ede5792-0a4a-4237-8cc9-c32ccfd82a0f
md"""
**Remark.**
The infinite series obtained by taking the limit of ``P_n(x)`` as ``n → ∞`` is called the **Taylor series** for ``f`` about ``x_0``.
In the case ``x_0 = 0``, the Taylor polynomial is often called a **Maclaurin polynomial**, and the Taylor series is often called a **Maclaurin series**.
"""

# ╔═╡ c27cae21-d3e2-44d9-a500-4812b5407e08
md"""
**Remark.**
The term **truncation error** in the Taylor polynomial refers to the error involved in using a truncated, or finite, summation to approximate the sum of an infinite series.
"""

# ╔═╡ ecc18c73-a0fb-48e7-b403-6ab2c48a690d
md"""
**Example 3**
Let ``f(x) = \cos{x}`` and ``x_0 = 0``.
Determine

- **(a)** the second Taylor polynomial for ``f`` about ``x_0``; and

- **(b)** the third Taylor polynomial for ``f`` about ``x_0``.

_**Solution**_
 Since ``f ∈ C^∞(ℝ)``, Taylor's Theorem can be applied for any ``n ≥ 0``.
Also,

$f'(x) = -\sin{x}, \; f''(x) = -\cos{x}, \; f'''(x) = \sin{x}, \quad\text{and}\quad f^{(4)}(x) = \cos{x},$

so

$f(0) = 1, \; f'(0) = 0, \; f''(0) = -1, \quad\text{and}\quad f'''(0) = 0.$

- **(a)** For ``n = 2``, and ``x_0 = 0``, we have

  $\begin{align*}
  \cos{x} &= f(0) + f'(0) x + \frac{f''(0)}{2!} x^2 + \frac{f'''(ξ(x))}{3!} x^3 \\
  &= 1 - \frac{1}{2} x^2 + \frac{1}{6} x^3 \sin{ξ(x)},
  \end{align*}$

  where ``ξ(x)`` is some (generally unknown) number between ``0`` and ``x``.
  (See Figure 1.9.)

  When ``x = 0.01``, this becomes

  $\cos{0.01} = 1 - \frac{1}{2} (0.01)^2 + \frac{1}{6} (0.01)^3 \sin{ξ(0.01)} = 0.99995 + \frac{10^{-6}}{6} \sin{ξ(0.01)}.$

  The approximation to ``\cos{0.01}`` given by the Taylor polynomial is therefore ``0.99995``.
  The truncation error, or remainder term, associated with this approximation is

  $\frac{10^{-6}}{6} \sin{ξ(0.01)} = 0.1\bar{6} \times 10^{-6} \sin{ξ(0.01)},$

  where the bar over the ``6`` in ``0.1\bar{6}`` is used to indicate that this digit repeats indefinitely.
  Although we have no way of determining ``\sin{ξ(0.01)}``, we know that all values of the sine lie in the interval ``[-1,1]``, so the error occurring if we use the approximation ``0.99995`` for the value of ``\cos{0.01}`` is bounded by

  $|\cos{(0.01)} - 0.99995| = 0.1\bar{6} \times 10^{-6} |\sin{ξ(0.01)}| ≤ 0.1\bar{6} \times 10^{-6}.$

  Hence, the approximation ``0.99995`` matches at least the first five digits of ``\cos{0.01}``, and

  $\begin{align*}
  0.9999483 < 0.99995 - 1.\bar{6} \times 10^{-6} &≤ \cos{0.01} \\
  &≤ 0.99995 + 1.\bar{6} \times 10^{-6} < 0.9999517.
  \end{align*}$

  The error bound is much larger than the actual error.
  This is due in part to the poor bound we used for ``|\sin{ξ(x)}|``.
  It is shown in Exercise 27 that for all values of ``x``, we have ``|\sin{x}| ≤ |x|``.
  Since ``0 ≤ ξ < 0.01``, we could have used the fact that ``|\sin{ξ(x)}| ≤ 0.01`` in the error formula, producing the bound ``0.1\bar{6} \times 10^{-8}``.

- **(b)** Since ``f'''(0) = 0``, the third Taylor polynomial with remainder term about ``x_0 = 0`` is

  $\cos{x} = 1 - \frac{1}{2} x^2 + \frac{1}{24} \cos{\tilde{ξ}(x)},$

  where ``0 < \tilde{ξ(x)} < 0.01``.
  The approximating polynomial remains the same, and the approximation is still ``0.99995``, but we now have a much better accuracy assurance.
  Since ``|\cos{\tilde{ξ}(x)}| ≤ 1`` for all ``x``, we have

  $\left|\frac{1}{24} x^4 \cos{\tilde{ξ}(x)}\right| ≤ \frac{1}{24} (0.01)^4 (1) ≈ 4.2 \times 10^{-10}.$

  So,

  $|\cos{0.01} - 0.99995| ≤ 4.2 \times 10^{-10},$

  and

  $\begin{align*}
  0.99994999958 &= 0.99995 - 4.2 \times 10^{-10} \\
  &≤ \cos{0.01} ≤ 0.99995 + 4.2 \times 10^{-10} = 0.99995000042.
  \end{align*}$
"""

# ╔═╡ 8afe25ab-bb17-4ffa-a843-126f191d38cd
md"""
**Remark.**
Example 3 illustrates the two objectives of numerical analysis:

- **(i)** Find an approximation to the solution of a given problem.

- **(ii)** Determine a bound for the accuracy of the approximation.

The Taylor polynomials in both parts provide the same answer to (i), but the third Taylor polynomial gave a much better answer to (ii) than the second Taylor polynomial.

We can also use the Taylor polynomials to give us approximations to integrals.
"""

# ╔═╡ 7bc40d2d-ba03-4650-af02-e6e47f00bad6
md"""
**Illustration.**
We can use the third Taylor polynomial and its remainder term found in Example 3 to approximate ``∫_0^{0.1} \cos{x} \,dx``.
We have

$\begin{align*}
∫_0^{0.1} \cos{x} \,dx &= ∫_0^{0.1} \left(1 - \frac{1}{2}x^2\right) + \frac{1}{24} ∫_0^{0.1} x^4 \cos{\tilde{ξ}(x)} \,dx \\
&= \left[x - \frac{1}{6}x^3\right]_0^{0.1} + \frac{1}{24} ∫_0^{0.1} x^4 \cos{\tilde{ξ}(x)} \,dx \\
&= 0.1 - \frac{1}{6} (0.1)^3 + \frac{1}{24} ∫_0^{0.1} x^4 \cos{\tilde{ξ}(x)} \,dx.
\end{align*}$

Therefore,

$∫_0^{0.1} \cos{x} \,dx ≈ 0.1 - \frac{1}{6} (0.1)^3 = 0.998\bar{3}.$

A bound for the error in this approximation is determined from the integral of the Taylor remainder term and the fact that ``|\cos{\tilde{ξ}(x)}| ≤ 1`` for all ``x``:

$\begin{align*}
\frac{1}{24} \left|∫_0^{0.1} x^4 \cos{\tilde{ξ}(x)} \,dx\right| &≤ \frac{1}{24} ∫_0^{0.1} x^4 |\cos{\tilde{ξ}(x)}| \,dx \\
&≤ \frac{1}{24} ∫_0^{0.1} x^4 \,dx = \frac{(0.1)^5}{120} = 8.\bar{3} \times 10^{-8}.
\end{align*}$

so the actual error for this approximation is ``8.3314 \times 10^{-8}``, which is within the error bound.
"""

# ╔═╡ 119ae5d4-f3bc-4a7c-9bb3-d3d3b2fd97b5
md"## 1.2 Round-off Errors and Computer Arithmetic"

# ╔═╡ c39ed048-0f56-4426-9355-7e03b9e3b740
md"""
**Remark.**
The error that is produced when a calculator or computer is used to perform real-number calculations is called **round-off error**.
It occurs because the arithmetic performed in a machine involves numbers with only a finite number of digits, with the result that calculations are performed with only approximate representations of the actual numbers.
In a computer, only a relatively small subset of the real number system is used for the representation of all the real numbers.
This subset contains only rational numbers, both positive and negative, and stores the fractional part, together with an exponential part.
"""

# ╔═╡ 458ed239-d082-40d0-a34f-d61f37ddf7cc
md"### Binary Machine Numbers"

# ╔═╡ 3d5b9fa7-735e-4b6f-841e-1845f1388472
md"""
**Remark.**
In 1985, the IEEE (Institute for Electrical and Electronic Engineers) published a report called *Binary Floating Point Arithmetic Standard 754--1985*.
An updated version was published in 2008 as *IEEE 754--2008*.
This provides standards for binary and decimal floating point numbers, formats for data interchange, algorithms for rounding arithmetic operations, and the handling of exceptions.
Formats are specified for single, double, and extended precisions, and these standards are generally followed by all microcomputer manufacturers using floating-point hardware.
"""

# ╔═╡ 0d6f63c3-e1f7-4fd3-8b5b-3bbca21076c9
md"""
**Remark.**
A 64-bit (binary digit) representation is used for a real number.
The first bit is a sign indicator, denoted ``s``.
This is followed by an 11-bit exponent, ``c``, called the **characteristic**, and a 52-bit binary fraction, ``f``, called the **mantissa**.
The base for the exponent is 2.
"""

# ╔═╡ 20194d15-27ea-4b46-8b22-3426705201f1
md"""
**Remark.**
Since 52 binary digits correspond to between 16 and 17 decimal digits, we can assume that a number represented in this system has at least 16 decimal digits of precision.
The exponent of 11 binary digits gives a range of 0 to ``2^{11} - 1 = 2047``.
However, using only positive integers for the exponent would not permit an adequate representation of numbers with small magnitude.
To ensure that numbers with small mangiutde are equally representable, 1023 is subtracted from the characteristic, so the range of the exponent is actually from -1023 to 1024.
"""

# ╔═╡ dbcd0980-6f05-44d2-8ba8-6e3a4026e106
md"""
**Remark.**
To save storage and provide a unique representation for each floating-point number, a normalization is imposed.
Using this system gives a floating-point number of the form

$(-1)^s 2^{c - 1023} (1 + f).$
"""

# ╔═╡ f1a9588d-059b-4bfd-b080-0417ce35fe14
md"""
**Remark.**
Numbers occurring in calculations that have a magnitude less than

$2^{-1022} ⋅ (1 + 0)$

result in **underflow** and are generally set to zero.
Numbers greater than

$2^{1023} ⋅ (2 - 2^{-52})$

result in **overflow** and typically cause the computations to stop (unless the program has been designed to detect this occurrence).
Note that there are two representations for the number zero: a positive 0 when ``s = 0``, ``c = 0``, and ``f = 0`` and a negative 0 when ``s = 1``, ``c = 0``, and ``f = 0``.
"""

# ╔═╡ d4a8cf4a-d9b2-47fa-8d3b-a45e45ed6fcd
md"### Decimal Machine Numbers"

# ╔═╡ 48744727-20d8-4fd7-bd3a-881096eb1080
md"""
**Remark.**
The use of binary digits tends to conceal the computational difficulties that occur when a finite collection of machine numbers is used to represent all the real numbers.
To examine these problems, we will use more familiar decimal numbers instead of binary representation.
Specifically, we assume that machine numbers are represented in the normalized *decimal* floating-point form

$±0.d_1 d_2 … d_k × 10^n, \quad 1 ≤ d_1 ≤ 9, \quad\text{ and }\quad 0 ≤ d_i ≤ 9,$

for each ``i = 2, …, k``.
Numbers of this form are called ``k``-digit *decimal machine numbers*.
"""

# ╔═╡ 7f81bd98-bc93-4cc0-bec0-43952e52d9f8
md"""
**Remark.**
Any positive real number within the numerical range of the machine can be normalized to the form

$y = 0.d_1 d_2 … d_k d_{k+1} d_{k+2} … × 10^n.$

The floating-point form of ``y``, denoted ``fl(y)``, is obtained by terminating the mantissa of ``y`` at ``k`` decimal digits.
There are two common ways of performing this termination.
One method, called **chopping**, is to simply chop off the digits ``d_{k+1} d_{k+2} …``.
This produces the floating-point form

$fl(y) = 0.d_1 d_2 … d_k × 10^n.$

The other method, called **rounding**, adds ``5 × 10^{n - (k + 1)}`` to ``y`` then chops the result to obtain a number of the form

$fl(y) = 0.δ_1 δ_2 … δ_k × 10^n.$

For rounding, when ``d_{k+1} ≥ 5``, we add 1 to ``d_k`` to obtain ``fl(y)``; that is, we *round up*.
When ``d_{k+1} < 5``, we simply chop off all but the first ``k`` digits; that is, *round down*.
If we round down, then ``δ_i = d_i``, for each ``i = 1,2,…,k``.
However, if we round up, the digits (and even the exponent) might change.
"""

# ╔═╡ 45a2bf53-09f2-4278-805d-f5c6b5d2fecf
md"""
**Example 1**
Determine the five-digit (a) chopping and (b) rounding values of the irrational number ``π``.

_**Solution**_
The number ``π`` has an infinite deciminal expansion of the form ``π = 3.14159265… .``
Written in the normalized decimal form, we have

$π = 0.314159265… × 10^1.$

(a) The floating-point form of ``π`` using five-digit chopping is

$fl(π) = 0.31415 × 10^1 = 3.1415$

(b) The sixth digit of the decimal expansion of ``π`` is a 9, so the floating-point form of ``π`` using five-digit rounding is

$fl(π) = (0.31415 + 0.00001) × 10^1 = 3.1416.$
"""

# ╔═╡ ac363c90-5fab-4155-a70f-0b1a2328c501
md"""
**Definition 1.15**
Suppose that ``p^*`` is an approximation to ``p``.
The **actual error** is ``p - p^*``, the **absolute error** is ``|p - p^*|``, and the **relative error** is ``\displaystyle\frac{|p - p^*|}{|p|}``, provided that ``p ≠ 0``.
"""

# ╔═╡ a67a84f0-62a7-4fd5-90e4-7e04d5c2d5ec
md"""
**Example 2**
Determine the actual, absolute, and relative errors when approximating ``p`` by ``p^*`` when

(a) ``p = 0.3000 × 10^1`` and ``p^* = 0.3100 × 10^1``;

(b) ``p = 0.3000 × 10^{-3}`` and ``p^* = 0.3100 × 10^{-3}``;

(c) ``p = 0.3000 × 10^4`` and ``p^* = 0.3100 × 10^4``.

_**Solution**_

(a) For ``p = 0.3000 × 10^1`` and ``p^* = 0.3100 × 10^1``, the actual error is ``-0.1``, the absolute error is ``0.1``, and the relative error is ``0.333\bar{3} × 10^{-1}``.

(b) For ``p = 0.3000 × 10^{-3}`` and ``p^* = 0.3100 × 10^{-3}``, the actual error is ``-0.1 × 10^{-4}``, the absolute error is ``0.1 × 10^{-4}``, and the relative error is ``0.333\bar{3} × 10^{-1}``.

(c) For ``p = 0.3000 × 10^4`` and ``p^* = 0.3100 × 10^4``, the actual error is ``-0.1 × 10^3``, the absolute error is ``0.1 × 10^3``, and the relative error is again ``0.333\bar{3} × 10^{-1}``.

This example shows that the same relative error, ``0.333\bar{3} × 10^{-1}``, occurs for widely varying absolute errors.
As a measure of accuracy, the absolute error can be misleading and the relative error more meaningful because the relative error takes into consideration the size of the value.
"""

# ╔═╡ 521ed011-d220-45c7-b42c-07e24e4f5390
md"""
**Definition 1.16**
The number ``p^*`` is said to approximate ``p`` to ``t`` **significant digits** (or figures) if ``t`` is the largest nonnegative integer for which

$\frac{|p - p^*|}{|p|} ≤ 5 × 10^{-t}.$
"""

# ╔═╡ 9f923944-7541-4e87-8f52-a43536ea2cc4
md"### Finite-Digit Arithmetic"

# ╔═╡ 0dc5f118-efe9-481a-a455-abf1c5085de0
md"""
**Remark.**
In addition to inaccurate representation of numbers, the arithmetic performed in a computer is not exact.
The arithmetic involves manipulating binary digits by various shifting, or logical, operations.
Since the actual mechanics of these operations are not pertinent to this presentation, we shall devise our own approximation to computer arithemtic.
Although our arithmetic will not give the exact picture, it suffices to explain the problems that occur.
(For an explanation of the manipulations actually involved, the reader is urged to consult more technically oriented computer science texts, such as [Ma], *Computer System Architecture*.)
"""

# ╔═╡ e6075102-3f7f-4fe4-9c18-146af93a02bf
md"""
**Remark.**
Assume that the floating-point representations ``fl(x)`` and ``fl(y)`` are given for the real numbers ``x`` and ``y`` and that the symbols ``⊕``, ``⊖``, ``⊗``, and ``⨸`` represent machine addition, subraction, multiplication, and division operations, respectively.
We will assume a finite-digit arithmetic given by

$\begin{align*}
x ⊕ y &= fl(fl(x) + fl(y)), \quad x ⊗ y = fl(fl(x) × fl(y)), \\
x ⊖ y &= fl(fl(x) - fl(y)), \quad x ⨸ y = fl(fl(x) ÷ fl(y)).
\end{align*}$

This arithmetic corresponds to performing exact arithmetic on the floating-point representations of ``x`` and ``y`` and then converting the exact result to its finite-digit floating-point representation.
"""

# ╔═╡ ef7d9a3d-431d-4ebc-9f54-f2e44322957b
md"""
**Remark.**
One of the most common error-producing calculations involves the cancelation of significant digits due to the subtraction of nearly equal numbers.
Suppose two nearly equal numbers ``x`` and ``y``, with ``x > y``, have the ``k``-digit representations

$fl(x) = 0.d_1 d_2 … d_p α_{p+1} α_{p+2} … α_k × 10^n$

and

$fl(y) = 0.d_1 d_2 … d_p β_{p+1} β_{p+2} … β_k × 10^n.$

The floating-point form of ``x - y`` is

$fl(fl(x) - fl(y)) = 0.σ_{p+1} σ_{p+2} … σ_k × 10^{n-p},$

where

$0.σ_{p+1} σ_{p+2} … σ_k = 0.α_{p+1} α_{p+2} … α_k - 0.β_{p+1} β_{p+2} … β_k.$

The floating-point number used to represent ``x - y`` has at most ``k - p`` digits of significance.
However, in most calculation devices, ``x - y`` will be assigned ``k`` digits, with the last ``p`` being either zero or randomly assigned.
Any further calculations involving ``x - y`` retain the problem of having only ``k - p`` digits of significance, since a chain of calculations is no more accurate that its weakest portion.
"""

# ╔═╡ 4feabf0d-869f-4bcc-aa95-0b166765537d
md"### Nested Arithmetic"

# ╔═╡ 513d860f-a870-4138-b500-ccdeae3eed2b
md"""
**Remark.**
Accuracy loss due to round-off error can also be reduced by rearranging calculations, as shown in the next example.
"""

# ╔═╡ bdbccf8e-3bf3-4a96-a51a-d8a77fbb8a36
md"""
**Remark.**
Polynomials should *always* be expressed in nested form before performing an evaluation because this form minimizes the number of arithmetic calculations.
The decreased error in the illustration is due to the reduction in computations from four multiplications and three additions to two multiplications and three additions.
One way to reduce round-off error is to reduce the number of computations.
"""

# ╔═╡ 09cdfdaf-62aa-479b-b36e-993a457aa252
md"## 1.3 Algorithms and Convergence"

# ╔═╡ 96e16465-87a5-4f8f-bd50-abc05247c3e6
md"""
**Remark.**
Throughout the text, we will be examining approximation procedurers, called *algorithms*, involving sequences of calculations.
An **algorithm** is a procedure that describes, in an unambiguous manner, a finite sequence of steps to be performed in a specified order.
The object of the algorithm is to implement a procedure to solve a problem or approximate a solution to the problem.
"""

# ╔═╡ d07dc6d5-1dd4-43d8-a83c-7db4bbf9fe7c
md"""
**Remark.**
We use a **pseudocode** to describe the algorithms.
This pseudocode specifies the form of the input to be supplied and the form of the desired output.
Not all numerical procedures give satisfactory output for arbitrarily chosen input.
As a consequence, a stopping technique independent of the numerical technique is incorporated into each algorithm to avoid infinite loops.
"""

# ╔═╡ 8e10ec87-d488-44d8-ad12-cb09ff652820
md"""
**Remark.**
Two punctuation symbols are used in the algorithms:

- A period (.) indicates the termination of a step.

- A semicolon (;) separates tasks within a step.
"""

# ╔═╡ b65ae051-f995-40fd-8b67-caca49d328bd
md"### Characterizing Algorithms"

# ╔═╡ 230c64d0-ae77-4ea4-99fa-b5bb5d9746e9
md"""
**Remark.**
We will be considering a variety of approximation problems throughout the text, and in each case we need to determine approximation methods that produce dependably accurate results for a wide class of problems.
Because of the differing ways in which the approximation methods are derived, we need a variety of conditions to categorize their accuracy.
Not all of these conditions will be appropriate for any particular problem.
"""

# ╔═╡ 99bfe880-0356-4441-b672-fd2ed0404be5
md"""
**Remark.**
One criterion we will impose on an algorithm whenever possible is that small changes in the initial data produce correspondingly small changes in the final results.
"""

# ╔═╡ 9fdf2bf4-bc30-4600-9f9d-65d0f6a6f1d8
md"""
**Remark.**
To further consider the subject of round-off error growth and its connection to algorithm stability, suppose an error with magnitude ``E_0 > 0`` is introduced at some stage in the calculations and that the magnitude of the error after ``n`` subsequent operations is denoted by ``E_n``.
The two cases that arise most often in practice are defined as follows.
"""

# ╔═╡ dc3cd185-b3a4-407a-bea3-fc88e8711cbb
md"""
**Definition 1.17**
Suppose that ``E_0`` denotes an error introduced at some stage in the calculations and ``E_n`` represents the magnitude of the error after ``n`` subsequent operations.

- If ``E_n ≈ C n E_0``, where ``C`` is a constant independent of ``n``, then the growth of error is said to be **linear**.

- If ``E_n ≈ C^n E_0``, for some ``C > 1``, then the growth of error is called **exponential**.
"""

# ╔═╡ 5452cdba-33dd-4bbd-8e44-3fb5cfe921bd
md"### Rates of Convergence"

# ╔═╡ 36f80fdd-ccf3-4bd2-9e67-c4e8ade6544a
md"""
**Remark.**
Since iterative techniques involving sequences are often used, this section concludes with a brief discussion of some terminology used to describe the rate at which convergence occurs.
In general, we would like the technique to converge as rapidly as possible.
The following definition is used to compare the convergence rates of sequences.
"""

# ╔═╡ 0fc97dc6-e560-4f5d-9719-640aa38603cf
md"""
**Definition 1.18**
Suppose ``\{β_n\}^∞_{n=1}`` is a sequence known to converge to zero and ``\{α_n\}^∞_{n=1}`` converges to a number ``α``.
If a positive constant ``K`` exists with

$|α_n - α| ≤ K|β_n|, \quad \text{ for large } n,$

then we say that ``\{α_n\}^∞_{n=1}`` converges to ``α`` with **rate, or order, of convergence** ``O(β_n)``.
It is indicated by writing ``α_n = α + O(β_n)``.
"""

# ╔═╡ d8945fb4-8f62-42ce-8ad2-b9b253203e38
md"""
**Remark.**
Although Definition 1.18 permits ``\{α_n\}^∞_{n=1}`` to be compared with an arbitrary sequence ``\{β_n\}^∞_{n=1}``, in nearly every situation we use

$β_n = \frac{1}{n^p},$

for some number ``p > 0``.
We are generally interested in the largest value of ``p`` with ``α_n = α + O(1/n^p)``.
"""

# ╔═╡ adff733d-7715-401a-8b72-e5718e785661
md"""
**Example 2**
Suppose that, for ``n ≥ 1``,

$α_n = \frac{n+1}{n^2} \quad\text{and}\quad \hat{α}_n = \frac{n+3}{n^3}.$

Both ``\lim_{n→∞} α_n  = 0`` and ``\lim_{n→∞}\hat{α}_n = 0``, but the sequence ``\{\hat{α}_n\}`` converges to this limit much faster than the sequence ``\{α_n\}``.
Using five-digit rounding arithmetic, we have the values shown in Table 1.7.
Determine rates of convergence for these two sequences.

_**Solution**_
Define the sequences ``β_n = 1/n`` and ``\hat{β}_n = 1/n^2``.
Then

$|α_n - 0| = \frac{n + 1}{n^2} ≤ \frac{n + n}{n^2} = 2 ⋅ \frac{1}{n} = 2β_n$

and

$|\hat{α}_n - 0| = \frac{n + 3}{n^3} ≤ \frac{n + 3n}{n^3} = 4 ⋅ \frac{1}{n^2} = 4\hat{β_n}.$

Hence, the rate of convergence of ``\{α_n\}`` to zero is similar to the convergence of ``\{1/n\}`` to zero, whereas ``\{\hat{α}_n\}`` converges to zero at a rate similar to the more rapidly convergent sequence ``\{1/n^2\}``.
We express this by writing

$α_n = 0 + O\left(\frac{1}{n}\right) \quad\text{ and }\quad \hat{α}_n = 0 + O\left(\frac{1}{n^2}\right).$
"""

# ╔═╡ 5fce4410-0f86-441b-98e8-42ad7f6e5fb2
md"""
**Definition 1.19**
Suppose that ``\lim_{h→0} G(h) = 0`` and ``\lim_{h→0} F(h) = L``.
If a positive constant ``K`` exists with

$|F(h) - L| ≤ K|G(h)|, \quad\text{ for sufficiently small } h,$

then we write ``F(h) = L + O(G(h))``.
"""

# ╔═╡ 4d184b50-bba5-4ba5-930b-c03e5bedc662
md"""
**Remark.**
The functions we use for comparison generally have the form ``G(h) = h^p``, where ``p > 0``.
We are interested in the largest value of ``p`` for which ``F(h) = L + O(h^p)``.
"""

# ╔═╡ 25bf8f22-cede-4ef2-947b-3ccb2ed0e840
md"""
**Example 3**
Use the third Taylor polynomial about ``h = 0`` to show that ``\cos{h} + \frac{1}{2} h^2 = 1 + O(h^4).``

_**Solution**_
In Example 3(b) of Section 1.1, we found that this polynomial is

$\cos{h} = 1 - \frac{1}{2} h^2 + \frac{1}{24} h^4 \cos{\tilde{ξ}(h)},$

for some number ``\tilde{ξ}(h)`` between zero and ``h``.
This implies that

$\cos{h} + \frac{1}{2} h^2 = 1 + \frac{1}{24} h^4 \cos{\tilde{ξ(h)}}.$

Hence,

$\left|\left(\cos{h} + \frac{1}{2} h^2\right) - 1\right| = \left|\frac{1}{24} \cos{\tilde{ξ(h)}}\right| h^4 ≤ \frac{1}{24} h^4,$

so as ``h → 0``, ``\cos{h} + \frac{1}{2} h^2`` converges to its limit, 1, about as fast as ``h^4`` converges to 0.
That is,

$\cos{h} + \frac{1}{2} h^2 = 1 + O(h^4).$
"""

# ╔═╡ f6efa262-f885-4520-b183-44907cc96254
md"## 1.4 Numerical Software"

# ╔═╡ d632bb09-296d-4ea0-afff-5c0eb2587da6
md"# 2 Solutions of Equations in One Variable"

# ╔═╡ 8dc32425-ad0d-4bfe-823c-23e64cd903fa
md"""
**Remark.**
The growth of a population can often be modeled over short periods of time by assuming that the population grows continuously with time at a rate proportional to the number present at that time.
Suppose ``N(t)`` denotes the number in the population at time ``t`` and ``λ`` denote the constant birthrate of the population.
Then the population satisfies the differential equation

$\frac{dN(t)}{dt} = λN(t),$

whose solution is ``N(t) = N_0 e^{λt}``, where ``N_0`` denotes the initial population.
"""

# ╔═╡ a77c153a-ff24-437f-84a3-0309cc204219
md"""
**Remark.**
This exponential model is valid only when the population is isolated, with no immigration.
If immigration is permitted at a constant rate ``v``, then the differential equation becomes

$\frac{dN(t)}{dt} = λN(t) + v,$

whose solution is

$N(t) = N_0 e^{λt} + \frac{v}{λ} (e^{λt} - 1).$
"""

# ╔═╡ 1fee97b6-ee90-4366-a561-0acfc5e8c32f
md"""
**Example.**
Suppose that a certain population contains ``N(0) = 1,000,000`` individuals initially, that 435,000 individuals immigrate into the community in the first year, and that ``N(1) = 1,564,000`` individuals are present at the end of one year.
To determine the birthrate of this population, we need to find ``λ`` in the equation

$1,564,000 = 1,000,000e^λ + \frac{435,000}{λ} (e^λ - 1).$

It is not possible to solve explicitly for ``λ`` in this equation, but numerical methods discussed in this chapter can be used to approximate solutions of equations of this type to an arbitrarily high accuracy.
The solution to this particular problem is considered in Exercise 22 of Section 2.3.
"""

# ╔═╡ e1466ee6-e15f-47bf-b889-6cf098abba1e
md"## 2.1 The Bisection Method"

# ╔═╡ 1559d9b2-d230-42f2-adc4-1d52fff1769a
md"""
**Remark.**
In this chapter we consider one of the most basic problems of numerical approximation, the **root-finding problem**.
This process involves finding a **root**, or solution, of an equation of the form ``f(x) = 0``, for a given function ``f``.
A root of this equation is also called a **zero** of the function ``f``.
"""

# ╔═╡ 89a0f371-57a9-4465-9ea0-570a46985156
md"""
**Remark.**
The problem of finding an approximation to the root of an equation can be traced back to at least 1700 B.C.E.
A cuneiform table in the Yale Bablyonian Collection dating from that period gives a sexigesimal (base-60) number equivalent to 1.414222 as an approximation to ``\sqrt{2}``, a result that is accurate to within ``10^{-5}``.
This approximation can be found by applying a technique described in Exercise 19 of Section 2.2.
"""

# ╔═╡ 143bd2ee-9fd4-4f08-9220-dc4c7f361215
md"### Bisection Technique"

# ╔═╡ f012cb56-9175-41a5-9459-f4cf897147c7
md"""
**Remark.**
The first technique, based on Intermediate Value Theorem, is called the **Bisection**, or **Binary-search, method**.
"""

# ╔═╡ c826a507-42ad-4ad0-8933-c3e25638cf76
md"""
**Remark.**
Suppose ``f`` is continuous function defined on the interval ``[a,b]``, with ``f(a)`` and ``f(b)`` of opposite sign.
The Intermediate Value Theorem implies that a number ``p`` exists in ``(a,b)`` with ``f(p) = 0``.
Although the procedure will work when there is more than one root in the interval ``(a,b)``, we assume for simplicity that the root in this interval is unique.
The method calls for a repeated halving (or bisecting) of subintervals of ``[a,b]`` and, at each step, locating the half containing ``p``.
"""

# ╔═╡ e2762236-455c-450c-84e7-e67aee6db99d
md"""
**Remark.**
To begin, set ``a_1 = a`` and ``b_1 = b`` and let ``p_1`` be the midpoint of ``[a,b]``; that is,

$p_1 = a_1 + \frac{b_1 - a_1}{2} = \frac{a_1 + b_1}{2}.$

- If ``f(p_1) = 0``, then ``p = p_1``, and we are done.

- If ``f(p_1) ≠ 0``, then ``f(p_1)`` has the same sign as either ``f(a_1)`` or ``f(b_1)``.

  - If ``f(p_1)`` and ``f(a_1)`` have the same sign, ``p ∈ (p_1, b_1)``.
    Set ``a_2 = p_1`` and ``b_2 = b_1``.

  - If ``f(p_1)`` and ``f(a_1)`` have opposite signs, ``p ∈ (a_1, p_1)``.
    Set ``a_2 = a_1`` and ``b_2 = p_1``.

Then reapply the process to the interval ``[a_2, b_2]``.
This produces the method described in Algorithm 2.1.
(See Figure 2.1.)
"""

# ╔═╡ ded5e8c9-51c5-4e74-884c-8538ba575795
md"""
**Algorithm 2.1 (Bisection Method)**
To find a solution to ``f(x) = 0`` given the continuous function ``f`` on the interval ``[a,b]``, where ``f(a)`` and ``f(b)`` have opposite signs:

- INPUT endpoints ``a,b``; tolerance TOL; maximum number of iterations ``N_0``.

- OUTPUT approximate solution ``p`` or message of failure.

- Step 1 Set ``i = 1;``

  - ``FA = f(a)``.

- Step 2 While ``i ≤ N_0`` do Steps 3--6.

  - Step 3 Set ``p = a + (b - a) / 2``; *(Compute ``p_i``.)*
    - ``FP = f(p)``.

  - Step 4 If ``FP = 0`` or ``(b - a) / 2 < TOL`` then

    - OUTPUT(p); *(Procedure completed successfully.)*

    - STOP.

  - Step 5 Set ``i = i + 1``.

  - Step 6 If ``FA ⋅ FP > 0`` then set ``a = p``; *(Compute ``a_i``, ``b_i``.)*

    - ``FA = FP``

    - else set ``b = p``. *(``FA`` is unchanged)*

- Step 7 OUTPUT ('Method failed after ``N_0`` iterations, ``N_0 =``', ``N_0``);

  *(The procedure was unsuccessful.)*

  STOP.
"""

# ╔═╡ dbee2984-b5da-4f25-907d-62808f13fd68
md"""
**Example 1**
Show that ``f(x) = x^3 + 4x^2 - 10 = 0`` has a root in ``[1,2]`` and use the Bisection method to determine an approximation to the root that is accurate to at least within ``10^{-4}``.

_**Solution**_
Because ``f(1) = -5`` and ``f(2) = 14``, the Intermediate Value Theorem 1.11 ensures that this continuous function has a root in ``[1,2]``.

For the first iteration of the Bisection method, we use the fact that at the midpoint of ``[1,2]`` we have ``f(1.5) = 2.375 > 0``.
This indicates that we should select the interval ``[1,1.5]`` for our second iteration.
Then we find that ``f(1.25) = -1.796875``, so our new interval becomes ``[1.25,1.5]``, whose midpoint is 1.375.
Continuing in this manner gives the values in the Table 2.1.

After 13 iterations, ``p_{13} = 1.365112305`` approximates the root ``p`` with an error

$|p - p_{13}| < |b_{14} - a_{14}| = |1.365234375 - 1.365112305| = 0.000122070.$

Since ``|a_{14}| < |p|``, we have

$\frac{|p - p_{13}|}{|p|} < \frac{|b_{14} - a_{14}|}{|a_{14}|} ≤ 9.0 × 10^{-5},$

so the approximation is correct to at least within ``10^{-4}``.
The correct value of ``p`` to nine decimal places is ``p = 1.365230013``.
Note that ``p_9`` is closer to ``p`` than is the final approximation ``p_{13}``.
You might suspect this is true because ``|f(p_9)| < |f(p_{13})|``, but we cannot be sure of this unless the true answer is known.
"""

# ╔═╡ be3c68fe-8d3c-4a88-a1d2-566afd788d1b
md"""
**Remark.**
The Bisection method, though conceptually clear, has significant drawbacks.
It is relatively slow to converge (that is, ``N`` may become quite large before ``|p - p_N|`` is sufficiently small), and a good intermediate approximation might be inadvertently discarded.
However, the method has important property that it always converges to a solution, and for that reason it is often used as a starter for the more efficient methods we will see later in this chapter.
"""

# ╔═╡ 866b7b24-1429-4005-b77a-e0957d3f1278
md"""
**Theorem 2.1**
Suppose that ``f ∈ C[a,b]`` and ``f(a) ⋅ f(b) < 0``.
The Bisection method generates a sequence ``\{p_n\}_{n=1}^∞`` approximating a zero ``p`` of ``f`` with

$|p_n - p| ≤ \frac{b - a}{2^n},\quad\text{ when }\quad n≥1.$
"""

# ╔═╡ a4055202-8001-4c00-965f-539a313eff7f
md"""
**Example 2**
Determine the number of iterations necessary to solve ``f(x) = x^3 + 4x^2 - 10 = 0`` with accuracy ``10^{-3}`` using ``a_1 = 1`` and ``b_1 = 2``.

_**Solution**_
We will use logarithms to find an integer ``N`` that satisfies

$|p_N - p| ≤ 2^{-N} (b - a) = 2^{-N} < 10^{-3}.$

Logarithms to any base would suffice, but we will use base-10 logarithms because the tolerance is given as a power of 10.
Since ``2^{-N} < 10^{-3}`` implies that ``\log_{10}{2^{-N}} < \log_{10}{10^{-3}} = -3``, we have

$-N \log_{10}{2} < -3 \quad\text{and}\quad N > \frac{3}{\log_{10}{2}} ≈ 9.96.$

Hence, 10 iterations are required for an approximation accurate to within ``10^{-3}``.
"""

# ╔═╡ 3f41b43a-10e9-4660-8fd8-2369fc4fd2eb
md"## 2.2 Fixed-Point Iteration"

# ╔═╡ 5dfb111b-31a9-41a0-9215-c1559232da3b
md"""
**Remark.**
A *fixed point* for a function is a number at which the value of the function does not change when the function is applied.
"""

# ╔═╡ 7646252b-a583-446d-862b-a793fdfae96a
md"""
**Definition 2.2**
The number ``p`` is a **fixed point** for a given function if ``g`` if ``g(p) = p``.
"""

# ╔═╡ 6657c0c6-0c38-44b8-8e69-f2c0e5fc4c65
md"""
**Remark.**
In this section, we consider the problem of finding solutions to fixed-point problems and the connection between the fixed-point problems and the root-finding problems we wish to solve.
Root-finding problems and fixed-point problems are equivalent classes in the following sense:

- Given a root-finding problem ``f(p) = 0``, we can define functions ``g`` with a fixed point at ``p`` in a number of ways, for example, as

  $g(x) = x - f(x) \quad\text{or as}\quad g(x) = x + 3f(x).$

- Conversely, if the function ``g`` has a fixed point at ``p``, then the function defined by

  $f(x) = x - g(x)$

  has a zero at ``p``.
"""

# ╔═╡ 4c7f1ea7-38b5-4956-b2dd-ff81db7445f3
md"""
**Remark.**
Although the problems we wish to solve are in the root-finding form, the fixed-point form is easier to analyze, and certain fixed-point choices lead to very powerful root-finding techniques.
"""

# ╔═╡ 54e0418a-9ca3-4182-8e09-1bb034efe3a8
md"""
**Remark.**
We first need to become cmofortable with this new type of problem and to decide when a function has a fixed point and how the fixed points can be approximated to within a specified accuracy.
"""

# ╔═╡ 0a650ded-443b-4055-9d44-f7fc6662409a
md"""
**Example 1**
Determine any fixed points of the function ``g(x) = x^2 - 2``.

_**Solution**_
A fixed point ``p`` for ``g`` has the property that

$p = g(p) = p^2 - 2, \quad\text{which implies that}\quad 0 = p^2 - p - 2 = (p + 1)(p - 2).$

A fixed point for ``g`` occurs precisely when the graph of ``y = (x)`` intersects the graph of ``y = x``, so ``g`` has two fixed points, one at ``p = -1`` and the other at ``p = 2``.
These are shown in Figure 2.2.
"""

# ╔═╡ d4b7276f-78f2-4f33-bbb9-f6d6f2569eb8
md"""
**Remark.**
The following theorem gives sufficient conditions for the existence and uniqueness of a fixed point.
"""

# ╔═╡ 9f7a35ca-469f-4363-b770-0e9c06033b5f
md"""
**Theorem 2.3**

(i) If ``g ∈ C[a,b]`` and ``g(x) ∈ [a,b]`` for all ``x ∈ [a,b]``, then ``g`` has at least one fixed point in ``[a,b]``.

(ii) If, in addition, ``g'(x)`` exists on ``(a,b)`` and a positive constant ``k < 1`` exists with

$|g'(x)| ≤ k, \quad \text{for all } x ∈ (a,b),$

then there is exactly one fixed point in ``[a,b]``. (See Figure 2.3.)
"""

# ╔═╡ 047c7e98-5d68-4a45-8178-5f504264f87c
md"""
**Example 2**
Show that ``g(x) = (x^2 - 1)/3`` has a unique fixed point on the interval ``[-1,1]``.

_**Solution**_
The maximum and minimum values of ``g(x)`` for ``x`` in ``[-1,1]`` must occur when ``x`` is an endpoint of the interval or when the derivative is ``0``.
Since ``g'(x) = 2x/3``, the function ``g`` is continuous, and ``g'(x)`` exists on ``[-1,1]``.
The maximum and minimum values of ``g(x)`` occur at ``x = -1``, ``x = 0``, or ``x = 1``.
But ``g(-1) = 0``, ``g(1) = 0``, and ``g(0) = -1/3``, so an absolute maximum for ``g(x)`` on ``[-1,1]`` occurs at ``x = -1`` and ``x = 1`` and an absolute minimum at ``x = 0``.

Moreover,

$|g'(x)| = \left|\frac{2x}{3}\right| ≤ \frac{2}{3}, \quad\text{ for all } x ∈ (-1,1).$

So ``g`` satisfies all the hypotheses of Theorem 2.3 and has a unique fixed point in ``[-1,1]``.
"""

# ╔═╡ c3580c5e-b3fe-43e0-81e3-907414eda51b
md"""
**Remark.**
For the function in Example 2, the unique fixed point ``p`` in the interval ``[-1,1]`` can be determined algebraically.
If

$p = g(p) = \frac{p^2 - 1}{3}, \quad\text{then}\quad p^2 - 3p - 1 = 0,$

which, by the quadratic formula, implies, as shown on the left graph in Figure 2.4, that

$p = \frac{1}{2} (3 - \sqrt{13})$
"""

# ╔═╡ 238e7794-616d-4da9-9c81-4d6f9fa3be8e
md"""
**Remark.**
Note that ``g`` also has a unique fixed point ``p = \frac{1}{2} (3 + \sqrt{13})`` for the interval ``[3,4]``.
However ``g(4) = 5`` and ``g'(4) = \frac{8}{3} > 1``, so ``g`` does not satisfy the hypotheses of Theorem 2.3 on ``[3,4]``.
This demonstrates that the hypotheses of Theorem 2.3 are sufficient to guarantee a unique fixed point but are not necessary.
(See the graph on the right in Figure 2.4.)
"""

# ╔═╡ 751fae05-6c93-4e23-a009-39daf2e95ae3
md"""
**Example 3**
Show that Theorem 2.3 does not ensure a unique fixed point of ``g(x) = 3^{-x}`` on the interval ``[0,1]``, even though a unique fixed point on this interval does not exist.

_**Solution**_
``g'(x) = -3^{-x} \ln{3} < 0`` on ``[0,1]``, the function ``g`` is strictly decreasing on ``[0,1]``.
So

$g(1) = \frac{1}{3} ≤ g(x) ≤ 1 = g(0), \quad\text{for}\quad 0 ≤ x ≤ 1.$

Thus, for ``x ∈ [0,1]``, we have ``g(x) ∈ [0,1]``.
The first part of Theorem 2.3 ensures that there is at least one fixed point in ``[0,1]``.

However,

$g'(0) = -\ln{3} = -1.098612289,$

so ``|g'(x)| ≰ 1`` on ``(0,1)``, and Theorem 2.3 cannot be used to determine uniqueness.
But ``g`` is always decreasing, and it is clear from Figure 2.5 that the fixed point must be unique.
"""

# ╔═╡ 9936a10f-0584-420b-af92-cd41fbd31668
md"### Fixed-Point Iteration"

# ╔═╡ 234c5fef-469a-4f1d-bc5e-e149051a498c
md"""
**Remark.**
We cannot explicitly determine the fixed point in Example 3 because we have no way to solve for ``p`` in the equation ``p = g(p) = 3^{-p}``.
We can, however, determine approximation to this fixed point to any specified degree of accuracy.
We will now consider how this can be done.
"""

# ╔═╡ 84107ded-bfce-48a7-8827-84367ca63ee6
md"""
**Remark.**
To approximate the fixed point of a function ``g``, we choose an initial approximation ``p_0`` and generate the sequence ``\{p_n\}_{n=0}^∞`` by letting ``p_n = g(p_n - 1)``, for each ``n ≥ 1``.
If the sequence converges to ``p`` and ``g`` is continuous, then

$p = \lim_{n→∞} p_n = \lim_{n→∞} g(p_n - 1) = g \left(\lim_{n→∞} p_{n-1}\right) = g(p),$

and a solution to ``x = g(x)`` is obtained.
This technique is called **fixed-point**, or **functional iteration**.
The procedure is illustrated in Figure 2.6 and detailed in Algorithm 2.2.
"""

# ╔═╡ defec1fa-05c0-47ee-ac5d-82b00b359652
md"""
**Theorem 2.4 (Fixed-Point Theorem)**
Let ``g ∈ C[a,b]`` be such that ``g(x) ∈ [a,b]``, for all ``x`` in ``[a,b]``.
Suppose, in addition, that ``g'`` exists on ``(a,b)`` and that a constant ``0 < k < 1`` exists with

$|g'(x)| ≤ k, \quad\text{ for all } x ∈ (a,b).$

Then, for any number ``p_0`` in ``[a,b]``, the sequence defined by

$p_n = g(p_{n - 1}), \quad n ≥ 1,$

converges to the unique fixed point ``p`` in ``[a,b]``.
"""

# ╔═╡ 282d5528-ea4b-444b-9c98-55fbf1033105
md"""
**Corollary 2.5**
If ``g`` satisfies the hypothesis of Theorem 2.4, then bounds for the error involved in using ``p_n`` to approximate ``p`` are given by

$|p_n - p| ≤ k^n \max\{p_0 - a, b - p_0\} \tag{2.5}$

and

$|p_n - p| ≤ \frac{k^n}{1 - k} |p_1 - p_0|, \quad\text{for all}\quad n ≥ 1. \tag{2.6}$
"""

# ╔═╡ ed7e0ff6-199b-4707-8b3b-f8e3fcbb9e42
md"""
**Remark.**
Both inequalities in the corollary relate the rate at which ``\{p_n\}_{n=0}^∞`` converges to the bound ``k`` on the first derivative.
The rate of convergence depends on the factor ``k^n``.
The smaller the value of ``k``, the fast the convergence.
However, the convergence may be very slow if ``k`` is close to 1.
"""

# ╔═╡ e667f130-c551-41c3-aae5-0addaec3cdd5
md"""
**Illustration**
Let us reconsider the various fixed-point schemes described in the preceding illustration in light of the Fixed-Point Theorem 2.4 and its Corollary 2.5.

(a) For ``g_1(x) = x - x^3 - 4x^2 + 10``, we have ``g_1(1) = 6`` and ``g_1(2) = -12``, so ``g_1`` does not map ``[1,2]`` into itself.
Moreover, ``g_1'(x) = 1 - 3x^2 - 8x``, so ``|g_1'(x)| > 1`` for all ``x`` in ``[1,2]``.
Although Theorem 2.4 does not guarantee that the method must fail for this choice of ``g``, there is no reason to expect convergence.

(b) With ``g_2(x) = [(10/x) - 4x]^{1/2}``, we can see that ``g_2`` does not map ``[1,2]`` into ``[1,2]``, and the sequence ``\{p_n\}_{n=0}^∞`` is not defined when ``p_0 = 1.5``.
Moreover, there is no interval containing ``p ≈ 1.365`` such that ``|g_2'(x)| < 1`` because ``|g_2'(p)| ≈ 3.4``.
There is no reason to expect that this method will converge.

(c) For the function ``g_3(x) = \frac{1}{2} (10 - x^3)^{1/2}``, we have

$g_3'(x) = -\frac{3}{4} x^2 (10 - x^3)^{-1/2} < 0 \quad\text{ on } [1,2],$

so ``g_3`` is strictly decreasing on ``[1,2]``.
However, ``|g_3'(2)| ≈ 2.12``, so the condition ``|g_3'(x)| ≤ k < 1`` fails on ``[1,2]``.
A closer examination of the sequence ``\{p_n\}_{n=0}^∞`` starting with ``p_0 = 1.5`` shows that it suffices to consider the interval ``[1,1.5]`` instead of ``[1,2]``.
On this interval, it is still true that ``g_3'(x) < 0`` and ``g_3`` is strictly decreasing, but, additionally,

$1 < 1.28 ≈ g_3(1.5) ≤ g_3(x) ≤ g_3(1) = 1.5,$

for all ``x ∈ [1,1.5]``.
This shows that ``g_3`` maps the interval ``[1,1.5]`` into itself.
It is also true that ``|g_3'(x)| ≤ |g_3'(1.5)| ≈ 0.66`` on this interval, so Theorem 2.4 confirms the convergence of which we were already aware.

(d) For ``g_4(x) = (10 / (4 + x))^{1/2}``, we have

$|g_4'(x)| = \left|\frac{-5}{\sqrt{10} (4 + x)^{3/2}}\right| ≤ \frac{5}{\sqrt{10} (5)^{3/2}} < 0.15, \quad\text{ for all }\quad x ∈ [1,2].$

The bound on the magnitude of ``g_4'(x)`` is much smaller than the bound (found in (c)) on the magnitude of ``g_3'(x)``, which explains the more rapid convergence using ``g_4``.

(e) The sequence defined by

$g_5(x) = x - \frac{x^3 + 4x^2 - 10}{3x^2 + 8x}$

converges much more rapidly than our other choices.
In the next sections, we will see where this choice came from and why it is so effective.
"""

# ╔═╡ deac8e0e-20ab-4a11-acc5-426cdfb33525
md"## 2.3 Newton's Method and Its Extensions"

# ╔═╡ 22e7cec2-58dd-470a-b266-d3922929eb63
md"""
**Remark.**
**Newton's** (or the *Newton-Raphson*) **method** is one of the most powerful and well-known numerical methods for solving a root-finding problem.
There are many ways of introducing Newton's method.
"""

# ╔═╡ e196f30a-b529-4f72-90f2-67b56c633473
md"### Newton's Method"

# ╔═╡ 9dd1f3ae-18c2-4aec-9d1b-89ce7a957bec
md"""
**Remark.**
If we want only an algorithm, we can consider the technique graphically, as is often done in calculus.
Another possibility is to derive Newton's method as a technique to obtain faster convergence than offered by other types of functional iteration, as is done in Section 2.4.
A third means of introducing Newton's method, which is discussed next, is based on Taylor polynomials.
We will see there that this particular derivation produces not only the method but also a bound for the error of the approximation.
"""

# ╔═╡ 33dd758a-9373-4019-b4a4-92d24161fb8a
md"""
**Remark.**
Suppose that ``f ∈ C^2[a,b]``.
Let ``p_0 ∈ [a,b]`` be an approximation to ``p`` such that ``f'(p_0) ≠ 0`` and ``|p - p_0|`` is "small."
Consider the first Taylor polynomial for ``f(x)`` expanded about ``p_0`` and evaluated at ``x = p``:

$f(p) = f(p_0) + (p - p_0) f'(p_0) + \frac{(p - p_0)^2}{2} f''(ξ(p)),$

where ``ξ(p)`` lies between ``p`` and ``p_0``.
Since ``f(p) = 0``, this equation gives

$0 = f(p_0) + (p - p_0) f'(p_0) + \frac{(p - p_0)^2}{2} f''(ξ(p)).$
"""

# ╔═╡ 5ff7ede5-c5bd-4ed3-b36c-de984b6d7269
md"""
**Remark.**
Newton's method is derived by assuming that since ``|p - p_0|`` is small, the term involving ``(p - p_0)^2`` is much smaller, so

$0 ≈ f(p_0) + (p - p_0) f'(p_0).$

Solving for ``p`` gives

$p ≈ p_0 - \frac{f(p_0)}{f'(p_0)} ≡ p_1.$
"""

# ╔═╡ 1392082c-df83-4834-aaa1-3cf927729254
md"""
**Remark.**
This sets the stage for Newton's method, which starts with an initial approximation ``p_0`` and generates the sequence ``\{p_n\}_{n=0}^∞``, by

$p_n = p_{n-1} - \frac{f(p_{n-1})}{f'(p_{n-1})}, \quad\text{ for } n ≥ 1. \tag{2.7}$
"""

# ╔═╡ 3829beb6-cb1e-4d73-9989-a440a142ba72
md"""
**Remark.**
Figure 2.7 illustrates how the approximations are obtained using succcessive tangents.
(Also see Exercise 31.)
Starting with the initial approximation ``p_0``, the approximation ``p_1`` is the ``x``-intercept of the tangent line to the graph of ``f`` at ``(p_0, f(p_0))``.
The approximation ``p_2`` is the ``x``-intercept of the tangent line to the graph of ``f`` at ``(p_1, f(p_1))`` and so on.
Algorithm 2.3 implements this procedure.
"""

# ╔═╡ 6be0b014-1670-45b9-b6a7-b9b5f7e1e1cf
md"""
**Algorithm 2.3 (Newton's Method).**
To find a solution to ``f(x) = 0`` given an initial approximation ``p_0``:

- INPUT initial approximation ``p_0``; tolerance ``TOL``; maximum number of iterations ``N_0``.

- OUTPUT approximate solution ``p`` or message of failure.

- Step 1 Set ``i = 1``.

- Step 2 While ``i ≤ N_0`` do Steps 3--6.

  - Step 3 Set ``p = p_0 - f(p_0) / f'(p_0)``. (Compute ``p_i``.)

  - Step 4 If ``|p - p_0| < TOL`` then

    - OUTPUT(``p``); *(The procedure was successful.)*

    - STOP.

  - Step 5 Set ``i = i + 1``

  - Step 6 Set ``p_0 = p``. *(Update ``p_0``.)*

- Step 7 OUTPUT('The method failed after ``N_0`` iterations, ``N_0=``', ``N_0``);

  - *(The procedure was unsuccessful.)*

  - STOP.
"""

# ╔═╡ 2ac60db8-ebda-4571-b610-35315750e113
md"""
**Remark.**
The stopping-technique inequalities given with the Bisection method are applicable to Newton's method.
That is, select a tolerance ``ε > 0`` and construct ``p_1, …p_N`` until

$|p_N - p_{N-1}| < ε, \tag{2.8}$

$\frac{|p_N - p_{N-1}|}{|p_N|} < ε, \quad p_N ≠ 0, \tag{2.9}$

or

$|f(p_N)| < ε. \tag{2.10}$

A form of Inequality (2.8) is used in Step 4 of Algorithm 2.3.
Note that none of the inequalities (2.8), (2.9), or (2.10) give precise information about the actual error ``|p_N - p|`` (See Exercises 19 and 20 in Section 2.1.)
"""

# ╔═╡ a1388e95-2241-4ebd-bfdd-eac6dab12dbb
md"""
**Remark.**
Newton's method is a functional iteration technique with ``p_n = g(p_{n-1})``, for which

$g(p_{n-1}) = p_{n-1} - \frac{f(p_{n-1})}{f'(p_{n-1})}, \quad\text{ for } n ≥ 1. \tag{2.11}$

In fact, this is the functional iteration technique that was used to give the rapid convergence we saw in colume (e) of Table 2.2 in Section 2.2.
"""

# ╔═╡ b622e4ec-5df6-42f1-a8eb-507885ed3ab6
md"""
**Remark.**
It is clear from Equation (2.7) that Newton's method cannot be continued if ``f'(p_{n-1}) = 0`` for some ``n``.
In fact, we will see that the method is most effective when ``f'`` is bounded away from zero near ``p``.
"""

# ╔═╡ 365cdc0d-8235-4aea-8211-9d214bf2b0c4
md"""
**Example 1**
Consider the function ``f(x) = \cos{x} - x = 0``.
Approximate a root of ``f`` using (a) a fixed-point method, and (b) Newton's method.

_**Solution**_
(a) A solution to this root-finding problem is also a solution to the fixed-point problem ``x = \cos{x}``, and the graph in Figure 2.8 implies that a single fixed point ``p`` lies in ``[0,π/2]``.

Table 2.3 shows the results of fixed-point iteration with ``p_0 = π/4``.
The best we could conclude from these results is that ``p ≈ 0.74``.

(b) To apply Newton's method to this problem, we need ``f'(x) = -\sin{x} - 1``.
Starting again with ``p_0 = π/4``, we have

$\begin{align*}
p_1 &= p_0 - \frac{p_0}{f'(p_0)}\\
&= \frac{π}{4} - \frac{\cos(π/4) - π/4}{-\sin(π/4) - 1} \\
&= \frac{π}{4} - \frac{\sqrt{2}/2 - π/4}{-\sqrt{2}/2 - 1} \\
&= 0.7395361337 \\
p_2 &= p_1 - \frac{\cos(p_1) - p_1}{-\sin(p_1) - 1} \\
&= 0.7390851781
\end{align*}$

We continue generating the sequence by

$p_n = p_{n-1} - \frac{f(p_{n-1})}{f'(p_{n-1})} = p_{n-1} - \frac{\cos(p_{n-1}) - p_{n-1}}{-\sin(p_{n-1}) - 1}.$

This gives the approximations in Table 2.4.
An excellent approximation is obtained with ``n = 3``.
Because of the agreement of ``p_3`` and ``p_4``, we could reasonably expect this result to be accurate to the places listed.
"""

# ╔═╡ ba45e8ca-60fe-4b2e-a7b7-404bc670954f
md"### Convergence Using Newton's Method"

# ╔═╡ 96d49def-ba6e-4909-a46c-6940bbb446f4
md"""
**Remark.**
Example 1 shows that Newton's method can provide extremely accurate approximations with very few iterations.
For that example, only one iteration of Newton's method was needed to give better accuracy than seven iterations of the fixed-point method.
It is now time to examine Newton's method more carefully to discovery why it is so effective.
"""

# ╔═╡ 9a430950-d9c5-4101-a602-59f1ae4043ac
md"""
**Remark.**
The Taylor series derivation of Newton's method at the beginning of the section points out the importance of an accurate initial approximation.
The crucial assumption is that the term involving ``(p - p_0)^2`` is, by comparison with ``|p - p_0|``, so small that it can be deleted.
This will clearly be false unless ``p_0`` is a good approximation to ``p``.
If ``p_0`` is not sufficiently close to the actual root, there is little reason to suspect that Newton's method will converge to the root.
However, in some instances, even poor initial approximations will produce convergence.
(Exercise 15 and 16 illustrate some of these possibilities.)
"""

# ╔═╡ 2e708a9c-7f84-42d1-8575-b45e6de46b74
md"""
**Theorem 2.6**
Let ``f ∈ C^2[a,b]``.
If ``p ∈ (a,b)`` such that ``f(p) = 0`` and ``f'(p) ≠ 0``, then there exists a ``δ > 0`` such that Newton's method generates a sequence ``\{p_n\}_{n=1}^∞`` converging to ``p`` for any initial approximation ``p_0 ∈ [p - δ, p + δ]``.

_**Proof**_
The proof is based on analyzing Newton's method as the functional iteration scheme ``p_n = g(p_{n-1})``, for ``n ≥ 1``, with

$g(x) = x - \frac{f(x)}{f'(x)}.$

Let ``k`` be in ``(0,1)``.
We first find an interval ``[p - δ, p + δ]`` that ``g`` maps into itself and for which ``|g'(x)| ≤ k``, for all ``x ∈ (p - δ, p + δ)``.

Since ``f'`` is continuous and ``f'(p) ≠ 0``, part (a) of Exercise 30 in Section 1.1 implies that there exists a ``δ_1 > 0``, such that ``f'(x) ≠ 0`` for ``x ∈ [p - δ_1, p + δ_1] ⊆ [a,b]``.
Thus, ``g`` is defined and continuous on ``[p - δ_1, p + δ_1]``.
Also,

$g'(x) = 1 - \frac{f'(x) f'(x) - f(x) f''(x)}{[f'(x)]^2} = \frac{f(x) f''(x)}{[f'(x)]^2},$

for ``x ∈ [p - δ_1, p + δ_1]``, and, since ``f ∈ C^2[a,b]``, we have ``g ∈ C^1[p - δ_1, p + δ_1]``.

By assumption, ``f(p) = 0``, so

$g'(p) = \frac{f(p) f''(p)}{[f'(p)]^2} = 0.$

Since ``g'`` is continuous and ``0 < k < 1``, part (b) of Exercise 30 in Section 1.1 implies that there exists a ``δ``, with ``0 < δ < δ_1``, for which

$|g'(x)| ≤ k, \quad\text{ for all } x ∈ [p - δ, p + δ].$

It remains to show that ``g`` maps ``[p - δ, p + δ]`` into ``[p - δ, p + δ]``.
If ``x ∈ [p - δ, p + δ]``, the Mean Value Theorem implies that for some number ``ξ`` between ``x`` and ``p``, ``|g(x) - g(p)| = |g'(ξ)| |x - p|``.
So,

$|g(x) - p| = |g(x) - g(p)| = |g'(ξ)||x - p| ≤ k|x - p| < |x - p|.$

Since ``x ∈ [p - δ, p + δ]``, it follows that ``|x - p| < δ`` and that ``|g(x) - p| < δ``.
Hence, ``g`` maps ``[p - δ, p + δ]`` into ``[p - δ, p + δ]``.

All the hypotheses of the Fixed-Point Theorem 2.4 are now satisfied, so the sequence ``\{p_n\}_{n=1}^∞``, defined by

$p_n = g(p_{n-1}) = p_{n-1} - \frac{f(p_{n-1})}{f'(p_{n-1})}, \quad\text{ for } n ≥ 1,$

converges to ``p`` for any ``p_0 ∈ [p - δ, p + δ]``.
"""

# ╔═╡ 06b5d562-5c56-400e-9d84-dc153b13842c
md"""
**Remark.**
Theorem 2.6 states that, under reasonable assumptions, Newton's method converges, provided that a sufficiently accurate initial approximation is chosen.
It also implies that the constant ``k`` that bounds the derivative of ``g`` and, consequently, indicates the speed of convergence of the method decreases to ``0`` as the procedure continues.
This result is import for the theory of Newton's method, but it is seldom applied in practice because it does not tell us how to determine ``δ``.
"""

# ╔═╡ 07932733-be06-4a7a-8ca2-4ecdbc505c47
md"### The Secant Method"

# ╔═╡ dc14bc97-62e3-419f-80ec-0c1cbd0321ce
md"""
**Remark.**
Newton's method is an extremely powerful technique, but it has a major weakness: the need tok now the value of the derivative of ``f`` at each approximation.
Frequently, ``f'(x)`` is for more difficult and needs more arithmetic operations to calculate than ``f(x)``.
"""

# ╔═╡ 43a3bb21-2820-4151-a847-c480279a18a0
md"""
**Remark.**
To circumvent the problem of the derivative evaluation in Newton's method, we introduce a slight variation.
By definition,

$f'(p_{n-1}) = \lim_{x → p_{n-1}} \frac{f(x) - f(p_{n-1})}{x - p_{n-1}}$

If ``p_{n-2}`` is close to ``p_{n-1}``, then

$f'(p_{n-1}) ≈ \frac{f(p_{n-2}) - f(p_{n-1})}{p_{n-2} - p_{n-1}} = \frac{f(p_{n-1}) - f(p_{n-2})}{p_{n-1} - p_{n-2}}.$

Using this approximation for ``f'(p_{n-1})`` in Newton's formula gives

$p_n = p_{n-1} - \frac{f(p_{n-1})(p_{n-1} - p_{n-2})}{f(p_{n-1}) - f(p_{n-2})}. \tag{2.12}$
"""

# ╔═╡ 335f92e6-cbd8-49d2-baaa-1fc8633cb05e
md"""
**Remark.**
This technique is called the **Secant method** and is presented in Algorithm 2.4.
(See Figure 2.9.)
Starting with the two initial approximations ``p_0`` and ``p_1``, the approximation ``p_2`` is the ``x``-intercept of the line joining ``(p_0, f(p_0))`` and ``(p_1,f(p_1))``.
The approximation ``p_3`` is the ``x``-intercept of the line joining ``(p_1, f(p_1))`` and ``(p_2, f(p_2))`` and so on.
Note that only one function evaluation is needed per step for the Secant method after ``p_2`` has been determined.
In contrast, each step of Newton's method requires an evaluation of both the function and its derivative.
"""

# ╔═╡ 20834636-449f-4e66-8e31-0686e6164e6d
md"""
**Example 2**
Use the Secant method to find a solution to ``x = \cos{x}`` and compare the approximations with those given in Example 1, which applied Newton's method.

_**Solution**_
In Example 1, we compared fixed-point iteration and Newton's method starting with the initial approximation ``p_0 = π/4``.
For the Secant method, we need two initial approximations.
Suppose we use ``p_0 = 0.5`` and ``p_1 = π/4``:

$\begin{align*}
p_2 &= p_1 - \frac{(p_1 - p_0)(\cos{p_1} - p_1)}{(\cos{p_1} - p_1) - (\cos{p_2} - p_2)} \\
&= \frac{π}{4} - \frac{(π/4 - 0.5) (\cos(π/4) - π/4)}{(\cos(π/4) - π/4) - (\cos{0.5} - 0.5)} \\
&= 0.7363841388.
\end{align*}$

Succeeding approximations are generated by the formula

$p_n = p_{n-1} - \frac{(p_{n-1} - p_{n-2})(\cos{p_{n-1}} - p_{n-1})}{(\cos{p_{n-1}} - p_{n-1}) - (\cos{p_{n-2}} - p_{n-2})}, \quad \text{ for } n ≥ 2.$

These give the results in Table 2.5.
We note that although the formula for ``p_2`` seems to indicate a repeated computation, once ``f(p_0)`` and ``f(p_1)`` are computed, they are not computed again.
"""

# ╔═╡ d0edc777-d66f-4a1a-95c8-6644fefb94ea
md"""
**Remark.**
Comparing the results in Table 2.5 from the Secant method and Newton's method, we see that the Secant method approximation ``p_5`` is accurate to the 10th decimal place, whereas Newton's method obtained this accuracy by ``p_3``.
For this example, the convergence of the Secant method is much faster than functional iteration but slightly slower than Newton's method.
This is generally the case. (See Exercise 14 of Section 2.4.)
"""

# ╔═╡ 080e0c41-9e34-4674-a1fb-f1b42a7e3bb0
md"""
**Remark.**
Newton's method or the Secant method is often used to refine an answer obtained by another technique, such as the Bisection method, since these methods require good first approximations but generally give rapid convergence.
"""

# ╔═╡ 6002fca9-d606-4b7c-bf29-75642ef303ca
md"## 2.4 Error Analysis for Iterative Methods"

# ╔═╡ 2426fc36-c102-477d-b836-0f2c37b0d6d5
md"""
**Remark.**
In this section, we investigate the order of convergence of functional iteration schemes and, as a means of obtaining rapid convergence, rediscover Newton's method.
"""

# ╔═╡ 0ed97bc8-4956-4fb8-952d-72fdc097d666
md"### Order of Convergence"

# ╔═╡ d0bcd8e5-45b9-4625-b0ef-65d5a99e9d3b
md"""
**Definition 2.7**
Suppose ``\{p_n\}_{n=0}^∞`` is a sequence that converges to ``p``, with ``p_n ≠ p`` for all ``n``.
If positive constants ``λ`` and ``α`` exists with

$\lim_{n→∞} \frac{|p_{n+1} - p|}{|p_n - p|^α} = λ,$

then ``\{p_n\}_{n=0}^∞`` **converges to ``p`` of order ``α``, with asymptotic error constant ``λ``**.
"""

# ╔═╡ e522336b-6ebf-4c2e-8b1c-52af3e9500e9
md"""
**Remark.**
An iterative technique of the form ``p_n = g(p_{n-1})`` is said to be of *order* ``α`` if the sequence ``\{p_n\}_{n=0}^∞`` converges to the solution ``p = g(p)`` of order ``α``.
"""

# ╔═╡ 876a20bb-1e83-4b91-83c3-9ed7f33ae1cd
md"""
**Remark.**
In general, a sequence with a high order of convergence converges more rapidly than a sequence with a lower order.
The asymptotic constant affects the speed of convergence but not to the extent of the order.
Two cases of order are given special attention:

(i) If ``α = 1`` (and ``λ < 1``), the sequence is **linearly convergent**.

(ii) If ``α = 2``, the sequence is **quadratically convergent**.
"""

# ╔═╡ e2aac1d4-52ca-4372-85e5-b8e9fa561a14
md"""
**Theorem 2.8**
Let ``g ∈ C[a,b]`` be such that ``g(x) ∈ [a,b]``, for all ``x ∈ [a,b]``.
Suppose, in addition, that ``g'`` is continuous on ``(a,b)`` and that a positive constant ``k < 1`` exists with

$|g'(x)| ≤ k, \quad \text{ for all } x ∈ (a,b).$

If ``g'(p) ≠ 0``, then for any number ``p_0 ≠ p`` in ``[a,b]``, the sequence

$p_n = g(p_{n-1}), \quad\text{ for } n ≥ 1,$

converges only linearly to the unique fixed point ``p`` in ``[a,b]``.
"""

# ╔═╡ f6665670-acc5-4a35-b7d0-7376290567fe
md"""
**Theorem 2.9**
Let ``p`` be a solution of the equation ``x = g(x)``.
Suppose that ``g'(p) = 0`` and ``g''`` is continuous with ``|g''(x)| < M`` on an open interval ``I`` containing ``p``.
Then theree exists ``δ > 0`` such that, for ``p_0 ∈ [p - δ, p + δ]``, the sequence defined by ``p_n = g(p_{n-1})``, when ``n ≥ 1``, converges at least quadratically to ``p``.
Moreover, for sufficiently large values of ``n``,

$|p_{n+1} - p| < \frac{M}{2} |p_n - p|^2.$
"""

# ╔═╡ 848929da-481f-45db-8436-51bbc068816c
md"### Multiple Roots"

# ╔═╡ 046ace93-48b1-48f7-aee5-718ef4b254d0
md"""
**Definition 2.10**
A solution ``p`` of ``f(x) = 0`` is a **zero of multiplicity** ``m`` of ``f`` if for ``x ≠ p``, we can write ``f(x) = (x - p)^m q(x)``, where ``\lim_{x → p} q(x) ≠ 0``.
"""

# ╔═╡ 8ca736e0-ab65-4efc-a560-bf2dfcb3cc95
md"""
**Theorem 2.11**
The function ``f ∈ C^1[a,b]`` has a simple zero at ``p`` in ``(a,b)`` if and only if ``f(p) = 0`` and ``f'(p) ≠ 0``.
"""

# ╔═╡ e6262e17-39c7-4ad1-996d-524324f7e7e6
md"""
**Theorem 2.12**
The function ``f ∈ C^m [a,b]`` has a zero of multiplicity ``m`` at ``p`` in ``(a,b)`` if and only if

$0 = f(p) = f'(p) = f''(p) = ⋯ = f^{(m-1)}(p), \quad\text{ but }\quad f^{(m)}(p) ≠ 0.$
"""

# ╔═╡ d1c62d89-19ae-40da-92c0-c8a2793a1a39
md"## 2.5 Accelerating Convergence"

# ╔═╡ 67c21172-1a8e-43e9-a38e-57dc8ca4f064
md"""
**Remark.**
Theorem 2.8 indicates that it is rare to have the luxury of quadratic convergence.
We now consider a technique called **Aitken's Δ² method**, which can be used to accelerate the convergence of a sequence that is linearly convergent, regardless of its origin or application.
"""

# ╔═╡ 0b351e5c-7c7d-45b6-9156-806df3e776e6
md"### Aitken's Δ² Method"

# ╔═╡ 2f7bb65e-ebcb-4ed4-829c-129e9823f755
md"""
**Definition 2.13**
For a given sequence ``\{p_n\}_{n=0}^∞``, the **forward difference** ``\Delta p_n`` (read "delta ``p_n``") is defined by

$\Delta p_n = p_{n+1} - p_n, \quad\text{ for } n ≥ 0.$

Higher powers of the operator Δ are defined recursively by

$\Delta^k p_n = \Delta (\Delta^{k-1} p_n), \quad\text{ for } k ≥ 2.$
"""

# ╔═╡ 42c870f0-717b-496f-ac60-3f1958bab858
md"""
**Theorem 2.14**
Suppose that ``\{p_n\}_{n=0}^∞`` is a sequence that converges linearly to the limit ``p`` and that

$\lim_{n→∞} \frac{p_{n+1} - p}{p_n - p} < 1.$

Then the Aitken's Δ² sequence ``\{\hat{p}_n\}_{n=0}^∞`` converges to ``p`` faster than ``\{p_n\}_{n=0}^∞`` in the sense that

$\lim_{n→∞} \frac{\hat{p}_n - p}{p_n - p} = 0.$
"""

# ╔═╡ e09d141d-be9c-471d-bf7d-11558f91385f
md"### Steffensen's Method"

# ╔═╡ 2f54abf1-79f2-497d-aaee-667c04bbf3a1


# ╔═╡ 834f01cc-58b9-4982-b8bb-4a3484397bb8
md"## 2.6 Zeros of Polynomials and Müller's Method"

# ╔═╡ e43d72e0-101f-4c9b-a9f1-8418bc8bde9c
md"## 2.7 Numerical Software and Chapter Review"

# ╔═╡ 75ba971e-9f21-4e4e-8400-106ac8a7efb3
md"# 3 Interpolation and Polynomial Approximation"

# ╔═╡ 061c1400-2c90-4c66-99d4-5404063bc321
md"""
**Introduction.**
A census of the population of the United States is taken every 10 years.
The following table lists the population, in thousands of people, from 1960 to 2010, and the data are also represented in the figure.

| Year | Population (in thousands) |
|------|---------------------------|
| 1960 | 179,323 |
| 1970 | 203,302 |
| 1980 | 226,542 |
| 1990 | 249,633 |
| 2000 | 281,422 |
| 2010 | 308,746 |

In reviewing these data, we might ask whether they could be used to provide a reasonable estimate of the population, say, in 1975 or even in the year 2020.
Predictions of this type can be obtained by using a function that fits the given data.
This process is called *interpolation* and is the subject of this chapter.
This population problem is considered throughout the chapter and in Exercises 19 of Section 3.1, 17 of Section 3.3, and 24 of Section 3.5.
"""

# ╔═╡ 8e9547e1-e9d0-4209-83f7-74e0406adb8b
md"## 3.1 Interpolation and the Lagrange Polynomial"

# ╔═╡ 0cbfc117-3dbf-41db-8c3c-fb1f9fbcdbe9
md"""
**Remark.**
One of the most useful and well-known classes of functions mapping the set of real numbers into itself is the *algebraic polynomials*, the set of functions of the form

$P_n(x) = a_n x^n + a_{n-1} x^{n-1} + ⋯ + a_1 x + a_0,$

where ``n`` is a nonnegative integer and ``a_0, …, a_n`` are real constants.
One reason for their importance is that they uniformly approximate continuous functions.
By this we mean that given any function, defined and continuous on a closed and bounded interval, there exists a polynomial that is as "close" to the given function as desired.
This result is expressed precisely in the Weierstrass Approximation Theorem (See Figure 3.1.)
"""

# ╔═╡ 29b61ceb-0d39-4ecf-8b35-bc044214c39d
md"""
**Theorem 3.1 (Weierstrass Approximation Theorem)**
Suppose ``f`` is defined and continuous on ``[a,b]``.
For each ``ϵ > 0``, there exists a polynomial ``P(x)``, with the property that

$|f(x) - P(x)| < ϵ, \quad\text{for all } x \text{ in } [a,b].$
"""

# ╔═╡ cd259dfd-f06e-46f8-bb49-36a5866e14f8
md"""
**Remark.**
The proof of this theorem can be found in most elementary texts on real analysis (see, for example, [Bart], pp. 165-172).
"""

# ╔═╡ 011be372-a4c2-4f48-b074-92407ab8bb62
md"""
**Remark.**
Another important reason for considering the class of polynomials in the approximation of functions is that the derivative and indefinite integral of a polynomial are easy to determine and are also polynomials.
For these reasons, polynomials are often used for approximating continuous functions.
"""

# ╔═╡ c3940f20-17c2-4bc3-89b3-45fd52edf799
md"""
**Remark.**
The Taylor polynomials were introduced in Section 1.1, where they were described as one of the fundamental building blocks of numerical analysis.
Given this prominence, you might expect that polynomial approximation would make heavy use of these functions.
However, this is not the case.
The Taylor polynomials agree as closely as possible with a given function at a specific point, but they concentrate their accuracy near that point.
A good approximating polynomial needs to provide a relative accuracy over an entire interval, and Taylor polynomials do not generally do this.
For example, suppose we calculate the first six Taylor polynomials about ``x_0 = 0`` for ``f(x) = e^x``.
Since the derivatives of ``f(x)`` are all ``e^x``, which evaluated at ``x_0 = 0`` gives 1, the Taylor polynomials are

$P_0(x) = 1, \quad P_1(x) = 1 + x, \quad P_2(x) = 1 + x + \frac{x^2}{2}, \quad P_3(x) = 1 + x + \frac{x^2}{2} + \frac{x^3}{6},$

$P_4(x) = 1 + x + \frac{x^2}{2} + \frac{x^3}{6} + \frac{x^4}{24}, \quad\text{and}\quad P_5(x) = 1 + x + \frac{x^2}{2} + \frac{x^3}{6} + \frac{x^4}{24} + \frac{x^5}{120}.$
"""

# ╔═╡ eef8bfbb-180f-4d73-8bc5-47832735c153
md"""
**Remark.**
The graphs of the polynomials are shown in Figure 3.2.
(Notice that even for the higher-degree polynomials, the error becomes progressively worse as we move away from zero.)
"""

# ╔═╡ 23e127be-a0cb-4721-b9d6-15b28b7cd405
md"""
**Remark.**
Although better approximations are obtained for ``f(x) = e^x`` if higher-degree Taylor polynomials are used, this is not true for all functions.
Consider, as an extreme example, using Taylor polynomials of various degrees for ``f(x) = 1/x`` expanded about ``x_0 = 1`` to approximate ``f(3) = 1/3``.
Since

$f(x) = x^{-1}, \;f'(x) = -x^{-2}, \;f''(x) = (-1)^2 2 ⋅ x^{-3},$

and, in general,

$f^{(k)}(x) = (-1)^k k! x^{-k-1},$

the Taylor polynomials are

$P_n(x) = \sum_{k=0}^n \frac{f^{(k)}(1)}{k!} (x - 1)^k = \sum_{k=0}^n (-1)^k (x - 1)^k.$

To approximate ``f(3) = 1/3`` by ``P_n(3)`` for increasing values of ``n``, we obtain the values in Table 3.1--rather a dramatic failure!
When we approximate ``f(3) = 1/3`` by ``P_n(3)`` for larger values of ``n``, the approximations become increasingly inaccurate.
"""

# ╔═╡ 6deca4f3-632f-4b55-887f-836f430ac9e9
md"""
**Table 3.1**

| ``n`` | ``P_n(3)`` |
|-------|------------|
| 0 | 1 |
| 1 | -1 |
| 2 | 3 |
| 3 | -5 |
| 4 | 11 |
| 5 | -21 |
| 6 | 43 |
| 7 | -85 |
"""

# ╔═╡ ba08934f-41aa-4ec9-bfa9-c5eeb2a332a4
md"""
**Remark.**
For the Taylor polynomials, all the information used in the approximation is concentrated at the single number ``x_0``, so these polynomials will generally give inaccurate approximations as we move away from ``x_0``.
This limits Taylor polynomial approximation to the situation in which approximations are needed only at numbers close to ``x_0``.
For ordinary computational purposes, it is more efficient to use methods that include information at various points.
We consider this in the remainder of the chapter.
The primary use of Taylor polynomials in numerical analysis is not for approximation purposes but rather for the derivation of numerical techniques and error estimation.
"""

# ╔═╡ 33047f1b-47a7-4bd5-8e98-ea21be91f5a8
md"### Lagrange Interpolating Polynomials"

# ╔═╡ 0a173495-f416-40b8-886a-6a07357a74eb
md"""
**Remark.**
The problem of determining a polynomial of degree one that passes through the distinct points ``(x_0,y_0)`` and ``(x_1,y_1)`` is the same as approximating a function ``f`` for which ``f(x_0) = y_0`` and ``f(x_1) = y_1`` by means of a first-degree polynomial **interpolating**, or agreeing with, the values of ``f`` at the given points.
Using this polynomial for approximation within the interval given by the endpoints is called polynomial **interpolation**.
"""

# ╔═╡ dd157e39-2347-422a-b2cf-030b0dc8cb65
md"""
**Remark.**
Define the functions

$L_0(x) = \frac{x - x_1}{x_0 - x_1}\;\text{ and }\;L_1(x) = \frac{x - x_0}{x_1 - x_0}.$

The linear **Lagrange interpolating polynomial** through ``(x_0,y_0)`` and ``(x_1,y_1)`` is

$P(x) = L_0(x) f(x_0) + L_1(x) f(x_1) = \frac{x - x_1}{x_0 - x_1} f(x_0) + \frac{x - x_0}{x_1 - x_0} f(x_1).$

Note that

$L_0(x_0) = 1, \quad L_0(x_1) = 0, \quad L_1(x_0) = 0, \quad\text{and}\quad L_1(x_1) = 1,$

which implies that

$P(x_0) = 1 ⋅ f(x_0) + 0 ⋅ f(x_1) = f(x_0) = y_0$

and

$P(x_1) = 0 ⋅ f(x_0) + 1 ⋅ f(x_1) = f(x_1) = y_1.$

So, ``P`` is the unique polynomial of degree at most one that passes through ``(x_0, y_0)`` and ``(x_1, y_1)``.
"""

# ╔═╡ 58802c56-f618-455e-b85e-8832173e9b36
md"""
**Example 1**
Determine the linear Lagrange interpolating polynomial that passes through the points (2,4) and (5,1).

_**Solution**_
In this case, we have

$L_0(x) = \frac{x - 5}{2 - 5} = -\frac{1}{3}(x - 5) \;\text{ and }\; L_1(x) = \frac{x - 2}{5 - 2} = \frac{1}{3}(x - 2),$

so

$P(x) = -\frac{1}{3}(x - 5) ⋅ 4 + \frac{1}{3} (x - 2) ⋅ 1 = -\frac{4}{3} x + \frac{20}{3} + \frac{1}{3} x - \frac{2}{3} = -x + 6.$

The graph of ``y = P(x)`` is shown in Figure 3.3.
"""

# ╔═╡ 106ae98e-7ff8-44fb-8600-5baf618c21e8
md"""
**Remark.**
To generalize the concept of linear interpolation, consider the construction of a polynomial of degree at most ``n`` that passes through the ``n + 1`` points

$(x_0, f(x_0)), (x_1, f(x_1)), …, (x_n, f(x_n)).$

(See Figure 3.4.)
"""

# ╔═╡ c07ac7cf-8c96-463b-a264-1c9d264568d0
md"""
**Remark.**
In this case, we first consrtuct, for each ``k = 0, 1, …, n``, a function ``L_{n,k}(x)`` with the property that ``L_{n,k}(x_i) = 0`` when ``i ≠ k`` and ``L_{n,k}(x_k) = 1``.
To satisfy ``L_{n,k}(x_i) = 0`` for each ``i ≠ k`` requires that the numerator of ``L_{n,k}(x)`` contain the term

$(x - x_0)(x - x_1) ⋯ (x - x_{k-1})(x - x_{k+1}) ⋯ (x - x_n).$

To satisfy ``L_{n,k}(x_k) = 1``, the denominator of ``L_{n,k}(x)`` must be this same term but evaluated at ``x = x_k``.
Thus,

$L_{n,k}(x) = \frac{(x - x_0) ⋯ (x - x_{k-1})(x - x_{k+1}) ⋯ (x - x_n)}{(x_k - x_0) ⋯ (x_k - x_{k-1})(x_k - x_{k+1}) ⋯ (x_k - x_n)}.$

A sketch of the graph of a typical ``L_{n,k}`` (when ``n`` is even) is shown in Figure 3.5.
"""

# ╔═╡ 0c716cc7-aee8-456e-b2dd-e92ae14e807b
md"""
**Remark.**
The interpolating polynomial is easily described once the form of ``L_{n,k}`` is known.
This polynomial, called the **``n``th Lagrange interpolating polynomial**, is defined in the following theorem.
"""

# ╔═╡ 4163cb6c-c7e8-4d56-9d59-7026294b3279
md"""
**Theorem 3.2**
If ``x_0,x_1,…,x_n`` are ``n + 1`` distinct numbers and ``f`` is a function whose values are given at these numbers, then a unique polynomial ``P(x)`` of degree at most ``n`` exists with

$f(x_k) = P(x_k), \quad \text{for each } k = 0, 1, …, n.$

This polynomial is given by

$P(x) = f(x_0) L_{n,0}(x) + ⋯ + f(x_n) L_{n,n}(x) = \sum_{k = 0}^n f(x_k)L_{n,k}(x), \tag{3.1}$

where, for each ``k = 0, 1, …, n``,

$\begin{align*}
L_{n,k}(x) &= \frac{(x - x_0)(x - x_1) ⋯ (x - x_{k-1})(x - x_{k+1}) ⋯ (x - x_n)}{(x_k - x_0)(x_k - x_1) ⋯ (x_k - x_{k-1})(x_k - x_{k+1}) ⋯ (x_k - x_n)} \tag{3.2} \\
&= \prod_{\substack{i = 0 \\ i ≠ k}}^n \frac{(x - x_i)}{(x_k - x_i)}.
\end{align*}$
"""

# ╔═╡ 395f6d7f-5347-4d2b-a999-55e4f46f50a6
md"""
**Remark.**
We will write ``L_{n,k}(x)`` simply as ``L_k(x)`` when there is no confusion as to its degree.
"""

# ╔═╡ 422a8e1b-636c-4072-9b99-da06b46eca44
md"""
**Example 2**

**(a)** Use the numbers (called *nodes*) ``x_0 = 2``, ``x_1 = 2.75``, and ``x_2 = 4`` to find the second Lagrange intepolating polynomial for ``f(x) = 1/x``.

**(b)** Use this polynomial to approximate ``f(3) = 1/3``.

_**Solution**_
**(a)**
We first determine the coefficient polynomials ``L_0(x)``, ``L_1(x)``, and ``L_2(x)``.
In nested form, they are

$L_0(x) = \frac{(x - 2.75)(x - 4)}{(2 - 2.75)(2 - 4)} = \frac{2}{3} (x - 2.75)(x - 4).$

$L_1(x) = \frac{(x - 2)(x - 4)}{(2.75 - 2)(2.75 - 4)} = -\frac{16}{15} (x - 2)(x - 4),$

and

$L_2(x) = \frac{(x - 2)(x - 2.75)}{(4 - 2)(4 - 2.75)} = \frac{2}{5} (x - 2)(x - 2.75).$

Also, ``f(x_0) = f(2) = 1/2``, ``f(x_1) = f(2.75) = 4/11``, and ``f(x_2) = f(4) = 1/4``, so

$\begin{align*}
P(x) &= \sum_{k=0}^2 f(x_k) L_k(x) \\
&= \frac{1}{3} (x - 2.75)(x - 4) - \frac{64}{165} (x - 2)(x - 4) + \frac{1}{10} (x - 2)(x - 2.75) \\
&= \frac{1}{22} x^2 - \frac{35}{88} x + \frac{49}{44}.
\end{align*}$

**(b)**
An approximation to ``f(3) = 1/3`` (see Figure 3.6) is

$f(3) ≈ P(3) = \frac{9}{22} - \frac{105}{88} + \frac{49}{44} = \frac{29}{88} ≈ 0.32955.$

Recall that in the opening section of this chapter (see Table 3.1), we found that no polynomial expanded about ``x_0 = 1`` could be used to reasonably approximate ``f(x) = 1/x`` at ``x = 3``.
"""

# ╔═╡ d9b78f61-5f46-472b-a6a8-10d270131532
md"""
**Remark.**
The next step is to calculate a remained term or bound for the error involved in approximating a function by an interpolating polynomial.
"""

# ╔═╡ 56fbee44-aa54-4931-81f3-bc06aa7944dc
md"""
**Theorem 3.3**
Suppose ``x_0,x_1,…,x_n`` are distinct numbers in the interval ``[a,b]`` and ``f ∈ C^{n+1}[a,b]``.
Then, for each ``x`` in ``[a,b]``, a number ``ξ(x)`` (generally unknown) between ``\min\{x_0,x_1,…,x_n\}``, and the ``\max\{x_0,x_1,…,x_n\}`` and hence in ``(a,b)``, exists with

$f(x) = P(x) + \frac{f^{(n+1)} (ξ(x))}{(n + 1)!} (x - x_0) (x - x_1) ⋯ (x - x_n), \tag{3.3}$

where ``P(x)`` is the interpolating polynomial given in Eq. (3.1).
"""

# ╔═╡ 9a1011d3-13ef-4590-b580-f4951c8b451f
md"""
**Remark.**
The error formula in Theorem 3.3 is an important theoretical result because Lagrange polynomials are used extensively for deriving numerical differentiation and integration methods.
Error bounds for these techniques are obtained from the Lagrange error formula.
"""

# ╔═╡ e55cb028-dece-42a1-8cb5-b64c1b289808
md"""
**Remark.**
Note that the error form for the Lagrange polynomial is quite similar to that for the Taylor polynomial.
The ``n``th Taylor polynomial about ``x_0`` concentrates all the known information at ``x_0`` and has an error term of the form

$\frac{f^{(n+1)}(ξ(x))}{(n + 1)!}(x - x_0)^{n+1}.$

The Lagrange polynomial of degree ``n`` uses information at the distinct numbers ``x_0,x_1,…,x_n``, and, in place of ``(x - x_0)^n``, its error formula uses a product of the ``n + 1`` terms ``(x - x_0), (x - x_1), …, (x - x_n)``:

$\frac{f^{(n+1)}(ξ(x))}{(n + 1)!} (x - x_0)(x - x_1) ⋯ (x - x_n).$
"""

# ╔═╡ 25dc0c95-c5cb-497c-8b7e-83c739fbb252
md"""
**Example 3**
In Example 2, we found the second Lagrange polynomial for ``f(x) = 1/x`` on ``[2,4]`` using the nodes ``x_0 = 2``, ``x_1 = 2.75``, and ``x_2 = 4``.
Determine the error form for this polynomial and the maximum error when the polynomial is used to approximate ``f(x)`` for ``x ∈ [2,4]``.

_**Solution**_
Because ``f(x) = x^{-1}``, we have

$f'(x) = -x^{-2}, \quad f''(x) = 2x^{-3}, \;\text{ and }\; f'''(x) = -6x^{-4}.$

As a consequence, the second Lagrange polynomial has the error form

$\frac{f'''(ξ(x))}{3!}(x - x_0)(x - x_1)(x - x_2) = -(ξ(x))^{-4}(x - 2)(x - 2.75)(x - 4), \;\text{for } ξ(x) \text{ in } (2,4).$

The maximum value of ``(ξ(x))^{-4}`` on the interval is ``2^{-4} = 1/16``.
We now need to determine the maximum value on this interval of the absolute value of the polynomial

$g(x) = (x - 2)(x - 2.75)(x - 4) = x^3 - \frac{35}{4} x^2 + \frac{49}{2} x - 22.$

Because

$D_x \left(x^3 - \frac{35}{4} x^2 + \frac{49}{2} x - 22\right) = 3x^2 - \frac{35}{2} x + \frac{49}{2} = \frac{1}{2} (3x - 7)(2x - 7),$

the critical points occur at

$x = \frac{7}{3}, \text{ with } g\left(\frac{7}{3}\right) = \frac{25}{108}, \quad\text{ and }\quad x = \frac{7}{2}, \text{ with } g\left(\frac{7}{2}\right) = -\frac{9}{16}.$

Hence, the maximum error is

$\frac{f'''(ξ(x))}{3!} |(x - x_0)(x - x_1)(x - x_2)| ≤ \frac{1}{16} \left|-\frac{9}{16}\right| = \frac{9}{256} ≈ 0.03515625.$
"""

# ╔═╡ d8e398df-d15c-4674-a23a-b49f6b7740fa
md"## 3.2 Data Approximation and Neville's Method"

# ╔═╡ bf3f094e-187a-4d8c-95e3-ed7f2467105c
md"""
**Remark.**
In the previous section, we found an explicit representation for Lagrange polynomials and their error when approximating a function on an interval.
A frequent use of these polynomials involves the interpolation of tabulated data.
In this case, an explicit representation of the polynomial might not be needed, only the values of the polynomial at specified points.
In this situation, the function underlying the data might not be known, so the explicit form of the error cannot be used.
We will now illustrate a practical application of interpolation in such a situation.
"""

# ╔═╡ de87cedb-aac5-404a-999f-ce9ae813012b
md"### Neville's Method"

# ╔═╡ a188c78b-3cfa-4b1f-b5ef-2ffbe02b84fe
md"""
**Definition 3.4**
Let ``f`` be a function defined at ``x_0,x_1,x_2,…,x_n`` and suppose that ``m_1,m_2,…,m_k`` are ``k`` distinct integers, with ``0≤m_i≤n`` for each ``i``.
The Lagrange polynomial that agrees with ``f(x)`` at the ``k`` points ``x_{m_1},x_{m_2},…,x_{m_k}`` is denoted ``P_{m_1,m_2,…,m_k}(x)``.
"""

# ╔═╡ e49a5b52-bc6a-482f-9889-d38b4d275a3b
md"""
**Theorem 3.5**
Let ``f`` be defined at ``x_0,x_1,…,x_k`` and let ``x_j`` and ``x_i`` be two distinct numbers in this set.
Then

$P(x) = \frac{(x - x_j)P_{0,1,…,j-1,j+1,…k}(x) - (x - x_i) P_{0,1,…,i-1,i+1,…,k}(x)}{(x_i - x_j)}$

is the ``k``th Lagrange polynomial that interpolates ``f`` at the ``k + 1`` points ``x_0,x_1,…,x_k``.
"""

# ╔═╡ 476c325d-75d8-493e-bd14-e1545fbff3b7
md"## 3.3 Divided Differences"

# ╔═╡ b9aa4dce-4914-4077-8f73-708984880067
md"""
**Remark.**
Iterated interpolating was used in the previous section to generate successively higher-degree polynomial approximations at a specific point.
Divided-difference methods introduced in this section are used to sucessively generate the polynomials themselves.
"""

# ╔═╡ 36d46835-d901-4df9-b2e5-af25f7a9f966
md"### Forward Differences"

# ╔═╡ e59f352d-399c-435f-8662-ea85f15119a6
md"""
**Newton Forward-Difference Formula**

$P_n(x) = f(x_0) + \sum_{k=1}^n \begin{pmatrix} s \\ k \end{pmatrix} \Delta^k f(x_0) \tag{3.12}$
"""

# ╔═╡ f9a812db-284f-4841-a467-f6138562caa5
md"### Backward Differences"

# ╔═╡ c002148a-415b-43ad-bbe9-df88b9c2047e
md"""
**Definition 3.7**
Given the sequence ``\{p_n\}_{n=0}^∞``, define the backward-difference ``∇p_n`` (read *nabla* ``p_n``) by

$∇p_n = p_n - p_{n-1}, \quad\text{for } n ≥ 1.$

Higher powers are defined recursively by

$∇^k p_n = ∇(∇^{k-1} p_n), \quad\text{for } k ≥ 2.$
"""

# ╔═╡ a39b9e74-9400-42ef-aff4-b520967a244d
md"""
**Newton Backward-Difference Formula**

$P_n(x) = f[x_n] + \sum_{k=1}^n (-1)^k \begin{pmatrix} -s \\ k \end{pmatrix} ∇^k f(x_n) \tag{3.13}$
"""

# ╔═╡ 7d5096cb-d595-4b50-9fb4-2fc3cab87eb0
md"### Centered Differences"

# ╔═╡ 263f0f23-f2c3-46c7-a61b-734f7933e480
md"""
**Remark.**
The Newton forward- and backward-difference formulas are not appropriate for approximatin ``f(x)`` when ``x`` lies near the center of the table because neither will permite the highest-order difference to have ``x_0`` close to ``x``.
A number of divided-difference formulas are available for this case, each of which has the situations when it can be used to maximum advantage.
These methods are known as **centered-difference formulas**.
We will consider only one centered-difference formula, Stirling's method.
"""

# ╔═╡ 622f5a33-7a6f-4934-a686-108e8af6b5f6
md"## 3.4 Hermite Interpolation"

# ╔═╡ 2dcdbbba-bd25-4633-9898-e24e519d1f95
md"""
**Remark.**
*Osculating polynomials* generalize both the Taylor polynomials and the Lagrange polynomials.
Suppose that we are given ``n + 1`` distinct numbers ``x_0,x_1,…,x_n`` in ``[a,b]`` and nonnegative integers ``m_0,m_1,…,m_n``, and ``m = \max\{m_0,m_1,…,m_n\}``.
The osculating polynomial approximating a function ``f ∈ C^m[a,b]`` at ``x_i``, for each ``i = 0,…,n``, is the polynomial of least degree that has the same values as the function ``f`` and all its derivatives of order less than or equal to ``m_1`` at each ``x_i``.
The degree of this osculating polynomial is at most

$M = \sum_{i=0}^n m_i + n$

because the number of conditions to be satisfied is ``\sum_{i=0}^n m_i + (n + 1)``, and a polynomial of degree ``M`` has ``M + 1`` coefficients that can be used to satisfy these conditions.
"""

# ╔═╡ 2dc1ca0d-ef77-4e5e-8f27-d52b9bd625ba
md"""
**Definition 3.8**
Let ``x_0,x_1,…,x_n`` be ``n + 1`` distinct numbers in ``[a,b]``, and for ``i=0,1,…,n``, let ``m_i`` be a nonnegative integer.
Suppose that ``f ∈ C^m[a,b]``, where ``m = \max_{0≤i≤n} m_i``.

The **osculating polynomial** approximating ``f`` is the polynomial ``P(x)`` of least degree such that

$\frac{d^k P(x_i)}{dx^k} = \frac{d^k f(x_i)}{dx^k}, \quad\text{for each } i = 0,1,…,n \quad\text{and}\quad k = 0,1,…,m_i.$
"""

# ╔═╡ 841b74c3-acb3-4661-9656-6394e61a3976
md"""
**Remark.**
Note that when ``n = 0``, the osculating polynomial approximating ``f`` is the ``m_0``th Taylor polynomials for ``f`` at ``x_0``.
When ``m_i = 0`` for each ``i``, the osculating polynomial is the ``n``th Lagrange polynomial interpolating ``f`` on ``x_0,x_1,…,x_n``.
"""

# ╔═╡ c3b766fb-a87e-4868-887b-3008dc046459
md"### Hermite Polynomials"

# ╔═╡ 566f92b5-3a39-4fbd-8990-1778cc328037
md"""
**Remark.**
The case when ``m_i = 1``, for each ``i = 0,1,…,n``, gives the **Hermite polynomials**.
For a given function ``f``, these polynomials agree with ``f`` at ``x_0,x_1,…,x_n``.
In addition, since their first derivatives agree with those of ``f``, they have the same "shape" as the function at ``(x_i,f(x_i))`` in the sense that the *tangent lines* to the polynomial and the function agree.
We will restrict our study of osculating polynomials to this situation and consider first a theorem that describes precisely the form of the Hermite polynomials.
"""

# ╔═╡ 26ad0783-4f25-4330-8413-5d0b948ebc82
md"""
**Theorem 3.9**
If ``f ∈ C^1[a,b]`` and ``x_0,…,x_n ∈ [a,b]`` are distinct, the unique polynomial of least degree agreeing with ``f`` and ``f'`` at ``x_0,…,x_n`` is the Hermite polynomial of degree at most ``2n + 1`` given by

$H_{2n+1}(x) = \sum_{j=0}^n f(x_j) H_{n,j}(x) + \sum_{j=0}^n f'(x_j) \hat{H}_{n,j}(x).$

where, for ``L_{n,j}(x)`` denoting the ``j``th Lagrange coefficient polynomial of degree ``n``, we have

$H_{n,j}(x) = [1 - 2(x - x_j)L_{n,j}'(x_j)] L_{n,j}^2(x) \;\text{ and }\; \hat{H}_{n,j}(x) = (x - x_j) L_{n,j}^2(x).$

Moreover, if ``f ∈ C^{2n+2}[a,b]``, then

$f(x) = H_{2n+1}(x) + \frac{(x - x_0)^2 … (x - x_n)^2}{(2n + 2)!} f^{(2n + 2)} (ξ(x)),$

for some (generally unknown) ``ξ(x)`` in the interval ``(a,b)``.
"""

# ╔═╡ 19b20ee2-03ef-41ba-9843-6a81a55f8bce
md"""
**Remark.**
Although Theorem 3.9 provides a complete description of the Hermite polynomials, it is clear from Example 1 that the need to determine and evaluate the Lagrange polynomials and their derivatives makes the procedure tedious even for small values of ``n``.
"""

# ╔═╡ 7bd15f66-cbe3-4371-9889-f82b08797aaf
md"""
**Table 3.15**

| ``k`` | ``x_k`` | ``f(x_k)`` | ``f'(x_k)`` |
|-------|---------|------------|-------------|
| 0 | 1.3 | 0.6200860 | -0.5220232 |
| 1 | 1.6 | 0.4554022 | -0.5698959 |
| 2 | 1.9 | 0.2818186 | -0.5811571 |
"""

# ╔═╡ e68c8404-5599-4eb0-87e5-c8e7daf6cff8
md"""
**Example 1**
Use the Hermite polynomial that agrees with the data listed in Table 3.15 to find an approximation of ``f(1.5)``.

_**Solution**_
We first compute the Lagrange polynomials and their derivatives.
This gives

$\begin{align*}
L_{2,0}(x) &= \frac{(x - x_1)(x - x_2)}{(x_0 - x_1)(x_0 - x_2)} = \frac{50}{9} x^2 - \frac{175}{9} x + \frac{152}{9}, & L_{2,0}'(x) &= \frac{100}{9} x - \frac{175}{9}; \\
L_{2,1}(x) &= \frac{(x - x_0)(x - x_2)}{(x_1 - x_0)(x_1 - x_2)} = \frac{-100}{9} x^2 + \frac{320}{9} x - \frac{247}{9}, & L_{2,1}'(x) &= \frac{-200}{9} x + \frac{320}{9}; \\
\end{align*}$

and

$\begin{align*}
L_{2,2}(x) &= \frac{(x - x_0)(x - x_1)}{(x_2 - x_0)(x_2 - x_1)} = \frac{50}{9} x^2 - \frac{145}{9} x + \frac{104}{9}, & L_{2,2}'(x) = \frac{100}{9} x - \frac{145}{9}.
\end{align*}$

The polynomials ``H_{2,j}(x)`` and ``\hat{H}_{2,j}(x)`` are then

$\begin{align*}
H_{2,0}(x) &= [1 - 2(x - 1.3)(-5)] \left(\frac{50}{9} x^2 - \frac{175}{9} x + \frac{152}{9}\right)^2 \\
&= (10x - 12) \left(\frac{50}{9} x^2 - \frac{175}{9} x + \frac{152}{9}\right)^2, \\
H_{2,1}(x) &= 1 ⋅ \left(\frac{-100}{9}x^2 + \frac{320}{9}x - \frac{247}{9}\right)^2, \\
H_{2,2}(x) &= 10(2 - x) \left(\frac{50}{9}x^2 - \frac{145}{9}x + \frac{104}{9}\right)^2, \\
\hat{H}_{2,0} &= (x - 1.3) \left(\frac{50}{9}x^2 - \frac{175}{9}x + \frac{152}{9}\right)^2, \\
\hat{H}_{2,1} &= (x - 1.6) \left(\frac{-100}{9}x^2 + \frac{320}{9}x - \frac{247}{9}\right)^2,
\end{align*}$

and

$\hat{H}_{2,2} = (x - 1.9) \left(\frac{50}{9}x^2 - \frac{145}{9}x + \frac{104}{9}\right)^2.$
"""

# ╔═╡ fa765be9-8d71-4ec1-8589-12015c6f741c
md"### Hermite Polynomials Using Divided Differences"

# ╔═╡ bf278e70-8d48-4ada-92f8-8e850e8ab9b5
md"""
**Remark.**
There is an alternative method for generating Hermite approximations that has as its basis the Newton interpolatory divided-difference formula (3.10) at ``x_0,x_1,…,x_n``; that is,

$P_n(x) = f[x_0] + \sum_{k=1}^n f[x_0,x_1,…,x_k] (x - x_0) ⋯ (x - x_{k-1}).$

The alternative method uses the connection between the ``n``th divided difference and the ``n``th derivative of ``f``, as outlined in Theorem 3.6 in Section 3.3.
"""

# ╔═╡ e410f6ec-3456-4c9b-a975-e9aebab75bcb
md"""
**Remark.**
Suppose that the distinct numbers ``x_0,x_1,…,x_n`` are given together with the values of ``f`` and ``f'`` at these numbers.
Define a new sequence ``z_0,z_1,…,z_{2n+1}`` by

$z_{2i} = z_{2i+1} = x_i, \quad\text{for each } i = 0, 1, …, n,$

and construct the divided difference table in the form of Table 3.9 that uses ``z_0,z_1,…,z_{2n+1}``.
"""

# ╔═╡ 010a00b1-7923-4b0b-aff8-b58f89d081c7
md"""
**Remark.**
Since ``z_{2i} = z_{2i+1} = x_i`` for each ``i``, we cannot define ``f[z_{2i},z_{2i+1}]`` by the divided-difference formula.
However, if we assume, based on Theorem 3.6, that the reasonable substitution in this situation is ``f[z_{2i},z_{2i+1}] = f'(z_{2i}) = f'(x_i)``, we can use the entries

$f'(x_0),f'(x_1),…,f'(x_n)$

in place of the undefined first divided differences

$f[z_0,z_1],f[z_2,z_3],…,f[z_{2n},z_{2n+1}].$

The remaining divided differences are produced as usual, and the appropriate divided differences are employed in Newton's interpolatory divided-difference formula.
Table 3.16 shows the entries that are used for the first three divided-difference columns when determining the Hermite polynomial ``H_5(x)`` for ``x_0``,``x_1``, and ``x_2``.
The remaining entries are generated in the same manner as in Table 3.9.
The Hermite polynomial is then given by

$H_{2n+1}(x) = f[z_0] + \sum_{k=1}^{2n+1} f[z_0,…,z_k](x - z_0)(x - z_1) ⋯ (x-z_{k-1}).$

A proof of this fact can be found in [Pow], p.56.
"""

# ╔═╡ 8ca6d5d1-bb3e-4595-b862-d8e1fc297f35
md"## 3.5 Cubic Spline Interpolation"

# ╔═╡ 13b57180-ebab-444b-94a0-e3550386a3d8
md"""
**Remark.**
The previous sections concerned the approximation of arbitrary functions on closed intervals using a single polynomial.
However, high-degree polynomials can oscillate erratically; that is, a minor fluctuation over a small portion of the interval can induce large fluctations over the entire range.
We will see a good example of this in Figure 3.14 at the end of this section.
"""

# ╔═╡ e82e185c-d29d-48ae-a57e-d7130f3a3fb7
md"""
**Remark.**
An alternative approach is to divide the approximation interval into a collection of subintervals and construct a (generally) different approximating polynomial on each subinterval.
This is called **piecewise-polynomial approximation**.
"""

# ╔═╡ e8d30c02-ce7b-4cd2-be37-9c43b4528a14
md"### Piecewise-Polynomial Approximation"

# ╔═╡ 462d63b2-288a-43fb-ac2c-e0c4d5912bd1
md"""
**Remark.**
The simplest piecewise-polynomial approximation is **piecewise-linear** interpolation, which consists of joining a set of data points

$\{(x_0, f(x_0)), (x_1, f(x_1)), …, (x_n, f(x_n))\}$

by a series of straight lines, as shown in Figure 3.7.
"""

# ╔═╡ 5b34aa84-b257-483d-8ccc-11e91c0d5b70
md"""
**Remark.**
A disadvantage of linear function approximation is that there is likely no differentiability at the endpoints of the subintervals, which, in a geometrical context, means that the interpolating function is not "smooth."
Often it is clear from physical conditions that smoothness is required, so the approximating function must be continuously differentiable.
"""

# ╔═╡ 5842a6f3-600c-494a-b9b7-8c2ddb9baa98
md"""
**Remark.**
An alternative procedure is to use a piecewise polynomial of Hermite type.
For example, if the values of ``f`` and of ``f'`` are known at each of the points ``x_0 < x_1 < ⋯ < x_n``, a cubic Hermite polynomial can be used on each of the subintervals ``[x_0,x_1], [x_1,x_2],…,[x_{n-1},x_n]`` to obtain a function that has a continuous derivative on the interval ``[x_0,x_n]``.
"""

# ╔═╡ 67c473e0-4b34-4180-b1d9-eb82591e2419
md"### Cubic Splines"

# ╔═╡ 011e14e7-3dd8-4a6c-af03-11c93d02a8b5
md"""
**Remark.**
The most common piecewise-polynomial approximation uses cubic polynomials between each successive pair of nodes and is called **cubic spline interpolation**.
A general cubic spline polynomial involves four constants, so there is sufficient flexibility in the cubic spline procedure to ensure that the interpolant not only is continuously differentiable on the interval but also has a continuous second derivative.
The construction of the cubic spline does not, however, assume that the derivatives of the interpolant agree with those of the function it is approximating, even at the nodes. (See Figure 3.8.)
"""

# ╔═╡ 03899dd7-0f65-488d-a36c-f00a7489e186
md"""
**Definition 3.10**
Given a function ``f`` defined on ``[a,b]`` and a set of nodes ``a = x_0 < x_1 < ⋯ < x_n = b``, a **cubic spline interpolant** ``S`` for ``f`` is a function that satisfies the following conditions:

- **(a)** ``S(x)`` is a cubic polynomial, denoted ``S_j(x)``, on the subinterval ``[x_j, x_{j+1}]`` for each ``j = 0, 1, …, n - 1``;

- **(b)** ``S_j(x_j) = f(x_j)`` and ``S_j(x_{j+1}) = f(x_{j+1})`` for each ``j = 0, 1, …, n - 1``;

- **(c)** ``S_{j+1}(x_{j+1}) = S_j(x_{j+1})`` for each ``j = 0, 1, …, n - 2``; *(Implied by **(b)**.)*

- **(d)** ``S_{j+1}'(x_{j+1}) = S_j'(x_{j+1})`` for each ``j = 0, 1, …, n - 2``;

- **(e)** ``S_{j+1}''(x_{j+1}) = S_j''(x_{j+1})`` for each ``j = 0, 1, …, n - 2``;

- **(f)** One of the following sets of boundary conditions is satisfied:

  - **(i)** ``S''(x_0) = S''(x_n) = 0`` **(natural (or free) boundary)**;

  - **(ii)** ``S'(x_0) = f'(x_0)`` and ``S'(x_n) = f'(x_n)`` **(clamped boundary)**.
"""

# ╔═╡ 51431ec8-3ec6-4f7c-a3bb-563d90d9201b
md"### Construction of a Cubic Spline"

# ╔═╡ 95f946d7-6df1-4f21-bbb0-12af41c734cf
md"### Natural Splines"

# ╔═╡ fc2aacf4-a7f8-4703-b663-6effff4205e1
md"""
**Theorem 3.11**
If ``f`` is defined at ``a = x_0 < x_1 < ⋯ < x_n = b``, then ``f`` has a unique natural spline interpolant ``S`` on the nodes ``x_0, x_1, …, x_n``; that is, a spline interpolant that satisfies the natural boundary conditions ``S''(a) = 0`` and ``S''(b) = 0``.
"""

# ╔═╡ 50c1fc3b-3003-4b2f-8812-9226163a4448
md"## 3.6 Parametric Curves"

# ╔═╡ cb2f2af2-f365-4565-ba6d-e5b4b28e2151
md"## 3.7 Numerical Software and Chapter Review"

# ╔═╡ a32f7967-8416-4155-9532-4acdac059186
md"# 4 Numerical Differentiation and Integration"

# ╔═╡ 6c478232-67f6-4630-ad81-f2887e9c1ddc
md"""
**Remark.**
A sheet of corrugated roofing is constructed by pressing a flat sheet of aluminum into one whose cross section has the form of a sine wave.
"""

# ╔═╡ 98f67a0a-67d2-49a9-8ca1-9bf95926fc2f
md"## 4.1 Numerical Differentiation"

# ╔═╡ 73dbdfd7-4d98-49a7-9fa4-670819a4efd5
md"""
**Remark.**
The derivative of the function ``f`` at ``x_0`` is

$f'(x_0) = \lim_{h→0} \frac{f(x_0 + h) - f(x_0)}{h}.$

This formula gives an obvious way to generate an approximation to ``f'(x_0)``; simply compute

$\frac{f(x_0 + h) - f(x_0)}{h}$

for small values of ``h``.
Although this may be obvious, it is not very successful due to our old nemesis round-off error.
But it is certainly a place to start.
"""

# ╔═╡ 24837a6e-ff42-473b-a9fb-f8213dcafc90
md"""
**Remark.**
To approximate ``f'(x_0)``, suppose first that ``x_0 ∈ (a,b)``, where ``f ∈ C^2[a,b]``, and that ``x_1 = x_0 + h`` for some ``h ≠ 0`` that is sufficiently small to ensure that ``x_1 ∈ [a,b]``.
We construct the first Lagrange polynomial ``P_{0,1}(x)`` for ``f`` determined by ``x_0`` and ``x_1``, with its error term:

$\begin{align*}
f(x) &= P_{0,1}(x) + \frac{(x-x_0)(x-x_1)}{2!} f''(ξ(x)) \\
&= \frac{f(x_0)(x - x_0 - h)}{-h} + \frac{f(x_0 + h)(x - x_0)}{h} + \frac{(x - x_0)(x - x_0 - h)}{2} f''(ξ(x)),
\end{align*}$

for some ``ξ(x)`` between ``x_0`` and ``x_1``.
Differentiating gives

$\begin{align*}
f'(x) &= \frac{f(x_0+h) - f(x_0)}{h} + D_x \left[\frac{(x-x_0)(x-x_0-h)}{2} f''(ξ(x))\right] \\
&= \frac{f(x_0+h) - f(x_0)}{h} + \frac{2(x-x_0)-h}{2} f''(ξ(x)) \\
&\quad + \frac{(x-x_0)(x-x_0-h)}{2} D_x (f''(ξ(x))).
\end{align*}$

Deleting the terms involving ``ξ(x)`` gives

$f'(x) ≈ \frac{f(x_0+h) - f(x_0)}{h}.$

One difficulty with this formula is that we have no information about ``D_x f''(ξ(x))``, so the truncation error cannot be estimated.
When ``x`` is ``x_0``, however, the coefficient of ``D_x f''(ξ(x))`` is ``0``, and the formula simplifies to

$f'(x_0) = \frac{f(x_0 + h) - f(x_0)}{h} - \frac{h}{2} f''(ξ). \tag{4.1}$
"""

# ╔═╡ 43289993-e3c6-4fce-bfad-d1e237e63775
md"""
**Remark.**
For small values of ``h``, the difference quotient ``[f(x_0 + h) - f(x_0)] / h`` can be used to approximate ``f'(x_0)`` with an error bounded by ``M|h|/2``, where ``M`` is a bound on ``|f''(x)|`` for ``x`` between ``x_0`` and ``x_0 + h``.
This formula is known as the **forward-difference formula** if ``h > 0`` (see Figure 4.1) and the **backward-difference formula** if ``h < 0``.
"""

# ╔═╡ ab3e1864-93b2-41f0-a2ba-8e89035c6a91
md"""
**Example 1**
Use the forward-difference formula to approximate the derivative of ``f(x) = \ln{x}`` at ``x_0 = 1.8`` using ``h = 0.1``, ``h = 0.05``, and ``h = 0.01`` and determine bounds for the approximation errors.

_**Solution**_
The forward-difference formula

$\frac{f(1.8 + h) - f(1.8)}{h}$

which ``h = 0.1`` gives

$\frac{\ln{1.9} - \ln{1.8}}{0.1} = \frac{0.6418539 - 0.58778667}{0.1} = 0.5406722.$

Because ``f''(x) = -1/x^2`` and ``1.8 < ξ < 1.9``, a bound for this approximation error is

$\frac{|h''(ξ)|}{2} = \frac{|h|}{2ξ^2} < \frac{0.1}{2(1.8)^2} = 0.0154321.$

The approximation and error bounds when ``h = 0.05`` and ``h = 0.01`` are found in a similar manner, and the results are shown in Table 4.1.

**Table 4.1**

| ``h`` | ``f(1.8 + h)`` | ``\frac{f(1.8 + h) - f(1.8)}{h}`` | ``\frac{\|h\|}{2(1.8)^2}`` |
|---------|--------|--------|--------|
| 0.1 | 0.64185389 | 0.5406722 | 0.0154321 |
| 0.05 | 0.61518564 | 0.5479795 | 0.0077160 |
| 0.01 | 0.59332685 | 0.5540180 | 0.0015432 |

Since ``f'(x) = 1/x``, the exact value of ``f'(1.8)`` is ``0.55\bar{5}``, and in this case the error bounds are quite close to the true approximation error.
"""

# ╔═╡ 73447e6f-3811-4b16-8169-edf6ff29de01
md"""
**Remark.**
To obtain general derivative approximation formulas, suppose that ``\{x_0,x_1,…,x_n\}`` are ``(n+1)`` distinct numbers in some interval ``I`` and that ``f ∈ C^{n+1}(I)``.
From Theorem 3.3 on page 109,

$f(x) = \sum_{k=0}^n f(x_k) L_k(x) + \frac{(x-x_0) ⋯ (x-x_n)}{(n+1)!} f^{(n+1)}(ξ(x)),$

for some ``ξ(x)`` in ``I``, where ``L_k(x)`` denotes the ``k``th Lagrange coefficient polynomial for ``f`` at ``x_0,x_1,…,x_n``.
Differentiating this expression gives

$\begin{align*}
f'(x) &= \sum_{k=0}^n f(x_k) L_k'(x) + D_x \left[\frac{(x-x_0)⋯(x-x_n)}{(n + 1)!}\right] f^{(n+1)}(ξ(x)) \\
&\quad {}+ \frac{(x - x_0)⋯(x - x_n)}{(n + 1)!} D_x \left[f^{(n+1)}(ξ(x))\right].
\end{align*}$
"""

# ╔═╡ 5c9a27f6-c77f-4a59-99f1-22b1bee36435
md"""
**Remark.**
We again have a problem estimating the truncation error unless ``x`` is one of the numbers ``x_j``.
In this case, the term multiplying ``D_x[f^{(n+1)}(ξ(x))]`` is ``0``, and the formula becomes

$f'(x_j) = \sum_{k=0}^n f(x_k) L_k'(x_j) + \frac{f^{(n+1)}(ξ(x_j))}{(n+1)!} \prod_{\substack{k=0\\k≠j}}^n (x_j - x_k), \tag{4.2}$

which is called an **``(n + 1)``-point formula** to approximate ``f'(x_j)``.
"""

# ╔═╡ d0ccb09f-1452-4598-9ddc-d49fdef4f42e
md"""
**Remark.**
In general, using more evaluation points in Eq. (4.2) produces greater accuracy, although the number of functional evaluations and growth of round-off error discourages this somewhat.
The most common formulas are those involving three and five evaluation points.
"""

# ╔═╡ 308fe786-38eb-4dc6-8e2b-c0ff3467f7b0
md"""
**Remark.**
We first derive some useful three-point formulas and consider aspects of their errors.
Because

$L_0(x) = \frac{(x-x_1)(x-x_2)}{(x_0-x_1)(x_0-x_2)}, \quad\text{we have}\quad L_0'(x) = \frac{2x - x_1 - x_2}{(x_0 - x_1)(x_0 - x_2)}.$

Similarly,

$L_1'(x) = \frac{2x-x_0-x_2}{(x_1-x_0)(x_1-x_2)} \quad\text{and}\quad L_2'(x) = \frac{2x-x_0-x_1}{(x_2-x_0)(x_2-x_1)}.$

Hence, from Eq. (4.2),

$\begin{align*}
f'(x_j) &= f(x_0) \left[\frac{2x_j - x_1 - x_2}{(x_0 - x_1)(x_0 - x_2)}\right] + f(x_1) \left[\frac{2x_j - x_0 - x_2}{(x_1-x_0)(x_1-x_2)}\right] \\
&\quad {}+f(x_2) \left[\frac{2x_j - x_0 - x_1}{(x_2-x_0)(x_2-x_1)}\right] + \frac{1}{6} f^{(3)}(ξ_j) \prod_{\substack{k=0\\k≠j}}^2 (x_j - x_k), \tag{4.3}
\end{align*}$

for each ``j=0,1,2``, where the notation ``ξ_j`` indicates that this point depends on ``x_j``.
"""

# ╔═╡ 24cf7831-07ec-4f53-a470-552fa89dd1b1
md"### Three-Point Formulas"

# ╔═╡ 835f1922-3505-42a2-88ef-42fbb5fa2915
md"""
**Remark.**
The formulas from Eq. (4.3) become especially useful if the nodes are equally spaced, that is, when

$x_1 = x_0 + h \quad\text{and}\quad x_2 = x_0 + 2h, \quad\text{for some } h ≠ 0.$

We will assume equally spaced nodes throughout the remained of this section.
"""

# ╔═╡ f0beaeb7-aefb-4cc4-b6cf-0f363a365693
md"""
**Remark.**
Using Eq. (4.3) with ``x_j = x_0``, ``x_1 = x_0 + h``, and ``x_2 = x_0 + 2h`` gives

$f'(x_0) = \frac{1}{h} \left[-\frac{3}{2} f(x_0) + 2f(x_1) - \frac{1}{2} f(x_2)\right] + \frac{h^2}{3} f^{(3)}(ξ_0).$

Doing the same for ``x_j = x_1`` gives

$f'(x_1) = \frac{1}{h} \left[-\frac{1}{2} f(x_0) + \frac{1}{2} f(x_2)\right] - \frac{h^2}{6} f^{(3)}(ξ_1)$

and, for ``x_j = x_2``,
"""

# ╔═╡ 83154f35-624f-417e-bc01-4074116aca47
md"### Three-Point Endpoint Formula"

# ╔═╡ f36e3b10-c87b-4b75-a4ff-eba55d69c611
md"""
**Remark.**

$f'(x_0) = \frac{1}{2h} [-3f(x_0) + 4f(x_0 + h) - f(x_0 + 2h)] + \frac{h^2}{3} f^{(3)}(ξ_0), \tag{4.4}$

where ``ξ_0`` lies between ``x_0`` and ``x_0 + 2h``.
"""

# ╔═╡ 3581420f-2c3f-40f6-99c5-90bcd594b1eb
md"### Three-Point Midpoint Formula"

# ╔═╡ ce9d3b47-fa76-4ed5-b284-6fbab811d3c4
md"""
**Remark.**

$f'(x_0) = \frac{1}{2h} [f(x_0 + h) - f(x_0 - h)] - \frac{h^2}{6} f^{(3)}(ξ_1), \tag{4.5}$

where ``ξ_1`` lies between ``x_0 - h`` and ``x_0 + h``.
"""

# ╔═╡ 860a661b-668c-45a9-84aa-3e4d631a4a41
md"### Five-Point Formulas"

# ╔═╡ e73fbaa4-373c-4565-b77a-bcde2a693eba
md"""
**Remark.**
The mtehods presented in Eqs. ``(4.4)`` and ``(4.5)`` are called **three-point formulas** (even though the third point ``f(x_0)`` does not appear in Eq. ``(4.5)``).
Similarly, there are **five-point formulas** that involve evaluating the function at two additional points.
The error term for these formulas is ``O(h^4)``.
One common five-point formula is used to determine approximations for the derivative at the midpoint.
"""

# ╔═╡ 9bd636ac-7d93-49a1-a482-89d2f6d8149c
md"### Five-Point Midpoint Formula"

# ╔═╡ 5c8cec6b-1668-4794-ad67-6b79da8c5c37
md"""
**Remark.**

$f'(x_0) = \frac{1}{12h} [f(x_0 - 2h) - 8f(x_0 - h) + 8f(x_0 + h) - f(x_0 + 2h)] + \frac{h^4}{30} f^{(5)}(ξ), \tag{4.6}$

where ``ξ`` lies between ``x_0 - 2h`` and ``x_0 + 2h``.

The derivation of this formulas is considered in Section 4.2.
The other five-point formula is used for approximations at the endpoints.
"""

# ╔═╡ 8d757352-a2ee-44f3-84f3-045f2dfb95b9
md"### Five-Point Endpoint Formula"

# ╔═╡ 05851fb6-cc27-4061-8048-312f28225d94
md"""
**Remark.**

$\begin{align*}
f'(x_0) &= \frac{1}{12h} [-25f(x_0) + 48f(x_0 + h) - 36f(x_0 + 2h) \\
&\quad {}+ 16 f(x_0 + 3h) - 3f(x_0 + 4h)] + \frac{h^4}{5} f^{(5)}(ξ), \tag{4.7}
\end{align*}$

where ``ξ`` lies between ``x_0`` and ``x_0 + 4h``.

Left-endpoint approximations are found using this formula with ``h > 0`` and right-endpoint approximations with ``h < 0``.
The five-point endpoint formula is particularly useful for the clamped cubic spline interpolation of Section 3.5.
"""

# ╔═╡ 33c3e2f4-8b6c-4542-b027-727a050f6eed
md"### Second Derivative Midpoint Formula"

# ╔═╡ 457f48a3-1a73-44b6-b86c-fa6bdd08ff0b
md"""
**Remark.**

$f''(x_0) = \frac{1}{h^2} [f(x_0 - h) - 2f(x_0) + f(x_0 + h)] - \frac{h^2}{12} f^{(4)}(ξ), \tag{4.9}$

for some ``ξ``, where ``x_0 - h < ξ < x_0 + h``.

If ``f^{(4)}`` is continuous on ``[x_0 - h, x_0 + h]``, it is also bounded, and the approximation is ``O(h^2)``.
"""

# ╔═╡ 7888789a-43b4-47d9-96f0-3a1c2b37bcce
md"### Round-Off Error Instability"

# ╔═╡ 4ede9e88-6f71-45c2-a1b1-0616cd83a003
md"""
**Remark.**
It is particularly important to pay attention to round-off error when approximating derivatives.
"""

# ╔═╡ b6e0143b-1066-4280-acaa-4f543fa42959
md"## 4.2 Richardson's Extrapolation"

# ╔═╡ f40d0a7c-ac33-4988-aa41-8ca491f90681
md"""
**Remark.**
Richardson's extrapolation is used to generate high-accuracy results while using low-order formulas.
"""

# ╔═╡ 2cc766b3-e863-41e5-80b0-e8bc902244f2
md"## 4.3 Elements of Numerical Integration"

# ╔═╡ 0a4c8b29-731f-481c-8c70-1c52aebabdba
md"""
**Remark.**
The need often arises for evaluating the definite integral of a function that has no explicit antiderivative or whose antiderivative is not easy to obtain.
The basic method involved in approximating ``∫_a^b f(x) \,dx`` is called **numerical quadrature**.
It uses a sum ``\sum_{i=0}^n a_i f(x_i)`` to approximate ``∫_a^b f(x) \,dx``.
"""

# ╔═╡ 13859101-e0df-456c-b9e5-230650c0553f
md"""
**Remark.**
The methods of quadrature in this section are based on the interpolation polynomials given in Chapter 3.
The basic idea is to select a set of distinct nodes ``\{x_0,…,x_n\}`` from the interval ``[a,b]``.
Then integrate the Lagrange interpolating polynomial

$P_n(x) = \sum_{i=0}^n f(x_i) L_i(x)$

and its truncation error term over ``[a,b]`` to obtain

$\begin{align*}
∫_a^b f(x) \,dx &= ∫_a^b \sum_{i=0}^n f(x_i) L_i(x) \,dx + ∫_a^b \prod_{i=0}^n (x - x_i) \frac{f^{(n+1)}(ξ(x))}{(n+1)!} \,dx \\
&= \sum_{i=0}^n a_i f(x_i) + \frac{1}{(n+1)!} ∫_a^b \prod_{i=0}^n (x - x_i) f^{(n + 1)} (ξ(x)) \,dx,
\end{align*}$

where ``ξ(x)`` is in ``[a,b]`` for each ``x`` and

$a_i = ∫_a^b L_i(x) \,dx, \quad\text{for each } i = 0,1,…,n.$

The quadrature formula is, therefore,

$∫_a^b f(x) \,dx ≈ \sum_{i=0}^n a_i f(x_i),$

with error given by

$E(f) = \frac{1}{(n+1)!} ∫_a^b \prod_{i=0}^n (x-x_i) f^{(n+1)}(ξ(x)) \,dx.$
"""

# ╔═╡ 2481faa0-85d8-42a2-a8d6-bf2cc8eab5b7
md"""
**Remark.**
Before discussing the general situation of quadrature formulas, let us consider formulas produced by using first and second Lagrange polynomials with equally spaced nodes.
This gives the **Trapezoidal rule** and **Simpson's rule**, which are commonly introduced in calculus courses.
"""

# ╔═╡ 84c51562-647e-40ef-a266-7e6acd9f4daf
md"### The Trapezoidal Rule"

# ╔═╡ 01ee02d8-402f-4d62-83da-91ca3ef79b9f
md"""
**Trapezoidal Rule**

$∫_a^b f(x) \,dx = \frac{h}{2} [f(x_0) + f(x_1)] - \frac{h^3}{12} f''(ξ).$
"""

# ╔═╡ 252c34ea-23ab-4b74-a6e7-37799633b3f4
md"### Simpson's Rule"

# ╔═╡ e79c2d68-d900-4bc1-b50f-cb1e15cc88b1
md"""
**Simpson's Rule**

$∫_{x_0}^{x_2} f(x) \,dx = \frac{h}{3} [f(x_0) + 4f(x_1) + f(x_2)] - \frac{h^5}{90} f^{(4)}(ξ).$
"""

# ╔═╡ ff02a90e-1731-4c01-9654-a827e918c5a6
md"### Measuring Precision"

# ╔═╡ 55edf836-6ec4-4c3a-9844-8f2914b80003
md"""
**Remark.**
The standard derivation of quadrature formulas is based on determining the class of polynomials for which these formulas produce exact results.
The next definition is used to facilitate the discussion of this derivation.
"""

# ╔═╡ da07c466-630d-4d4e-b366-904ef33494eb
md"""
**Definition 4.1**
The **degree of accuracy**, or **precision**, of a quadrature formula is the largest positive integer ``n`` such that the formula is exact for ``x^k``, for each ``k = 0,1,…,n``.
"""

# ╔═╡ 99d2d39e-8fb2-43c4-b9a8-897d90dd2a4c
md"### Closed Newton-Cotes Formulas"

# ╔═╡ e5a1508c-9982-420a-9263-1deae08f2e47
md"""
**Remark.**
The *``(n+1)``-point closed Newton-Cotes formula* uses nodes ``x_i = x_0 + ih``, for ``i = 0,1,…,n``, where ``x_0 = a``, ``x_n = b`` and ``h = (b - a) / n``.
"""

# ╔═╡ 72d5b687-d328-446a-b338-7f162bc8d805
md"""
**Theorem 4.2**
Suppose that ``\sum_{i=0}^n a_i f(x_i)`` denotes the ``(n+1)``-point closed Newton-Cotes formula with ``x_0 = a``, ``x_n = b``, and ``h = (b - a) / n``.
There exists ``ξ ∈ (a,b)`` for which

$∫_a^b f(x) \,dx = \sum_{i=0}^n a_i f(x_i) + \frac{h^{n+3} f^{(n+2)}(ξ)}{(n+2)!} ∫_0^n t^2 (t - 1) ⋯ (t - n) \,dt,$

if ``n`` is even and ``f ∈ C^{n+2} [a,b]``, and

$∫_a^b f(x) \,dx = \sum_{i=0}^n a_i f(x_i) + \frac{h^{n+2} f^{(n+1)}(ξ)}{(n+1)!} ∫_0^n t (t - 1) ⋯ (t - n) \,dt,$

if ``n`` is odd and ``f ∈ C^{n+1}[a,b]``.
"""

# ╔═╡ 1c8beda1-a780-4328-89c4-aaa7a99699a4
md"### Open Newton-Cotes Formulas"

# ╔═╡ 4509bfe5-69bf-4dbb-b49b-2461901488f1
md"""
**Remark.**
The *open Newton-Cotes formulas* do not include the endpoints of ``[a,b]`` as nodes.
"""

# ╔═╡ a0f45715-6f06-4e8c-b299-c164b3836ca6
md"""
**Theorem 4.3**
Suppose that ``\sum_{i=0}^n a_i f(x_i)`` denotes the ``(n+1)``-point closed Newton-Cotes formula with ``x_{-1} = a``, ``x_{n+1} = b``, and ``h = (b - a) / (n + 2)``.
There exists ``ξ ∈ (a,b)`` for which

$∫_a^b f(x) \,dx = \sum_{i=0}^n a_i f(x_i) + \frac{h^{n+3} f^{(n+2)}(ξ)}{(n+2)!} ∫_{-1}^{n+1} t^2 (t - 1) ⋯ (t - n) \,dt,$

if ``n`` is even and ``f ∈ C^{n+2} [a,b]``, and

$∫_a^b f(x) \,dx = \sum_{i=0}^n a_i f(x_i) + \frac{h^{n+2} f^{(n+1)}(ξ)}{(n+1)!} ∫_{-1}^{n+1} t (t - 1) ⋯ (t - n) \,dt,$

if ``n`` is odd and ``f ∈ C^{n+1}[a,b]``.
"""

# ╔═╡ cadc1cb3-76d5-4a62-8ad2-16bc602bd3e3
md"## 4.4 Composite Numerical Integration"

# ╔═╡ dd8ed6b9-08c8-46ea-ac73-fcc117ac4482
md"""
**Remark.**
The Newton-Cotes formulas are generally unsuitable for use over large integration intervals.
High-degree formulas would be required, and the values of the coefficients in these formulas are difficult to obtain.
Also, the Newton-Cotes formulas are based on interpolatory polynomials that use equally spaced nodes, a procedure that is inaccurate over large intervals because of the oscillatory nature of high-degree polynomials.
"""

# ╔═╡ ce80e909-ea27-42f8-9640-9450d2d71275
md"""
**Remark.**
In this section, we discuss a *piecewise* approach to numerical integration that uses the low-order Newton-Cotes formulas.
These are the techniques most often applied.
"""

# ╔═╡ 940f3c3d-b2e0-411b-ae64-f1b118ad4450
md"""
**Example 1**
Simpson's rule on ``[0,4]`` uses ``h = 2`` and gives

$∫_0^4 e^x \,dx ≈ \frac{2}{3} (e^0 + 4e^2 + e^4) = 56.76958.$

The exact answer in this case is ``e^4 - e^0 = 53.59815``, and the error ``-3.17143`` is far larger than we would normally accept.

Applying Simpson's rule on each of the intervals ``[0,2]`` and ``[2,4]`` uses ``h = 1`` and gives

$\begin{align*}
∫_0^4 e^x \,dx &= ∫_0^2 e^x \,dx + ∫_2^4 e^x \,dx \\
&≈ \frac{1}{3} (e^0 + 4e + e^2) + \frac{1}{3} (e^2 + 4e^3 + e^4) \\
&= \frac{1}{3} (e^0 + 4e + 2e^2 + 4e^3 + e^4) \\
&= 53.86385.
\end{align*}$

The error has been reduced to ``-0.26570``.

For the intervals ``[0,`]``, ``[1,2]``, ``[2,3]``, and ``[3,4]``, we use Simpson's rule four times with ``h = \frac{1}{2}`` giving

$\begin{align*}
∫_0^4 e^x \,dx &= ∫_0^1 e^x \,dx + ∫_1^2 e^x \,dx + ∫_2^3 e^x \,dx + ∫_3^4 e^x \,dx \\
&≈ \frac{1}{6} (e^0 + 4e^{1/2} + e^2) + \frac{1}{6} (e^2 + 4e^{3/2} + e^2) \\
&\quad {}+ \frac{1}{6} (e^0 + 4e^{5/2} + e^2) + \frac{1}{6} (e^0 + 4e^{7/2} + e^2) \\
&= \frac{1}{6} (e^0 + 4e^{1/2} + 2e + 4e^{3/2} + 2e^2 + 4e^{5/2} + 2e^3 + 4e^{7/2} + e^4) \\
&= 53.61622.
\end{align*}$

The error for this approximation has been reduced to ``-0.01807``.
"""

# ╔═╡ 2daf89c1-79d7-47a7-803e-63db9c274116
md"""
**Remark.**
To generalize this procedure for an arbitrary integral ``∫_a^b f(x) \,dx``, choose an even integer ``n``.
Subdivide the interval ``[a,b]`` into ``n`` subintervals and apply Simpson's rule on each consecutive pair of subintervals. (See Figure 4.7.)
"""

# ╔═╡ 2c864c81-37ea-4834-bd87-054db5b71e1f
md"""
**Theorem 4.4**
Let ``f ∈ C^4[a,b]``, ``n`` be even, ``h = (b - a) / n``, and ``x_j = a + jh``, for each ``j = 0,1,…,n``.
There exists a ``μ ∈ (a,b)`` for which the **Composite Simpson's rule** for ``n`` subintervals can be written with its error term as

$∫_a^b f(x) \,dx = \frac{h}{3} \left[f(a) + 2 \sum_{j=1}^{(n/2)-1} f(x_{2j}) + 4 \sum_{j=1}^{n/2} f(x_{2j-1}) + f(b)\right] - \frac{b - a}{180} h^4 f^{(4)}(μ).$
"""

# ╔═╡ d50561d3-2efa-4f10-a483-6ad784a05d66
md"""
**Remark.**
Notice that the error term for the Composite Simpson's rule is ``O(h^4)``, whereas it was ``O(h^5)`` for the standard Simpson's rule.
However, these rates are not comparable because for the standard Simpson's rule, we have ``h`` fixed at ``h = (b - a) / 2``, but for the Composite Simpson's rule, we have ``h = (b - a) / n``, for ``n`` an even integer.
This permits us to considerably reduce the value of ``h``.
"""

# ╔═╡ f3e9f2a2-7231-4e7e-81ce-a3a2e8b9283a
md"""
**Remark.**
Algorithm 4.1 uses the Composite Simpson's rule on ``n`` subintervals.
This is the most frequently used general-purpose quadrature algorithm.
"""

# ╔═╡ 0f6b8e73-b50d-4c10-8eb0-b910e2c6d05e
md"""
!!! info "Algorithm 4.1"

	**Composite Simpson's Rule**

	To approximate the integral ``I = ∫_a^b f(x) \,dx``:

	INPUT endpoints ``a``, ``b``; even positive integer ``n``

	OUTPUT approximation ``XI`` to ``I``.

	Step 1 Set ``h = (b - a) / n``.

	Step 2 Set ``XI0 = f(a) + f(b); XI1 = 0; XI2 = 0.``

	Step 3 For ``i = 1, …, n - 1`` do Steps 4 and 5.

	- Step 4 Set ``X = a + ih``

	- Step 5 If ``i`` is even then set ``XI2 = XI2 + f(X)`` else set ``XI1 = XI1 + f(X)``.

	Step 6 Set ``XI = h(XI0 + 2 ⋅ XI2 + 4 ⋅ XI1) / 3.``

	Step 7 OUTPUT(``XI``); STOP.
"""

# ╔═╡ 4aa76d84-ca61-4c68-aa6d-118071f3d917
md"""
**Remark.**
The subdivision approach can be applied to any of the Newton-Cotes formulas.
The extensions of the Trapezoidal (see Figure 4.8) and Midpoint rules are given without proof.
The Trapezoidal rule requires only one interval for each application, so the integer ``n`` can be either odd or even.
"""

# ╔═╡ 914af8c3-5e33-439c-bf72-5cc4b5a6cd27
md"""
**Theorem 4.5**
Let ``f ∈ C^2[a,b]``, ``h = (b - a) / n``, and ``x_j = a + jh``, for each ``j = 0,1,…,n``.
There exists a ``μ ∈ (a,b)`` for which the **Composite Trapezoidal rule** for ``n`` subintervals can be written with its error term as

$∫_a^b f(x) \,dx = \frac{h}{2} \left[f(a) + 2 \sum_{j=1}^{n-1} f(x_j) + f(b)\right] - \frac{b - a}{12} h^2 f''(μ).$
"""

# ╔═╡ f5daa6d1-dead-4a2c-8d03-70b3adf794e8
md"""
**Remark.**
For the **Composite Midpoint rule**, ``n`` must again be even. (See Figure 4.9.)
"""

# ╔═╡ 34dc8e7d-c896-4c50-8790-4555856f3f77
md"""
**Theorem 4.6**
Let ``f ∈ C^2[a,b]``, ``n`` be even, ``h = (b - a) / (n + 2)``, and ``x_j = a + (j + 1)h`` for each ``j = -1,0,…n+1``.
There exists a ``μ ∈ (a,b)`` for which the **Composite Midpoint rule** for ``n + 2`` subintervals can be written with its error term as

$∫_a^b f(x) \,dx = 2h \sum_{j=0}^{n/2} f(x_{2j}) + \frac{b - a}{6} h^2 f''(μ).$
"""

# ╔═╡ 18009ca1-856a-4040-a2c5-be311be07f14
md"""
**Example 2**
Determine values of ``h`` that will ensure an approximation error of less than 0.00002 when approximating ``∫_0^π \sin{x} \,dx`` and employing
**(a)** Composite Trapezoidal rule and **(b)** Composite Simpson's rule.

_**Solution**_
**(a)** The error form for the Composite Trapezoidal rule for ``f(x) = \sin{x}`` on ``[0,π]`` is

$\left|\frac{πh^2}{12} f''(μ)\right| = \left|\frac{πh^2}{12} (-\sin{u})\right| = \frac{π h^2}{12} |\sin{μ}|.$

To ensure sufficient accuracy with this technique, we need to have

$\frac{πh^2}{12} |\sin{μ}| ≤ \frac{πh^2}{12} < 0.00002.$

Since ``h = π/n``, we need

$\frac{π^3}{12n^2} < 0.00002, \quad\text{which implies that}\quad n > \left(\frac{π^3}{12(0.00002)}\right)^{1/2} ≈ 359.44.$

and the Composite Trapezoidal rule requires ``n ≥ 360``.

**(b)** The error form for the Composite Simpson's rule for ``f(x) = \sin{x}`` on ``[0,π]`` is

$\left|\frac{πh^4}{180} f^{(4)}(μ)\right| = \left|\frac{πh^4}{180} \sin{μ}\right| = \frac{πh^4}{180} |\sin{μ}|.$

To ensure sufficient accuracy with this technique, we need to have

$\frac{πh^4}{180} |\sin{μ}| ≤ \frac{πh^4}{180} < 0.00002.$

Using again the fact that ``n = π / h`` gives

$\frac{π^5}{180n^4} < 0.00002, \quad\text{which implies that}\quad n > \left(\frac{π^5}{180(0.00002)}\right)^{1/4} ≈ 17.07.$

So, the Composite Simpson's rule requires only ``n ≥ 18``.

The Composite Simpson's rule with ``n = 18`` gives

$∫_0^π \sin{x} \,dx ≈ \frac{π}{54} \left[2 \sum_{j=1}^8 \sin{\left(\frac{jπ}{9}\right)} + 4\sum_{j=1}^9 \sin{\left(\frac{(2j - 1)π}{18}\right)}\right] = 2.0000104.$

The is accurate to within about ``10^{-5}`` because the true value is ``-\cos(π) - (-\cos(0)) = 2``.
"""

# ╔═╡ a3673f9d-b3cd-4e1f-b18e-a0a816f0eaa1
md"### Round-Off Error Stability"

# ╔═╡ 173ee4d1-902d-48ce-af0f-56d454aa315d
md"""
**Remark.**
In Example 2, we saw that ensuring an accuracy of ``2 × 10^{-5}`` for approximating ``∫_0^π \sin{x} \,dx`` required 360 subdivisions of ``[0,π]`` for the Composite Trapezoidal rule and only 18 for the Composite Simpson's rule.
"""

# ╔═╡ 09534f01-c9b5-492d-97af-f10dbfaa1c1c
md"""
**Remark.**
To demonstrate this rather amazing fact, suppose we apply the Composite Simpson's rule with ``n`` subintervals to a function ``f`` on ``[a,b]`` and determine the maximum bound for the round-off error.
"""

# ╔═╡ 22d4c65c-0636-4e61-91ed-c0926a2b1dd9
md"## 4.5 Romberg Integration"

# ╔═╡ 96577e2f-2276-4c8b-88a1-b18868919134
md"## 4.6 Adaptive Quadrature Methods"

# ╔═╡ 23d7a6fd-7296-4769-916d-9dfcde87ccbc
md"## 4.7 Gaussian Quadrature"

# ╔═╡ c4327b0e-8953-4fb8-b4bf-bb73811c425f
md"## 4.8 Multiple Integrals"

# ╔═╡ 1b44329e-97ea-46f6-bdfd-26216c592ee2
md"## 4.9 Improper Integrals"

# ╔═╡ 12e445df-54a6-4a43-8253-b92c5cf24a66
md"## 4.10 Numerical Software and Chapter Review"

# ╔═╡ 79d0937e-5837-437e-ba9b-9a7050c3e27a
md"# 5 Initial-Value Problems for Ordinary Differential Equations"

# ╔═╡ abd4f3f6-2e75-4b81-ab3e-b73cb38b1868
md"""
**Remark.**
The motion of a swinging pendulum under certain simplifying assumptions is described by the second-order differential equation

$\frac{d^2 θ}{dt^2} + \frac{g}{L} \sin{θ} = 0,$

where ``L`` is the length of the pendulum, ``g ≈ 32.17 \text{ ft/s}^2`` is the gravitational constant of the earth, and ``θ`` is the angle the pendulum makes with the vertical.
"""

# ╔═╡ 545feb7b-e53c-4438-b554-78893199abd4
md"## 5.1 The Elementary Theory of Initial-Value Problems"

# ╔═╡ ec4e80fb-e212-4b1c-88b6-63ea441f3fb5
md"""
**Remark.**
Differential equations are used to model problems in science and engineering that involve the change of some variable with respect to another.
"""

# ╔═╡ e1243f0f-0cdb-428e-8c0e-8717a16c0620
md"""
**Remark.**
In common real-life situations, the differential equation that models the problem is too complicated to solve exactly, and one of two approaches is taken to approximate the solution.
"""

# ╔═╡ a37d8465-797c-4e1f-a508-034342763e43
md"""
**Remark.**
The methods that we consider in this chapter do not produce a continuous approximation to the solution of the initial-value problem.
"""

# ╔═╡ 3dbda725-2f1f-4097-a070-ba1f853c5f62
md"""
**Remark.**
We need some definitions and results from the theory of ordinary differential equations before considering methods for approximating the solutions to initial-value problems.
"""

# ╔═╡ dc95805d-4275-405d-b63e-57642b421739
md"""
**Definition 5.1**
A function ``f(t, y)`` is said to satisfy a **Lipschitz condition** in the variable ``y`` on a set ``D ⊂ ℝ^2`` if a constant ``L > 0`` exists with

$|f(t, y_1) - f(t, y_2)| ≤ L|y_1, y_2|,$

whenever ``(t,y_1)`` and ``(t,y_2)`` are in ``D``.
The constant ``L`` is called a **Lipschitz constant** for ``f``.
"""

# ╔═╡ 4567e6b1-b4c2-4bc9-a2c7-21e0f134af8b
md"""
**Definition 5.2**
A set ``D ⊂ ℝ^2`` is said to be **convex** if whenever ``(t_1,y_1)`` and ``(t_2,y_2)`` belong to ``D``, then ``((1 - λ)t_1 + λt_2, (1 - λ)y_1 + λy_2)`` also belongs to ``D`` for every ``λ`` in ``[0,1]``.
"""

# ╔═╡ 46f0b390-7c31-41c2-bc8a-4dc2f171fda2
md"""
**Theorem 5.3**
Suppose ``f(t,y)`` is defined on a convex set ``D ⊂ ℝ^2``.
If a constant ``L > 0`` exists with

$\left|\frac{∂f}{∂y}(t,y)\right| ≤ L, \quad\text{for all } (t, y) ∈ D, \tag{5.1}$

then ``f`` satisfies a Lipschitz condition on ``D`` in the variable ``y`` with Lipschitz constant ``L``.
"""

# ╔═╡ dc61e975-ec10-4647-b5aa-f1306222479e
md"""
**Theorem 5.4**
Suppose that ``D = \{(t,y) ∣ a ≤ t ≤ b \text{ and } -∞ < y < ∞\}`` and that ``f(t,y)`` is continuous on ``D``.
If ``f`` satisfies a Lipschitz condition on ``D`` in the variable ``y``, then the initial-value problem

$y'(t) = f(t,y), \quad a ≤ t ≤ b, \quad y(a) = α,$

has a unique solution ``y(t)`` for ``a ≤ t ≤ b``.
"""

# ╔═╡ e599e21a-77ad-4ca4-8f51-18684def0dba
md"### Well-Posed Problems"

# ╔═╡ d7aceca1-aa42-49c6-b610-1520bf64a6f5
md"""
**Definition 5.5**
The initial-value problem

$\frac{dy}{dt} = f(t,y), \quad a ≤ t ≤ b, \quad y(a) = α, \tag{5.2}$

is said to be a **well-posed problem** if:

- A unique solution, ``y(t)``, to the problem exists, and

- There exist constants ``ε_0 > 0`` and ``k > 0`` such that for any ``ε``, in ``(0,ε_0)``, whenever ``δ(t)`` is continuous with ``|δ(t)| < ε`` for all ``t`` in ``[a,b]``, and when ``|δ_0| < ε``, the initial-value problem

  $\frac{dz}{dt} = f(t,z) + δ(t), \quad a ≤ t ≤ b, \quad z(a) = α + δ_0, \tag{5.3}$

  has a unique solution ``z(t)`` that satisfies

  $|z(t) - y(t)| < kε \quad \text{ for all } t \text{ in } [a,b].$
"""

# ╔═╡ cf9cb808-25b6-4bf2-925d-047aa6a80a28
md"""
**Theorem 5.6**
Suppose ``D = \{(t,y) ∣ a ≤ t ≤ b \text{ and } -∞ < y < ∞\}``.
If ``f`` is continuous and satisfies a Lipschitz condition in the variable ``y`` on the set ``D``, then the initial-value problem

$\frac{dy}{dt} = f(t,y), \quad a ≤ t ≤ b, \quad y(a) = α$

is well posed.
"""

# ╔═╡ 42c68221-35a6-4f87-b958-79bf4cb792d6
md"## 5.2 Euler's Method"

# ╔═╡ 08d09281-4356-40ab-8c43-19b97413a99f
md"""
**Remark.**
Euler's method is the most elementary approximation technique for solving initial-value problems.
Although it is seldom used in practice, the simplicity of its derivation can be used to illustrate the techniques involved in the construction of some of the more advanced techniques, without the cumbersome algebra that accompanies these constructions.
"""

# ╔═╡ 0441342e-1631-42dd-9d1a-351158681fa2
md"""
**Remark.**
The object of Euler's method is to obtain approximations to the well-posed initial-value problem

$\frac{dy}{dt} = f(t,y), \quad a ≤ t ≤ b, \quad y(a) = α. \tag{5.6}$
"""

# ╔═╡ 1be85162-e1a5-452e-bdf8-181d60ae7d41
md"""
**Remark.**
A continuous approximation to the solution ``y(t)`` will not be obtained; instead approximations to ``y`` will be generated at various values, called **mesh points**, in the interval ``[a,b]``.
Once the approximate solution is obtained at the points, the approximate solution at other points in the interval can be found by interpolation.
"""

# ╔═╡ 7a57bdaa-f23e-455c-9e41-48d872247f1c
md"""
**Remark.**
We first make the stipulation that the mesh points are equally distributed throughout the interval ``[a,b]``.
This condition is ensured by choosing a positive integer ``N``, setting ``h = (b - a) / N``, and selecting the mesh points

$t_i = a + ih, \quad \text{ for each } i = 0, 1, 2, …, N.$

The common distance between the points ``h = t_{i+1} - t_i`` is called the **step size**.
"""

# ╔═╡ 951a62ba-bbac-4125-9ee4-e4d12b465126
md"""
**Remark.**
We will use Taylor's Theorem to derive Euler's method.
Suppose that ``y(t)``, the unique solution to (5.6), has two continuous derivatives on ``[a,b]``, so that for each ``i = 0,1,2,…,N-1``,

$y(t_{i+1}) = y(t_i) + (t_{i+1} - t_i) y'(t_i) + \frac{(t_{i+1} - t_i)^2}{2} y''(ξ_i),$

for some number ``ξ_i`` in ``(t_i,t_{i+1})``.
Because ``h = t_{i+1} - t_i``, we have

$y(t_{i+1}) = y(t_i) + hy'(t_i) + \frac{h^2}{2} y''(ξ_i),$

and, because ``y(t)`` satisfies the differential equation ``(5.6)``,

$y(t_{i+1}) = y(t_i) + hf(t_i, y(t_i)) + \frac{h^2}{2} y''(ξ_i). \tag{5.7}$
"""

# ╔═╡ 681037f0-edd6-4034-8ae5-14fec97d9b10
md"""
**Remark.**
Euler's method constructs ``w_i ≈ y(t_i)``, for each ``i = 1,2,…,N``, by deleting the remainder term.
Thus, Euler's method is

$\begin{align*}
w_0 &= α, \\
w_{i+1} &= w_i + hf(t_i,w_i), \quad \text{for each } i = 0,1,…,N-1. \tag{5.8}
\end{align*}$
"""

# ╔═╡ db436ab4-1b48-4c40-99e9-7b555d605486
md"""
**Remark.**
Equation ``(5.8)`` is called the **difference equation** associated with Euler's method.
As we will see later in this chapter, the theory and solution of difference equations parallel in many ways, the theory and solution of differential equations.
Algorithm 5.1 implements Euler's method.
"""

# ╔═╡ 0124fb25-d031-4478-bb58-9ce7daeab8df
md"### Error Bounds for Euler's Method"

# ╔═╡ 627d9dd9-88ba-48a5-80bf-c38bcff3964e
md"""
**Remark.**
Although Euler's method is not accurate enough to warrant its use in practice, it is sufficiently elementary to analyze the error that is produced from its application.
"""

# ╔═╡ a63e040a-7d84-459d-9e14-9db93a9bea3f
md"""
**Lemma 5.7**
For all ``x ≥ -1`` and any positive ``m``, we have ``0 ≤ (1 + x)^m ≤ e^{mx}``.
"""

# ╔═╡ b0323c57-49cb-4f39-b14e-c4453a76f226
md"""
**Lemma 5.8**
If ``s`` and ``t`` are positive real numbers, ``\{a_i\}_{i=0}^k`` is a sequence satisfying ``a_0 ≥ -t/s``, and

$a_{i+1} ≤ (1 + s)a_i + t, \quad \text{ for each } i = 0,1,2,…,k-1, \tag{5.9}$

then

$a_{i+1} ≤ e^{(i+1)s}\left(a_0 + \frac{t}{s}\right) - \frac{t}{s}.$
"""

# ╔═╡ c7d867d2-5f20-4a99-af19-ae8e1b1001cb
md"""
**Theorem 5.9**
Suppose ``f`` is continuous and satisfies a Lipschitz condition with constant ``L`` on

$D = \{(t,y) ∣ a ≤ t ≤ b \text{ and } -∞ < y < ∞\}$

and that a constant ``M`` exists with

$|y''(t)| ≤ M, \quad \text{ for all } t ∈ [a,b],$

where ``y(t)`` denotes the unique solution to the initial-value problem

$y' = f(t,y), \quad a ≤ t ≤ b, \quad y(a) = α.$

Let ``w_0,w_1,…,w_N`` be the approximations generated by Euler's method for some positive integer ``N``.
Then, for each ``i = 0,1,2,…,N,``

$|y(t_i) - w_i| ≤ \frac{hM}{2L} \left[e^{L(t_i - a)} - 1\right]. \tag{5.10}$
"""

# ╔═╡ ac602b17-9f04-4371-bfe0-830f4a6f1a21
md"""
**Theorem 5.10**
Let ``y(t)`` denote the unique solution to the initial-value problem

$y' = f(t,y), \quad a ≤ t ≤ b, \quad y(a) = α, \tag{5.12}$

and ``u_0,u_1,…,u_N`` be the approximations obtained using Eq. ``(5.11)``.
If ``|δ_i| < δ`` for each ``i = 0,1,…,N`` and the hypothesis of Theorem 5.9 hold for Eq. ``(5.12)``, then

$|y(t_i) - u_i| ≤ \frac{1}{L} \left(\frac{hM}{2} + \frac{δ}{h}\right) [e^{L(t_i - a)} - 1] + |δ_0| e^{L(t_i - a)}, \tag{5.13}$

for each ``i = 0,1,…,N``.
"""

# ╔═╡ db29b1ad-d326-4df9-823e-a26fd6e682ad
md"## 5.3 Higher-Order Taylor Methods"

# ╔═╡ fda62b5b-17b4-421e-bb98-24fe3272725b
md"## 5.4 Runge-Kutta Methods"

# ╔═╡ 6e0d5a4d-7b16-4d82-9eb9-6f53e08912c2
md"## 5.5 Error Control and the Runge-Kutta-Fehlberg Method"

# ╔═╡ 3a7bac9b-74b2-4d96-838e-dc25876afa3d
md"## 5.6 Multistep Methods"

# ╔═╡ 7fe7de57-1cb4-477a-8783-958e52441191
md"## 5.7 Variable Step-Size Multistep Methods"

# ╔═╡ 9e791289-970e-409a-a220-194f8d416055
md"## 5.8 Extrapolation Methods"

# ╔═╡ 38dc53ab-f825-4634-9464-8b2d34807c86
md"## 5.9 Higher-Order Equations and Systems of Differential Equations"

# ╔═╡ a86efe21-9842-4df8-806d-bc83f0beadb3
md"## 5.10 Stability"

# ╔═╡ 5f47e4cc-1b2d-4c67-8308-f571bf9e9d60
md"## 5.11 Stiff Differential Equations"

# ╔═╡ ac1d1864-9c9a-4cf9-a90b-9a5f56e528eb
md"## 5.12 Numerical Software"

# ╔═╡ d7bd5b45-82a0-40c3-bbe1-d5157b7107b9
md"# 6 Direct Methods for Solving Linear Systems"

# ╔═╡ 0840932f-e86f-40b1-91c9-d3b5e768af5e
md"""
**Remark.**
Kirchhoff's laws of electrical circuits state that both the net flow of current through each junction and the net voltage drop around each closed loop of a circuit are zero.
Suppose that a potential of ``V`` volts is applied between the points ``A`` and ``G`` in the circuit and that ``i_1``, ``i_2``, ``i_3``, ``i_4``, and ``i_5`` represent current flow as shown in the diagram.
Using ``G`` as a reference point, Kirchhoff's laws imply that the currents satisfy the following system of linear equations:

$\begin{align*}
5i_1 + 5i_2 &= V, \\
i_3 - i_4 - i_5 &= 0, \\
2i_4 - 3i_5 &= 0, \\
i_1 - i_2 - i_3 &= 0, \\
5i_2 - 7i_3 - 2i_4 &= 0.
\end{align*}$
"""

# ╔═╡ 1418a72b-f368-4f70-8fa3-cc7e59d5e093
md"""
**Remark.**
The solution of systems of this type will be considered in this chapter.
This application is discussed in Exercise 23 of Section 6.6.
"""

# ╔═╡ 0381bc64-6a79-4225-be8a-5742852c3b13
md"""
**Remark.**
Linear systems of equations are associated with many problems in engineering and science as well as with applications of mathematics to the social sciences and the quantitative study of business and economic problems.
"""

# ╔═╡ d4d94e16-7ec0-443c-8f42-715c32fa1365
md"""
**Remark.**
In this chapter, we consider *direct methods* for solving a linear system of ``n`` equations in ``n`` variables.
Such a system has the form

$\begin{align*}
E_1 : a_{11} x_1 + a_{12} x_2 + ⋯ + a_{1n} x_n &= b_1, \\
E_2 : a_{21} x_1 + a_{22} x_2 + ⋯ + a_{2n} x_n &= b_2, \\
&⋮ \tag{6.1} \\
E_n : a_{n1} x_1 + a_{n2} x_2 + ⋯ + a_{nn} x_n &= b_n. \\
\end{align*}$

In this system, we are given the constants ``a_{ij}``, for each ``i, j = 1,2,…,n``, and ``b_i``, for each ``i = 1,2,…,n``, and we need to determine the unknowns ``x_1,…,x_n``.
"""

# ╔═╡ ef23edd7-cfa3-4138-ac4f-3f86769c59d2
md"""
**Remark.**
Direct techniques are methods that theoretically give thet exact solution to the system in a finite number of steps.
In practice, of course, the solution obtained will be contaminated by the round-off error that is involved with the arithmetic being used.
Analyzing the effect of this round-off error and determining ways to keep it under control will be a major component of this chapter.
"""

# ╔═╡ 3f75a6f9-1c7d-4843-be81-ec54caaf4bef
md"""
**Remark.**
A course in linear algebra is not assumed to be prerequisite for this chapter, so we will include a number of the basic notions of the subject.
These results will also be used in Chapter 7, where we consider methods of approximating the solution to linear systems using iterative methods.
"""

# ╔═╡ 6287227b-e351-40db-a840-0f8d26398810
md"## 6.1 Linear Systems of Equations"

# ╔═╡ 3faa3b5c-53bb-4450-8ff0-55b01f049f3a
md"""
**Remark.**
We use three operations to simplify the linear system in Eq. (6.1):

1. Equation ``E_i`` can be multiplied by any nonzero constant ``λ`` with the resulting equation used in place of ``E_i``.
   This operation is denoted ``(λE_i) → (E_i)``.

2. Equation ``E_j`` can be multiplied by any constant ``λ`` and added to equation ``E_i`` with the resulting equation used in place of ``E_i``.
   This operation is denoted ``(E_i + λE_j) → (E_i)``.

3. Equations ``E_i`` and ``E_j`` can transposed in order,
   This operation is denoted ``(E_i) ↔ (E_j)``.
"""

# ╔═╡ 0e9fd5e6-2d96-4869-b6f2-a6babd85625e
md"""
**Illustration.**
The four equations

$\begin{array}{ccccccc}
E_1 &: &x_1 &+ &x_2 && &+ &3x_4 &= &4, \\
E_2 &: &2x_1 &+ &x_2 &- &x_3 &+ &x_4 &= &1, \\
E_3 &: &3x_1 &- &x_2 &- &x_3 &+ &2x_4 &= &-3, \tag{6.2} \\
E_4 &: &-x_1 &+ &2x_2 &+ &3x_3 &- &x_4 &= &4, \\
\end{array}$

will be solved for ``x_1``, ``x_2``, ``x_3``, and ``x_4``.
We first use equation ``E_1`` to eliminate the unknown ``x_1`` from equations ``E_2``, ``E_3``, and ``E_4`` by performing ``(E_2 - 2E_1) → (E_2)``, ``(E_3 - 3E_1) → (E_3)``, and ``(E_4 + E_1) → (E_4)``.
For example, in the second equation,

$(E_2 - 2E_1) → (E_2)$

produces

$(2x_1 + x_2 - x_3 + x_4) - 2(x_1 + x_2 + 3x_4) = 1 - 2(4),$

which simplifies to the result shown as ``E_2`` in

$\begin{array}{ccccccc}
E_1 &: &x_1 &+ &x_2 && &+ &3x_4 &= &4, \\
E_2 &: & &- &x_2 &- &x_3 &- &5x_4 &= &-7, \\
E_3 &: & &- &4x_2 &- &x_3 &- &7x_4 &= &-15, \\
E_4 &: & &+ &3x_2 &+ &3x_3 &+ &2x_4 &= &8. \\
\end{array}$

For simplicity, the new equations are again labeled ``E_1``, ``E_2``, ``E_3``, and ``E_4``.

In the new systems, ``E_2`` is used to eliminate the unknown ``x_2`` from ``E_3`` and ``E_4`` by performing ``(E_3 - 4E_2) → (E_3)`` and ``(E_4 + 3E_2) → (E_4)``.
This results in

$\begin{array}{ccccccc}
E_1 &: &x_1 &+ &x_2 && &+ &3x_4 &= &4, \\
E_2 &: & &- &x_2 &- &x_3 &- &5x_4 &= &-7, \tag{(6.3)} \\
E_3 &: & & & & &3x_3 &+ &13x_4 &= &13, \\
E_4 &: & & & & & &- &13x_4 &= &-13. \\
\end{array}$

The system of equations ``(6.3)`` is now in **triangular** (or **reduced**) **form** and can be solved for the unknowns by a **backward-substitution process**.
Since ``E_4`` implies ``x_4 = 1``, we can solve ``E_3`` for ``x_3`` to give

$x_3 = \frac{1}{3} (13 - 13x_4) = \frac{1}{3} (13 - 13) = 0.$

Continuing, ``E_2`` gives

$x_2 = -(-7 + 5x_4 + x_3) = -(-7 + 5 + 0) = 2,$

and ``E_1`` gives

$x_1 = 4 - 3x_4 - x_2 = 4 - 3 - 2 = -1.$

The solution to system ``(6.3)`` and, consequently, to system ``(6.2)`` is, therefore, ``x_1 = -1``, ``x_2 = 2``, ``x_3 = 0``, and ``x_4 = 1``.
"""

# ╔═╡ 301c31be-a7d7-40f1-944c-23713767f137
md"### Matrices and Vectors"

# ╔═╡ a7f5f93d-0822-4784-9db0-d3d223d3404d
md"""
**Remark.**
When performing the calculations in the illustration, we would not need to write out the full equations at each step or to carry the variables ``x_1``, ``x_2``, ``x_3``, and ``x_4`` through the calculations, if they always remained the same column.
"""

# ╔═╡ d0c6ec89-72d2-40df-bc40-544400675961
md"""
**Definition 6.1**
An ``\boldsymbol{n} × \boldsymbol{m}`` (``\boldsymbol{n}`` by ``\boldsymbol{m}``) **matrix** is a rectangular array of elements with ``n`` rows and ``m`` columns in which not only is the value of an element important but also its position in the array.
"""

# ╔═╡ 4e8ba8da-0c6e-42de-967d-8ae88fea888b
md"""
**Example 1**
Determine the size and respective entries of the matrix

$A = \begin{bmatrix}
2 & -1 & 7 \\
3 & 1 & 0
\end{bmatrix}.$

_**Solution**_
The matrix has two rows and three columns, so its of size ``2 × 3``.
Its entires are described by ``a_{11} = 2``, ``a_{12} = -1``, ``a_{13} = 7``, ``a_{21} = 3``, ``a_{22} = 1``, and ``a_{23} = 0``.
"""

# ╔═╡ 41781451-5be3-42bd-97ad-c79001fa1b65
md"""
**Remark.**
The ``1 \times n`` matrix

$A = \begin{bmatrix} a_{11} & a_{12} & ⋯ & a_{1n} \end{bmatrix}$

is called an **``\boldsymbol{n}``-dimensional row vector**, and an ``n \times 1`` matrix

$A = \begin{bmatrix}
a_{11} \\
a_{21} \\
⋮ \\
a_{n1}
\end{bmatrix}$

is called an **``\boldsymbol{n}``-dimensional column vector**.
Usually, the unnecessary subscripts are omitted for vectors, and a boldface lowercase letter is used for notation.
"""

# ╔═╡ 6b06f828-1761-4af9-99f4-3d1f6b74206e
md"""
**Remark.**
An ``n \times (n + 1)`` matrix can be used to represent the linear system

$\begin{align*}
a_{11} x_1 + a_{12} x_2 + ⋯ + a_{1n} x_n &= b_1, \\
a_{21} x_1 + a_{22} x_2 + ⋯ + a_{2n} x_n &= b_2, \\
⋮ \qquad\qquad\qquad\quad &\;\;⋮ \\
a_{n1} x_1 + a_{n2} x_2 + ⋯ + a_{nn} x_n &= b_n, \\
\end{align*}$

by first constructing

$A = [a_{ij}] = \begin{bmatrix}
a_{11} & a_{12} & ⋯ & a_{1n} \\
a_{21} & a_{22} & ⋯ & a_{2n} \\
⋮ & ⋮ & & ⋮ \\
a_{n1} & a_{n2} & ⋯ & a_{nn}
\end{bmatrix} \quad\text{and}\quad 𝐛 = \begin{bmatrix}
b_1 \\ b_2 \\ ⋮ \\ b_n
\end{bmatrix}$

$[A, 𝐛] = \left[\begin{array}{cccc:c}
a_{11} & a_{12} & ⋯ & a_{1n} & b_1 \\
a_{21} & a_{22} & ⋯ & a_{2n} & b_2 \\
⋮ & ⋮ & & ⋮ & ⋮ \\
a_{n1} & a_{n2} & ⋯ & a_{nn} & b_n
\end{array}\right]$

where the vertical dotted line is used to separate the coefficients of the unknowns from the values on the right-hand side of the equations.
The array ``[A, 𝐛]`` is called an **augmented matrix**.
"""

# ╔═╡ 95321ea5-d9b0-4a45-ab54-4285fd9b4ff7
md"### Operation Counts"

# ╔═╡ ce75f4dc-44cc-4b83-b2ef-48ac5bc91cf2
md"""
**Remark.**
Both the amount of time required to complete the calculations and the subsequent round-off error depend on the number of floating-point arithmetic operations needed to solve a routine problem.
In general, the amount of time required to perform a multiplication or division on a computer is approximately the same and is considerably greater than that required to perform an addition or subtraction.
The actual differences in execution time, however, depend on the particular computing system.
To demonstrate the counting operations for a given method, we will count the operations required to solve a typical linear system of ``n`` equations in ``n`` unknowns using Algorithm 6.1.
We will keep the count of the additions/subtractions separate from the count of the multiplications/divisions because of the time differential.
"""

# ╔═╡ c888793b-f1dd-45cb-a0e3-3bd3f810d22a
md"""
**Remark.**
No arithmetic operations are performed until Steps 5 and 6 in the algorithm.
Step 5 requires that ``(n - i)`` divisions be performed.
The replacement of the equation ``E_j`` by ``(E_j - m_{ji} E_i)`` in Step 6 requires that ``m_{ji}`` be multiplied by each term in ``E_i``, resulting in a total of ``(n - i)(n - i + 1)`` multiplications.
After this is completed, each term of the resulting equation is subtracted from the corresponding term in ``E_j``.
This requires ``(n - i)(n - i + 1)`` subtractions.
For each ``i = 1,2,…,n-1``, the operations required in Steps 5 and 6 are as follows.

**Multiplications/divisions:**

$(n - i) + (n - i)(n - i + 1) = (n - i)(n - i + 2).$

**Additions/subtractions:**

$(n - i)(n - i + 1).$
"""

# ╔═╡ f924b536-3812-42d9-b122-80d74efa5dd8
md"## 6.2 Pivoting Strategies"

# ╔═╡ 5599f7ff-f9b4-46d7-b36a-951779d1bb45
md"""
**Remark.**
In deriving Algorithm 6.1, we found that a row interchange was needed when one of the pivot elements ``a_{kk}^{(k)}`` is ``0``.
This row interchange has the form ``(E_k) ↔ (E_p)``, where ``p`` is the smallest integer greater than ``k`` with ``a_{pk}^{(k)} ≠ 0``.
To reduce round-off error, it is often necessary to perform row interchanges even when the pivot elements are not zero.
"""

# ╔═╡ fff09de6-6084-4a8b-8775-e70a9bfe5ef4
md"""
**Remark.**
If ``a_{kk}^{(k)}`` is small in magnitude compared to ``a_{jk}^{(k)}``, then the magnitude of the multiplier

$m_{jk} = \frac{a_{jk}^{(k)}}{a_{kk}^{(k)}}$

will be much larger than 1.
Round-off error introduced in the computation of one of the terms ``a_{kl}^{(k)}`` is multiplied by ``m_{jk}`` when computing ``a_{jl}^{(k + 1)}``, which compounds the original error.
Also, when performing the backward substitution for

$x_k = \frac{a_{k,n+1}^{(k)} - \sum_{j={k+1}}^n a_{kj}^{(k)}}{a_{kk}^{(k)}},$

with a small value of ``a_{kk}^{(k)}``, any error in the numerator can be dramatically increased because of the division by ``a_{kk}^{(k)}``.
In our next example, we will see that even for small systems, round-off error can dominate the calculations.
"""

# ╔═╡ 2eedfce9-f054-428d-b44b-450aba1a4f61
md"### Partial Pivoting"

# ╔═╡ 9e4b9ce3-da28-490f-aa2d-58fee309f054
md"""
**Remark.**
Example 1 shows how difficulties can arise when the pivot element ``a_{kk}^{(k)}`` is small relative to the entries ``a_{ij}^{(k)}``, for ``k ≤ i ≤ n`` and ``k ≤ j ≤ n``.
To avoid this problem, pivoting is performed by selecting an element ``a_{pq}^{(k)}`` with a larger magnitude as the pivot and interchanging the ``k``th and ``p``th rows.
This can be followed by the interchange of the ``k``th and ``q``th columns, if necessary.
"""

# ╔═╡ 61940fd9-9b30-4784-819a-02bee1d48e32
md"""
**Remark.**
The simplest strategy, called partial pivoting, is to select an element in the same column that is below the diagonal and has the largest absolute value; specifically, we determine the smallest ``p ≥ k`` such that

$|a_{pk}^{(k)}| = \max_{k ≤ i ≤ n} |a_{ik}^{(k)}|$

and perform ``(E_k) ↔ (E_p)``.
In this case, no interchange of columns is used.
"""

# ╔═╡ 738df3ce-83fc-402d-87bf-29a7f0df02f0
md"""
**Remark.**
The technique just described is **partial pivoting** (or *maximal column pivoting*) and is detailed in Algorithm 6.2.
The actual row interchanging is simulated in the algorithm by interchanging the values of *NROW* in Step 5.
"""

# ╔═╡ 5b3d83ab-0432-4df2-bde4-0b38338839bb
md"### Scaled Partial Pivoting"

# ╔═╡ e1c3df4c-a7df-4923-911e-e544ca87c973
md"""
**Remark.**
**Scaled partial** pivoting (or *scaled-column pivoting*) is needed for the system in the illustration.
It places the element in the pivot position that is largest relative to the entries in its row.
The first step in this procedure is to define a scale factor ``s_i`` for each row as

$s_i = \max_{1 ≤ j ≤ n} |a_{ij}|.$

If we have ``s_i = 0`` for some ``i``, then the system has no unique solution since all entries in the ``i``th row are ``0``.
Assuming that this is not the case, the appropriate row interchange to place zeros in the first column is determined by choosing the least integer ``p`` with

$\frac{|a_{p1}}{s_p} = \max_{1 ≤ k ≤ n} \frac{|a_{k1}|}{s_k}$

and performing ``(E_1) ↔ (E_p)``.
The effect of scaling is to ensure that the largest element in each row has a *relative* magnitude of 1 before the comparison for row interchange is performed. 
"""

# ╔═╡ 3de45458-29e4-49bb-a17c-1d13f25fae1d
md"""
**Remark.**
In a similar manner, before eliminating the variable ``x_i`` using the operations

$E_k - m_{ki} E_i, \qquad \text{for } k = i + 1, …, n,$

we select the smallest integer ``p ≥ i`` with

$\frac{|a_{pi}|}{s_p} = \max_{i ≤ k ≤ n} \frac{|a_{ki}|}{s_k}$

and perform the row interchange ``(E_i) ↔ (E_p)`` if ``i ≠ p``.
The scale factors ``s_1, …, s_n`` are computed only once, at the start of the procedure.
They are row dependent, so they must also be interchanged when row interchanges are performed.
"""

# ╔═╡ 6ac17019-5304-4cd0-a7c7-19106c324a61
md"### Complete Pivoting"

# ╔═╡ 8f82c0dc-13b9-4b7d-b34c-65f175542176
md"""
**Remark.**
Pivoting can incorporate the interchange of both rows and columns.
**Complete** (or *maximal*) **pivoting** at the ``k``th step searches all the entries ``a_{ij}``, for ``i = k, k + 1, …, n`` and ``j = k, k + 1, …, n``, to find the entry with the largest magnitude.
Both row and column interchanges are performed to bring this entry to the pivot position.
The first step of total pivoting requires that ``n^2 - 1`` comparisons be performed, the second step requires ``(n - 1)^2 - 1`` comparisons, and so on.
The total additional time required to incorporate complete pivoting into Gaussian elimination is

$\sum_{k=2}^n (k^2 - 1) = \frac{n(n-1)(2n+5)}{6}$

comparisons.
Complete pivoting is, consequently, the strategy recommended only for systems where accuracy is essential and the amount of execution time needed for this method can be justified.
"""

# ╔═╡ b8948156-e93c-4da4-85d2-92b4fc0e9703
md"## 6.3 Linear Algebra and Matrix Inversion"

# ╔═╡ 699693d4-b360-4670-b2ff-4d58672d7f3e
md"""
**Remark.**
Matrices were introduced in Section 6.1 as a convenient method for expressing and manipulating linear systems.
In this section, we consider some algebra associated with matrices and show how it can be used to solve problems involving linear systems.
"""

# ╔═╡ ee0c05c8-41e2-454d-8455-aeb186ec51ba
md"""
**Definition 6.2**
Two matrices ``A`` and ``B`` are **equal** if they have the same number of rows and columns, say, ``n \times m``, and if ``a_{ij} = b_{ij}``, for each ``i = 1,2,…,n`` and ``j = 1,2,…,m``.
"""

# ╔═╡ f2935800-ba61-48a1-830d-019d0ea27ba4
md"### Matrix Arithmetic"

# ╔═╡ 29d3b04c-80b7-4267-95f9-4420e80c3934
md"""
**Remark.**
Two important operations performed on matrices are the sum of two matrices and the multiplication of a matrix by a real number.
"""

# ╔═╡ dd9bd6b7-6dd4-4cef-b91f-d644cd610788
md"### Matrix-Vector Products"

# ╔═╡ a6de4dd1-d8b2-4487-8e42-56de8a016168
md"""
**Remark.**
The product of matrices can also be defined in certain instances.
We will first consider the product of an ``n \times m`` matrix and a ``m \times 1`` column vector.
"""

# ╔═╡ 8522f0c1-64ff-4af6-bf09-a80a41bfdd55
md"### Matrix-Matrix Products"

# ╔═╡ 73f80ed3-e3ab-4416-b591-217bf2a9f319
md"""
**Remark.**
We can use matrix-vector multiplication to define general matrix-matrix multiplication.
"""

# ╔═╡ a76df0f1-d942-4f1d-b259-b2c3ad217caa
md"### Square Matrices"

# ╔═╡ a95bc88e-aaed-4564-86b2-70a84dc8fb53
md"""
**Remark.**
Matrices that have the same number of rows as columns are particularly important in applications.
"""

# ╔═╡ e8fa290a-9805-4c9b-9250-52323f4c6859
md"### Inverse Matrices"

# ╔═╡ 70f8cbb2-b736-458a-94fd-6307d280ffb6
md"""
**Remark.**
Related to the linear systems is the **inverse of a matrix**.
"""

# ╔═╡ 55cca44e-589a-44b8-8c60-0655f2314485
md"### Transpose of a Matrix"

# ╔═╡ 69c3c27f-679b-4750-9edf-f3f00ef3a980
md"""
**Remark.**
Another important matrix associated with a given matrix ``A`` is its *transpose*, denoted ``A'``.
"""

# ╔═╡ d9ef48b2-75eb-4465-80d0-cc4101d57441
md"## 6.4 The Determinant of a Matrix"

# ╔═╡ ad9d14e3-850e-4394-9324-dd0b8c11e216
md"""
**Remark.**
The *determinant* of a matrix provides existence and uniqueness results for linear systems having the same number of equations and unknowns.
We will denote the determinant of a square matrix ``A`` by ``\det{A}``, but it is also common to use the notation ``|A|``.
"""

# ╔═╡ 83d90676-8424-4230-aae8-18a58970177f
md"## 6.5 Matrix Factorization"

# ╔═╡ 0455e0c2-146a-4823-acab-230feb507ca6
md"""
**Remark.**
Gaussian elimination is the principal tool in the direct solution of linear systems of equations, so it should be no surprise that it appears in other guises.
In this section, we will see that the steps used to solve a system of the form ``A𝐱 = 𝐛`` can be used to factor a matrix.
The factorization is particularly useful when it has the form ``A = LU``, where ``L`` is lower triangular and ``U`` is upper triangular.
Although not all martices have this type of representation, many do that occur frequently in the application of numerical techniques.
"""

# ╔═╡ 4a80dc7d-1d42-4070-b570-e408134aa091
md"""
**Remark.**
In Section 6.1, we found that Gaussian elimination applied to an arbitrary linear system ``A𝐱 = 𝐛`` requires ``O(n^3/3)`` arithmetic operations to determine ``𝐱``.
However, solving a linear system that involves an upper-triangular system requires only backward substitution, which takes ``O(n^2)`` operations.
The number of operations required to solve a lower-triangular systems is similar.
"""

# ╔═╡ 8cf4f98c-ab95-4a0f-9f5a-9ea6e1c7daae
md"""
**Remark.**
Suppose that ``A`` has been factored into the triangular form ``A = LU``, where ``L`` is lower triangular and ``U`` is upper triangular.
Then we can solve for ``𝐱`` more easily by using a two-step process.

- First, we let ``𝐲 = U𝐱`` and solve the lower-triangular system ``L𝐲 = 𝐛`` for ``𝐲``.
  Since ``L`` is triangular, determining ``𝐲`` from this equation requires only ``O(n^2)`` operations.

- Once ``𝐲`` is known, the upper-triangular system ``U𝐱 = 𝐲`` requires only an additional ``O(n^2)`` operations to determine the solution ``𝐱``.

Solving a linear system ``A𝐱 = 𝐛`` in factored form means that the number of operations needed to solve the system ``A𝐱 = 𝐛`` is reduced from ``O(n^3/3)`` to ``O(2n^2)``.
"""

# ╔═╡ baa7dc04-74c7-492d-b78e-47ee868aaf36
md"""
**Example 1**
Compare the approximate number of operations required to determine the solution to a linear system using a technique requiring ``O(n^3/3)`` operations and one requiring ``O(2n^2)`` when ``n = 20``, ``n = 100``, and ``n = 1000``.

_**Solution**_
Table 6.3 gives the results of these calculations.
"""

# ╔═╡ c37d51d7-4cab-454d-b60f-0ee8fa07e42e
md"""
**Table 6.3**

| ``n`` | ``n^3 / 3`` | ``2n^2`` | ``\% \text{ Reduction}`` |
|-------|-------------|----------|-------------|
| ``10`` | ``3.\bar{3} \times 10^2`` | ``2 \times 10^2`` | ``40`` |
| ``100`` | ``3.\bar{3} \times 10^5`` | ``2 \times 10^4`` | ``94`` |
| ``1000`` | ``3.\bar{3} \times 10^8`` | ``2 \times 10^6`` | ``99.4`` |
"""

# ╔═╡ 069251e2-67c8-4336-8442-cd967b12db63
md"""
**Remark.**
As the example illusrtates, the reduction factor increases dramatically with the size of the matrix.
Not surprisingly, the reductions from the factorization come at a cost; determinng the specific matrices ``L`` and ``U`` requires ``O(n^3 / 3)`` operations.
But once factorization is determined, systems involving the matrix ``A`` can be solved in this simplified manner for any number of vectors ``𝐛``.
"""

# ╔═╡ c4facf43-2de0-457b-a8d7-2769fc6502c3
md"""
**Remark.**
To see which matrices have an ``LU`` factorization and to find how it is determined, first suppose that Gaussian elimination can be performed on the system ``A𝐱 = 𝐛`` without row interchanges.
With the notation in Section 6.1, this is equivalent to having nonzero pivot elements ``a_{ii}^{(i)}``, for each ``i = 1,2,…,n``.
"""

# ╔═╡ 55e46e5e-bf9a-4ae2-ba52-8799e2ff5cd2
md"""
**Remark.**
The first step in the Gaussian elimination process consists of performing, for each ``j = 2,3,…,n``, the operations

$(E_j - m_{j,1} E_1) → (E_j), \quad\text{where}\quad m_{j,1} = \frac{a_{j1}^{(1)}}{a_{11}^{(1)}}. \tag{6.8}$

These operations transform the system into one in which all the entries in the first column below the diagonal are zero.
"""

# ╔═╡ dd87b6c7-4f9b-4c0a-ae35-c64bc7d31c1c
md"""
**Remark.**
The system of operations in Eq. (6.8) can be viewed in another way.
It is simultaneously accomplished by multiplying the original matrix ``A`` on the left by the matrix

$M^{(1)} = \begin{bmatrix}
1 & 0 & ⋯ & ⋯ & 0 \\
-m_{21} & 1 & ⋱ & & ⋮ \\
⋮ & 0 & ⋱ & ⋱ & ⋮ \\
⋮ & ⋮ & ⋱ & ⋱ & 0 \\
-m_{n1} & 0 & ⋯ & 0 & 1 \\
\end{bmatrix}$

This is called **first Gaussian transformation matrix.**
We denote the product of this matrix with ``A^{(1)} ≡ A`` by ``A^{(2)}`` and with ``𝐛`` by ``𝐛^{(2)}``, so

$A^{(2)} 𝐱 = M^{(1)} A𝐱 = M^{(1)} 𝐛 = 𝐛^{(2)}.$
"""

# ╔═╡ 1812fa6e-dd19-44b7-971b-e3dfec362a12
md"""
**Remark.**
In a similar manner, we construct ``M^{(2)}``, the identity matrix with the entries below the diagonal in the second column replaced by the negatives of the multipliers

$m_{j,2} = \frac{a_{j2}^{(2)}}{a_{22}^{(2)}}.$

The product of this matrix with ``A^{(2)}`` has zeros below the diagonal in the first two columns, and we let

$A^{(3)} 𝐱 = M^{(2)} A^{(2)} 𝐱 = M^{(2)} M^{(1)} A 𝐱 = M^{(2)} M^{(1)} 𝐛 = 𝐛^{(3)}.$
"""

# ╔═╡ 80f3dac8-7a9c-4d8d-97fc-377ab84bf9a9
md"""
**Remark.**
In general, with ``A^{(k)} 𝐱 = 𝐛^{(k)}`` already formed, multiply by the **``k``th Gaussian transformation matrix**

$M^{(k)} = \begin{bmatrix}
1 & 0 & ⋯ & ⋯ & ⋯ & ⋯ & ⋯ & ⋯ & 0 \\
0 & ⋱ & ⋱ & & & & & & ⋮ \\
⋮ & ⋱ & ⋱ & ⋱ & & & & & ⋮ \\
⋮ &  & ⋱ & ⋱ & ⋱ & & & & ⋮ \\
⋮ &  &  & 0 & ⋱ & ⋱ & & & ⋮ \\
⋮ &  &  & ⋮ & -m_{k+1,k} & ⋱ & ⋱ & & ⋮ \\
⋮ &  &  & ⋮ & ⋮ & 0 & ⋱ & ⋱ & ⋮ \\
⋮ &  &  & ⋮ & ⋮ & ⋮ & ⋱ & ⋱ & 0 \\
0 & ⋯ & ⋯ & 0 & -m_{n,k} & 0 & ⋯ & 0 & 1 \\
\end{bmatrix}$

to obtain

$A^{(k+1)} 𝐱 = M^{(k)} A^{(k)} 𝐱 = M^{(k)} ⋯ M^{(1)}A 𝐱 = M^{(k)} 𝐛^{(k)} = 𝐛^{(k+1)} = M^{(k)} ⋯ M^{(1)} 𝐛. \tag{6.9}$

The process ends with the formation of ``A^{(n)} 𝐱 = 𝐛^{(n)}``, where ``A^{(n)}`` is the upper-triangular matrix

$A^{(n)} = \begin{bmatrix}
a_{11}^{(1)} & a_{12}^{(1)} & ⋯ & a_{1n}^{(1)} \\
0 & a_{22}^{(2)} & ⋱ & ⋮ \\
⋮ & ⋱ & ⋱ & a_{n-1,n}^{(n-1)} \\
0 & ⋯ & 0 & a_{nn}^{(n)} \\
\end{bmatrix}.$

given by

$A^{(n)} = M^{(n-1)} M^{(n-2)} ⋯ M^{(1)} A.$
"""

# ╔═╡ 73e4c6c5-6010-463b-b2b1-63a0d11551bd
md"""
**Remark.**
This process forms the ``U = A^{(n)}`` portion of the matrix factorization ``A = LU``.
To determine the complementary lower-triangular matrix ``L``, first recall the multiplication of ``A^{(k)} 𝐱 = 𝐛^{(k)}`` by the Gaussian transformation of ``M^{(k)}`` used to obtain Eq. (6.9):

$A^{(k+1)} 𝐱 = M^{(k)} A^{(k)} 𝐱 = M^{(k)} 𝐛^{(k)} = 𝐛^{(k+1)},$

where ``M^{(k)}`` generates the row operations

$(E_j - m_{j,k} E_k) → (E_j), \quad \text{ for} j = k + 1,…,n.$

To reverse the effects of this transformation and return to ``A^{(k)}`` requires that the operations ``(E_j + m_{j,k} E_k) → (E_j)`` be performed for each ``j = k + 1,…,n``.
This is equivalent to multiplying by the inverse of the matrix ``M^{(k)}``, the matrix

$L^{(k)} = [M^{(k)}]^{-1} = \begin{bmatrix}
1 & 0 & ⋯ & ⋯ & ⋯ & ⋯ & ⋯ & ⋯ & 0 \\
0 & ⋱ & ⋱ & & & & & & ⋮ \\
⋮ & ⋱ & ⋱ & ⋱ & & & & & ⋮ \\
⋮ &  & ⋱ & ⋱ & ⋱ & & & & ⋮ \\
⋮ &  &  & 0 & ⋱ & ⋱ & & & ⋮ \\
⋮ &  &  & ⋮ & m_{k+1,k} & ⋱ & ⋱ & & ⋮ \\
⋮ &  &  & ⋮ & ⋮ & 0 & ⋱ & ⋱ & ⋮ \\
⋮ &  &  & ⋮ & ⋮ & ⋮ & ⋱ & ⋱ & 0 \\
0 & ⋯ & ⋯ & 0 & m_{n,k} & 0 & ⋯ & 0 & 1 \\
\end{bmatrix}.$
"""

# ╔═╡ fde1a4c8-a2d3-4c9e-9b2e-bdb588ac2a8e
md"""
**Remark.**
The lower-triangular matrix ``L`` in the factorization of ``A``, then, is the product of the matrices ``L^{(k)}``:

$L = L^{(1)}L^{(2)} ⋯ L^{(n-1)} = \begin{bmatrix}
1 & 0 & ⋯ & 0 \\
m_{21} & 1 & ⋱ & ⋮ \\
⋮ & ⋱ & ⋱ & 0 \\
m_{n1} & ⋯ & m_{n,n-1} & 1 \\
\end{bmatrix},$

since the product of ``L`` with the upper-triangular matrix ``U = M^{(n-1)} ⋯ M^{(2)} M^{(1)} A`` gives

$\begin{align*}
LU &= L^{(1)}L^{(2)} ⋯ L^{(n-3)} L^{(n-2)} L^{(n-1)} ⋅ M^{(n-1)} M^{(n-2)} M^{(n-3)} ⋯ M^{(2)} M^{(1)} A \\
&= [M^{(1)}]^{-1} [M^{(2)}]^{-1} ⋯ [M^{(n-2)}]^{-1} [M^{(n-1)}]^{-1} ⋅ M^{(n-1)} M^{(n-2)} ⋯ M^{(2)} M^{(1)} A = A.
\end{align*}$

Theorem 6.19 follows from these observations.
"""

# ╔═╡ 5a265095-2a90-403b-be91-2fd8b1c752b4
md"""
**Theorem 6.19**
If Gaussian elimination can be performed on the linear system ``A𝐱 = 𝐛`` without row interchanegs, then the matrix ``A`` can be factored into the product of a lower-triangular matrix ``L`` and an upper-triangular matrix ``U``, that is, ``A = LU``, where ``m_{ji} = a_{ji}^{(i)} / a_{ii}^{(i)},``

$U = \begin{bmatrix}
a_{11}^{(1)} & a_{12}^{(1)} & ⋯ & a_{1n}^{(1)} \\
0 & a_{22}^{(2)} & ⋱ & ⋮ \\
⋮ & ⋱ & ⋱ & a_{n-1,n}^{(n-1)} \\
0 & ⋯ & 0 & a_{nn}^{(n)} \\
\end{bmatrix}, \quad \text{ and } \quad L = \begin{bmatrix}
1 & 0 & ⋯ & 0 \\
m_{21} & 1 & ⋱ & ⋮ \\
⋮ & ⋱ & ⋱ & 0 \\
m_{n1} & ⋯ & m_{n,n-1} & 1 \\
\end{bmatrix}.$
"""

# ╔═╡ 77ae36ef-966c-4d1b-a003-5accc7e68a4c
md"""
**Example 2**
**(a)** Determine the ``LU`` factorization for the matrix ``A`` in the linear system ``A𝐱 = 𝐛``, where

$A = \begin{bmatrix}
1 & 1 & 0 & 3 \\
2 & 1 & -1 & 1 \\
3 & -1 & -1 & 2 \\
-1 & 2 & 3 & -1
\end{bmatrix}
\quad\text{ and }\quad
𝐛 = \begin{bmatrix} 4 \\ 1 \\ -3 \\ 4 \end{bmatrix}.$

**(b)** Then use the factorization to solve the system

$\begin{array}{cccccccc}
x_1 &+ &x_2 & & &+ &3x_4 &= & 8, \\
2x_1 &+ &x_2 &- &x_3 &+ &x_4 &= & 7, \\
3x_1 &- &x_2 &- &x_3 &+ &2x_4 &= & 14, \\
-x_1 &+ &2x_2 &+ &3x_3 &- &x_4 &= & -7.
\end{array}$

_**Solution**_
**(a)**
The original system was considered in Section 6.1, where we saw that the sequence of operations ``(E_2 - 2E_1) → (E_2)``, ``(E_3 - 3E_1) → (E_3)``, ``(E_4 - (-1)E_1) → (E_4)``, ``(E_3 - 4E_2) → (E_3)``, ``(E_4 - (-3)E_2) → (E_4)`` converts the system to the triangular system

$\begin{array}{cccccccc}
x_1 &+ &x_2 & & &+ &3x_4 &= & 4, \\
 &- &x_2 &- &x_3 &- &5x_4 &= & -7, \\
 & & & &3x_3 &+ &13x_4 &= & 13, \\
 & & & & &- &13x_4 &= & -13.
\end{array}$

The multipliers ``m_{ij}`` and the upper triangular matrix produce the factorization

$A = \begin{bmatrix}
1 & 1 & 0 & 3 \\
2 & 1 & -1 & 1 \\
3 & -1 & -1 & 2 \\
-1 & 2 & 3 & -1
\end{bmatrix}
=
\begin{bmatrix}
1 & 0 & 0 & 0 \\
2 & 1 & 0 & 0 \\
3 & 4 & 1 & 0 \\
-1 & -3 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
1 & 1 & 0 & 3 \\
0 & -1 & -1 & -5 \\
0 & 0 & 3 & 13 \\
0 & 0 & 0 & -13
\end{bmatrix}
= LU.$

**(b)**
To solve

$A𝐱 = LU𝐱 = \begin{bmatrix}
1 & 0 & 0 & 0 \\
2 & 1 & 0 & 0 \\
3 & 4 & 1 & 0 \\
-1 & -3 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
1 & 1 & 0 & 3 \\
0 & -1 & -1 & -5 \\
0 & 0 & 3 & 13 \\
0 & 0 & 0 & -13
\end{bmatrix}
\begin{bmatrix}
x_1 \\ x_2 \\ x_3 \\ x_4
\end{bmatrix}
\begin{bmatrix}
8 \\ 7 \\ 14 \\ -7
\end{bmatrix},$

we first introduce the substitution ``𝐲 = U𝐱``.
Then ``𝐛 = L(U𝐱) = L𝐲``.
That is,

$L𝐲 = \begin{bmatrix}
1 & 0 & 0 & 0 \\
2 & 1 & 0 & 0 \\
3 & 4 & 1 & 0 \\
-1 & -3 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
y_1 \\ y_2 \\ y_3 \\ y_4
\end{bmatrix}
=
\begin{bmatrix}
8 \\ 7 \\ 14 \\ -7
\end{bmatrix}.$

This system is solved for ``𝐲`` by a simple forward-substitution process:

$\begin{align*}
y_1 &= 8; \\
2y_1 + y_2 &= 7, &&\text{ so } y_2 = 7 - 2y_1 = -9; \\
3y_1 + 4y_2 + y_3 &= 14, &&\text{ so } y_3 = 14 - 3y_1 - 4y_2 = 26; \\
-y_1 - 3y_2 + y_4 &= -7, &&\text{ so } y_4 = -7 + y_1 + 3y_2 = -26.
\end{align*}$

We then solve ``U𝐱 = 𝐲`` for ``𝐱``, the solution of the original system; that is,

$\begin{bmatrix}
1 & 1 & 0 & 3 \\
0 & -1 & -1 & -5 \\
0 & 0 & 3 & 13 \\
0 & 0 & 0 & -13
\end{bmatrix}
\begin{bmatrix}
x_1 \\ x_2 \\ x_3 \\ x_4
\end{bmatrix}
\begin{bmatrix}
8 \\ -9 \\ 26 \\ -26
\end{bmatrix}.$

Using backward-substitution, we obtain ``x_4 = 2``, ``x_3 = 0``, ``x_2 = -1``, ``x_1 = 3``.
"""

# ╔═╡ 5e331b26-0e1c-42be-a5d1-4ba745788e45
md"""
**Remark.**
The factorization used in Example 2 is called *Doolittle's method* and requires that 1s be on the diagonal of ``L``, which results in the factorization described in Theorem 6.19.
In Section 6.6, we consider *Crout's method*, a factorization method that requires 1s be on the diagonal elements of ``U``, and *Cholesky's method*, which requires that ``l_{ii} = u_{ii}``, for each ``i``.
"""

# ╔═╡ f5589be2-9f14-48e2-95e9-1970c4c6d9f3
md"""
**Remark.**
A general procedure for factoring matrices into a product of triangular matrices is contained in Algorithm 6.4.
Although new matrices ``L`` and ``U`` are constructed, the generated values can replace the corresponding entires of ``A`` that are no longer needed.
"""

# ╔═╡ 8ddeb153-e283-4226-b7d8-02c6b092ea45
md"""
**Remark.**
Algorithm 6.4 permits either the diagonal of ``L`` or the diagonal of ``U`` to be specified.
"""

# ╔═╡ e01e93f1-f0b7-4fda-8ac8-4ea516750171
md"""
!!! info "Algorithm 6.4: LU Factorization"

	To factor the ``n \times n`` matrix ``A = [a_{ij}]`` into the product of the lower-triangular matrix ``L = [l_{ij}]`` and the upper-triangular matrix ``U = [u_{ij}]``, that is, ``A = LU``, where the main diagonal of either ``L`` or ``U`` consists of all 1s:

	INPUT dimension ``n``; the entries ``a_{ij}``, ``1 ≤ i``, ``j ≤ n`` of ``A``; the diagonal ``l_{11} = ⋯ = l_{nn} = 1`` of ``L`` or the diagonal ``u_{11} = ⋯ = u_{nn} = 1`` of ``U``.

	OUTPUT the entries ``l_{ij}``, ``1 ≤ j ≤ i``, ``1 ≤ i ≤ n`` of ``L`` and the entries, ``u_{ij}``, ``i ≤ j ≤ n``, ``1 ≤ i ≤ n`` of ``U``.

	- *Step 1* Select ``l_{11}`` and ``u_{11}`` satisfying ``l_{11}u_{11} = a_{11}``.

	- *Step 2* For ``j = 2, …, n``

	  - set ``u_{1j} = a_{1j} / l_{11}``; (*First row of ``U``.*)

	  - set ``l_{j1} = a_{j1} / u_{11}``; (*First column of ``L``.*)

	- *Step 3* For ``i = 2, …, n - 1`` do Steps 4 and 5.

	  - *Step 4* Select ``l_{ii}`` and ``u_{ii}`` satisfying ``l_{ii} u_{ii} = a_{ii} - \sum_{k=1}^{i - 1} l_{ik} u_{ki}``.

	    - If ``l_{ii} u_{ii} = 0`` then OUTPUT ('Factorization impossible');

	      - STOP.

	  - *Step 5* For ``j = i + 1, …, n``

	    - set ``\displaystyle u_{ij} = \frac{1}{l_{ii}} \left[a_{ij} - \sum_{k=1}^{i-1} l_{ik} u_{kj}\right]``; (*``i``th row of ``U``.*)

	    - set ``\displaystyle l_{ji} = \frac{1}{u_{ii}} \left[a_{ji} - \sum_{k=1}^{i-1} l_{jk} u_{ki}\right]``; (*``i``th column of ``L``.*)

	- *Step 6* Select ``l_{nn}`` and ``u_{nn}`` satisfying ``l_{nn} u_{nn} = a_{nn} - \sum_{k=1}^{n - 1} l_{nk} u_{kn}``.

	  - (*Note: If ``l_{nn} u_{nn} = 0``, then ``A = LU`` but ``A`` is singular.*)

	- *Step 7*

	  - OUTPUT (``l_{ij}`` for ``j = 1, …, i`` and ``i = 1, …, n``);

	  - OUTPUT (``u_{ij}`` for ``j = i, …, n`` and ``i = 1, …, n``);

	  - STOP.
"""

# ╔═╡ 261fa7ab-377a-4629-9c17-813b96ff248e
md"""
**Remark.**
Once the matrix factorization is complete, the solution to a linear system of the form ``A𝐱 = LU𝐱 = 𝐛`` is found by first letting ``𝐲 = U𝐱`` and solving ``L𝐲 = 𝐛`` for ``𝐲``.
Since ``L`` is lower triangular, we have

$y_1 = \frac{b_1}{l_{11}},$

and, for each ``i = 2,3,…,n``,

$y_i = \frac{1}{l_{ii}} \left[b_i - \sum_{j=1}^{i-1} l_{ij} y_j\right].$

After ``𝐲`` is found by this forward-substitution process, the upper-triangular system ``U𝐱 = 𝐲`` is solved for ``𝐱`` by backward substitution using the equations

$x_n = \frac{y_n}{u_{nn}} \quad\text{and}\quad x_i = \frac{1}{u_{ii}} \left[y_i - \sum_{j=i+1}^n u_{ij} x_j\right].$
"""

# ╔═╡ 0c816bf9-db5f-46ee-8ef9-008ae9a8fa0d
md"### Permutation Matrices"

# ╔═╡ b270dfae-7956-4c7c-95be-b5b9248c9deb
md"""
**Remark.**
In the previous discussion, we assumed that ``A𝐱 = 𝐛`` can be solved using Gaussian elimination without row interchanges.
From a practical standpoint, this factorization is useful only when row interchanges are not required to control the round-off error resulting from the use of finite-digit arithmetic.
Fortunately, many systems we consider when using approximation methods are of this type, but we will now consider the modifications that must be made when row interchanges are required.
We begin the discussion with the introduction of a class of matrices that are used to rearrange, or permute, rows of a given matrix.
"""

# ╔═╡ be8ab057-88d3-4d27-947a-2075062a6051
md"""
**Remark.**
An ``n \times n`` **permutation matrix** ``P = [p_{ij}]`` is a matrix obtained by rearranging the rows of ``I_n``, the identity matrix.
This gives a matrix with precisely one nonzero entry in each row and in each column, and each nonzero entry is a 1.
"""

# ╔═╡ b9769822-adbc-4c8f-96ce-ff30728fdb5f
md"""
**Illustration**
The matrix

$P = \begin{bmatrix}
1 & 0 & 0 \\
0 & 0 & 1 \\
0 & 1 & 0
\end{bmatrix}$

is a ``3 \times 3`` permutation matrix.
For any ``3 \times 3`` matrix ``A``, multiplying on the left by ``P`` has the effect of interchanging the second and third rows of ``A``:

$PA = \begin{bmatrix}
1 & 0 & 0 \\
0 & 0 & 1 \\
0 & 1 & 0
\end{bmatrix}
\begin{bmatrix}
a_{11} & a_{12} & a_{13} \\
a_{21} & a_{22} & a_{23} \\
a_{31} & a_{32} & a_{33}
\end{bmatrix}
=
\begin{bmatrix}
a_{11} & a_{12} & a_{13} \\
a_{31} & a_{32} & a_{33} \\
a_{21} & a_{22} & a_{23} \\
\end{bmatrix}.$

Similarly, multiplying ``A`` on the right by ``P`` interchanges the second and third columns of ``A``.

Two useful properties of permutations matrices relate to Gaussian elimination, the first of which is illustrated in the previous example.
Suppose ``k_1,…,k_n`` is a permutation of the integers ``1,…,n`` and the permutation matrix ``P = (p_{ij})`` is defined by

$p_{ij} = \begin{cases}
1, &\text{if } j = k_i, \\
0, &\text{otherwise.}
\end{cases}$

Then

- ``PA`` permutes the rows of ``A``; that is,

  $PA = \begin{bmatrix}
  a_{k_1,1} & a_{k_1,2} & ⋯ & a_{k_1n} \\
  a_{k_2,1} & a_{k_2,2} & ⋯ & a_{k_2n} \\
  ⋮ & ⋮ & ⋱ & ⋮ \\
  a_{k_n,1} & a_{k_n,2} & ⋯ & a_{k_nn} \\
  \end{bmatrix}$

- ``P^{-1}`` exists and ``P^{-1} = P^t``.

At the end of Section 6.4, we saw that for any nonsingular matrix ``A``, the linear system ``A𝐱 = 𝐛`` can be solved by Gaussian elimination, with the possibility of row interchanges.
If we knew the row interchanges that were required to solve the system by Gaussian elimination, we could arrange the original equations in an order that would ensure that no row interchanges are needed.
Hence, there *is* a rearrangement of the equations in the system that permits Gaussian elimination to proceed *without row* interchanges.
This implies that for any nonsingular matrix ``A``, a permutation matrix ``P`` exists for which the system

$PA𝐱 = P𝐛$

can be solved without row interchanges.
As a consequence, this matrix ``PA`` can be factored into

$PA = LU,$

where ``L`` is lower triangular and ``U`` is upper triangular.
Because ``P^{-1} = P^t``, this produces the factorization

$A = P^{-1} LU = (P^t L)U.$

The matrix ``U`` is still upper triangular, but ``P^t L`` is not lower triangular unless ``P = I``.
"""

# ╔═╡ 5f4bfb0b-7641-4036-b03f-5484df878b6f
md"## 6.6 Special Types of Matrices"

# ╔═╡ 25f6299a-7a6c-496a-8c43-1448dd89499a
md"""
**Remark.**
We now turn attention to two classes of matrices for which Gaussian elimination can be performed effectively without row interchanges.
"""

# ╔═╡ 60ea49a1-a2f8-4c1b-85df-33d8385aa7b7
md"### Diagonally Dominant Matrices"

# ╔═╡ 9390e28d-ffec-44c1-8f25-a96f629fb26d
md"### Positive Definite Matrices"

# ╔═╡ 8b0316d5-e226-4d09-899b-523f44fcdee6
md"### Band Matrices"

# ╔═╡ 6bfbc150-cd65-4b34-914e-9ec60c0fb78d
md"### Tridiagonal Matrices"

# ╔═╡ d38bd2b2-be8f-4d54-a4fa-d104e88aa391
md"## 6.7 Numerical Software"

# ╔═╡ c256d357-5c32-4f62-8107-b5fa4848a5e9
md"""
**Remark.**
The software for matrix operations and the direct solution of linear systems implemented in IMSL and NAG is based on LAPACK, a subroutine package in the public domain.
There is excellent documentation available with it and from the books written about it.
We will focus on several of the subroutines that are available in all three sources.
"""

# ╔═╡ 3c344162-16ce-4187-b0ca-dc3a10ebfc47
md"""
**Remark.**
Accompanying LAPACK is a set of lower-level operations called Basic Linear Algebra Subprograms (BLAS).
Level 1 of BLAS generally consists of vector-vector operations, such as vector additions with input data and operations counts of ``O(n)``.
Level 2 consists of the matrix-vector operations, such as the product of a matrix and a vector with input data and operation counts of ``O(n^2)``.
Level 3 consists of the matrix-matrix operations, such as matrix products with input data and operation counts of ``O(n^3)``.
"""

# ╔═╡ 405f9714-8390-4ea1-9d20-87608db6df5c
md"""
**Remark.**
The subroutines in LAPACK for solving linear systems first factor the matrix ``A``.
The factorization depends on the type of matrix in the following way:

1. General matrix ``PA = LU``

2. Positive definite matrix ``A = LL^t``

3. Symmetric matrix ``A = LDL^t``

4. Tridiagonal matrix ``A = LU`` (in banded form)

In addition, inverses and determinants can be computed.
"""

# ╔═╡ 8be103ee-b8c0-47c8-9580-75ba4ce840e6
md"""
**Remark.**
The IMSL Library includes counterparts to almost all the LAPACK subroutines and some extensions as well.
The NAG Library has numerous subroutines for direct methods of solving linear systems similar to those in LAPACK and IMSL.
"""

# ╔═╡ aa85b624-7f2e-4283-86d2-081e6e240ac4
md"# 7 Iterative Techniques in Matrix Algebra"

# ╔═╡ 666e598e-b701-4d01-a898-6ad4f83dbc44
md"""
**Remark.**
Trusses are lightweight structures capable of carrying heavy loads.
In bridge design, the individual members of the truss are connected with rotable pin joints that permit forces to be transferred from one member of the truss to another.
The accompanying figure shows a truss that is held stationary at the lower left endpoint (1) is permitted to move horizontally at the lower right endpoint (4) and has pint joints at (1), (2), (3), and (4).
A load of 10,000 newtons (N) is placed at joint (3), and the resulting forces on the joints are given by ``f_1``, ``f_2``, ``f_3``, ``f_4``, and ``f_5``, as shown.
When positive, these forces indicate tension on the truss elements and, when negative, compression.
The stationary support member could have both a horizontal force component ``F_1`` and a vertical force component ``F_2``, but the movable support member has only a vertical force component ``F_3``.
"""

# ╔═╡ f97694d2-ae75-4dd8-aace-1564a27ff8bf
md"## 7.1 Norms of Vectors and Matrices"

# ╔═╡ 070973fb-1e32-499b-a757-973d43127759
md"""
**Remark.**
In Chapter 2, we described iterative techniques for finding roots of equations of the form ``f(x) = 0``.
An initial approximation (or approximations) was found, and new approximations are then determined based on how well the previous approximations satisfied the equation.
The objective is to find a way to minimize the difference between the approximations and the exact solution.
"""

# ╔═╡ 9abf2535-8373-4fa6-8042-9674f3fdc0b5
md"""
**Remark.**
To discuss iterative methods for solving linear systems, we first need to determine a way to measure the distance between ``n``-dimensional column vectors.
This will permit us to determine whether a sequence of vectors converges to a solution of the system.
"""

# ╔═╡ cf2cd405-da8b-4906-9c5b-b05d3e1b726c
md"""
**Remark.**
In actuality, this measure is also needed when the solution is obtained by the direct methods presented in Chapter 6.
Those methods required a large number of arithmetic operations, and using finite-digit arithmetic leads only to an approximation to an actual solution of the system.
"""

# ╔═╡ b41cd452-afd7-469c-b46e-15e28fbb391d
md"### Vector Norms"

# ╔═╡ c3f3954e-f1e1-44e9-ac71-356f2f555c36
md"""
**Remark.**
Let ``ℝ^n`` denote the set of all ``n``-dimensional column vectors with real-number components.
To define a distance in ``ℝ^n``, we use the notion of a norm, which is the generalization of the absolute value on ``ℝ``, the set of real numbers.
"""

# ╔═╡ 6c83602d-bf00-4336-9111-f128abc55520
md"""
**Definition 7.1**
A **vector norm** on ``ℝ^n`` is a function, ``\|⋅\|``, from ``ℝ^n`` into ``ℝ`` with the following properties:

1. ``\|𝐱\| ≥ 0`` for all ``𝐱 ∈ ℝ^n``,

2. ``\|𝐱\| = 0`` if and only if ``𝐱 = \bf{0}``,

3. ``\|α𝐱\| = |α|\|𝐱\|`` for all ``α ∈ ℝ`` and ``𝐱 ∈ ℝ^n``,

4. ``\|𝐱 + 𝐲\| ≤ \|𝐱\| + \|𝐲\|`` for all ``𝐱,𝐲 ∈ ℝ^n``.
"""

# ╔═╡ b4e5d5e2-9270-449c-ab04-52fc812bc38e
md"""
**Remark.**
Vectors in ``ℝ^n`` are column vectors, and it is convenient to use the transpose notation presented in Section 6.3 when a vector is represented in terms of its components.
For example, the vector

$𝐱 = \begin{bmatrix} x_1 \\ x_2 \\ ⋮ \\ x_n \end{bmatrix}$

will be written ``𝐱 = (x_1,x_2,…,x_n)^t``.
"""

# ╔═╡ a45bb2de-373e-48f1-bb21-67ff82b8ff54
md"""
**Remark.**
We will need only two specific norms on ``ℝ^n``, although a third norm on ``ℝ^n`` is presented in Exercise 9.
"""

# ╔═╡ 2047f6f7-907c-4ea4-8012-d240f639aa0d
md"""
**Definition 7.2**
The ``l_2`` and ``l_∞`` norms for the vector ``𝐱 = (x_1,x_2,…,x_n)^t`` are defined by

$\|𝐱\|_2 = \left\{\sum_{i=1}^n x_i^2 \right\}^{1/2} \quad\text{and}\quad \|𝐱\|_∞ = \max_{1 ≤ i ≤ n} |x_i|.$
"""

# ╔═╡ 8ad884c4-9431-4a14-b0e2-783996799f6e
md"""
**Remark.**
Note that each of these norms reduces to the absolute value in the case ``n = 1``.
"""

# ╔═╡ 520320e7-4d47-40ba-8596-7743247109a4
md"""
**Remark.**
The ``l_2`` norm is called the **Euclidean norm** of the vector ``𝐱`` because it represents the usual notion of distance from the origin in case ``𝐱`` is in ``ℝ^1 ≡ ℝ``, ``ℝ^2``, or ``ℝ^3``.
For example, the ``l_2`` norm of the vector ``𝐱 = (x_1,x_2,x_3)^t`` gives the length of the straight line joining the points ``(0,0,0)`` and ``(x_1,x_2,x_3)``.
Figure 7.1 shows the boundary of those vectors in ``ℝ^2`` and ``ℝ^3`` that have ``l_2`` norm less than 1.
Figure 7.2 is a similar illustration for the ``l_∞`` norm.
"""

# ╔═╡ 2ca239e1-9193-4e14-b200-9b011b094394
md"""
**Theorem 7.3 (Cauchy-Bunyakovsky-Schwarz Inequality for Sums)**
For each ``𝐱 = (x_1,x_2,…,x_n)^t`` and ``𝐲 = (y_1,y_2,…,y_n)^t`` in ``ℝ^n``,

$𝐱^t 𝐲 = \sum_{i=1}^n x_i y_i ≤ \left\{\sum_{i=1}^n x_i^2\right\}^{1/2} \left\{\sum_{i=1}^n y_i^2\right\}^{1/2} = \|𝐱\|_2 ⋅ \|𝐲\|_2. \tag{7.1}$
"""

# ╔═╡ 1292b300-8a1f-4cfd-8c9e-83bf6c47757b
md"### Distance between Vectors in ``ℝ^n``"

# ╔═╡ 48d247ea-e037-4316-81f7-27274eb0b9f9
md"""
**Remark.**
The norm of a vector gives a measure for the distance between an arbitrary vector and the zero vector, just as the absolute value of a real number describes its distance from ``0``.
Similarly, the **distance between two vectors** is defined as the norm of the difference of the vectors between two real numbers is the absolute value of their difference.
"""

# ╔═╡ da53cf75-ebff-4a81-b427-27c8f9081bc6
md"""
**Definition 7.4**
If ``𝐱 = (x_1,x_2,…,x_n)^t`` and ``𝐲 = (y_1,y_2,…,y_n)^t`` are vectors in ``ℝ^n``, the ``l_2`` and ``l_∞`` distances between ``𝐱`` and ``𝐲`` are defined by

$\|𝐱 - 𝐲\|_2 = \left\{\sum_{i=1}^n (x_i - y_i)^2\right\}\quad\text{and}\quad \|𝐱 - 𝐲\|_∞ = \max_{1 ≤ i ≤ n} |x_i - y_i|.$
"""

# ╔═╡ 4a49d982-61ab-4607-b80b-8dc7a37bc70d
md"""
**Remark.**
The concept of distance in ``ℝ^n`` is also used to define a limit of a sequence of vectors in this space.
"""

# ╔═╡ a5109c6c-b86d-4a2f-9616-4945b8cff95f
md"""
**Definition 7.5**
A sequence ``\{𝐱^{(k)}\}_{k=1}^∞`` of vectors in ``ℝ^n`` is said to **converge** to ``𝐱`` with respect to the norm ``\|⋅\|`` if, given any ``ε > 0``, there exists an integer ``N(ε)`` such that

$\|𝐱^{(k)} - 𝐱\| < ε, \quad\text{for all } k ≥ N(ε).$
"""

# ╔═╡ 171dc046-0062-44a9-b00a-a655cba1e0f7
md"""
**Theorem 7.5**
The sequence of vectors ``\{𝐱^{(k)}\}`` converges to ``𝐱`` in ``ℝ^n`` with respect to the ``l_∞`` norm if and only if ``\lim_{k → ∞} x_i^{(k)} = x_i``, for each ``i = 1, 2, …, n``.
"""

# ╔═╡ b9dd0400-8197-493d-bd96-4ac18cb2bf85
md"""
**Theorem 7.7**
For each ``𝐱 ∈ ℝ^n``,

$\|𝐱\|_∞ ≤ \|𝐱\|_2 ≤ \sqrt{n} \|𝐱\|_∞.$
"""

# ╔═╡ fced0846-7843-4843-bcaf-7c66f1674e79
md"### Matrix Norms and Distances"

# ╔═╡ c00cdd64-c9f4-4e63-833f-41cc43800278
md"""
**Remark.**
In the subsequent sections of this chapter and in later chapters, we will need methods for determining the distance between ``n \times n`` matrices.
This again requires the use of a norm.
"""

# ╔═╡ be2d592d-2d05-4b08-8488-453e5944f774
md"""
**Definition 7.8**
A **matrix norm** on the set of all ``n \times n`` matrices is a real-valued function, ``\|⋅\|``, defined on this set, satisfying for all ``n \times n`` matrices ``A`` and ``B`` and all real numbers ``α``:

1. ``\|A\| ≥ 0``;

2. ``\|A\| = 0``, if and only if ``A`` is ``O``, the matrix with all ``0`` entries;

3. ``\|αA\| = |α| \|A\|``;

4. ``\|A + B\| ≤ \|A\| + \|B\|``;

5. ``\|AB\| ≤ \|A\| \|B\|``.
"""

# ╔═╡ 2ebbb939-6174-4ae8-b062-78adf1c65fb5
md"""
**Remark.**
The **distance between ``n \times n`` matrices** ``A`` and ``B`` with respect to this matrix norm is ``\|A - B\|``.
"""

# ╔═╡ 592060ef-3492-482b-9b8e-d1f0278b0eb6
md"""
**Remark.**
Although matrix norms can be obtained in various ways, the norms considered most frequently are those that are natural consequences of the vector norms ``l_2`` and ``l_∞``.
"""

# ╔═╡ 19fb8f8f-182a-4568-a45a-c5cb5ea2c78a
md"""
**Remark.**
These norms are defined using the following theorem, whose proof is considered in Exercise 17.
"""

# ╔═╡ d8c7de07-b041-4524-8bf1-6c43d9ad16c2
md"""
**Theorem 7.9**
If ``\|⋅\|`` is a vector norm on ``ℝ^n``, then

$\|A\| = \max_{\|𝐱\| = 1} \|A𝐱\| \tag{7.2}$

is a matrix norm.
"""

# ╔═╡ 080c1020-ab8c-4ad6-a653-ccfd29a9faf7
md"""
**Remark.**
Matrix norms defined by vector norms are called the **natural**, or *induced*, **matrix norm** associated with the vector norm.
In this text, all matrix norms will be assumed to be natural matrix norms unless specified otherwise.
"""

# ╔═╡ cfe61e3b-159f-4db2-8e5c-03d1c3a5434c
md"""
**Remark.**
For any ``𝐳 ≠ 𝟎``, the vector ``𝐱 = 𝐳 / \|𝐳\|`` is a unit vector.
Hence,

$\max_{\|𝐱\| = 1} \|A𝐱\| = \max_{𝐳 ≠ 𝟎} \left\|A \left(\frac{𝐳}{\|𝐳\|}\right)\right\| = \max_{𝐳 ≠ 𝟎} \frac{\|A𝐳\|}{\|𝐳\|},$

and we can alternatively write

$\|A\| = \max_{𝐳 ≠ 𝟎} \frac{\|A𝐳\|}{\|𝐳\|}. \tag{7.3}$
"""

# ╔═╡ 33624853-aa8f-4829-bbe3-dda1fc6f458e
md"""
**Remark.**
The following corollary to Theorem 7.9 follows from this representation of ``\|A\|``.
"""

# ╔═╡ 8bb3c3a9-872c-4f81-b27d-2209d8dbe4eb
md"""
**Corollary 7.10**
For any vector ``𝐳 ≠ 𝟎``, matrix ``A``, and any natural norm ``\|⋅\|``, we have

$\|A𝐳\| ≤ \|A\| ⋅ \|𝐳\|.$
"""

# ╔═╡ 95e77bb6-a1d9-41f9-8aa4-e0e247de092f
md"""
**Remark.**
The measure given to a matrix under a natural norm describes how the matrix stretches unit vectors relative to that norm.
The maximum stretch is the norm of the matrix.
The matrix norms we will consider have the forms

$\|A\|_∞ = \max_{\|𝐱\|_∞ = 1} \|A𝐱\|_∞, \quad\text{the } l_∞ \text{ norm},$

and

$\|A\|_2 = \max_{\|𝐱\|_2 = 1} \|A𝐱\|_2, \quad\text{the } l_2 \text{ norm}.$
"""

# ╔═╡ b3945280-406f-4ec4-8d8b-2003db0f9a61
md"""
**Remark.**
An illustration of these norms when ``n = 2`` is shown in Figures 7.4 and 7.5 for the matrix

$A = \begin{bmatrix} 0 & -2 \\ 2 & 0 \end{bmatrix}.$
"""

# ╔═╡ 9b916bbe-563f-4d9b-be7f-6b2d041e228e
md"""
**Remark.**
The ``l_∞`` norm of a matrix can be easily computed from the entries of the matrix.
"""

# ╔═╡ c8b4ccdf-3c55-448c-bb26-d300a17567ac
md"""
**Theorem 7.11**
If ``A = (a_{ij})`` is an ``n \times n`` matrix, then ``\displaystyle \|A\|_∞ = \max_{1 ≤ i ≤ n} \sum_{j=1}^n |a_{ij}|``.
"""

# ╔═╡ cc35232d-0811-4e0b-9900-b53fae5f0af5
md"## 7.2 Eigenvalues and Eigenvectors"

# ╔═╡ 83e0a811-8e7b-44c4-94f9-39a9ac77fbd3
md"""
**Remark.**
An ``n \times m`` matrix can be considered as a function that uses matrix multiplication to take ``m``-dimensional column vectors into ``n``-dimensional column vectors.
"""

# ╔═╡ 4305503d-5700-437a-9167-d56f204bd065
md"""
**Definition 7.12**
If ``A`` is a square matrix, the **characteristic polynomial** of ``A`` is defined by

$p(λ) = \det(A - λI).$
"""

# ╔═╡ 20da5ed1-81ee-48ca-a355-ae76febbc68d
md"""
**Remark.**
It is not difficult to show (see Exercise 15) that ``p`` is an ``n``th-degree polynonmial and, consequently, has at most ``n`` distinct zeros, some of which might be complex.
"""

# ╔═╡ 3e54cc92-e1a5-4e5c-bfb1-423aa82aaa8a
md"""
**Definition 7.13**
If ``p`` is the characteristic polynomial of the matrix ``A``, the zeros of ``p`` are called **eigenvalues**, or characteristic values, of the matrix ``A``.
If ``λ`` is an eigenvalue of ``A`` and ``𝐱 ≠ 𝟎`` satisfies ``(A - λI)𝐱 = 𝟎``, then ``𝐱`` is an **eigenvector**, or characteristic vector, of ``A`` corresponding to the eigenvalue ``λ``.
"""

# ╔═╡ a3e9aabb-b904-44b0-a5fd-8531a54459be
md"### Spectral Radius"

# ╔═╡ b154ce77-af41-4f84-b998-c5fec1e6b19c
md"""
**Definition 7.14**
The **spectral radius** ``ρ(A)`` of a matrix ``A`` is defined by

$ρ(A) = \max|λ|, \quad\text{where } λ \text{ is an eigenvalue of } A.$

(For complex ``λ = α + βi``, we define ``|λ| = (α^2 + β^2)^{1/2}``.)
"""

# ╔═╡ a87127bc-a78e-49a5-9498-aa428a613b18
md"""
**Theorem 7.15**
If ``A`` is an ``n \times n`` matrix, then

1. ``\|A\|_2 = [ρ(A^t A)]^{1/2}``,

2. ``ρ(A) ≤ \|A\|``, for any natural norm ``\|⋅\|``.
"""

# ╔═╡ 3744a8c4-06c5-4a8f-ae74-9e8071672249
md"### Convergent Matrices"

# ╔═╡ f70c0587-4b42-4262-8b55-dcd085dd776c
md"""
**Remark.**
In studying iterative matrix techniques, it is of particular importance to know when powers of a matrix become small (that is, when all the entries approach zero).
Matrices of this type are called *convergent*.
"""

# ╔═╡ 4e6c20f1-e307-471b-a327-edcec6b01fae
md"""
**Definition 7.16**
We call an ``n \times n`` matrix ``A`` **convergent** if

$\lim_{k → ∞} (A^k)_{ij} = 0, \quad\text{for each } i = 1, 2, …, n \text{ and } j = 1, 2, …, n.$
"""

# ╔═╡ aaf2dbf5-081d-4d6c-becf-39cfdfd56db1
md"## 7.3 The Jacobi and Gauss-Siedel Iterative Techniques"

# ╔═╡ be63f24c-b38e-4c4c-863e-06d2fe45869a
md"""
**Remark.**
In this section, we describe the Jacobi and Gauss-Seidel iterative methods, classic methods that date to the late 18th century.
Iterative techniques are seldom used for solving linear systems of small dimension since the time required for sufficient accuracy exceeds that required for direct techniques, such as Gaussian elimination.
For large systems with a high percentage of ``0`` entries, however, these techniques are efficient in terms of both computer storage and computation.
Systems of this type arise frequently in circuit analysis and in the numerical solution of boundary-value problems and partial-differential equations.
"""

# ╔═╡ 7cb67a58-8758-499d-aa2a-601bb4aef308
md"""
**Remark.**
An iterative technique to solve the ``n \times n`` linear system ``A𝐱 = 𝐛`` starts with an initial approximation ``𝐱^{(0)}`` to the solution and generates a sequence of vectors ``\{𝐱^{(k)}\}_{k=0}^∞`` that converge to ``𝐱``.
"""

# ╔═╡ 4a1451ea-c144-4fc1-9d1c-ab7d482567a8
md"### Jacobi's Method"

# ╔═╡ ad26e1ac-9cd6-4971-8d71-e5df6376dcaf
md"""
**Remark.**
The **Jacobi iterative method** is obtained by solving the ``i``th equation in ``A𝐱 = 𝐛`` for ``x_i`` to obtain (provided ``a_{ii} ≠ 0``)

$x_i = \sum_{\substack{j = 1 \\ j ≠ i}}^n \left(-\frac{a_{ij} x_j}{a_{ii}}\right) + \frac{b_i}{a_{ii}}, \quad\text{ for } i = 1, 2, …, n.$

For each ``k ≥ 1``, generate the components ``x_i^{(k)}`` of ``𝐱^{(k)}`` from the components of ``𝐱^{(k-1)}`` by

$x_i^{(k)} = \frac{1}{a_{ii}} \left[\sum_{\substack{j = 1 \\ j ≠ i}}^n \left(-a_{ij} x_j^{(k-1)}\right) + b_i\right], \quad\text{ for } i = 1, 2, …, n. \tag{7.5}$
"""

# ╔═╡ 6020c18a-35be-4095-bed3-1ed63068ee88
md"""
**Remark.**
In general, iterative techniques for solving linear systems involve a process that converts the system ``A𝐱 = 𝐛`` into an equivalent system of the form ``𝐱 = T𝐱 + 𝐜`` for some fixed matrix ``T`` and vector ``𝐜``.
After the initial vector ``𝐱^{(0)}`` is selected, the sequence of appropriate solution vectors is generated by computing

$𝐱^{(k)} = T𝐱^{(k-1)} + 𝐜,$

for each ``k = 1,2,3,…,.``
This should be reminiscent of the fixed-point iteration studied in Chapter 2.
"""

# ╔═╡ c0e67789-de3f-4b46-850a-d0bb79a9c925
md"""
**Remark.**
The Jacobi method can be written in the form ``𝐱^{(k)} = T𝐱^{(k-1)} + 𝐜`` by splitting ``A`` into its diagonal and off-diagonal parts.
To see this, let ``D`` be the diagonal matrix whose diagonal entries are those of ``A``, ``-L`` be the strictly lower-triangular part of ``A``, and ``-U`` be the strictly upper-triangular part of ``A``.
With this notation,

$A = \begin{bmatrix}
a_{11} & a_{12} & ⋯ & a_{1n} \\
a_{21} & a_{22} & ⋯ & a_{2n} \\
⋮ & ⋮ & & ⋮ \\
a_{n1} & a_{n2} & ⋯ & a_{nn}
\end{bmatrix}$

is split into

$\begin{align*}
A &= \begin{bmatrix}
a_{11} & 0 & ⋯ & 0 \\
0 & a_{22} & ⋱ & ⋮ \\
⋮ & ⋱ & ⋱ & 0 \\
0 & ⋯ & 0 & a_{nn}
\end{bmatrix} - \begin{bmatrix}
0 & ⋯ & ⋯ & 0 \\
-a_{21} & ⋱ &  & ⋮ \\
⋮ & & ⋱ & ⋮ \\
-a_{n1} & ⋯ & -a_{n,n-1} & 0
\end{bmatrix} - \begin{bmatrix}
0 & -a_{12} & ⋯ & -a_{1n} \\
⋮ & ⋱ & ⋱ & ⋮ \\
⋮ & & ⋱ & -a_{n-1,n} \\
0 & ⋯ & ⋯ & 0
\end{bmatrix} \\
&= D - L - U.
\end{align*}$
"""

# ╔═╡ 5a0380c5-366c-49f2-85ab-a556605a18ac
md"""
**Remark.**
The equation ``A𝐱 = 𝐛``, or ``(D - L - U)𝐱 = 𝐛``, is then transformed into

$D𝐱 = (L + U)𝐱 + 𝐛,$

and, if ``D^{-1}`` exists, that is, if ``a_{ii} ≠ 0`` for each ``i``, then

$𝐱 = D^{-1}(L + U)𝐱 + D^{-1}𝐛.$

This results in the matrix form of the Jacobi iterative technique:

$𝐱^{(k)} = D^{-1}(L + U)𝐱^{(k - 1)} + D^{-1}𝐛, \quad k = 1, 2, … . \tag{7.6}$

Introducing the notation ``T_j = D^{-1}(L + U)`` and ``𝐜_j = D^{-1} 𝐛`` gives the Jacobi technique the form

$𝐱^{(k)} = T_j 𝐱^{(k-1)} + 𝐜_j . \tag{7.7}$

In practice, Eq. (7.5) is used in computation and Eq. (7.7) for theoretical purposes.
"""

# ╔═╡ d36a9b12-9d42-4fef-94ca-3150152c851b
md"### The Gauss-Seidel Method"

# ╔═╡ 4c924509-8a7e-467b-8420-c51c1e5f15d9
md"""
**Remark.**
A possible improvement in Algorithm 7.1 can be seen by reconsidering Eq. (7.5).
The components of ``𝐱^{(k-1)}`` are used to compute all the components ``x_i^{(k)}`` of ``𝐱^{(k)}``.
But, for ``i > 1``, the components ``x_1^{(k)}, …, x_{i-1}^{(k)}`` of ``𝐱^{(k)}`` have already been computed and are expected to be better approximations to the actual solutions ``x_1,…,x_{i-1}`` than are ``x_1^{(k-1)}, …, x_{i-1}^{(k-1)}``.
It seems reasonable, then, to compute ``x_i^{(k)}`` using these most recently calculated values.
That is, to use

$x_i^{(k)} = \frac{1}{a_{ii}} \left[-\sum_{j=1}^{i-1} (a_{ij} x_j^{(k)}) - \sum_{j = i + 1} (a_{ij} x_j^{(k-1)}) + b_i\right], \tag{7.8}$

for each ``i = 1, 2, …, n``, instead of Eq. (7.5).
This modification is called the **Gauss-Seidel iterative technique** and is illustrated in the following example.
"""

# ╔═╡ 1ebb00ff-c487-4eb2-83a8-a4176778b675
md"### General Iteration Methods"

# ╔═╡ 47232258-df69-4bff-be76-6943e964f634
md"""
**Remark.**
To study the convergence of general iteration techniques, we need to analyze the formula

$𝐱^{(k)} = T𝐱^{(k-1)} + 𝐜, \quad\text{for each } k = 1, 2, …,$

where ``𝐱^{(0)}`` is arbitrary.
The next lemma and Theorem 7.17 on page 454 provide the key for this study.
"""

# ╔═╡ a9356cb0-0244-4841-9902-d1084811ea92
md"""
**Lemma 7.18**
If the spectral radius satisfies ``ρ(T) < 1``, then ``(I - T)^{-1}`` exists, and

$(I - T)^{-1} = I + T + T^2 + ⋯ = \sum_{j=0}^∞ T^j.$
"""

# ╔═╡ f6f5b606-2133-47ca-8aae-a596ea99e276
md"""
**Theorem 7.19**
For any ``𝐱^{(0)} ∈ ℝ^n``, the sequence ``\{𝐱^{(k)}\}_{k=0}^∞`` defined by

$𝐱^{(k)} = T𝐱^{(k-1)} + 𝐜, \quad\text{ for each } k ≥ 1, \tag{7.11}$

converges to the unique solution of ``𝐱 = T𝐱 + 𝐜`` if and only if ``ρ(T) < 1``.
"""

# ╔═╡ 0000333d-e9bb-4484-9199-586d717c1843
md"""
**Corollary 7.20**
If ``\|T\| < 1`` for any natural matrix norm and ``𝐜`` is a given vector, then the sequence ``\{𝐱^{(k)}\}_{k=0}^∞`` defined by ``𝐱^{(k)} = T𝐱^{(k-1)} + 𝐜`` converges, for any ``𝐱^{(0)} ∈ ℝ^n``, to a vector ``𝐱 ∈ ℝ^n``, with ``𝐱 = T𝐱 + 𝐜``, and the following error bounds hold:

$\bf{(i)} \quad \|𝐱 - 𝐱^{(k)}\| ≤ \|T\|^k \|𝐱^{(0)} - 𝐱\|; \quad \bf{(ii)} \quad \|𝐱 - 𝐱^{(k)}\| ≤ \frac{\|T\|^k}{1 - \|T\|} \|𝐱^{(1)} - 𝐱^{(0)}\|.$
"""

# ╔═╡ 096fbb85-c0db-4a7c-9e95-519057a6aaed
md"""
**Theorem 7.21**
If ``A`` is strictly diagonally dominant, then for any choice of ``𝐱^{(0)}``, both the Jacobi and Gauss-Siedel methods give sequences ``\{𝐱^{(k)}\}_{k=0}^∞`` that converge to the unique solution of ``A𝐱 = 𝐛``.
"""

# ╔═╡ 80a95ee2-0a3e-4205-aed1-6c6e98d8ee49
md"## 7.4 Relaxation Techniques for Solving Linear Systems"

# ╔═╡ 9a07986d-748f-410e-9079-7c7d7586ad76
md"""
**Remark.**
We saw in Section 7.3 that the rate of convergence of an iterative technique depends on the spectral radius of the matrix associated with the method.
One way to select a procedure to accelerate convergence is to choose a method whose associated matrix has minimal spectral radius.
Before describing a procedure for selecting such a method, we need to introduce a new means of measuring the amount by which an approximation to the solution to a linear system differs from the true solution to the system.
The method makes use of the vector described in the following definition.
"""

# ╔═╡ 4b772541-c056-4f27-89ae-5e9e0efbae98
md"""
**Definition 7.23**
Suppose ``\tilde{𝐱} ∈ ℝ^n`` is an approximation to the solution of the linear system defined by ``A𝐱 = 𝐛``.
The **residual vector** for ``\tilde{𝐱}`` with respect to this system is ``𝐫 = 𝐛 - A\tilde{x}``.
"""

# ╔═╡ a5e89c36-df36-49b5-aff9-b638ce2c9580
md"## 7.5 Error Bounds and Iterative Refinement"

# ╔═╡ 7a894ea5-7fcd-4432-bc8f-f1032e5c2040
md"""
**Remark.**
It seems intuitively reasonable that if ``\tilde{𝐱}`` is an approximation to the solution ``𝐱`` of ``A𝐱 = 𝐛`` and the residual vector ``𝐫 = 𝐛 - A\tilde{𝐱}`` has the property that ``\|𝐫\|`` is small, then ``\|𝐱 - \tilde{𝐱}\|`` would be small as well.
This is often the case, but certain systems, which occur frequently in practice, fail to have this property.
"""

# ╔═╡ 8ed3b461-dab3-477e-a757-56f6b31dbdeb
md"""
**Theorem 7.27**
Suppose that ``\tilde{𝐱}`` is an approximation to the solution of ``A𝐱 = 𝐛``, ``A`` is a nonsingular matrix, and ``𝐫`` is the residual vector for ``\tilde{𝐱}``.
Then, for any natural norm,

$\|𝐱 - \tilde{𝐱}\| ≤ \|𝐫\| ⋅ \|A^{-1}\|,$

and if ``𝐱 ≠ 𝟎`` and ``𝐛 ≠ 𝟎``,

$\frac{\|𝐱 - \tilde{𝐱}\|}{\|𝐱\|} ≤ \|A\| ⋅ \|A^{-1}\| \frac{\|𝐫\|}{\|𝐛\|}. \tag{7.20}$
"""

# ╔═╡ 305f9f1f-7a17-46d0-854e-9a41085f8c41
md"### Condition Numbers"

# ╔═╡ c02e4e1f-10ea-4cf1-90cd-b6d170e46323
md"""
**Remark.**
The inequalities in Theorem 7.27 imply that ``\|A^{-1}\|`` and ``\|A\| ⋅ \|A^{-1}\|`` provide an indication of the connection between the residual vector and the accuracy of the approximation.
In general, the relative error ``\|𝐱 - \tilde{𝐱}\| / \|𝐱\|`` is of most interest, and, by Inequality (7.20), this error is bounded by the product of ``\|A\| ⋅ \|A^{-1}\|`` with the relative residual for this approximation, ``\|𝐫\| / \|𝐛\|``.
Any convenient norm can be used for this approximation; the only requirement is that it be used consistently throughout.
"""

# ╔═╡ b403dab9-5e68-48f6-b03f-30b2893fb004
md"""
**Definition 7.28**
The **condition number** of the nonsingular matrix ``A`` relative to a norm ``\|⋅\|`` is

$K(A) = \|A\| ⋅ \|A^{-1}\|.$
"""

# ╔═╡ 09624c51-d07b-43ba-8024-5750dc260153
md"""
**Remark.**
With this notation, the inequalities in Theorem 7.27 become

$\|𝐱 - \tilde{𝐱}\| ≤ K(A) \frac{\|𝐫\|}{\|A\|}$

and

$\frac{\|𝐱 - \tilde{𝐱}\|}{\|𝐱\|} ≤ K(A) \frac{\|𝐫\|}{\|𝐛\|}.$
"""

# ╔═╡ f6eb99e7-fa84-4608-9b53-dddb06b18027
md"## 7.6 The Conjugate Gradient Method"

# ╔═╡ 5fcbeea1-7207-4b17-ba96-20e7b0a41107
md"""
**Remark.**
The conjugate gradient method of Hestenes and Stiefel [HS] was originally developed as a direct method designed to solve an ``n \times n`` positive definite linear system.
As a direct method, it is generally inferior to Gaussian elimination with pivoting.
Both methods require ``n`` steps to determine a solution, and the steps of the conjugate gradient method are more computationally expensive than those of Gaussian elimination.
"""

# ╔═╡ ef4ea9bb-dfb3-4330-80b3-a582c2ecca35
md"""
**Remark.**
However, the conjugate gradient method is useful when employed as an iterative approximation method for solving large sparse systems with nonzero entries occurring in predictable patterns.
"""

# ╔═╡ 5b8d0390-1f74-4a6a-b202-14a10cb69ba8
md"""
**Remark.**
Throughout this section, we assume that the matrix ``A`` is positive definite.
We will use the *inner product* notation

$⟨𝐱, 𝐲⟩ = 𝐱^t 𝐲, \tag{7.26}$

where ``𝐱`` and ``𝐲`` are ``n``-dimensional vectors.
We will also need some additional standard results from linear algebra.
A review of this material is found in Section 9.1.
"""

# ╔═╡ c446eefc-80a7-4a4b-810f-cacb68f4bdef
md"""
**Theorem 7.30**
For any vectors ``𝐱``, ``𝐲``, and ``𝐳`` and any real number ``α``, we have

1. ``⟨𝐱,𝐲⟩ = ⟨𝐲,𝐱⟩``;

2. ``⟨α𝐱,𝐲⟩ = ⟨𝐱,α𝐲⟩ = α⟨𝐱,𝐲⟩``;

3. ``⟨𝐱 + 𝐳, 𝐲⟩ = ⟨𝐱,𝐲⟩ + ⟨𝐳,𝐲⟩``;

4. ``⟨𝐱,𝐱⟩ ≥ 0``;

5. ``⟨𝐱,𝐱⟩ = 0`` if and only if ``𝐱 = 𝟎``.
"""

# ╔═╡ 8c439332-b79f-4092-a50e-3cf6d8281686
md"""
**Theorem 7.31**
The vector ``𝐱^*`` is a solution to the positive definite linear system ``A𝐱 = 𝐛`` if and only if ``𝐱^*`` produces the minimal value of

$g(𝐱) = ⟨𝐱, A𝐱⟩ - 2⟨𝐱,𝐛⟩.$
"""

# ╔═╡ bd566391-a1b9-4614-b9a7-6a0a9217cf44
md"""
**Theorem 7.32**
Let ``\{𝐯^{(1)}, …, 𝐯^{(n)}\}`` be an ``A``-orthogonal set of nonzero vectors associated with the positive definite matrix ``A`` and let ``𝐱^{(0)}`` be arbitrary.
Define

$t_k = \frac{⟨𝐯^{(k)}, 𝐛 - A𝐱^{(k-1)}⟩}{⟨𝐯^{(k)},A𝐯^{(k)}⟩} \quad\text{and}\quad 𝐱^{(k)} = 𝐱^{(k-1)} + t_k 𝐯^{(k)},$

for ``k = 1,2,…,n``.
Then, assuming exact arithmetic, ``A𝐱^{(n)} = 𝐛``.
"""

# ╔═╡ 500506be-dd52-4cb0-8e27-fc1f385ecc15
md"## 7.7 Numerical Software"

# ╔═╡ 72dfae42-fde8-4fb0-b454-427aeb18892e
md"# 8 Approximation Theory"

# ╔═╡ 701baaaf-b0ea-4e42-b778-0df9a1283919
md"""
**Remark.**
Hooke's law states that when a force is applied to a spring constructed of uniform material, the length of the spring is a linear function of that force.
We can write the linear function as ``F(l) = k(l - E)``, where ``F(l)`` represents the force required to stretch the spring ``l`` units, the constant ``E`` represents the length of the spring with no force applied, and the constant ``k`` is the spring constant.
"""

# ╔═╡ 9bba7823-5247-4770-91b0-b0dbbd77580a
md"""
**Remark.**
Suppose we want to determine the spring constant for a spring that has initial length 5.3 in.
We apply forces of 2, 4, and 6 lb to the spring and find that its length increases to 7.0, 9.4, and 12.3 in, respectively.
A quick examination shows that the points (0, 5.3), (2, 7.0), (4, 9.4), and (6, 12.3) do not quite lie in a straight line.
Although we could use a random pair of these data points to approximate the spring constant, it would seem more reasonable to find the line that *best* approximates all the data points to determine the constant.
This type of approximation will be considered in this chapter, and this spring application can be found in Exercise 7 of Section 8.1.
"""

# ╔═╡ 955d3329-832f-4c7a-8493-cccb7e274384
md"""
**Remark.**
Approximation theory involves two general types of problems.
One problem arises when a function is given explicitly but we wish to find a "simpler" type of function, such as a polynomial, to approximate values of the given function.
The other problem in approximation theory is concerned with fitting functions to given data and finding the "best" function in a certain class to represent the data.
"""

# ╔═╡ 95a6b60b-59c0-4eba-8101-6ddfba56f49c
md"## 8.1 Discrete Least Squares Approximation"

# ╔═╡ 81351d16-4b2c-43c4-9cd4-d7ae29fbec41
md"""
**Remark.**
Consider the problem of estimating the values of a function at nontabulated points, given the experimental data in Table 8.1.
"""

# ╔═╡ 961b2d3f-ee7a-4818-8154-9f2abff21794
md"""
**Remark.**
Figure 8.1 shows a graph of the values in Table 8.1.
From this graph, it appears that the actual relationship between ``x`` and ``y`` is linear.
The likely reason that no line precisely fits the data is because of the errors in the data.
So, it is unreasonable to require that the approximating function agree exactly with the data.
In fact, such a function would introduce oscillations that were not originally present.
For example, the graph of the ninth-degree interpolating polynomial shown in unconstrained mode for the data in Table 8.1 is shown in Figure 8.2.
"""

# ╔═╡ d5516080-b06a-4ea0-a0bb-f48783cbd546
md"""
**Remark.**
This polynomial is clearly a poor predictor of information between a number of the data points.
A better approach would be to find the "best" (in some sense) approximating line, even if it does not agree precisely with the data at any point.
"""

# ╔═╡ 98eb69c7-7ae4-4dc1-854a-ce620bcbcfd9
md"""
**Remark.**
Let ``a_1 x_i + a_0`` denote the ``i``th value on the approximating line and ``y_i`` be the ``i``th given ``y``-value.
We assume throughout that the independent variables, the ``x_i``, are exact; it is the dependent variables, the ``y_i``, that are suspect.
This is a reasonable assumption in most experimental situations.
"""

# ╔═╡ afcca1b0-346e-40de-ad31-7f5d51c30780
md"""
**Remark.**
The problem of finding the equation of the best linear approximation in the absolute sense requires that values of ``a_0`` and ``a_1`` be found to minimize

$E_∞(a_0,a_1) = \max_{1 ≤ i ≤ 10} \{|y_i - (a_1 x_i + a_0)|\}.$

This is commonly called a **minimax** problem and cannot be handled by elementary techniques.
"""

# ╔═╡ ed3f095d-d0d9-4b26-8b75-be0ffd7114d5
md"""
**Remark.**
Another approach to determining the best linear approximation involves finding values of ``a_0`` and ``a_1`` to minimize

$E_1(a_0, a_1) = \sum_{i=1}^{10} |y_i - (a_1 x_i + a_0)|.$

This quantity is called the **absolute deviation**.
To minimize a function of two variables, we need to set its partial derivatives to zero and simultaneously solve the resulting equations.
In the case of the absolute deviation, we need to find ``a_0`` and ``a_1`` with

$0 = \frac{∂}{∂a_0} \sum_{i = 1}^{10} |y_i - (a_1 x_i + a_0)| \quad\text{and}\quad 0 = \frac{∂}{∂a_1} \sum_{i=1}^{10} |y_i - (a_1 x_i + a_0)|.$

The problem is that the absolute-value function is not differentiable at zero, and we might not be able to find solutions to this pair of equations.
"""

# ╔═╡ 2dba3402-8875-4632-9517-df90069fcd1e
md"### Linear Least Squares"

# ╔═╡ 505438a2-faaf-4244-b57d-dd89fd16e128
md"""
**Remark.**
The **least squares** approach to this problem involves determining the best approximating line when the error involved is the sum of the squares of the differences between the ``y``-values on the approximating line and the given ``y``-values.
Hence, constants ``a_0`` and ``a_1`` must be found that minimize the least squares error:

$E_2(a_0,a_1) = \sum_{i=1}^{10} [y_i - (a_1 x_i + a_0)]^2.$
"""

# ╔═╡ ba05577d-6ffd-478b-9331-a81435bee7e6
md"""
**Remark.**
The least squares method is the most convenient procedure for determining best linear approximations, but there are also important theoretical considerations that favor it.
"""

# ╔═╡ 9fce7bd0-e96a-4002-8840-3b5e976fcd87
md"""
**Remark.**
The general problem of fitting the best least squares line to a collection of data ``\{(x_i,y_i)\}_{i=1}^m`` involves minimizing the total error,

$E ≡ E_2(a_0,a_1) = \sum_{i=1}^m [y_i - (a_1 x_i + a_0)]^2,$

with respect to the parameters ``a_0`` and ``a_1``.
For a minimum to occur, we need both

$\frac{∂E}{∂a_0} = 0 \quad\text{and}\quad \frac{∂E}{∂a_1} = 0,$

that is,

$0 = \frac{∂}{∂a_0} \sum_{i=1}^m [y_i - (a_1 x_i - a_0)]^2 = 2 \sum_{i=1}^m (y_i - a_1 x_i - a_0)(-1)$

and

$0 = \frac{∂}{∂a_1} \sum_{i=1}^m [y_i - (a_1 x_i + a_0)]^2 = 2 \sum_{i=1}^m (y_i - a_1 x_i - a_0)(-x_i).$
"""

# ╔═╡ 9f128e8c-a780-458f-b979-5d4662c223a6
md"""
**Remark.**
These equations simplify to the **normal equations**:

$a_0 ⋅ m + a_1 \sum_{i=1}^m x_i = \sum_{i=1}^m y_i \quad\text{and}\quad a_0 \sum_{i=1}^m x_i + a_1 \sum_{i=1}^m x_i^2 = \sum_{i=1}^m x_i y_i.$
"""

# ╔═╡ 86bdf524-63f9-4202-a37b-3c941ad62f08
md"""
**Remark.**
The solution to this system of equations is

$a_0 = \frac{\displaystyle \sum_{i=1}^m x_i^2 \sum_{i=1}^m y_i - \sum_{i=1}^m x_i y_i \sum_{i=1}^m x_i}{\displaystyle m\left(\sum_{i=1}^m x_i^2\right) - \left(\sum_{i=1}^m x_i\right)^2} \tag{8.1}$

and

$a_1 = \frac{\displaystyle m \sum_{i=1}^m x_i y_i - \sum_{i=1}^m x_i \sum_{i=1}^m y_i}{\displaystyle m\left(\sum_{i=1}^m x_i^2\right) - \left(\sum_{i=1}^m x_i\right)^2}. \tag{8.2}$
"""

# ╔═╡ 79fb24d4-96fb-4a7b-ab61-85a4d9805c1d
md"### Polynomial Least Squares"

# ╔═╡ 9815df20-31d0-450a-9bbd-4078f834603f
md"""
**Remark.**
The general problem of approximating a set of data, ``\{(x_i,y_i)∣i=1,2,…,m\}``, with an algebraic polynomial

$P_n(x) = a_n x^n + a_{n-1}x^{n-1} + ⋯ + a_1 x + a_0,$

of degree ``n < m - 1``, using the least squares procedure is handled similarly.
We choose the constants ``a_0, a_1, …, a_n`` to minimize the least squares error ``E = E_2(a_0,a_1,…,a_n)``, where

$\begin{align*}
E &= \sum_{i=1}^m (y_i - P_n(x_i))^2 \\
&= \sum_{i=1}^m y_i^2 - 2\sum_{i=1}^m P_n(x_i) y_i + \sum_{i=1}^m (P_n(x_i))^2 \\
&= \sum_{i=1}^m y_i^2 - 2\sum_{i=1}^m \left(\sum_{j=0}^n a_j x_i^j\right) + \sum_{i=1}^m \left(\sum_{j=0}^n a_j x_i^j\right)^2 \\
&= \sum_{i=1}^m y_i^2 - 2\sum_{j=0}^n a_j \left(\sum_{i=1}^m y_i x_i^j\right) + \sum_{j=0}^n \sum_{k=0}^n a_j a_k \left(\sum_{i=1}^m x_i^{j+k}\right).
\end{align*}$
"""

# ╔═╡ c006275b-51b7-45f8-8baf-bf3da3c90270
md"""
**Remark.**
As in the linear case, for ``E`` to be minimized it is necessary that ``∂E/∂a_j = 0``, for each ``j = 0,1,…,n``.
Thus, for each ``j``, we must have

$0 = \frac{∂E}{∂a_j} = -2\sum_{i=1}^m y_i x_i^j + 2\sum_{k=0}^n a_k \sum_{i=1}^m x_i^{j+k}.$

This gives ``n + 1`` **normal equations** in the ``n + 1`` unknowns ``a_j``.
These are

$\sum_{k=0}^n a_k \sum_{i=1}^m x_i^{j+k} = \sum_{i=1}^m y_i x_i^j, \quad\text{ for each } j = 0, 1, …, n. \tag{8.3}$

It is helpful to write the equations as follows:

$\begin{align*}
a_0 \sum_{i=1}^m x_i^0 + a_1 \sum_{i=1}^m x_i^1 + a_2 \sum_{i=1}^m x_i^2 + ⋯ + a_n \sum_{i=1}^m x_i^n &= \sum_{i=1}^m y_i x_i^0 \\
a_0 \sum_{i=1}^m x_i^1 + a_1 \sum_{i=1}^m x_i^2 + a_2 \sum_{i=1}^m x_i^3 + ⋯ + a_n \sum_{i=1}^m x_i^{n+1} &= \sum_{i=1}^m y_i x_i^0 \\
&⋮ \\
a_0 \sum_{i=1}^m x_i^n + a_1 \sum_{i=1}^m x_i^{n+1} + a_2 \sum_{i=1}^m x_i^{n+2} + ⋯ + a_n \sum_{i=1}^m x_i^{2n} &= \sum_{i=1}^m y_i x_i^n \\
\end{align*}$
"""

# ╔═╡ 9d51e95c-62ef-445d-9e7a-8b5e4b36e742
md"""
**Remark.**
These *normal equations* have a unique solution provided that the ``x_i`` are distinct (See Exercise 14).
"""

# ╔═╡ 09531707-ae70-42dc-af3c-8662157c2642
md"## 8.2 Orthogonal Polynomials and Least Squares Approximation"

# ╔═╡ 41a6d428-a1bb-4e2f-a26e-c28de89a9733
md"## 8.3 Chebyshev Polynomials and Economization of Power Series"

# ╔═╡ a2632e13-c90a-4c7f-96ab-8b065eb5a790
md"## 8.4 Rational Functional Approximation"

# ╔═╡ 998be977-96ca-4b87-9d16-d2a1ca5535ae
md"## 8.5 Trigonometric Polynomial Approximation"

# ╔═╡ ac728634-7208-45a4-b663-3418d62f8d25
md"## 8.6 Fast Fourier Transforms"

# ╔═╡ f39d1db1-91e2-44f2-bd62-36522f4c3817
md"## 8.7 Numerical Software"

# ╔═╡ 087c12bd-e200-4e8f-8db5-f0e484fdfda0
md"# 9 Approximating Eigenvalues"

# ╔═╡ dea7bd8d-4c59-4522-bbf0-c673d981797a
md"## 9.1 Linear Algebra and Eigenvalues"

# ╔═╡ 76e509c7-f153-4c83-bcc1-65b3edd30f81
md"## 9.2 Orthogonal Matrices and Similarity Transformations"

# ╔═╡ dc1f8969-12ff-4fb1-87fd-7a90de4c1046
md"## 9.3 The Power Method"

# ╔═╡ 826eb206-d523-43f6-bba9-9160e0d32491
md"## 9.4 Householder's Method"

# ╔═╡ 075d6e1d-05b6-49a7-bde9-99a808b3baaa
md"## 9.5 The QR Algorithm"

# ╔═╡ ff93d4f3-ff83-44e7-ae2c-c337786fc319
md"## 9.6 Singular Value Decomposition"

# ╔═╡ 38bf5e96-295b-4ef4-9edd-c736255a554b
md"## 9.7 Numerical Software"

# ╔═╡ bcb2443b-c5c6-4405-a7d1-0bbfe01f22cd
md"# 10 Numerical Solutions of Nonlinear Systems of Equations"

# ╔═╡ 3375e1ad-a78c-4d90-b76d-53e65c1f7ad0
md"## 10.1 Fixed Points for Functions of Several Variables"

# ╔═╡ 5f3fb1a2-3008-42e4-addb-c623a1b0be08
md"## 10.2 Newton's Method"

# ╔═╡ c94a4618-25a6-416c-893e-bffb23fc568c
md"## 10.3 Quasi-Newton Methods"

# ╔═╡ df36d818-289c-465d-9f23-ef6153fa58c9
md"## 10.4 Steepest Descent Techniques"

# ╔═╡ 7a6b68d6-15c4-4555-8a2e-6be92e48e849
md"## 10.5 Homotopy and Continuation Methods"

# ╔═╡ 44a82d19-5ab4-49df-91d7-52b747002d84
md"## 10.6 Numerical Software"

# ╔═╡ 56ae73c4-e68d-4373-9dc0-6837f79a2f20
md"# 11 Boundary-Value Problems for Ordinary Differential Equations"

# ╔═╡ 6d20e9c0-9ffe-4d20-b6f1-bd1f2970501f
md"## 11.1 The Linear Shooting Method"

# ╔═╡ 6db3d241-ef74-4090-81a2-50864478bf6d
md"## 11.2 The Shooting Method for Nonlinear Problems"

# ╔═╡ 9840d4f0-ef3e-40ed-afaa-b47d24f522f8
md"## 11.3 Finite-Difference Methods for Linear Problems"

# ╔═╡ ad5aae09-c520-493a-aefa-b23be858c4fb
md"## 11.4 Finite-Difference Methods for Nonlinear Problems"

# ╔═╡ fa080ed4-36f9-4305-ab02-e090000ba82b
md"## 11.5 The Rayleigh-Ritz Method"

# ╔═╡ b14f50b2-8b67-4a46-8aee-0aa45c58bb98
md"## 11.6 Numerical Software"

# ╔═╡ c7df238e-d997-436c-a1fa-467164ecd3e3
md"# 12 Numerical Solutions to Partial Differential Equations"

# ╔═╡ 9604ca3c-0ffb-46ca-81cc-4af079419dc6
md"## 12.1 Elliptic Partial Differential Equations"

# ╔═╡ d35d8dfc-f307-4024-b9f2-f555705f8663
md"## 12.2 Parabolic Partial Differential Equations"

# ╔═╡ 0e761ab0-0470-4d9d-bf64-a1cb13d352c6
md"## 12.3 Hyperbolic Partial Differential Equations"

# ╔═╡ 3b5e57f4-6e9b-432d-880a-6d19be0bb9e8
md"## 12.4 An Introduction to the Finite-Element Method"

# ╔═╡ 698e124c-64b7-4269-b874-e0d049259969
md"## 12.5 Numerical Software"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.48"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "97be6e027681c6ecfa37671630e179d506eb1167"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "6c01a9b494f6d2a9fc180a08b182fcb06f0958a0"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "efc140104e6d0ae3e7e30d56c98c4a927154d684"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.48"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.URIs]]
git-tree-sha1 = "e59ecc5a41b000fa94423a578d29290c7266fc10"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─a901d416-c0e5-463c-a8a9-fb5b36188996
# ╟─e51df1be-23df-11ed-3d2a-41392648d60d
# ╟─20caac3c-1438-41ac-8eda-d3fd8161198d
# ╟─ea6233ff-0012-4068-981e-49e87afa809e
# ╟─870c6c63-97e1-44a7-89dc-b19561159419
# ╟─8cc829b1-0013-443b-89c0-880f1f9afc0e
# ╟─efc3dcf9-f411-439a-8394-76e592d568a5
# ╟─ef1f5730-754c-4591-a275-01e2620b53fe
# ╟─47600b32-a97f-4118-b061-632d0cac227e
# ╟─816a7c0e-1a3d-478d-9d25-13e0346f59ff
# ╟─44eb55d1-1e21-4c98-8817-db542809fdf4
# ╟─9337e240-5683-48a0-81f6-fdee622aea1b
# ╟─7fcde527-d788-4454-bf12-f8ab400d341b
# ╟─c5ee3f0e-eb52-46a6-9add-ac3178693a4b
# ╟─fa5e0ab8-f543-4fa4-adc3-5d3f8f0443ad
# ╟─cefd0c36-465f-44f3-b680-4c5aeda02b39
# ╟─723d7d56-5b20-48e9-a02c-c1b94777cd9f
# ╟─f95ab586-c39b-4e8f-b0cd-06b9837fff20
# ╟─7f629d7c-2fd9-4b47-8fd4-52d39d00771e
# ╟─03174326-bb3f-4687-a5af-f9ea160bae3b
# ╟─de43d124-5793-4326-b97c-f75aec9690d4
# ╟─accf74aa-0337-4e3f-b8d1-39d400125a82
# ╟─8ef6a807-8557-4fc5-9061-34a86132946e
# ╟─488a8db4-0065-4b60-b1a6-caafd5b6df0a
# ╟─f28061d8-b242-446c-a452-9ba535f806f4
# ╟─21b9fa78-542d-4788-96fa-a2ec3ea3c6f3
# ╟─a4bb4444-8f5d-4f01-9d90-fe7470d7aa1b
# ╟─0e70fd60-47e8-4dbb-9b81-ea8db52cbc85
# ╟─3641840a-d501-45d4-8cb3-dec99f83ad2d
# ╟─b8afaa05-2eef-4c35-b72a-326e4a6bf198
# ╟─708ba3e8-f0cc-45d4-a80c-93566d355ca0
# ╟─85c9ff97-8444-4911-8d47-483fa4b72c67
# ╟─11e825df-9313-4fa2-85e5-e8f88527ae29
# ╟─dac78d4d-f6f8-4439-8a27-4c583810064a
# ╟─3a896758-ed2d-4674-b3fa-69258a902b29
# ╟─660e14b6-5160-4e6e-87c5-f49302cfd36f
# ╟─efd7f9f9-6886-4602-9043-6f421952d0bb
# ╟─25194b29-3142-4713-b96d-e9ac91204817
# ╟─61231ff4-ba80-4a46-b532-893db800f58f
# ╟─404d0c2c-7e9e-45be-8608-6dbd43b4dab2
# ╟─f0385459-c814-4054-adc6-b24a8737eb25
# ╟─01119851-540f-4648-a130-816726280a9d
# ╟─b3aa226e-1fb8-4eae-8a56-7a52496038ab
# ╟─8f21d2a6-d237-4e0f-ac93-39bad4d7cb40
# ╟─f7d64cda-9a58-45e3-99ac-e5f652d092c4
# ╟─be030eae-17b5-4028-baa8-656dcb76c160
# ╟─97f1671d-ad6e-435d-a996-9e425f3db92c
# ╟─32da3ed2-d25f-46a8-a282-5365aff2bd4e
# ╟─0c8a33b0-2995-49f6-96db-c2d133380be8
# ╟─b40613fa-c635-4464-a0a4-62c422d591d2
# ╟─a698ba38-3547-4fef-8020-918c23083e6e
# ╟─8101b173-7522-4163-8b8a-a2b177e15171
# ╟─9f553224-6ae6-42f8-81d3-ed27400a345b
# ╟─35cd137e-1f5d-4f85-9bfe-f1f865faf5ce
# ╟─d6834c90-8144-468f-9fec-9c34f1b59f94
# ╟─45c692a3-94cd-47e7-9473-24179692e08b
# ╟─a15befb5-4a87-4d0f-b06e-3dd0cd061803
# ╟─9ede5792-0a4a-4237-8cc9-c32ccfd82a0f
# ╟─c27cae21-d3e2-44d9-a500-4812b5407e08
# ╟─ecc18c73-a0fb-48e7-b403-6ab2c48a690d
# ╟─8afe25ab-bb17-4ffa-a843-126f191d38cd
# ╟─7bc40d2d-ba03-4650-af02-e6e47f00bad6
# ╟─119ae5d4-f3bc-4a7c-9bb3-d3d3b2fd97b5
# ╟─c39ed048-0f56-4426-9355-7e03b9e3b740
# ╟─458ed239-d082-40d0-a34f-d61f37ddf7cc
# ╟─3d5b9fa7-735e-4b6f-841e-1845f1388472
# ╟─0d6f63c3-e1f7-4fd3-8b5b-3bbca21076c9
# ╟─20194d15-27ea-4b46-8b22-3426705201f1
# ╟─dbcd0980-6f05-44d2-8ba8-6e3a4026e106
# ╟─f1a9588d-059b-4bfd-b080-0417ce35fe14
# ╟─d4a8cf4a-d9b2-47fa-8d3b-a45e45ed6fcd
# ╟─48744727-20d8-4fd7-bd3a-881096eb1080
# ╟─7f81bd98-bc93-4cc0-bec0-43952e52d9f8
# ╟─45a2bf53-09f2-4278-805d-f5c6b5d2fecf
# ╟─ac363c90-5fab-4155-a70f-0b1a2328c501
# ╟─a67a84f0-62a7-4fd5-90e4-7e04d5c2d5ec
# ╟─521ed011-d220-45c7-b42c-07e24e4f5390
# ╟─9f923944-7541-4e87-8f52-a43536ea2cc4
# ╟─0dc5f118-efe9-481a-a455-abf1c5085de0
# ╟─e6075102-3f7f-4fe4-9c18-146af93a02bf
# ╟─ef7d9a3d-431d-4ebc-9f54-f2e44322957b
# ╟─4feabf0d-869f-4bcc-aa95-0b166765537d
# ╟─513d860f-a870-4138-b500-ccdeae3eed2b
# ╟─bdbccf8e-3bf3-4a96-a51a-d8a77fbb8a36
# ╟─09cdfdaf-62aa-479b-b36e-993a457aa252
# ╟─96e16465-87a5-4f8f-bd50-abc05247c3e6
# ╟─d07dc6d5-1dd4-43d8-a83c-7db4bbf9fe7c
# ╟─8e10ec87-d488-44d8-ad12-cb09ff652820
# ╟─b65ae051-f995-40fd-8b67-caca49d328bd
# ╟─230c64d0-ae77-4ea4-99fa-b5bb5d9746e9
# ╟─99bfe880-0356-4441-b672-fd2ed0404be5
# ╟─9fdf2bf4-bc30-4600-9f9d-65d0f6a6f1d8
# ╟─dc3cd185-b3a4-407a-bea3-fc88e8711cbb
# ╟─5452cdba-33dd-4bbd-8e44-3fb5cfe921bd
# ╟─36f80fdd-ccf3-4bd2-9e67-c4e8ade6544a
# ╟─0fc97dc6-e560-4f5d-9719-640aa38603cf
# ╟─d8945fb4-8f62-42ce-8ad2-b9b253203e38
# ╟─adff733d-7715-401a-8b72-e5718e785661
# ╟─5fce4410-0f86-441b-98e8-42ad7f6e5fb2
# ╟─4d184b50-bba5-4ba5-930b-c03e5bedc662
# ╟─25bf8f22-cede-4ef2-947b-3ccb2ed0e840
# ╟─f6efa262-f885-4520-b183-44907cc96254
# ╟─d632bb09-296d-4ea0-afff-5c0eb2587da6
# ╟─8dc32425-ad0d-4bfe-823c-23e64cd903fa
# ╟─a77c153a-ff24-437f-84a3-0309cc204219
# ╟─1fee97b6-ee90-4366-a561-0acfc5e8c32f
# ╟─e1466ee6-e15f-47bf-b889-6cf098abba1e
# ╟─1559d9b2-d230-42f2-adc4-1d52fff1769a
# ╟─89a0f371-57a9-4465-9ea0-570a46985156
# ╟─143bd2ee-9fd4-4f08-9220-dc4c7f361215
# ╟─f012cb56-9175-41a5-9459-f4cf897147c7
# ╟─c826a507-42ad-4ad0-8933-c3e25638cf76
# ╟─e2762236-455c-450c-84e7-e67aee6db99d
# ╟─ded5e8c9-51c5-4e74-884c-8538ba575795
# ╟─dbee2984-b5da-4f25-907d-62808f13fd68
# ╟─be3c68fe-8d3c-4a88-a1d2-566afd788d1b
# ╟─866b7b24-1429-4005-b77a-e0957d3f1278
# ╟─a4055202-8001-4c00-965f-539a313eff7f
# ╟─3f41b43a-10e9-4660-8fd8-2369fc4fd2eb
# ╟─5dfb111b-31a9-41a0-9215-c1559232da3b
# ╟─7646252b-a583-446d-862b-a793fdfae96a
# ╟─6657c0c6-0c38-44b8-8e69-f2c0e5fc4c65
# ╟─4c7f1ea7-38b5-4956-b2dd-ff81db7445f3
# ╟─54e0418a-9ca3-4182-8e09-1bb034efe3a8
# ╟─0a650ded-443b-4055-9d44-f7fc6662409a
# ╟─d4b7276f-78f2-4f33-bbb9-f6d6f2569eb8
# ╟─9f7a35ca-469f-4363-b770-0e9c06033b5f
# ╟─047c7e98-5d68-4a45-8178-5f504264f87c
# ╟─c3580c5e-b3fe-43e0-81e3-907414eda51b
# ╟─238e7794-616d-4da9-9c81-4d6f9fa3be8e
# ╟─751fae05-6c93-4e23-a009-39daf2e95ae3
# ╟─9936a10f-0584-420b-af92-cd41fbd31668
# ╟─234c5fef-469a-4f1d-bc5e-e149051a498c
# ╟─84107ded-bfce-48a7-8827-84367ca63ee6
# ╟─defec1fa-05c0-47ee-ac5d-82b00b359652
# ╟─282d5528-ea4b-444b-9c98-55fbf1033105
# ╟─ed7e0ff6-199b-4707-8b3b-f8e3fcbb9e42
# ╟─e667f130-c551-41c3-aae5-0addaec3cdd5
# ╟─deac8e0e-20ab-4a11-acc5-426cdfb33525
# ╟─22e7cec2-58dd-470a-b266-d3922929eb63
# ╟─e196f30a-b529-4f72-90f2-67b56c633473
# ╟─9dd1f3ae-18c2-4aec-9d1b-89ce7a957bec
# ╟─33dd758a-9373-4019-b4a4-92d24161fb8a
# ╟─5ff7ede5-c5bd-4ed3-b36c-de984b6d7269
# ╟─1392082c-df83-4834-aaa1-3cf927729254
# ╟─3829beb6-cb1e-4d73-9989-a440a142ba72
# ╟─6be0b014-1670-45b9-b6a7-b9b5f7e1e1cf
# ╟─2ac60db8-ebda-4571-b610-35315750e113
# ╟─a1388e95-2241-4ebd-bfdd-eac6dab12dbb
# ╟─b622e4ec-5df6-42f1-a8eb-507885ed3ab6
# ╟─365cdc0d-8235-4aea-8211-9d214bf2b0c4
# ╟─ba45e8ca-60fe-4b2e-a7b7-404bc670954f
# ╟─96d49def-ba6e-4909-a46c-6940bbb446f4
# ╟─9a430950-d9c5-4101-a602-59f1ae4043ac
# ╟─2e708a9c-7f84-42d1-8575-b45e6de46b74
# ╟─06b5d562-5c56-400e-9d84-dc153b13842c
# ╟─07932733-be06-4a7a-8ca2-4ecdbc505c47
# ╟─dc14bc97-62e3-419f-80ec-0c1cbd0321ce
# ╟─43a3bb21-2820-4151-a847-c480279a18a0
# ╟─335f92e6-cbd8-49d2-baaa-1fc8633cb05e
# ╟─20834636-449f-4e66-8e31-0686e6164e6d
# ╟─d0edc777-d66f-4a1a-95c8-6644fefb94ea
# ╟─080e0c41-9e34-4674-a1fb-f1b42a7e3bb0
# ╟─6002fca9-d606-4b7c-bf29-75642ef303ca
# ╟─2426fc36-c102-477d-b836-0f2c37b0d6d5
# ╟─0ed97bc8-4956-4fb8-952d-72fdc097d666
# ╟─d0bcd8e5-45b9-4625-b0ef-65d5a99e9d3b
# ╟─e522336b-6ebf-4c2e-8b1c-52af3e9500e9
# ╟─876a20bb-1e83-4b91-83c3-9ed7f33ae1cd
# ╟─e2aac1d4-52ca-4372-85e5-b8e9fa561a14
# ╟─f6665670-acc5-4a35-b7d0-7376290567fe
# ╟─848929da-481f-45db-8436-51bbc068816c
# ╟─046ace93-48b1-48f7-aee5-718ef4b254d0
# ╟─8ca736e0-ab65-4efc-a560-bf2dfcb3cc95
# ╟─e6262e17-39c7-4ad1-996d-524324f7e7e6
# ╟─d1c62d89-19ae-40da-92c0-c8a2793a1a39
# ╟─67c21172-1a8e-43e9-a38e-57dc8ca4f064
# ╟─0b351e5c-7c7d-45b6-9156-806df3e776e6
# ╟─2f7bb65e-ebcb-4ed4-829c-129e9823f755
# ╟─42c870f0-717b-496f-ac60-3f1958bab858
# ╟─e09d141d-be9c-471d-bf7d-11558f91385f
# ╠═2f54abf1-79f2-497d-aaee-667c04bbf3a1
# ╟─834f01cc-58b9-4982-b8bb-4a3484397bb8
# ╟─e43d72e0-101f-4c9b-a9f1-8418bc8bde9c
# ╟─75ba971e-9f21-4e4e-8400-106ac8a7efb3
# ╟─061c1400-2c90-4c66-99d4-5404063bc321
# ╟─8e9547e1-e9d0-4209-83f7-74e0406adb8b
# ╟─0cbfc117-3dbf-41db-8c3c-fb1f9fbcdbe9
# ╟─29b61ceb-0d39-4ecf-8b35-bc044214c39d
# ╟─cd259dfd-f06e-46f8-bb49-36a5866e14f8
# ╟─011be372-a4c2-4f48-b074-92407ab8bb62
# ╟─c3940f20-17c2-4bc3-89b3-45fd52edf799
# ╟─eef8bfbb-180f-4d73-8bc5-47832735c153
# ╟─23e127be-a0cb-4721-b9d6-15b28b7cd405
# ╟─6deca4f3-632f-4b55-887f-836f430ac9e9
# ╟─ba08934f-41aa-4ec9-bfa9-c5eeb2a332a4
# ╟─33047f1b-47a7-4bd5-8e98-ea21be91f5a8
# ╟─0a173495-f416-40b8-886a-6a07357a74eb
# ╟─dd157e39-2347-422a-b2cf-030b0dc8cb65
# ╟─58802c56-f618-455e-b85e-8832173e9b36
# ╟─106ae98e-7ff8-44fb-8600-5baf618c21e8
# ╟─c07ac7cf-8c96-463b-a264-1c9d264568d0
# ╟─0c716cc7-aee8-456e-b2dd-e92ae14e807b
# ╟─4163cb6c-c7e8-4d56-9d59-7026294b3279
# ╟─395f6d7f-5347-4d2b-a999-55e4f46f50a6
# ╟─422a8e1b-636c-4072-9b99-da06b46eca44
# ╟─d9b78f61-5f46-472b-a6a8-10d270131532
# ╟─56fbee44-aa54-4931-81f3-bc06aa7944dc
# ╟─9a1011d3-13ef-4590-b580-f4951c8b451f
# ╟─e55cb028-dece-42a1-8cb5-b64c1b289808
# ╟─25dc0c95-c5cb-497c-8b7e-83c739fbb252
# ╟─d8e398df-d15c-4674-a23a-b49f6b7740fa
# ╟─bf3f094e-187a-4d8c-95e3-ed7f2467105c
# ╟─de87cedb-aac5-404a-999f-ce9ae813012b
# ╟─a188c78b-3cfa-4b1f-b5ef-2ffbe02b84fe
# ╟─e49a5b52-bc6a-482f-9889-d38b4d275a3b
# ╟─476c325d-75d8-493e-bd14-e1545fbff3b7
# ╟─b9aa4dce-4914-4077-8f73-708984880067
# ╟─36d46835-d901-4df9-b2e5-af25f7a9f966
# ╟─e59f352d-399c-435f-8662-ea85f15119a6
# ╟─f9a812db-284f-4841-a467-f6138562caa5
# ╟─c002148a-415b-43ad-bbe9-df88b9c2047e
# ╟─a39b9e74-9400-42ef-aff4-b520967a244d
# ╟─7d5096cb-d595-4b50-9fb4-2fc3cab87eb0
# ╟─263f0f23-f2c3-46c7-a61b-734f7933e480
# ╟─622f5a33-7a6f-4934-a686-108e8af6b5f6
# ╟─2dcdbbba-bd25-4633-9898-e24e519d1f95
# ╟─2dc1ca0d-ef77-4e5e-8f27-d52b9bd625ba
# ╟─841b74c3-acb3-4661-9656-6394e61a3976
# ╟─c3b766fb-a87e-4868-887b-3008dc046459
# ╟─566f92b5-3a39-4fbd-8990-1778cc328037
# ╟─26ad0783-4f25-4330-8413-5d0b948ebc82
# ╟─19b20ee2-03ef-41ba-9843-6a81a55f8bce
# ╟─7bd15f66-cbe3-4371-9889-f82b08797aaf
# ╟─e68c8404-5599-4eb0-87e5-c8e7daf6cff8
# ╟─fa765be9-8d71-4ec1-8589-12015c6f741c
# ╟─bf278e70-8d48-4ada-92f8-8e850e8ab9b5
# ╟─e410f6ec-3456-4c9b-a975-e9aebab75bcb
# ╟─010a00b1-7923-4b0b-aff8-b58f89d081c7
# ╟─8ca6d5d1-bb3e-4595-b862-d8e1fc297f35
# ╟─13b57180-ebab-444b-94a0-e3550386a3d8
# ╟─e82e185c-d29d-48ae-a57e-d7130f3a3fb7
# ╟─e8d30c02-ce7b-4cd2-be37-9c43b4528a14
# ╟─462d63b2-288a-43fb-ac2c-e0c4d5912bd1
# ╟─5b34aa84-b257-483d-8ccc-11e91c0d5b70
# ╟─5842a6f3-600c-494a-b9b7-8c2ddb9baa98
# ╟─67c473e0-4b34-4180-b1d9-eb82591e2419
# ╟─011e14e7-3dd8-4a6c-af03-11c93d02a8b5
# ╟─03899dd7-0f65-488d-a36c-f00a7489e186
# ╟─51431ec8-3ec6-4f7c-a3bb-563d90d9201b
# ╟─95f946d7-6df1-4f21-bbb0-12af41c734cf
# ╟─fc2aacf4-a7f8-4703-b663-6effff4205e1
# ╟─50c1fc3b-3003-4b2f-8812-9226163a4448
# ╟─cb2f2af2-f365-4565-ba6d-e5b4b28e2151
# ╟─a32f7967-8416-4155-9532-4acdac059186
# ╟─6c478232-67f6-4630-ad81-f2887e9c1ddc
# ╟─98f67a0a-67d2-49a9-8ca1-9bf95926fc2f
# ╟─73dbdfd7-4d98-49a7-9fa4-670819a4efd5
# ╟─24837a6e-ff42-473b-a9fb-f8213dcafc90
# ╟─43289993-e3c6-4fce-bfad-d1e237e63775
# ╟─ab3e1864-93b2-41f0-a2ba-8e89035c6a91
# ╟─73447e6f-3811-4b16-8169-edf6ff29de01
# ╟─5c9a27f6-c77f-4a59-99f1-22b1bee36435
# ╟─d0ccb09f-1452-4598-9ddc-d49fdef4f42e
# ╟─308fe786-38eb-4dc6-8e2b-c0ff3467f7b0
# ╟─24cf7831-07ec-4f53-a470-552fa89dd1b1
# ╟─835f1922-3505-42a2-88ef-42fbb5fa2915
# ╟─f0beaeb7-aefb-4cc4-b6cf-0f363a365693
# ╟─83154f35-624f-417e-bc01-4074116aca47
# ╟─f36e3b10-c87b-4b75-a4ff-eba55d69c611
# ╟─3581420f-2c3f-40f6-99c5-90bcd594b1eb
# ╟─ce9d3b47-fa76-4ed5-b284-6fbab811d3c4
# ╟─860a661b-668c-45a9-84aa-3e4d631a4a41
# ╟─e73fbaa4-373c-4565-b77a-bcde2a693eba
# ╟─9bd636ac-7d93-49a1-a482-89d2f6d8149c
# ╟─5c8cec6b-1668-4794-ad67-6b79da8c5c37
# ╟─8d757352-a2ee-44f3-84f3-045f2dfb95b9
# ╟─05851fb6-cc27-4061-8048-312f28225d94
# ╟─33c3e2f4-8b6c-4542-b027-727a050f6eed
# ╟─457f48a3-1a73-44b6-b86c-fa6bdd08ff0b
# ╟─7888789a-43b4-47d9-96f0-3a1c2b37bcce
# ╟─4ede9e88-6f71-45c2-a1b1-0616cd83a003
# ╟─b6e0143b-1066-4280-acaa-4f543fa42959
# ╟─f40d0a7c-ac33-4988-aa41-8ca491f90681
# ╟─2cc766b3-e863-41e5-80b0-e8bc902244f2
# ╟─0a4c8b29-731f-481c-8c70-1c52aebabdba
# ╟─13859101-e0df-456c-b9e5-230650c0553f
# ╟─2481faa0-85d8-42a2-a8d6-bf2cc8eab5b7
# ╟─84c51562-647e-40ef-a266-7e6acd9f4daf
# ╟─01ee02d8-402f-4d62-83da-91ca3ef79b9f
# ╟─252c34ea-23ab-4b74-a6e7-37799633b3f4
# ╟─e79c2d68-d900-4bc1-b50f-cb1e15cc88b1
# ╟─ff02a90e-1731-4c01-9654-a827e918c5a6
# ╟─55edf836-6ec4-4c3a-9844-8f2914b80003
# ╟─da07c466-630d-4d4e-b366-904ef33494eb
# ╟─99d2d39e-8fb2-43c4-b9a8-897d90dd2a4c
# ╟─e5a1508c-9982-420a-9263-1deae08f2e47
# ╟─72d5b687-d328-446a-b338-7f162bc8d805
# ╟─1c8beda1-a780-4328-89c4-aaa7a99699a4
# ╟─4509bfe5-69bf-4dbb-b49b-2461901488f1
# ╟─a0f45715-6f06-4e8c-b299-c164b3836ca6
# ╟─cadc1cb3-76d5-4a62-8ad2-16bc602bd3e3
# ╟─dd8ed6b9-08c8-46ea-ac73-fcc117ac4482
# ╟─ce80e909-ea27-42f8-9640-9450d2d71275
# ╟─940f3c3d-b2e0-411b-ae64-f1b118ad4450
# ╟─2daf89c1-79d7-47a7-803e-63db9c274116
# ╟─2c864c81-37ea-4834-bd87-054db5b71e1f
# ╟─d50561d3-2efa-4f10-a483-6ad784a05d66
# ╟─f3e9f2a2-7231-4e7e-81ce-a3a2e8b9283a
# ╟─0f6b8e73-b50d-4c10-8eb0-b910e2c6d05e
# ╟─4aa76d84-ca61-4c68-aa6d-118071f3d917
# ╟─914af8c3-5e33-439c-bf72-5cc4b5a6cd27
# ╟─f5daa6d1-dead-4a2c-8d03-70b3adf794e8
# ╟─34dc8e7d-c896-4c50-8790-4555856f3f77
# ╟─18009ca1-856a-4040-a2c5-be311be07f14
# ╟─a3673f9d-b3cd-4e1f-b18e-a0a816f0eaa1
# ╟─173ee4d1-902d-48ce-af0f-56d454aa315d
# ╟─09534f01-c9b5-492d-97af-f10dbfaa1c1c
# ╟─22d4c65c-0636-4e61-91ed-c0926a2b1dd9
# ╟─96577e2f-2276-4c8b-88a1-b18868919134
# ╟─23d7a6fd-7296-4769-916d-9dfcde87ccbc
# ╟─c4327b0e-8953-4fb8-b4bf-bb73811c425f
# ╟─1b44329e-97ea-46f6-bdfd-26216c592ee2
# ╟─12e445df-54a6-4a43-8253-b92c5cf24a66
# ╟─79d0937e-5837-437e-ba9b-9a7050c3e27a
# ╟─abd4f3f6-2e75-4b81-ab3e-b73cb38b1868
# ╟─545feb7b-e53c-4438-b554-78893199abd4
# ╟─ec4e80fb-e212-4b1c-88b6-63ea441f3fb5
# ╟─e1243f0f-0cdb-428e-8c0e-8717a16c0620
# ╟─a37d8465-797c-4e1f-a508-034342763e43
# ╟─3dbda725-2f1f-4097-a070-ba1f853c5f62
# ╟─dc95805d-4275-405d-b63e-57642b421739
# ╟─4567e6b1-b4c2-4bc9-a2c7-21e0f134af8b
# ╟─46f0b390-7c31-41c2-bc8a-4dc2f171fda2
# ╟─dc61e975-ec10-4647-b5aa-f1306222479e
# ╟─e599e21a-77ad-4ca4-8f51-18684def0dba
# ╟─d7aceca1-aa42-49c6-b610-1520bf64a6f5
# ╟─cf9cb808-25b6-4bf2-925d-047aa6a80a28
# ╟─42c68221-35a6-4f87-b958-79bf4cb792d6
# ╟─08d09281-4356-40ab-8c43-19b97413a99f
# ╟─0441342e-1631-42dd-9d1a-351158681fa2
# ╟─1be85162-e1a5-452e-bdf8-181d60ae7d41
# ╟─7a57bdaa-f23e-455c-9e41-48d872247f1c
# ╟─951a62ba-bbac-4125-9ee4-e4d12b465126
# ╟─681037f0-edd6-4034-8ae5-14fec97d9b10
# ╟─db436ab4-1b48-4c40-99e9-7b555d605486
# ╟─0124fb25-d031-4478-bb58-9ce7daeab8df
# ╟─627d9dd9-88ba-48a5-80bf-c38bcff3964e
# ╟─a63e040a-7d84-459d-9e14-9db93a9bea3f
# ╟─b0323c57-49cb-4f39-b14e-c4453a76f226
# ╟─c7d867d2-5f20-4a99-af19-ae8e1b1001cb
# ╟─ac602b17-9f04-4371-bfe0-830f4a6f1a21
# ╟─db29b1ad-d326-4df9-823e-a26fd6e682ad
# ╟─fda62b5b-17b4-421e-bb98-24fe3272725b
# ╟─6e0d5a4d-7b16-4d82-9eb9-6f53e08912c2
# ╟─3a7bac9b-74b2-4d96-838e-dc25876afa3d
# ╟─7fe7de57-1cb4-477a-8783-958e52441191
# ╟─9e791289-970e-409a-a220-194f8d416055
# ╟─38dc53ab-f825-4634-9464-8b2d34807c86
# ╟─a86efe21-9842-4df8-806d-bc83f0beadb3
# ╟─5f47e4cc-1b2d-4c67-8308-f571bf9e9d60
# ╟─ac1d1864-9c9a-4cf9-a90b-9a5f56e528eb
# ╟─d7bd5b45-82a0-40c3-bbe1-d5157b7107b9
# ╟─0840932f-e86f-40b1-91c9-d3b5e768af5e
# ╟─1418a72b-f368-4f70-8fa3-cc7e59d5e093
# ╟─0381bc64-6a79-4225-be8a-5742852c3b13
# ╟─d4d94e16-7ec0-443c-8f42-715c32fa1365
# ╟─ef23edd7-cfa3-4138-ac4f-3f86769c59d2
# ╟─3f75a6f9-1c7d-4843-be81-ec54caaf4bef
# ╟─6287227b-e351-40db-a840-0f8d26398810
# ╟─3faa3b5c-53bb-4450-8ff0-55b01f049f3a
# ╟─0e9fd5e6-2d96-4869-b6f2-a6babd85625e
# ╟─301c31be-a7d7-40f1-944c-23713767f137
# ╟─a7f5f93d-0822-4784-9db0-d3d223d3404d
# ╟─d0c6ec89-72d2-40df-bc40-544400675961
# ╟─4e8ba8da-0c6e-42de-967d-8ae88fea888b
# ╟─41781451-5be3-42bd-97ad-c79001fa1b65
# ╟─6b06f828-1761-4af9-99f4-3d1f6b74206e
# ╟─95321ea5-d9b0-4a45-ab54-4285fd9b4ff7
# ╟─ce75f4dc-44cc-4b83-b2ef-48ac5bc91cf2
# ╟─c888793b-f1dd-45cb-a0e3-3bd3f810d22a
# ╟─f924b536-3812-42d9-b122-80d74efa5dd8
# ╟─5599f7ff-f9b4-46d7-b36a-951779d1bb45
# ╟─fff09de6-6084-4a8b-8775-e70a9bfe5ef4
# ╟─2eedfce9-f054-428d-b44b-450aba1a4f61
# ╟─9e4b9ce3-da28-490f-aa2d-58fee309f054
# ╟─61940fd9-9b30-4784-819a-02bee1d48e32
# ╟─738df3ce-83fc-402d-87bf-29a7f0df02f0
# ╟─5b3d83ab-0432-4df2-bde4-0b38338839bb
# ╟─e1c3df4c-a7df-4923-911e-e544ca87c973
# ╟─3de45458-29e4-49bb-a17c-1d13f25fae1d
# ╟─6ac17019-5304-4cd0-a7c7-19106c324a61
# ╟─8f82c0dc-13b9-4b7d-b34c-65f175542176
# ╟─b8948156-e93c-4da4-85d2-92b4fc0e9703
# ╟─699693d4-b360-4670-b2ff-4d58672d7f3e
# ╟─ee0c05c8-41e2-454d-8455-aeb186ec51ba
# ╟─f2935800-ba61-48a1-830d-019d0ea27ba4
# ╟─29d3b04c-80b7-4267-95f9-4420e80c3934
# ╟─dd9bd6b7-6dd4-4cef-b91f-d644cd610788
# ╟─a6de4dd1-d8b2-4487-8e42-56de8a016168
# ╟─8522f0c1-64ff-4af6-bf09-a80a41bfdd55
# ╟─73f80ed3-e3ab-4416-b591-217bf2a9f319
# ╟─a76df0f1-d942-4f1d-b259-b2c3ad217caa
# ╟─a95bc88e-aaed-4564-86b2-70a84dc8fb53
# ╟─e8fa290a-9805-4c9b-9250-52323f4c6859
# ╟─70f8cbb2-b736-458a-94fd-6307d280ffb6
# ╟─55cca44e-589a-44b8-8c60-0655f2314485
# ╟─69c3c27f-679b-4750-9edf-f3f00ef3a980
# ╟─d9ef48b2-75eb-4465-80d0-cc4101d57441
# ╟─ad9d14e3-850e-4394-9324-dd0b8c11e216
# ╟─83d90676-8424-4230-aae8-18a58970177f
# ╟─0455e0c2-146a-4823-acab-230feb507ca6
# ╟─4a80dc7d-1d42-4070-b570-e408134aa091
# ╟─8cf4f98c-ab95-4a0f-9f5a-9ea6e1c7daae
# ╟─baa7dc04-74c7-492d-b78e-47ee868aaf36
# ╟─c37d51d7-4cab-454d-b60f-0ee8fa07e42e
# ╟─069251e2-67c8-4336-8442-cd967b12db63
# ╟─c4facf43-2de0-457b-a8d7-2769fc6502c3
# ╟─55e46e5e-bf9a-4ae2-ba52-8799e2ff5cd2
# ╟─dd87b6c7-4f9b-4c0a-ae35-c64bc7d31c1c
# ╟─1812fa6e-dd19-44b7-971b-e3dfec362a12
# ╟─80f3dac8-7a9c-4d8d-97fc-377ab84bf9a9
# ╟─73e4c6c5-6010-463b-b2b1-63a0d11551bd
# ╟─fde1a4c8-a2d3-4c9e-9b2e-bdb588ac2a8e
# ╟─5a265095-2a90-403b-be91-2fd8b1c752b4
# ╟─77ae36ef-966c-4d1b-a003-5accc7e68a4c
# ╟─5e331b26-0e1c-42be-a5d1-4ba745788e45
# ╟─f5589be2-9f14-48e2-95e9-1970c4c6d9f3
# ╟─8ddeb153-e283-4226-b7d8-02c6b092ea45
# ╟─e01e93f1-f0b7-4fda-8ac8-4ea516750171
# ╟─261fa7ab-377a-4629-9c17-813b96ff248e
# ╟─0c816bf9-db5f-46ee-8ef9-008ae9a8fa0d
# ╟─b270dfae-7956-4c7c-95be-b5b9248c9deb
# ╟─be8ab057-88d3-4d27-947a-2075062a6051
# ╟─b9769822-adbc-4c8f-96ce-ff30728fdb5f
# ╟─5f4bfb0b-7641-4036-b03f-5484df878b6f
# ╟─25f6299a-7a6c-496a-8c43-1448dd89499a
# ╟─60ea49a1-a2f8-4c1b-85df-33d8385aa7b7
# ╟─9390e28d-ffec-44c1-8f25-a96f629fb26d
# ╟─8b0316d5-e226-4d09-899b-523f44fcdee6
# ╟─6bfbc150-cd65-4b34-914e-9ec60c0fb78d
# ╟─d38bd2b2-be8f-4d54-a4fa-d104e88aa391
# ╟─c256d357-5c32-4f62-8107-b5fa4848a5e9
# ╟─3c344162-16ce-4187-b0ca-dc3a10ebfc47
# ╟─405f9714-8390-4ea1-9d20-87608db6df5c
# ╟─8be103ee-b8c0-47c8-9580-75ba4ce840e6
# ╟─aa85b624-7f2e-4283-86d2-081e6e240ac4
# ╟─666e598e-b701-4d01-a898-6ad4f83dbc44
# ╟─f97694d2-ae75-4dd8-aace-1564a27ff8bf
# ╟─070973fb-1e32-499b-a757-973d43127759
# ╟─9abf2535-8373-4fa6-8042-9674f3fdc0b5
# ╟─cf2cd405-da8b-4906-9c5b-b05d3e1b726c
# ╟─b41cd452-afd7-469c-b46e-15e28fbb391d
# ╟─c3f3954e-f1e1-44e9-ac71-356f2f555c36
# ╟─6c83602d-bf00-4336-9111-f128abc55520
# ╟─b4e5d5e2-9270-449c-ab04-52fc812bc38e
# ╟─a45bb2de-373e-48f1-bb21-67ff82b8ff54
# ╟─2047f6f7-907c-4ea4-8012-d240f639aa0d
# ╟─8ad884c4-9431-4a14-b0e2-783996799f6e
# ╟─520320e7-4d47-40ba-8596-7743247109a4
# ╟─2ca239e1-9193-4e14-b200-9b011b094394
# ╟─1292b300-8a1f-4cfd-8c9e-83bf6c47757b
# ╟─48d247ea-e037-4316-81f7-27274eb0b9f9
# ╟─da53cf75-ebff-4a81-b427-27c8f9081bc6
# ╟─4a49d982-61ab-4607-b80b-8dc7a37bc70d
# ╟─a5109c6c-b86d-4a2f-9616-4945b8cff95f
# ╟─171dc046-0062-44a9-b00a-a655cba1e0f7
# ╟─b9dd0400-8197-493d-bd96-4ac18cb2bf85
# ╟─fced0846-7843-4843-bcaf-7c66f1674e79
# ╟─c00cdd64-c9f4-4e63-833f-41cc43800278
# ╟─be2d592d-2d05-4b08-8488-453e5944f774
# ╟─2ebbb939-6174-4ae8-b062-78adf1c65fb5
# ╟─592060ef-3492-482b-9b8e-d1f0278b0eb6
# ╟─19fb8f8f-182a-4568-a45a-c5cb5ea2c78a
# ╟─d8c7de07-b041-4524-8bf1-6c43d9ad16c2
# ╟─080c1020-ab8c-4ad6-a653-ccfd29a9faf7
# ╟─cfe61e3b-159f-4db2-8e5c-03d1c3a5434c
# ╟─33624853-aa8f-4829-bbe3-dda1fc6f458e
# ╟─8bb3c3a9-872c-4f81-b27d-2209d8dbe4eb
# ╟─95e77bb6-a1d9-41f9-8aa4-e0e247de092f
# ╟─b3945280-406f-4ec4-8d8b-2003db0f9a61
# ╟─9b916bbe-563f-4d9b-be7f-6b2d041e228e
# ╟─c8b4ccdf-3c55-448c-bb26-d300a17567ac
# ╟─cc35232d-0811-4e0b-9900-b53fae5f0af5
# ╟─83e0a811-8e7b-44c4-94f9-39a9ac77fbd3
# ╟─4305503d-5700-437a-9167-d56f204bd065
# ╟─20da5ed1-81ee-48ca-a355-ae76febbc68d
# ╟─3e54cc92-e1a5-4e5c-bfb1-423aa82aaa8a
# ╟─a3e9aabb-b904-44b0-a5fd-8531a54459be
# ╟─b154ce77-af41-4f84-b998-c5fec1e6b19c
# ╟─a87127bc-a78e-49a5-9498-aa428a613b18
# ╟─3744a8c4-06c5-4a8f-ae74-9e8071672249
# ╟─f70c0587-4b42-4262-8b55-dcd085dd776c
# ╟─4e6c20f1-e307-471b-a327-edcec6b01fae
# ╟─aaf2dbf5-081d-4d6c-becf-39cfdfd56db1
# ╟─be63f24c-b38e-4c4c-863e-06d2fe45869a
# ╟─7cb67a58-8758-499d-aa2a-601bb4aef308
# ╟─4a1451ea-c144-4fc1-9d1c-ab7d482567a8
# ╟─ad26e1ac-9cd6-4971-8d71-e5df6376dcaf
# ╟─6020c18a-35be-4095-bed3-1ed63068ee88
# ╟─c0e67789-de3f-4b46-850a-d0bb79a9c925
# ╟─5a0380c5-366c-49f2-85ab-a556605a18ac
# ╟─d36a9b12-9d42-4fef-94ca-3150152c851b
# ╟─4c924509-8a7e-467b-8420-c51c1e5f15d9
# ╟─1ebb00ff-c487-4eb2-83a8-a4176778b675
# ╟─47232258-df69-4bff-be76-6943e964f634
# ╟─a9356cb0-0244-4841-9902-d1084811ea92
# ╟─f6f5b606-2133-47ca-8aae-a596ea99e276
# ╟─0000333d-e9bb-4484-9199-586d717c1843
# ╟─096fbb85-c0db-4a7c-9e95-519057a6aaed
# ╟─80a95ee2-0a3e-4205-aed1-6c6e98d8ee49
# ╟─9a07986d-748f-410e-9079-7c7d7586ad76
# ╟─4b772541-c056-4f27-89ae-5e9e0efbae98
# ╟─a5e89c36-df36-49b5-aff9-b638ce2c9580
# ╟─7a894ea5-7fcd-4432-bc8f-f1032e5c2040
# ╟─8ed3b461-dab3-477e-a757-56f6b31dbdeb
# ╟─305f9f1f-7a17-46d0-854e-9a41085f8c41
# ╟─c02e4e1f-10ea-4cf1-90cd-b6d170e46323
# ╟─b403dab9-5e68-48f6-b03f-30b2893fb004
# ╟─09624c51-d07b-43ba-8024-5750dc260153
# ╟─f6eb99e7-fa84-4608-9b53-dddb06b18027
# ╟─5fcbeea1-7207-4b17-ba96-20e7b0a41107
# ╟─ef4ea9bb-dfb3-4330-80b3-a582c2ecca35
# ╟─5b8d0390-1f74-4a6a-b202-14a10cb69ba8
# ╟─c446eefc-80a7-4a4b-810f-cacb68f4bdef
# ╟─8c439332-b79f-4092-a50e-3cf6d8281686
# ╟─bd566391-a1b9-4614-b9a7-6a0a9217cf44
# ╟─500506be-dd52-4cb0-8e27-fc1f385ecc15
# ╟─72dfae42-fde8-4fb0-b454-427aeb18892e
# ╟─701baaaf-b0ea-4e42-b778-0df9a1283919
# ╟─9bba7823-5247-4770-91b0-b0dbbd77580a
# ╟─955d3329-832f-4c7a-8493-cccb7e274384
# ╟─95a6b60b-59c0-4eba-8101-6ddfba56f49c
# ╟─81351d16-4b2c-43c4-9cd4-d7ae29fbec41
# ╟─961b2d3f-ee7a-4818-8154-9f2abff21794
# ╟─d5516080-b06a-4ea0-a0bb-f48783cbd546
# ╟─98eb69c7-7ae4-4dc1-854a-ce620bcbcfd9
# ╟─afcca1b0-346e-40de-ad31-7f5d51c30780
# ╟─ed3f095d-d0d9-4b26-8b75-be0ffd7114d5
# ╟─2dba3402-8875-4632-9517-df90069fcd1e
# ╟─505438a2-faaf-4244-b57d-dd89fd16e128
# ╟─ba05577d-6ffd-478b-9331-a81435bee7e6
# ╟─9fce7bd0-e96a-4002-8840-3b5e976fcd87
# ╟─9f128e8c-a780-458f-b979-5d4662c223a6
# ╟─86bdf524-63f9-4202-a37b-3c941ad62f08
# ╟─79fb24d4-96fb-4a7b-ab61-85a4d9805c1d
# ╟─9815df20-31d0-450a-9bbd-4078f834603f
# ╟─c006275b-51b7-45f8-8baf-bf3da3c90270
# ╟─9d51e95c-62ef-445d-9e7a-8b5e4b36e742
# ╟─09531707-ae70-42dc-af3c-8662157c2642
# ╟─41a6d428-a1bb-4e2f-a26e-c28de89a9733
# ╟─a2632e13-c90a-4c7f-96ab-8b065eb5a790
# ╟─998be977-96ca-4b87-9d16-d2a1ca5535ae
# ╟─ac728634-7208-45a4-b663-3418d62f8d25
# ╟─f39d1db1-91e2-44f2-bd62-36522f4c3817
# ╟─087c12bd-e200-4e8f-8db5-f0e484fdfda0
# ╟─dea7bd8d-4c59-4522-bbf0-c673d981797a
# ╟─76e509c7-f153-4c83-bcc1-65b3edd30f81
# ╟─dc1f8969-12ff-4fb1-87fd-7a90de4c1046
# ╟─826eb206-d523-43f6-bba9-9160e0d32491
# ╟─075d6e1d-05b6-49a7-bde9-99a808b3baaa
# ╟─ff93d4f3-ff83-44e7-ae2c-c337786fc319
# ╟─38bf5e96-295b-4ef4-9edd-c736255a554b
# ╟─bcb2443b-c5c6-4405-a7d1-0bbfe01f22cd
# ╟─3375e1ad-a78c-4d90-b76d-53e65c1f7ad0
# ╟─5f3fb1a2-3008-42e4-addb-c623a1b0be08
# ╟─c94a4618-25a6-416c-893e-bffb23fc568c
# ╟─df36d818-289c-465d-9f23-ef6153fa58c9
# ╟─7a6b68d6-15c4-4555-8a2e-6be92e48e849
# ╟─44a82d19-5ab4-49df-91d7-52b747002d84
# ╟─56ae73c4-e68d-4373-9dc0-6837f79a2f20
# ╟─6d20e9c0-9ffe-4d20-b6f1-bd1f2970501f
# ╟─6db3d241-ef74-4090-81a2-50864478bf6d
# ╟─9840d4f0-ef3e-40ed-afaa-b47d24f522f8
# ╟─ad5aae09-c520-493a-aefa-b23be858c4fb
# ╟─fa080ed4-36f9-4305-ab02-e090000ba82b
# ╟─b14f50b2-8b67-4a46-8aee-0aa45c58bb98
# ╟─c7df238e-d997-436c-a1fa-467164ecd3e3
# ╟─9604ca3c-0ffb-46ca-81cc-4af079419dc6
# ╟─d35d8dfc-f307-4024-b9f2-f555705f8663
# ╟─0e761ab0-0470-4d9d-bf64-a1cb13d352c6
# ╟─3b5e57f4-6e9b-432d-880a-6d19be0bb9e8
# ╟─698e124c-64b7-4269-b874-e0d049259969
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
