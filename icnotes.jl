### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ 0b248756-8475-4c5b-82d6-741ae5d73f8d
using LinearAlgebra

# ╔═╡ cffcc58a-27da-4c87-9737-d4ae0a7d19b3
md"""
# 2022-08-23
## Numerical Analysis

-   Approximation

-   Algorithms

-   Create, analyze, implement algorithms for solving problems from continuous mathematics

-   Math problems arising from models of calculus

-   Newton, Euler, Lagrange, Gauss

-   Algorithm: set of instructions that process inputs to give back outputs

-   Proving theorems
    
    -> Existence & uniqueness of solutions
    
    -> Rate of convergence
    
    -> What is the error in the algorithm

-   Creating programs
    
    -> Accuracy
    
    -> Efficiency
    
    -> Stability

-   Use algorithms to solve problems mostly from calculus and linear algebra

-   Consider:
    -   Understand step of algorithm
    
    -   Identify & analyze errors
    
    -   Compute cost associated with algorithms
        
        -> Need to estimate time, memory
    
    -   When to use different algorithms
    
    -   Stability
        
        -> how small changes in inputs affect output
"""

# ╔═╡ eaefdbb1-230c-4558-a5ac-01f22f281c91
md"""
## Example 1

Best way to evaluate

$$P(x) = 2x^4 + 3x^3 - 3x^2 + 5x - 1 \quad @ \quad x = \frac{1}{2}$$

Obvious way:

$$P\left(\frac{1}{2}\right) = 2 \left(\frac{1}{2}\right)^4 + 3 \left(\frac{1}{2}\right)^3 - 3\left(\frac{1}{2}\right)^2 + 5 \left(\frac{1}{2}\right) - 1$$

Better way:

-> Nested multiplication/Horner's Method



## Example 2

Roots of $f(x) = 0$

Bisection, Newton's Method, Fixed Point Iteration



## Example 3 Interpolation

Given a set of data points find an approximating polynomoial that goes through all the points.



## Example 4

$$Ax = b$$
"""

# ╔═╡ 5c44aabc-247b-11ed-14b8-47bc9938cea5
md"""
# 2022-08-25

Numerical Analysis

- algorithms (create, analyze, implement)

- continuous mathematics

- linear algebra
"""

# ╔═╡ 96f88e4d-e634-4c18-944a-ca454965ab6c
md"""
## Section 1.2

Computers have finite precision

Consequences:

1. Can only represent some rational numbers

    - 9, 1000, 1024

    - 4/10 = 0.4 => nonterminating binary decimal

2. Round-off errors are inevitable

Round-off error: Error produced when a calculator/computer is used to perform real number arithmetic
"""

# ╔═╡ 7845aed3-2d70-4570-a8ad-1dc2e0941487
md"""
## IEEE

| Precision | Sign (s) | Exponent (c) | Mantissa (f) | Total |
|-----------|----------|--------------|--------------|-------|
| Single    | 1        | 8            | 23           | 32    |
| Double    | 1        | 11           | 52           | 64    |
| Extended  | 1        | 15           | 64           | 80    |

Normalized floating point representation (double precision)

$(-1)^s 2^{c - 1023} (1 + f), \qquad s ∈ \{0,1\}, \quad 0 ≤ c ≤ 2047$
"""

# ╔═╡ d305f73f-ea44-4199-8938-bb1f04e64652
md"""
## Ex 1

Consider machine number

$\underbrace{0}_{sign} \quad\underbrace{10000000011}_{exponent} \quad\underbrace{1011100100010⋯0}_{mantissa}$

$\begin{align*}
c &= 2^{10} (1) + 2^9 (0) + ⋯ + 2^1 (1) + 2^0 (1) \\
&= 2^{10} + 2 + 1 \\
&= 1024 + 2 + 1 \\
&= 1027
\end{align*}$

$2^{1027-1023} = 2^4$

$f = \frac{1}{2} + \frac{1}{2^3} + \frac{1}{2^4} + \frac{1}{2^5} + \frac{1}{2^8} + \frac{1}{2^{12}}$

Normalized floating point representation:

$2^4(1 + f) = 27.56640625$
"""

# ╔═╡ 8c31e561-adfd-4bbc-a9d3-363cc5e88508
md"""
## Binary machine numbers

$ϵ_{\text{mach}} = 2^{52} \quad\text{machine epsilon}$

Numbers less than ``ϵ_{\text{mach}}`` are representable but adding to 1 or another number has no effect

$1 + 2^{-53} = 1$

Smallest representable number (normalized) ``(s = 0, c = 1, f = 0)``

$(-1) 2^{1-1023}(1 + 0)= 2^{-1022}$

Largest representable number (normalized) ``(s = 0, c = 2046, f = 1 - 2^{52})``

$2^{1023}(2 - 2^{-52})$

Representing zero (normalized) ``(s = 0, c = 0, f = 0)`` or ``(s = 1, c = 0, f = 0)``

- +Inf ``(s = 0, c = 2017, f = 0)``

- -Inf ``(s = 1, c = 2047, f = 0)``

- NaN ``(s = 0 \text{ or } s = 1, c = 2047, f ≠ 0)``
"""

# ╔═╡ 2b5231fa-02b4-4254-adac-1ef4b96cd09b
md"""
## Underflow

- Condition when result of an arithmetic computation is smaller than the smallest number that can be represented

- defaults to zero
"""

# ╔═╡ b2eb34c3-c2af-49b0-82d9-e875598ad251
md"""
## Overflow

- larger than can be represented

- computations will terminate

- defaults to ``{+∞} / {-∞} / \text{NaN}``
"""

# ╔═╡ 3d326dda-53f7-48fe-94cd-ee0529677069
md"""
## Example 2

What happened to ``9.4 - 9 - 0.4`` in MATLAB?

$9 = \underbrace{0}_{sign} \quad \underbrace{00000001001}_{exponent} \quad \underbrace{00…000}_{mantissa}$


$0.4 = \underbrace{0}_{sign} \quad \underbrace{00…000}_{exponent} \quad \underbrace{01100110…0110}_{mantissa} \implies 0.4 + 0.2 × 2^{-52}$

$\begin{align*}
Expectation && 9.4 - 9 - 0.4 &= 0 \\
Reality && 9.4 - 9 - 0.4 &= 3 × 2^{-53}
\end{align*}$
"""

# ╔═╡ b26e2c07-78d0-4b75-bfe3-0d83246ecedc
md"""
## Decimal Machine Numbers

Why?
Binary Machine Numbers are complicated to deal with

Assume ``k``-digit decimal machine number

$±0.d_1 d_2 … d_k × 10^n \qquad d_1 ≠ 0, \quad 0 ≤ d_i ≤ 9, \quad i = 2, …, k$

$9 = +0.9000…0 × 10^1$

$y = 0.d_1 d_2 … d_k d_{k+1} d_{k+2} ⋯ × 10^n$

$fl(y) = 0.d_1 d_2 … d_k × 10^n$
"""

# ╔═╡ 07a24e03-7b90-4779-97f2-84a520e77723
md"""
## Rounding

Round: ``fl(y) = 0.δ_1 δ_2 … δ_k × 10^n``

``d_{k+1}≥5``, add 1 to ``d_k`` → round up → ``δ_i ≠ d_i``

``d_{k+1}<5``, round down → ``δ_i = d_i``
"""

# ╔═╡ 28735254-5904-4647-8166-0425b3bb3bce
md"""
## Ways of representing error

``p^*`` approximates ``p``

- Actual error: ``p - p^*``

- Absolute error: ``|p - p^*|``

- Relative error: ``\displaystyle \frac{|p - p^*|}{|p|}, \quad p ≠ 0``
"""

# ╔═╡ ad74d58e-95d0-4d9f-a5e9-b688573fe58f
md"# 2022-08-30"

# ╔═╡ c7439617-abe9-4e8a-8885-e604ac17da28
md"""
## Example 1

19b)

$\underbrace{1}_s \quad \underbrace{10000001010}_\text{11 bits for exponent} \quad \underbrace{10010011000…00}_\text{52 bits for mantissa}$

$-2^{11} \left(1 + \frac{1}{2} + \frac{1}{2^4} + \frac{1}{2^7} + \frac{1}{2^8}\right) = -\left(2^{11} + \frac{2^{11}}{2} + \frac{2^{11}}{2^4} + \frac{2^{11}}{2^7} + \frac{2^{11}}{2^8}\right) = -3224$

$c = 2^{10} + 2^3 + 2 = 1024 + 8 + 2 = 1034$

$f = \frac{1}{2} + \frac{1}{2^4} + \frac{1}{2^7} + \frac{1}{2^8}$
"""

# ╔═╡ a1004d29-1815-4ac3-8fef-4ae0b02e0a7d
md"""
## Decimal Machine Numbers

normalized ``k``-digit numbers

$0.d_1 d_2 d_3 … d_k × 10^n, \qquad 0 ≤ d_i ≤ 9, \quad i = 2, …k, \quad 1 ≤ d_1 ≤ 9$

any decimal #

$y = 0.d_1d_2d_3 …d_kd_{k+1}d_{k+2}…×10^n$

floating point number associated with ``y`` : ``fl(y)``

Chop:

$fl(y) = 0.d_1 d_2 … d_k × 10^n$

Round:

$\begin{align*}
fl(y) = 0.δ_1 δ_2 … δ_k × 10^n \\
d_{k+1} ≥ 5 \implies \text{round up} \implies \delta_i ≠ d_i \\
d_{k+1} < 5 \implies \text{round down} \implies \delta_i = d_i
\end{align*}$
"""

# ╔═╡ 0e5fb862-dc7e-45ac-b0de-ff7746ec6e40
md"""
## Example 3

Determine the 5 digit

a) Chopping of ``e``

b) Rounding of ``e``

**Solution.**

1st step: normalize ``e``:

``e^1 = 2.718281828… = 0.2718281828… × 10^1``

a) ``fl(e) = 0.27182 × 10^1``

b) ``fl(e) = 0.27183 × 10^1``
"""

# ╔═╡ 147224c2-792d-4dec-8d73-5a97f8190ed4
md"""
## Ways of approximating error

Suppose ``p^*`` approximates ``p``

- Actual error: ``p - p^*``

- Absolute error: ``|p - p^*|``

- Relative error: ``\displaystyle \frac{|p - p^*|}{|p|}, \quad p ≠ 0``
"""

# ╔═╡ f6656d21-fa78-4049-8101-537e138661a8
md"""
## Finite Digit Arithmetic

**Definition.**

$\begin{align*}
x ⊕ y &= fl(f(x) + fl(y)) \\
x ⊗ y &= fl(f(x) × fl(y)) \\
x ⊖ y &= fl(f(x) - fl(y)) \\
x ⨸ y &= fl(f(x) ÷ fl(y)) \\
\end{align*}$
"""

# ╔═╡ 26694b29-9a85-4bd8-9fba-06f6f8dfe50e
md"""
## Example

Suppose ``x = \frac{1}{3}, y = \frac{5}{7}``.
Use a 5 digit computer to calculate the following:

- ``x ⊕ y``

- ``x ⊗ y``

**Solution (Chopping).**

- ``x = 0.333333… × 10^0 \quad fl(x) = 0.33333×10^0``

- ``y = 0.714285… × 10^0 \quad fl(y) = 0.71428×10^0``

- ``x ⊕ y = fl(fl(x) + fl(y)) = fl(0.33333 + 0.71428) = fl(1.04761) = 0.10476 × 10^1``
"""

# ╔═╡ a55d2789-ba77-4b12-b822-f1257a1b5944
md"""
## Example

Let ``x = \sqrt{9.01}`` and ``y = 3``

Assume 3 digit computer.

``x ⊖ y``

``x = \sqrt{9.01} = 0.3001662… × 10^1``

``y = 0.300… × 10^1``

``fl(x) = 0.300 × 10^1``

``fl(y) = 0.300 × 10^1``

``fl(x) - fl(y) = 0``

Catastrophic cancellation

Let's try to "multiply by one" (conjugate)

$\sqrt{9.01} - 3 \left(\frac{\sqrt{9.01} + 3}{\sqrt{9.01} + 3}\right) = \frac{9.01 - 9}{\sqrt{9.01} + 3}$

$\frac{fl(9.01) - fl(9)}{fl(\sqrt{9.01}) + fl(3)} = \frac{0.901 × 10^1 - 0.9 × 10^1}{0.300×10^1 + 0.300×10^1} = \frac{0.001 × 10^1}{0.6 × 10^1} = 0.166 × 10^{-3}$
"""

# ╔═╡ 208c5c32-56ce-4a81-9c97-dc504387725a
md"""
Prepare section 1.3 for thursday
"""

# ╔═╡ 689b1d1e-0b4a-4fc2-b145-8ab5827099b8
md"""
# 2022-09-01
"""

# ╔═╡ 6f212283-3d93-405b-b711-68bd877e1f99
md"""
## Warm Up

How can we avoid catastrophic cancellation for the following:

$\frac{1 - \cos{(x)}}{\sin^2{(x)}}$

for what values of ``x`` are we in trouble?

_**Solution.**_ We are in trouble for values of ``x`` close to zero.
Rewrite the expression as

$\frac{1 - \cos{(x)}}{\sin^2{(x)}} = \frac{1 - \cos{(x)}}{1 - \cos^2{(x)}} = \frac{1 - \cos{(x)}}{(1 + \cos{(x)})(1 - \cos{(x)})} = \frac{1}{1 + \cos{(x)}}$
"""

# ╔═╡ 4880f4e7-41f2-4050-9f20-4799d866d2da
md"""
## Last class

- Round-off Errors

- Floating Point Arithmetic (Chop/Round)

  1. Subtracting numbers nearly equal to each other

  2. Divide by very large numbers

- Absolute & Relative Errors

- Big/Small Subjective

- Nested Arithmetic

  - Polynomials

  - Reduce round-off error by rearranging calculations

    - Ex: ``f(x) = 2x^4 + 3x^3 - 3x^2 + 5x - 1``, Compute @ x = ½.

      - Straightforward (10 multiplications, 4 additions):

        $\begin{align*}
        f\left(\frac{1}{2}\right) &= 2\left(\frac{1}{2}\right)^4 + 3\left(\frac{1}{2}\right)^3 - 3\left(\frac{1}{2}\right)^2 + 5\left(\frac{1}{2}\right) - 1 \\
        &= 2 \left(\frac{1}{2}⋅\frac{1}{2}⋅\frac{1}{2}⋅\frac{1}{2}\right) + 3\left(\frac{1}{2}⋅\frac{1}{2}⋅\frac{1}{2}\right) - 3\left(\frac{1}{2}⋅\frac{1}{2}\right) + 5⋅\frac{1}{2} - 1
        \end{align*}$

      - Method 2 (Store results) (7 multiplications, 4 additions):

        $\frac{1}{2}⋅\frac{1}{2} = \left(\frac{1}{2}\right)^2$

        $\left(\frac{1}{2}\right)^2 ⋅ \frac{1}{2} = \left(\frac{1}{2}\right)^3$

        $\left(\frac{1}{2}\right)^3 ⋅ \frac{1}{2} = \left(\frac{1}{2}\right)^4$

        $f\left(\frac{1}{2}\right) = 2 ⋅ \left(\frac{1}{2}\right)^3 - 3 \left(\frac{1}{2}\right)^2 + 5 \left(\frac{1}{2}\right) - 1$

      - Nested approach (4 multiplications, 4 additions):

        $\begin{align*}
        f(x) &= -1 + 5x - 3x^2 + 3x^3 + 2x^4 \\
        &= -1 + x(5 + x(-3 + x(3 + 2x)))
        \end{align*}$
"""

# ╔═╡ 9cbeca01-50fc-4756-b6af-18765def6329
md"""
## Characterizing Algorithms

Algorithms consists of a *finite* set of instructions that achieves a certain task on a computer.

1. Stable

2. Error - Rates of Convergence

3. Cost - Measured in number of floating point operations made
"""

# ╔═╡ 18838092-6a6d-400e-a065-73601b8e5471
md"""
## Numerical Stability

Algorithms that demonstrate large errors in outputs due to accumulation of arithmetic errors are numerically unstable.

Algorithms that are stable can recover from arithmetic errors.

Denote ``E_0 > 0`` as the error at some stage of a calculation; and ``E_n`` as the error after subsequent operations.

Define linear growth of error as ``E_n ≈ C n E_0`` where ``C`` is a constant independent of ``n``.

Exponential growth of error as ``E_n ≈ C^n E_0`` for some ``C > 1``.
"""

# ╔═╡ 19878cb0-3c46-43c1-bd81-46e92a7a34ab
md"""
## Rules of Convergence

### Sequences

Let ``\{x_n\}^*_{n=1}`` be an infinite sequence of real numbers.
The sequence converges to ``x`` if for any ``E > 0``, then there exists a positive integer ``N(ϵ)`` such that ``|x_n - x| < ϵ`` whenever ``n > N(ϵ)``

$\lim_{n→∞} x_n = x$

$x_n → x, n → ∞$

For an iterative algorithm you have some sequence ``\{x_n\}`` approximating ``x``.

Does the approximation get better as ``n → ∞``?

How fast are you approaching ``x``?
Equivalently, how quickly does the error decrease?
"""

# ╔═╡ 495c2646-89e4-4b40-a9b1-269bcc4ba4e4
md"""
## Example

Determine the rates of convergence for the following

a) ``\displaystyle α_n = \frac{n + 1}{n^2}, \quad \lim_{n→∞} α_n = 0``

b) ``\displaystyle α_n = \sin{\left(\frac{1}{n}\right)}, \quad \lim_{n→∞} α_n = 0``


_**Solution (a).**_

$\begin{align*}
|α_n - 0| = \frac{n+1}{n^2} &≤ \frac{n+n}{n^2}\\
&= \frac{2n}{n^2} \\
&= 2 ⋅ \frac{1}{n}, \text{ let } β_n = \frac{1}{n} \\
&= 2 β_n \\
\text{as fast as } \frac{1}{n} &→ 0
\end{align*}$

$α_n = 0 + O\left(\frac{1}{n}\right)$

$E_n = O\left(\frac{1}{n}\right) \quad \text{ error at step } n$

_**Solution (b).**_

$\hat{α}_n = \sin{\left(\frac{1}{n}\right)} ≤ \frac{1}{n}$

$n → ∞ \implies \sin{\left(\frac{1}{n}\right)} ≈ \frac{1}{n}$

$\sin{\left(\frac{1}{n}\right)} = 0 + O\left(\frac{1}{n}\right)$
"""

# ╔═╡ 30b62c00-4ead-4a5a-99a7-a3ac0428b232
md"""
## Big-Oh Relation for Functions

Suppose ``\displaystyle \lim_{h→0} G(h) = 0, \quad \lim_{h→0} F(h) = L``.

If there exists ``K > 0`` such that

$|F(h) - L| ≤ K|G(h)|$

then

$F(h) = L + O(G(h))$

Normally

$G(h) = h^p, \quad p > 0$

Want longest ``p`` such that ``F(h) = L + O(h^p)``
"""

# ╔═╡ f20bddb3-1f65-4cbb-a638-e643079c560a
md"# 2022-09-06"

# ╔═╡ 96f0eea8-aad2-43b3-b4a6-0cdb596e71d6
md"""
## Warm Up

True/False

If ``f`` is continuous on ``[a,b]`` and ``f(a) f(b) < 0`` then there exists ``p`` such that ``f(p) = 0``.

True. Intermediate Value Theorem
"""

# ╔═╡ 7ae9a472-3ea8-4322-bcd6-5461e4e35b1a
md"""
## Section 1.3

If ``∃ \;K > 0`` s.t.

$|α_n - α| ≤ K|β_n|$

where

$β_n = \frac{1}{n^p}$

$\frac{1}{n}, \frac{1}{n^2}, \frac{1}{n^4}$

$α_n = α + O(β_n)$
"""

# ╔═╡ b8fe81e4-13fe-42f4-9785-8ac09190006e
md"""
## Big Oh for functions

$\lim_{h→0} G(h) = 0$

$\lim_{h→0} F(h) = L$

$|F(h) - L| ≤ K|G(h)|$

$F(h) = L + O(G(h))$

$G(h) = h^p$

$h = \frac{1}{n}$
"""

# ╔═╡ 537bf5d9-60dd-4097-858b-e4b7bd79c20d
md"""
## Taylor's Theorem

Suppose ``f ∈ C^n([a,b])``, then ``f^{n+1}`` exists on ``[a,b]`` and ``x_0 ∈ [a,b]``.
For every ``x ∈ [a,b]`` there exists a number ``ξ(x)`` between ``x_0`` and ``x`` with ``f(x) = P_n(x) + R_n(x)``.

where

$\begin{align*}
P_n(x) &= f(x_0) + f'(x_0)(x - x_0) + \frac{f''(x_0)}{2!}(x - x_0)^2 + ⋯ + \frac{f^{(n)}{(x_0)}}{n!}(x - x_0)^n \\
&= \sum_{k=0}^n \frac{f^{(k)}(x_0)}{k!} (x - x_0)^k
\end{align*}$

and

$R_n(x) = \frac{f^{(n+1)}(ξ(x))}{(n + 1)!} (x - x_0)^{n+1}.$

``ξ(x)`` cannot be determined explicitly but lies between ``x_0`` and ``x``.

When ``n → ∞`` we get "Taylor Series".
When ``x_0 = 0`` we get "Maclaurin Series".
"""

# ╔═╡ e491d832-35a6-4315-b9b2-289dfe62a05e
md"""
## Example

Find the second Taylor polynomial and remainder for ``f(x) = \sin{(x)}`` about the point ``x_0 = 0``.

_**Solution.**_

``f ∈ C^∞(ℝ)``

$\begin{align*}
P_2(x) &= \sum_{k=0}^2 \frac{f^k(0)}{k!} x^k \\
&= f(0) + f'(0) ⋅ x + \frac{f''(0)}{2} x^2 \\
&= x
\end{align*}$

$\begin{align*}
R_2(x) &= \frac{f^3(ξ(x))}{3!} x^β \\
&= \frac{-\cos{ξ(x)}}{6} x^3
\end{align*}$
"""

# ╔═╡ 6428d0f4-243f-417d-a54f-1df72dbec447
md"""
## Example

Find an upper bound for using the second Taylor Polynomial around ``x_0 = 0`` for approximating ``f(x) = \sin{(x)}`` in the interval ``[-1,1]``.

_**Solution.**_

$\max_{x∈[-1,1]} \left|\frac{\cos{ξ(x)}}{6} x^3\right| ≤ \frac{1}{6} \max_{x∈[-1,1]} |x^3| ≤ \frac{1}{6}$
"""

# ╔═╡ aa8e7f84-3ae5-40c2-b8ab-c14620d7fa73
md"""
## Example

Determine the rate of convergence of

$\lim_{h→0} \frac{\sin{(h)}}{h} = 1$

$\sin(h) = h - \frac{1}{6} h^3 \cos{(ξ(h))}$

_**Solution.**_

$\frac{\sin(h)}{h} = 1 - \frac{1}{6} h^2 \cos{(ξ(h))}$

$\begin{align*}
\left|\frac{\sin(h)}{h} - 1\right| &= \left|\frac{1}{6} h^2 \cos{(ξ(h))}\right| \\
&≤ \frac{1}{6} h^2
\end{align*}$

$\frac{\sin(h)}{h} = 1 + O(h^2)$
"""

# ╔═╡ 4192fcba-7380-4142-828e-833544d2089b
md"""
## Chapter 2
"""

# ╔═╡ 993ad983-0a87-4d8b-acf5-0680b8c98baf
md"""
## Solutions of Equations in One Variable

Goal:
Find solutions to the root finding problem.
Find ``x`` such that ``f(x) = 0``.

Iterative:
Given same initial value we will generate a sequence of approximate solutions to the problem.
``n``th approximation will depend on previous values.

1. Bisection

2. Fixed point iteration

3. Newton's Method

4. Secant Method
"""

# ╔═╡ d7ff4882-ad10-4184-85da-11ee43839038
md"""
## Bisection Method

Idea based on IVT

Repeatedly halve the interval in search of ``p``.
The midpoint of the interval is our approximate value for ``p``.
Given ``[a,b]`` where ``f(a) f(b) < 0`` set ``a_1 = a``, ``b_1 = b`` find midpoint ``\displaystyle p_1 = \frac{a_1 + b_1}{2} = a_1 + \frac{b_1 - a_1}{2}``.

``p_1`` is first approximation to ``p``

Check is ``f(p_1) = 0``?

If yes then ``p = p_1``.

Else find interval where IVT is satisfied:

- If ``f(p_1)`` and ``f(a_1)`` have same sign:
  pick ``a_2 = p_1`` and ``b_2 = b_1``.

- If ``f(p_1)`` and ``f(a_1)`` have opposite signs:
  pick ``a_2 = a_1`` and ``b_2 = p_1``.

- Repeat process until root is found.

Generating ``\{p_n\}_{n=1}^∞`` that approximates ``p``
"""

# ╔═╡ ffc001e2-3f2a-458e-b860-2fa72eb6a0ec
md"""
## Example

Consider ``f(x) = x^5 - 4x + 1``

a) Show that ``f(x)`` has a root in the interval ``[0,1]``

b) Use Bisection Method to find a solution that is approximate to ``10^{-3}``

_**Solution.**_

a) ``f(0) = 1``, ``f(1) = -2`` so ``f(0)f(1) < 0`` so IVT applies and there is a root in the interval.

b) Actual ``p = 0.25024534…``

| n | aₙ | bₙ | pₙ | f(aₙ) | f(pₙ) | f(bₙ) |
|---|----|----|----|-------|-------|-------|
| 1 | 0 | 1 | 1/2 | 1 | -3/32 | -2 |
| 2 | 0 | 1/2 | 1/4 | 1 | 9.765625×10⁻⁴ | -31/32 |

$\frac{|p-p_2|}{|p|} = \frac{|0.25024… - 0.25|}{|0.25024…|} = 9.804… × 10^{-4} < 10^{-3}$
"""

# ╔═╡ b69083e6-15cf-4b86-8024-1be1bf0aa5ba
md"""
## Theorem 2.1

Suppose ``f ∈ C([a,b])`` and ``f(a)f(b) < 0``.
The Bisection method generates a sequence ``\{p_n\}^∞_{n=1}`` approximating a zero ``p`` of ``f`` with

$|p_n - p| ≤ \frac{b-a}{2^n},\quad\text{when}\quad n ≥ 1.$

*Proof.*

Note that ``b_1 - a_1 = \frac{b - a}{2^n}, b_2 - a_2 = \frac{1}{2} (b_1 - a_1) = \frac{b - a}{2}``.

$b_3 - a_3 = \frac{b_2 - a_2}{2} = \frac{b - a}{2^2}, …$

For ``n ≥ 1``, ``\displaystyle b_n - a_n = \frac{b - a}{2^{n-1}}`` and ``p ∈ (a_n,b_n)``.

Since ``\displaystyle p_n = \frac{a_n + b_n}{2}`` for all ``n ≥ 1``,

$\begin{align*}
|p_n - p| &≤ \frac{1}{2} (b_n - a_n) \\
&= \frac{1}{2} \frac{(b - a)}{2^{n-1}} \\
&= \frac{b - a}{2^n}
\end{align*}$

Since ``|p_n - p| ≤ \frac{b - a}{2^n}``

$p_n = p + O\left(\frac{1}{2^n}\right)$

This bound can be very loose ⟹ in reality the actual error can be much smaller than the bound.
"""

# ╔═╡ 7e3e7d9a-70d8-479e-b862-194e03e5ff42
md"""
## Example

Find number of iterations necessary to find root of ``x^5 - 4x + 1 = 0`` in ``[0,1]`` accurate to ``10^{-3}``

$\begin{align*}
|p - p_n| ≤ \frac{b - a}{2^n} < 10^{-3} \\
\frac{1}{2^n} < 10^{-3} \\
\log_{10}\left(\frac{1}{2^n}\right) < \log_{10} (10^{-3}) \\
-n \log_{10}{2} < -3 \\
n > \frac{3}{\log_{10}{2}} = 9.965…
\end{align*}$
"""

# ╔═╡ 3a070391-7df9-4728-a7c6-92d798670206
md"# 2022-09-08"

# ╔═╡ a3fe59f2-95a2-48d6-9ade-ab65a513ff9a
md"""
## Warm-Up

True/False:

If ``f`` is continuous over ``[a,b]`` then there exists a number ``c ∈ (a,b)`` such that ``\displaystyle f'(c) = \frac{f(b) - f(a)}{b - a}``.

**False**

This is close, but not quite true.
We need to add that "``f`` is differentiable over ``(a,b)``".

Correct statement (Mean Value Theorem):

If ``f`` is continuous over ``[a,b]`` and ``f`` is differentiable over ``(a,b)`` then there exists a number ``c ∈ (a,b)`` such that ``\displaystyle f'(c) = \frac{f(b) - f(a)}{b - a}``.
"""

# ╔═╡ 5bd94a2f-c956-4e97-8977-82c020270c51
md"""
## Fixed-Point Iteration

The real number ``p`` is a fixed point for a function ``g`` if ``g(p) = p``.

Find ``x`` s.t. ``f(x) = 0``

Root finding problem → Fixed Point Problem

Given ``f(p) = 0`` then define function ``g`` with fixed point at ``p``.
This ``g`` is not unique.

- (a) ``g(x) = x - f(x)``

  - ``g(p) = p = p - f(p)``

  - then ``f(p) = 0``

- (b) ``g(x) = x + cf(x)`` where ``c`` is a real number

  - ``g(p) = p``

  - ``p = p + cf(p)``

  - ``0 = cf(p)``

  - ``f(p) = 0``

Fixed point → Root finding

Given a ``g`` with a fixed point of ``p`` then

$f(x) = x - g(x)$

$\begin{align*}
f(p) &= p - g(p) \\
&= p - p \\
&= 0
\end{align*}$
"""

# ╔═╡ 4f178cca-2069-491e-a6cc-3ee93d5a9479
md"""
## Example

Find all the fixed points of the function

$g(x) = 2x - x^2$

Find all ``p`` s.t. ``g(p) = p``

$\begin{align*}
2p - p^2 &= p \\
p^2 - p &= 0 \\
p(p - 1) &= 0
\end{align*}$

so ``p = 0`` or ``p = 1``.
"""

# ╔═╡ 55e36783-5ede-44fd-8e94-c457310918a4
md"""
## Theorem 2.3

Sufficient conditions for existence & uniqueness of a fixed point.

i) [Existence] ``g ∈ C([a,b])`` and ``g(x) ∈ [a,b]`` for all ``x ∈ [a,b]`` then ``g`` has at least one fixed point in ``[a,b]``

ii) [Uniqueness] In addition if ``g'(x)`` exists on ``(a,b)`` and ``∃ \;k < 1`` with

$|g'(x)| ≤ k$

then the fixed point is unique.

_**Proof.**_

i) If ``g(a) = a`` or ``g(b) = b`` then the fixed point is at the endpoint;
   Else ``g(a) > a`` and ``g(b) < b``;
   Define ``h(x) = g(x) - x``;
   ``h(x)`` is continuous on ``[a,b]``;
   ``h(a) = g(a) - a > 0``;
   ``h(b) = g(b) - b < 0``;
   By the IVT, ``∃\;p ∈ (a,b)`` s.t. ``h(p) = 0``;
   ``0 = h(p) = g(p) - p \implies g(p) = p`` and ``p`` is a fixed point.

ii) Suppose ``|g'(x)| ≤ k < 1``;
    Assume ``g(p) = p`` and ``g(q) = q`` in ``[a,b]`` where ``p ≠ q``;
    By MVT, ``∃\;ξ∈[a,b]`` s.t. ``g'(ξ) = \frac{g(p) - g(q)}{p - q}``;

$\begin{align*}
|p - q| &= |g(p) - g(q)| \\
&= |g'(ξ)| |p - q| \\
&≤ k |p - q| < |p - q|
\end{align*}$
"""

# ╔═╡ 20eddabe-d9ee-4d6f-8a2a-8936ca596f04
md"""
## Example

$g(x) = \frac{x^2 - 1}{3}$

Interval ``[-1,1]``
"""

# ╔═╡ 48e71d08-71f2-4480-ac83-b1583fa8695b
md"""
## Fixed Point Iteration

Choose initial approximation ``p_0``;
Generate sequence ``\{p_n\}_{n=0}^∞``;

$p_n = g(p_{n-1})$

If sequence converges and ``g`` is continuous.

$p = \lim_{n→∞} p_n = \lim_{n→∞} g(p_{n-1}) = g(\lim_{n→∞} p_{n-1}) = g(p)$

Solution found.

Ways to convert root finding → fixed point.

Some lead to sequence that don't converge.

Some sequences converge faster than others.

**Want** Fixed point problem that generates a convergent sequence and converges quickly
"""

# ╔═╡ 564355cd-cd5a-4c94-beca-b127d589b2ee
md"""
## Theorem 2.4

``g ∈ C([a,b])``

``g : [a,b] → [a,b]``

``g'`` to exist on ``(a,b)``

and ``∃ \; k \quad 0 < k < 1``

s.t. ``|g'(x)| < k`` for all ``x ∈ (a,b)``

Then for any number ``p_0`` in ``[a,b]`` the sequence ``p_n = g(p_{n-1}) \quad n ≥ 1`` converges to a unique fixed point.
"""

# ╔═╡ a52a3510-aa63-4c12-a1d4-c59c0b30206a
md"""
## Corollary 2.5

If ``g`` satisfies Theorem 2.4 then the bounds for the error are

$|p_n - p| ≤ k^n \max\{p_0 - a, b - p_0\}$

and

$|p_n - p| ≤ \frac{k^n}{1 - k} |p_1 - p_0| \quad \text{ for all } n ≥ 1$
"""

# ╔═╡ cf1df799-902e-42ba-a229-6423606db4f3
md"# 2022-09-13"

# ╔═╡ 08e83883-5c62-46c8-ad6a-6dda06a3f536
md"""
## Warm Up

Are these problems equivalent

1. ``x^3 + x - 1 = 0``

2. ``\displaystyle \frac{1 + 2x^3}{1 + 3x^2} = x``

**Solution**

No. (1) is a root-finding problem while (2) is a fixed-point problem
"""

# ╔═╡ e7664cd1-19c6-4790-b5d6-40e0876daa68
md"""
## Bisection Method

Root-finding problem ``f(x) = 0``

``f(a) f(b) < 0``

``\{p_n\}_{n=1}^∞``

``p_n`` - midpoint of interval

Error bound:

$|p_n - p| ≤ \frac{b - a}{2^n}$

$\frac{b - a}{2^n} < 10^{-6}$
"""

# ╔═╡ de880347-c6ab-4e65-8963-c78f852d241b
md"""
## Fixed Point Iteration

``f(x) = 0``

Reformulate problem to ``g(x) = x``

e.g., ``g(x) = x + f(x)``

``p = g(p) = p + f(p)``

``f(p) = 0``

``\{p_n\}_{n=0}^∞``

``p_0`` is given

``p_n = g(p_{n-1})``, ``n ≥ 1``

Theorem 2.4 (Fixed-Point Theorem):

``g ∈ C[a,b]``

``g : [a,b] → [a,b]``

``g'`` exists on ``(a,b)``

``|g'(x)| ≤ k`` for all ``x ∈ (a,b)``

``k ∈ (0,1)``

Error Bounds (Corollary 2.5):

``|p_n - p| ≤ k^n \max\{p_0 - a, b - p_0\}``

and (more important)

``\displaystyle |p_n - p| ≤ \frac{k^n}{1 - k} |p_1 - p_0|``
"""

# ╔═╡ d23b4a9f-9bb5-4140-9f94-b754bee8bcea
md"""
## Newton's Method

- Developed Isaac Newton

- Newton-Raphson

- Root-finding problem ``f(x) = 0``

At ``p_0`` we know ``(p_0,f(p_0))`` ``f'(x)`` then we can determine ``f'(p_0)`` -- slope of the tangent line at ``(p_0,f(p_0))``

``y = mp + b``

``\displaystyle \frac{y - f(p_0)}{p - p_0} = f'(p_0)``

``y - f(p_0) = f'(p_0) (p - p_0)``

``-f(p_0) = f'(p_0)(p - p_0)``

``\displaystyle p_1 = p_0 - \frac{f(p_0)}{f'(p_0)}``

Newton's Method:

``\displaystyle p_n = p_{n-1} - \frac{f(p_{n-1})}{f'(p_{n-1})}, \quad n ≥ 1``
"""

# ╔═╡ 0abe2ab7-ab69-4c3b-89c0-f325b75fa716
md"""
## Example

``f(x) = \cos(x) - x = 0``

Find ``p_1`` for Newton's method given ``p_0 = π/4``

``f'(x) = -\sin(x) - 1``

$p_1 = \frac{π}{4} - \frac{\cos(π/4) - π/4}{-\sin(π/4) - 1} = \frac{π}{4} - \frac{π/2 - π/4}{-π/2 - 1}$
"""

# ╔═╡ 41c5412c-a8f1-4beb-ade8-91784c30f947
md"""
## Convergence of Newton's Method

The choice of ``p_0`` is crucial for convergence.
"""

# ╔═╡ c74768f3-2385-4c3a-9ed0-4d70e4ca2760
md"""
## Theorem 2.6

Let ``f ∈ C^2([a,b])``.
If ``p ∈ (a,b)`` such that ``f(p) = 0`` and ``f'(p) ≠ 0`` then there exists ``δ > 0`` such that Newton's Method generates a sequence ``\{p_n\}_{n=0}^∞`` converging to ``p`` for any initial guess ``p_0 ∈ [p - δ, p + δ]``

*Gist of proof.*

- Satisfy conditions of Theorem 2.4: Fixed Point Theorem

``g ∈ C[a,b], \; g : [a,b] → [a,b]``

``|g'(x)| ≤ k, \; k ∈ (0,1) \quad ∀x ∈ (a,b)``

for Newton's Method

$g(x) = x - \frac{f(x)}{f'(x)}$

1. ``g`` is continuous and defined on some interval ``[p - δ_1, p + δ_1]``

2. ``g`` is continuously differentiable on ``[p - δ_1, p + δ_1]``

3. There exists ``0 < δ < δ_1`` such that ``|g'(x)| ≤ k`` for ``x ∈ [p - δ, p + δ] ⊆ [p - δ_1, p + δ_1]``

4. ``g`` maps ``[p - δ, p + δ]`` to itself
"""

# ╔═╡ e2ac4adc-d34a-41c0-af13-8f3d2837049c
md"""
## Secant Method

Making the approximation

$f'(p_{n-1}) ≈ \frac{f(p_{n-1}) - f(p_{n-2})}{p_{n-1} - p_{n-2}} \;⟶\; p_n = p_{n-1} - \frac{f(p_{n-1})}{f'(p_{n-1})}$

$\implies p_n = p_{n-1} - \frac{f(p_{n-1})(p_{n-1} - p_{n-2})}{f(p_{n-1}) - f(p_{n-2})}, \quad n ≥ 2$
"""

# ╔═╡ e3db0115-325d-4bbc-bb09-559753338bc2
md"# 2022-09-20"

# ╔═╡ 8a2bac83-dd23-40ce-b80a-797f891f5763
md"## Order of Convergence"

# ╔═╡ 3d9f33ec-2659-4c5f-bfb5-e4bc43dce23c
md"""
**Linearly**

$\lim_{n→∞} \frac{|p_{n+1} - p|}{|p_n - p|} = λ ≤ 1$

**Sub-Linear**

$\lim_{n→∞} \frac{|p_{n+1} - p|}{|p_n - p|} = 1$

**Quadratic**

$\lim_{n→∞} \frac{|p_{n+1} - p|}{|p_n - p|^2} = λ < ∞$
"""

# ╔═╡ 28ee5df1-fdf6-4ace-ba67-7dbb70828d34
md"""
## Example (Sec 2.4 Exercise 7)

a) Show that for any positive integer ``k``, the sequence defined by ``p_n = \frac{1}{n^k}`` converges linearly to ``p = 0``.

b) For each pair of integers ``k`` and ``m``, determine a number ``N`` for which ``\frac{1}{N^k} < 10^{-m}``.

_**Solution (a).**_

$\lim_{n→∞} \frac{\left|\frac{1}{(n + 1)^k} - 0\right|}{\left|\frac{1}{n^k} - 0\right|} = \lim_{n→∞} \left|\frac{n^k}{(n + 1)^k}\right| = \lim_{n→∞} \left|\frac{n}{n + 1}\right|^k = \lim_{n→∞} \left|\frac{1}{1 + \frac{1}{n}}\right|^k = 1$

_**Solution (b).**_

Patrick's way:

$N^{-k} < 10^{-m} \implies N > 10^{m/k}$

Prof's way:

$\begin{align*}
N^k &> 10^m \\
k \log_{10} N &> m \\
\log_{10} N &> \frac{m}{k} \\
10^{\log_{10}{N}} &> 10^{m/k} \\
N &> 10^{m/k}
\end{align*}$
"""

# ╔═╡ b652d9e0-f93d-434f-9f3a-9fba372c4472
md"""
## Quadratic Convergence for Newton's Method

If ``f(p) = 0`` and ``f'(p) ≠ 0`` then for starting values sufficiently close to ``p``, Newton's method converges quadratically.

$p_n = p_{n - 1} - \frac{f(p_{n-1})}{f'(p_{n-1})}$

$p_n = g(p_{n-1})$
"""

# ╔═╡ e7dec4c2-097c-42ae-82ce-244d6d1fc864
md"""
## How to handle multiple roots for Newton's method

Let ``\displaystyle μ(x) = \frac{f(x)}{f'(x)}``

If ``p`` is a zero of ``f`` with multiplicity ``m``

$f(x) = (x - p)^m q(x) \quad\text{ then }$

$\begin{align*}
μ(x) &= \frac{(x - p)^m q(x)}{m(x - p)^{m - 1} q(x) + (x - p)^m q'(x)} \\
&= \frac{(x - p)^{m-1}}{(x - p)^{m-1}} \frac{(x - p)q(x)}{m q(x) + (x - p) q'(x)}
\end{align*}$

``μ(p) = 0`` so ``μ(x)`` has a zero at ``p``.
Since ``q(p) ≠ 0``.
"""

# ╔═╡ 2b183a03-8a5e-49f4-8e08-a90befad1166
md"""
## Modified Newton's Method

$p_n = p_{n-1} - \frac{f(p_{n-1}) f'(p_{n-1})}{(f'(p_{n-1}))^2 - f(p_{n-1}) f''(p_{n-1})}$

(+) Quadratic convergence regardless of multiplicity of zero at ``f``

(-) Extra calculation of ``f''``

(-) Possible round-off error for terms in denominator.
"""

# ╔═╡ 72906229-7393-4454-8903-c4a9d0a2769d
md"# 2022-09-22"

# ╔═╡ 304463f9-6661-44a4-8e47-1448ecfa314b
md"""
## Warm Up

$f(x) = e^x - x - 1$

Show that ``f`` has a zero of multiplicity 2 at ``x = 0``

$\begin{align*}
f(0) &= e^x - 0 - 1 = 0 \\
f'(x) &= e^x - 1 \implies f'(0) = 1 - 1 = 0 \\
f''(x) &= e^x \implies f''(0) = 1 ≠ 0
\end{align*}$
"""

# ╔═╡ 7148b4c4-1355-4c14-879a-ee8f209ad632
md"""
## Chapter 3: Interpolation

Problem: Given a set of data points, find the best polynomial that fits the data.

1. Given ``f(x)`` complicated ``(x_k, f(x_k))^n``

2. ``(x_k, y_k)^n``

Why?

1. Straightforward Mathematical properties of Polynomials

   ``P(x) = c_n x^n + c_{n-1} x^{n-1} + c_{n-2}x^{n-2} + ⋯ + c_2 x^2 + c_1 x^1 + c_0``

   "``n``th degree polynomial"

2. Derivatives & Integrals are easy to compute

3. Complicated functions can be approximated by interpolating polynomials

Types of interpolation

1. Lagrange Interpolation

2. Newton's Divided Difference

3. Hermite Interpolation

4. Cubic Splines - Natural Splines
"""

# ╔═╡ 82b8af49-59b8-4098-b5df-c8a7681bc5d3
md"""
## Idea 1

Consider the Taylor polynomial about a specific point ``x_0`` ``n``th degree Taylor polynomial

$f(x) = \sum_{k=0}^n \frac{f^k(x_0)}{k!} (x - x_0)^k + \frac{f^{n+1}(ξ)}{(n + 1)!} (x - x_0)^{n + 1}$
"""

# ╔═╡ 2cdcdbd1-1818-4112-9c21-1bc0846ba525
md"""
## Want

Good approximation for ``x`` within a large interval.
"""

# ╔═╡ 4af39427-d6c4-469b-a19a-05ef60c85428
md"""
## Lagrange Interpolant

Given ``n + 1`` data points ``\{(x_k, y_k)\}^n_{k=0}`` where ``\{x_k\}^n_{k=0}`` are distinct nodes we want to find a polynomial ``P(x)`` that passes through all the points.

Same as approaching ``f`` where ``y_k = f(x_k)``

Consider the case where we have ``(x_0,y_0)`` and ``(x_1,y_1)``

Define ``L_0(x) = \frac{x - x_1}{x_0 - x_1}``, ``L_1(x) = \frac{x - x_0}{x_1 - x_0}``

Note that

$\begin{align*}
L_0(x_0) &= 1 \\
L_0(x_1) &= 0 \\
L_1(x_0) &= 0 \\
L_1(x_1) &= 1
\end{align*}$

Linear Lagrange interpolating polynomial

$P(x) = y_0 L_0(x) + y_1 L_1(x)$

$y_0 = f(x_0), y_1 = f(x_1)$

$P(x) = f(x_0) L_0(x) + f(x_1) L_1(x) = f(x_0) \frac{x - x_1}{x_0 - x_1} + f(x_1) \frac{x - x_0}{x_1 - x_0}$

$P(x_0) = f(x_0)$

$P(x_1) = f(x_1)$

Exact points ``(x_0, f(x_0))`` and ``(x_1, f(x_1))``

``P`` is the unique polynomial of degree of most one that passes through ``(x_0,f(x_0))`` and ``(x_1,f(x_1))``.
"""

# ╔═╡ f29af101-1a1c-40d7-ac2a-a56fb68539d8
md"""
## Example

Determine Lagrange interpolating polynomial through ``(x_0,y_0) = (-3,4)`` and ``(x_1,y_1) = (5,-1)``.

$L_0(x) = \frac{x - x_1}{x_0 - x_1} = \frac{x - 5}{-3 - 5} = -\frac{1}{8} (x - 5)$

$L_1(x) = \frac{x - x_0}{x_1 - x_0} = \frac{x - (-3)}{5 - (-3)} = \frac{1}{8} (x + 3)$

$\begin{align*}
P(x) &= y_0 L_0(x) + y_1 L_1(x) \\
&= -\frac{4}{8} (x - 5) - \frac{1}{8}(x + 3) \\
&= -\frac{5}{8} x + \frac{17}{8}
\end{align*}$
"""

# ╔═╡ 89b91125-51a3-4a40-9b70-40408a81162c
md"""
## Kronecker Delta

$L_{n,k}(x_i) = δ_{n,k} = \begin{cases} 0 & \text{if } i ≠ k \\ 1 & \text{if } i = k \end{cases}$

$L_{n,k}(k) = \frac{(x - x_0)(x - x_1) ⋯ (x - x_n)}{(x_k - x_0)(x_k - x_1) ⋯ (x_k - x_n)} = \prod_{i=0,i≠k}^n \frac{x - x_i}{x_k - x_i}$

$\begin{align*}
P(x) &= \sum_{k=0}^n f(x_k) L_{n,k} (x) \\
&= f(x_0) L_{n,0}(x) + f(x_1) L_{n,1}(x) + ⋯ + f(x_n)
\end{align*}$
"""

# ╔═╡ 7c888c5e-8100-44ff-8278-5fe28d608a2b
md"""
## Theorem 3.2

Existence & uniqueness of Lagrange Interpolating Polynomial ``P(x)``
"""

# ╔═╡ 3e1fadd8-4c82-468e-9193-95100f64cd4e
md"# 2022-09-27"

# ╔═╡ 3c53c25a-39af-4f36-9a3f-dee81594043b
md"""
## Interpolation

Given *distinct* ``n + 1`` points ``\{(x_k, f(x_k))\}_{k=0}^n`` find a degree ``n`` Polynomial that goes through points ``P(x)``
"""

# ╔═╡ d316dcca-714e-4aa4-93ca-471a8c0161a3
md"""
## Ways of writing Polynomials

1. $P_n(x) = a_n x^n + a_{n-1} x^{n-1} + ⋯ + a_2 x^2 + a_1 x + a_0 = \sum_{k=0}^n a_k x^k$

   Basis = ``\{1,x,x^2,…,x^n\}`` 

   e.g., ``x^2 - 2x + 1``


2. Lagrange Interpolation

   $P_n(x) = \sum_{k=0}^n a_k L_{n,k}(x) \qquad a_k = f(x_k)$

   $L_{n,k}(x) = \prod_{i = 0, \,i ≠ k}^n \frac{x - x_i}{x_k - x_i}$

   $L_{n,k}(x_i) = δ_{ik} = \begin{cases} 0 &\text{if } i ≠ k \\ 1 &\text{if } i = k \end{cases}$
"""

# ╔═╡ 64554874-b845-4ef4-9b44-3393cb71c49c
md"""
## Error Bound

Assuming ``n + 1`` points

$|f(x) - P_n(x)| ≤ \left|\frac{f^{n+1}(ξ(x))}{(n + 1)!} \prod_{i=0}^n (x - x_i)\right|$

$\prod_{i=0}^n (x - x_i) = (x - x_0)(x - x_1) ⋯ (x - x_n)$
"""

# ╔═╡ ff36b7e9-ff58-430d-ad57-3f3837f943e0
md"""
## Example

Error form for a polynomial ``P(x)`` that approximates ``f(x) = 1/x`` when ``[2,4]`` using nodes ``x_0 = 2, x_1 = 2.75, x_2 = 4``.
What is maximum error when ``P(x)`` is used to approximate ``f(x)`` in ``[2,4]``?

_**Solution.**_

``f'''(x) = \;?``

``f(x) = x^{-1}, \quad f'(x) = -x^{-2}``

``f''(x) = 2x^{-3}, \quad f'''(x) = -6x^{-4}``


$\begin{align*}
\frac{f'''(ξ(x))}{3!} (x - 2)(x - 2.75)(x - 4) &= \frac{-6ξ(x)^{-4}}{6} (x - 2)(x - 2.75)(x - 4) \\
&= -ξ(x)^{-4} (x - 2)(x - 2.75)(x - 4)
\end{align*}$

$\max\left|-ξ(x)^{-4}(x - 2)(x - 2.75)(x - 4)\right|$

$\max_{x∈[2,4]} ξ(x)^{-4} = 2^{-4} = \frac{1}{16}$

(``x^{-4}`` is decreasing on ``[2,4]`` which implies ``2`` is the max.)


Let ``g(x) = (x - 2)(x - 2.75)(x - 4) = x^3 - \frac{35}{4} x^2 + \frac{49}{2} x - 22``

``\displaystyle \max_{x ∈ [2,4]} g(x) = \;?``

Find the critical points ``(g'(x) = 0)``

$\begin{align*}
g'(x) &= 3x^2 - \frac{35}{2} x + \frac{49}{2} = 0 \\
&= \frac{1}{2} (6x^2 - 35x + 49) = 0 \\
&= \frac{1}{2} (3x - 7)(2x - 7) = 0
\end{align*}$

$x = \frac{7}{3} \quad\text{ or }\quad x = \frac{7}{2}$

$\text{Critical point values} = \begin{cases}
g(\frac{7}{3}) = \frac{25}{108} \\
g(\frac{7}{2}) = -\frac{9}{16}
\end{cases}$

$\text{Endpoints} = \begin{cases}
g(2) = 0 \\
g(4) = 0
\end{cases}$

$\max|ξ(x)^{-4} (x - 2)(x - 2.75)(x - 4)| ≤ \left|\frac{1}{16} ⋅ \frac{9}{16}\right| = \frac{9}{256} ≈ 0.03515625$
"""

# ╔═╡ 006e9988-bb1a-4e6c-b9b0-1e8c3d94ceac
md"""
## Newton's Divided Differences

- Lagrange Form is normally used in an analytical scenario.

- Alternate algorithm representation for the unique polnoymial that goes through distinct nodes ``\{x_k\}_{k=0}^n``

$\begin{align*}
P_n(x) &= a_0 + a_1(x - x_0) + a_2(x - x_p)(x - x_1) + ⋯ + a_n(x - x_0)(x - x_1) ⋯ (x - x_{n-1}) \\
&= a_0 + \sum_{k=1}^n a_k \prod_{j=0}^{k-1} (x - x_j)
\end{align*}$

``P_n(x)`` exact at nodes ``\{x_k\}_{k=0}^n``

What are the coefficients ``a_k``?

$P_n(x_0) = a_0 = f(x_0)$
"""

# ╔═╡ a0c82316-6858-4d77-ab5a-1d6115bbe710
md"""
## Define divided differences in recursive fashion

$f[x_i] = f(x_i)$

$f[x_i,x_{i+1}] = \frac{f(x_{i+1}) - f(x_i)}{x_{i+1} - x_i}$

$f[x_i,x_{i+1},x_{i+2}] = \frac{f[x_{i+1},x_{i+2}] - f[x_i,x_{i+1}]}{x_{i+2} - x_i}$

$f[x_i,x_{i+1},x_{i+2},x_{i+3}] = \frac{f[x_{i+1},x_{i+2},x_{i+3}] - f[x_i,x_{i+1},x_{i+2}]}{x_{i+3} - x_i}$

$a_k = f[x_0,x_1,…,x_k]$

$P_n(x) = f[x_0] + \sum_{k=1}^n f[x_0,x_1,…,x_k](x - x_0)⋯(x - x_{k-1})$
"""

# ╔═╡ 0c4f8e25-285e-4c82-9752-12bbd1cc7b8c
md"# 2022-09-29"

# ╔═╡ e0f049d9-7cc1-4fb8-81b6-6179795fa2d6
md"""
### Interpolation

1. Lagrange

2. Newton's Divided Differences
"""

# ╔═╡ e493166b-d34a-48fb-9bd5-c2cf80ade67e
md"""
### Hermite Interpolation

For Lagrange approximating polynomial is exact at the nodes ``P(x_k) = f(x_k)``.

Supose we have ``\{x_k,f(x_k)f'(x_k)\}_{k=0}^n`` and assuming ``\{x_k\}_{k=0}^n`` distinct ``H(x)`` such that

$H(x_k) = f(x_k)$

$H'(x_k) = f'(x_k)$

for ``k = 0, 1, …, n``

Given ``2n + 2`` data points, ``H_{2n+1}(x)`` is unique

$H_{2n+1}(x) = \sum_{j=0}^n f(x_j) H_{n,j}(x) + \sum_{j=0}^n f'(x_j) \hat{H}_{n,j}(x)$

$H_{2n+1}(x) = \sum_{j=0}^n f(x_j) H_{n,j}(x) + \sum_{j=0}^n f'(x_j) \hat{H}_{n,j}(x)$

where

$H_{n,j}(x) = \left[1 - 2(x-x_j)L_{n,j}'(x)\right] L_{n,j}^2(x)$

$\hat{H}_{n,j}(x) = (x - x_j)L_{n,j}^2(x)$

$L_{n,j}(x) = \prod_{\substack{i=0\\i≠j}}^n \frac{(x-x_i)}{(x_j-x_i)} \qquad \text{Lagrange Basis Functions}$

**Want to check:**

$H(x_k) = f(x_k)$

$H'(x_k) = f'(x_k)$

$L_{n,j}(x_i) = \begin{cases} 0 & i ≠ j \\ 1 & i = j \end{cases}$

$H_{n,j}(x_i) = 0 \quad\text{when}\quad i ≠ j$

$\hat{H}_{n,j}(x_i) = 0 \quad\text{when}\quad i ≠ j$

Case: ``i = j``

$H_{n,i}(x_i) = 1 - 2(x_i - x_i)L_{n,i}'(x_i) = 1$

$\hat{H}_{n,i}(x_i) = 0$

$H_{2n+1}(x_i) = \sum_{\substack{j=0\\j≠i}}^n f(xy) ⋅ 0 + f(x_i) ⋅ 1 + \sum_{j=0}^n f'(x_j) ⋅ 0 = f(x_i)$

DO THIS BY YOURSELF: Confirm ``H_{2n+1}'(x_i) = f'(x_i)`` for all ``i`` given.
"""

# ╔═╡ 707dd81f-399b-4b65-8372-d463993e88d5
md"""
### Example

$n = 1$

Calculating, we get:

$H_{1,0}(x) = 2x^3 - 3x^2 + 1$

$\hat{H}_{1,0}(x) = x^3 - 2x^2 + x$

$H_{1,1}(x) = -2x^3 + 3x^2$

$\hat{H}_{1,1}(x) = x^3 - x^2$

$\begin{align*}
H_3(x) &= 0 ⋅ H_{1,0}(x) + 1 ⋅ H_{1,1}(x) + 1 ⋅ \hat{H}_{1,0}(x) + 0 ⋅ \hat{H}_{1,1}(x) \\
&= -2x^3 + 3x^2 + x^3 - 2x^2 + x \\
&= -x^3 + x^2 + x
\end{align*}$
"""

# ╔═╡ 04531271-325a-4b2e-8b28-fee3ab6d7ee6
md"""
### Exam note

You'll have to find a Hermite interpolating polynomial in the exam, but you should know which ones will be zero before calculating to prevent extra work.
"""

# ╔═╡ 04ad10ae-4f31-4637-b9c3-32c8321d5391
md"""
### Divided Differences for Hermite Interpolation

$P_n(x) = f[x_0] + \sum_{k=1}^n f[x_0,x_1,…,x_k] (x - x_0) ⋯ (x - x_{k-1}).$
"""

# ╔═╡ 566c6ee2-e808-40c0-b280-08c87cafd12f
md"# 2022-10-04"

# ╔═╡ 045f13b9-49cd-4289-be8d-47f7079e3b05
md"""
### Chapter 3

→ Lagrange Interpolation

$\{(x_k, f(x_k))\}_{k=0}^n, \qquad P_n(x) = \sum_{k=0}^n f(x_k) L_{n,k}(x)$

→ Newton's Divided Differences

$P(x) = f[x] + \sum_{k=1}^n f[x_0,x_1,…,x_k] (x - x_0) (x - x_1) ⋯ (x - x_k)$

→ Runge Phenomenon - As ``n`` increases, the approximation towards the endpoints of an interval becomes worse

- To fix Runge Phenomenon, use Chebyshev Interpolation

→ Hermite Interpolation

- If you have ``n + 1`` of ``(x_k, f(x_k))`` and ``(x_k, f'(x_k))`` then you can create the Hermite interpolating polynomial ``H_{2n+1}``

In each method, there's one formula for the whole polynomial.
"""

# ╔═╡ 38b2b188-1af6-4f40-a81f-73b06eae910b
md"""
### Cubic Splines

Splines: you divide your interval into separate subintervals then approximate your function using a polynomial on each interval.
"""

# ╔═╡ 26bf688c-3ea7-4065-b2d2-dc428804383d
md"""
### Example

Assume we have ``\{(x_k,f(x_k))\}_{k=0}^n`` sorted ``x_0 < x_1 < … < x_n`` Find linear spline through ``(1,2), (2,1), (4,4), (5,3)``.

Use Newton's Divided Differences for each pair to get,

[1,2]:

$s_0(x) = 2 - (x - 1)$

[2,4]:

$s_1(x) = 1 + \frac{3}{2}(x - 2)$

[4,5]:

$s_2(x) = 4 - (x - 4)$

Problem with linear splines: not differentiable
"""

# ╔═╡ 88c935a5-bd9c-44ca-b982-3fbf83207028
md"""
### Idea

Generate a cubic polynomial between each pair of points.

``s_j`` and ``s_{j+1}`` have the same zero, first, and second derivative of the joining point (knot)
"""

# ╔═╡ d25f08cf-b7ff-4347-883e-ca7107eb231f
md"""
### Definition of a cubic spline

``f`` defined on ``[a,b]``, ``a = x_0 < x_1 < ⋯ < x_n = b``.
A cubic spline ``S`` for approximating ``f`` is a set of cubic polynomials of the form

$S_0(x) = a_0 + b_0(x - x_0) + c_0(x - x_0)^2 + d_0(x - x_0)^3$

$S_1(x) = a_1 + b_1(x - x_1) + c_1(x - x_1)^2 + d_1(x - x_1)^3$

$⋮$

$S_{n-1}(x) = a_{n-1} + b_{n-1}(x - x_{n-1}) + c_{n-1}(x - x_{n-1})^2 + d_{n-1}(x - x_{n-1})^3$
"""

# ╔═╡ 5a90c5c3-694e-4738-bfa1-cbce1d6e788b
md"""
### Properties

1. ``\left.\begin{align*} S_j(x_j) = f(x_j) \\ S_j(x_{j+1}) = f(x_{j+1}) \end{align*}\right\rbrace`` for ``j = 0, …, n - 1``

  ``\implies S_{j+1}(x_{j+1}) = S_j(x_{j+1})`` for ``j = 0, …, n - 2``

2. ``S_{j+1}'(x_{j+1}) = S_j'(x_{j+1})``, for ``j = 0, …, n - 2``

3. ``S_{j+1}''(x_{j+1}) = S_j''(x_{j+1})``, for ``j = 0, …, n - 2``
"""

# ╔═╡ 89c6e98c-2591-40fc-9524-d4b54381f6e4
md"""
### Example

$S_j(x_j) = f(x_j)$

$S_j(x) = a_j + b_j (x - x_j) + c_j (x - x_j)^2 + d_j(x - x_j)^3$

$S_j(x_j) = a_j = f(x_j)$

What about ``b_j,c_j,d_j``?

``3n`` unknowns

``3n-2`` equations

Linear system underdetermined infinitely many solutions
"""

# ╔═╡ 10cd94af-1625-4ce1-8cda-64d2676aff73
md"""
### Focus on Natural Spline

Add conditions at boundary points

$S''(x_0) = 0$

$S'(x_n) = 0$

natural/free boundary

**Other conditions**

1. Clamped Boundary ``S'(x_0) = f'(x_0); \; S'(x_n) = f'(x_n)``

2. Parabolically terminated spline

3. Not-a-knot cubic spline
"""

# ╔═╡ 76cd9713-d2ce-43bc-b91c-b9b4da4011d8
md"""
### Section 3.6

Parametric Curves, Bezier Curves

- Used to create fonts

- Aerodynamic studies
"""

# ╔═╡ 567c5a14-9c99-4c19-beda-7adf207efdb3
md"""
### Example
Construct a natural spline

| ``j`` | ``x_j`` | ``f(x_j)`` |
|-------|---------|------------|
| 0 | 1 | 2 |
| 1 | 2 | 3 |
| 2 | 3 | 5 |

3 nodes, ``n = 2``, 2 cubic polynomials

$S_0(x) = 2 + b_0(x - 1) + c_0(x - 1)^2 + d_0(x - 1)^3$

$S_1(x) = 3 + b_1(x - 2) + c_1(x - 2)^2 + d_1(x - 2)^3$

$S_0(x_1) = f(x_1) \implies S_0(2) = 3$

$S_1(x_2) = f(x_2) \implies S_1(3) = 5$

$S_1'(x_1) = S_0'(x_1) \implies S_1'(2) = S_0'(2)$

$S_1''(x_1) = S_0''(x_1) \implies S_1''(2) = S_0''(2)$

$S_0''(1) = 0$

$S_1''(3) = 0$

We get a system of linear equations,

$\begin{array}{c}\begin{array}{ccccc}
b_0 & d_0 & b_1 & c_1 & d_1 
\end{array} \\
\left[\begin{array}{ccccc}
1 & 1 & 0 & 0 & 0 \\
0 & 0 & 1 & 1 & 1 \\
1 & 3 & -1 & 0 & 0 \\
0 & 6 & 0 & -2 & 0 \\
0 & 0 & 0 & 2 & 6
\end{array}\right]
\end{array}
\begin{bmatrix}
b_0 \\ d_0 \\ b_1 \\ c_1 \\ d_1
\end{bmatrix}$

We get the following cubic spline

$S(x) = \begin{cases} S_0(x) = 2 + \frac{3}{4}(x - 1) + \frac{1}{4}(x - 1)^3 &\text{for } x ∈ [1,2] \\
S_1(x) = 3 + \frac{3}{2}(x - 2) + \frac{3}{4}(x - 2)^2 - \frac{1}{4}(x - 2)^3 &\text{for } x ∈ [2,3] \end{cases}$
"""

# ╔═╡ d3f33cba-f153-4c5d-9729-bf870f8ef4b2
md"""
# 2022-10-11
"""

# ╔═╡ d1995034-3ef4-431d-bcb8-37a572703d60
md"""
### Chapter 4 Outline

4.1 Numerical Differentiation

4.3 Elements of Numerical Integration

4.4 Composite Numerical Integration

4.2 Richardson Extrapolation

- More accurate formulas for differentiation and integration

4.7 Gaussian Quadrature

- More accurate/preferred
"""

# ╔═╡ bd5e5ea4-b756-4b86-8071-df1cd43afdca
md"""
### Numerical Differentiation

1. Numerical computing of derivatives

   - find some approximating formula for derivative

2. Symbolic computing

   - In MATLAB/Mathematica

   - Analytical Derivatives
"""

# ╔═╡ 9b490af4-91dd-4a10-8f61-a75c07b13f8f
md"""
### Finite Difference formulas for derivatives

Derivative of ``f`` at ``x_0``:

$f'(x_0) = \lim_{h→0} \frac{f(x_0 + h) - f(x_0)}{h}$

Approximate (for small h):

$f'(x_0) = \frac{f(x_0 + h) - f(x_0)}{h}$

What is the error of the approximation?

By Taylor's Theorem if ``f ∈ C^2[a,b]`` with ``x_0 ∈ [a,b]`` then

$f(x) = f(x_0) + f'(x_0) (x - x_0) + \frac{f''(x_0)}{2} (x - x_0)^2 \quad \text{for } ξ(x) \text{ between } x \text{ and } x_0$

$f(x_0 + h) = f(x_0) + f'(x_0) + \frac{f''(ξ)}{2} h^2$

Two point forward difference formula ``h > 0``

$f'(x_0) = \frac{f(x_0 + h) - f(x_0)}{h} - \frac{h}{2} f''(ξ), \quad x_0 < ξ < x_0 + h$

``\displaystyle -\frac{h}{2} f''(ξ)`` is the truncation error

``h`` is small then the truncation error is small

1st order approximation

If error term is ``O(h^n)``, the formula is an order ``n`` approximation 

for ``n > 1``, more accurate approximation
"""

# ╔═╡ b904d122-4f5a-439a-9b0a-2e4c510d08b7
md"""
### Example

``f(x) = \ln(x)`` at ``x_0 = 1.8`` using ``h = 0.1, h = 0.05, h = 0.01``.

Determine bounds for approximation error.

Know ``f'(x) = 1/x``.

$\begin{align*}
f'(1.8) &≈ \frac{f(1.8 + h) - f(1.8)}{h} \\
&= \frac{\ln(1.9) - \ln(1.8)}{0.1} \\
&= 0.5406722
\end{align*}$

$f''(x) = -1/x^2$

$\begin{align*}
\frac{|hf''(ξ)|}{2} &= \frac{0.1}{2ξ^2} \\
&≤ \frac{0.1}{2} \max_{ξ ∈ [1.8,1.9]} \frac{1}{ξ^2} \\
&= \frac{0.1}{2} \frac{1}{1.8^2} \\
&= 0.0154321…
\end{align*}$
"""

# ╔═╡ a3275b95-737f-4192-9b5b-b1c77ce504d9
md"""
### Three point formulas
"""

# ╔═╡ 12d95124-a902-4a58-a58b-97444a5ee419
md"""
# 2022-10-13
"""

# ╔═╡ 6cf46177-07ba-46e9-8431-20fcbc0eea93
md"""
### Numerical Differentiation

$f'(x_0)=\frac{f(x_0+h) - f(x_0)}{h} - \frac{h}{2} f''(ξ) \qquad h > 0,\; ξ ∈ (x_0, x_0 + h)$

``O(h)`` halve ``h`` then Error will also halved.
"""

# ╔═╡ 9a567690-a7ea-44f8-be63-5ce36eb94cc2
md"""
### Three point Endpoint formula

$f'(x_0) = \frac{1}{2h} [-3f(x_0) + 4f(x_0 + h) - f(x_0 + 2h)] + \frac{h^2}{3} f^3(ξ_0), \; ξ_0 ∈ (x_0,x_0+2h)$
"""

# ╔═╡ dee54fec-59e2-4fa5-a42e-55949df62202
md"""
### Three point Midpoint formula

$f'(x_0) = \frac{1}{2h} [f(x_0 + h) - f(x_0 - h)] - \frac{h^2}{6} f^3(ξ_1), \; ξ_1 ∈ (x_0 - h, x_0 + h)$
"""

# ╔═╡ 85ba31db-57f7-4edb-bcd5-65659cc78eda
md"""
### ``(n+1)``-point formula

$f'(x_j) = \sum_{k=0}^n f(x_k) L_k'(x_k) + \frac{f^{n+1}(ξ(x_j))}{(n+1)!}\prod_{\substack{k=0\\k≠j}}^n (x_j - x_k)$
"""

# ╔═╡ d919c336-1102-466e-99e3-bb0cc8de38cf
md"""
### Second Derivative Midpoint formula

aka Centered finite difference formula

3rd Taylor Polynomial:

$f(x) = f(x_0) + f'(x_0)(x-x_0) + \frac{f''(x_0)}{2}(x - x_0)^2 + \frac{f'''(x)}{6}(x - x_0)^3$

``f(x_0 + h)`` and ``f(x_0 - h)``

$f(x_0 + h) = f(x_0) + f'(x_0) h + \frac{1}{2} f''(x_0)h^2 + \frac{1}{6} f'''(x_0)h^3 + \frac{1}{24} f^{(4)}(ξ_1) h^4$

$f(x_0 - h) = f(x_0) - f'(x_0) h + \frac{1}{2} f''(x_0)h^2 - \frac{1}{6} f'''(x_0)h^3 + \frac{1}{24} f^{(4)}(ξ_{-1}) h^4$

$f(x_0 + h) + f(x_0 - h) = 2f(x_0) + f''(x_0) h^2 + \frac{1}{24} [f^{(4)}(ξ_1) + f^{(4)}(ξ_{-1})] h^4$

$f''(x_0) = \frac{1}{h^2} [f(x_0 - h) - 2f(x_0) + f(x_0 + h)] - \frac{h^2}{24}  [f^{(4)}(ξ_1) + f^{(4)}(ξ_{-1})]$

Suppose ``f^{(4)}`` is continuous on ``[x_0 - h, x_0 + h]``, ``\frac{1}{2}[f^{(4)}(ξ_1)+f^{(4)}(ξ_{-1})]`` between ``f^{(4)}(ξ_1)`` and ``f^{(4)}(ξ_{-1})`` by IVT ``∃ ξ`` between ``ξ_1`` and ``ξ_{-1}`` such that ``f^{(4)}(ξ) = \frac{1}{2} [f^{(4)}(ξ_1) + f^{(4)}(ξ_{-1})]``

$f''(x_0) = \frac{1}{h^2} [f(x_0 - h) - 2f(x_0) + f(x_0 + h)] - \frac{h^2}{12}  f^{(4)}(ξ)$
"""

# ╔═╡ e190d5fb-1752-488e-a9d3-0834f0337d92
md"""
### Round off Error Instability

Consider the three point Midpoint formula

$f'(x_0) = \frac{1}{2h} [f(x_0 + h)-  f(x_0 - h)] - \frac{h^2}{6} f^{(3)}(ξ_1)$

Let

$\tilde{f}(x_0 + h) = f(x_0 + h) + e(x_0 + h)$

$\underbrace{\tilde{f}(x_0 - h)}_{\text{computer values}} = \underbrace{f(x_0 - h)}_{\text{actual values}} + \underbrace{e(x_0 - h)}_{\text{round-off error}}$

$f''(x_0) - \frac{\tilde{f}(x_0+h) - \tilde{f}(x_0 - h)}{2h} = \frac{e(x_0+h) - e(x_0-h)}{2h} - \frac{h^2}{6} f^{(3)}(ξ)$

Suppose ``e(x_0 ± h)`` is bounded by ``ξ > 0`` and ``f^{(3)}`` by ``M > 0`` then

$\left|f'(x_0) - \frac{\tilde{f}(x_0 + h) - \tilde{f}(x_0 - h)}{2h}\right| ≤ \frac{ξ}{h} + \frac{h^2}{6} M$
"""

# ╔═╡ 1b4431c5-75c7-4605-8f20-cd3d7f74b8d4
md"""
### Numerical Quadrature

Approximate ``\displaystyle \int_a^b f(x) \,dx`` using a sum ``\displaystyle \sum_{i=0}^n a_i f(x_i)``.

Consider distinct nodes ``\{x_i\}_{i=0}^n``.
Integrate Lagrange interpolating polynomial for ``f(x)``.

$\begin{align*}
∫_a^b f(x) \,dx &= ∫_a^b \sum_{i=0}^n f(x_i) L_i(x) \,dx + ∫_a^b \prod_{i=0}^n (x-x_i) \frac{f^{(n+1)}(ξ(x))}{(n+1)!} \,dx \\
&= \sum_{i=0}^n f(x_i) \int_a^b L_i(x) \,dx + \frac{1}{(n+1)!} ∫_a^b \prod_{i=0}^n (x-x_i) f^{(n+1)}(ξ(x)) \,dx \\
&= \sum_{i=0}^n a_i f(x_i) + \frac{1}{(n+1)!} ∫_a^b \prod_{i=0}^n (x-x_i) f^{(n+1)}(ξ(x)) \,dx
\end{align*}$

Quadrature formula → ``\displaystyle \sum_{i=0}^n a_i f(x_i)``

Error term:

$E(f) = \frac{1}{(n+1)!} ∫_a^b \prod_{i=0}^n (x-x_i) f^{(n+1)}(ξ(x)) \,dx$
"""

# ╔═╡ 6f08e4f1-cdad-4f11-9d86-bb82bcbba034
md"""
### Special Cases

1. Trapezoidal Rule -- derived from 1st Lagrange polynomial with equally spaced nodes

2. Simpson's Rule -- derived from 2nd Lagrange polynomial equally spaced nodes


**Example.**
Let ``x_0=a``, ``x_1 = b``, ``h = b - a``.

$∫_{x_0}^{x_1} P_1(x) \,dx = ∫_{x_0}^{x_1} \frac{(x-x_1)}{(x_0-x_1)} f(x_0) + \frac{(x-x_0)}{(x_1-x_0)} f(x_1) \,dx$
"""

# ╔═╡ 159edd5a-5e7e-498e-bb42-b813257e3747
md"# 2022-10-18"

# ╔═╡ 1df0f559-fe05-4741-ae59-d3e19fc799df
md"""
## Trapezoidal Rule

$∫_a^b f(x) \,dx = ∫_a^b \sum_{i=0}^n f(x) L_i(x) \,dx + ∫_a^b \prod_{i=0}^n (x - x_i) \frac{f^{(n+1)}(ξ(x))}{(n+1)!} \,dx$

Lagrange Interpolant with two points ``x_0``, ``x_1``, ``x_0 = a``, ``x_1 = b``, ``h = b - a``.

$∫_a^b P_1(x) = \frac{1}{2} (x_1 - x_0)[f(x_0) + f(x_1)] = \frac{1}{2} h [f(x_0) + f(x_1)]$

$\begin{align*}
E(f) &= ∫_{x_0}^{x_1} (x - x_0)(x - x_1) \frac{f''(ξ(x))}{2!} \,dx \\
&= \frac{f''(μ)}{2} ∫_{x_0}^{x_1} (x-x_0)(x-x_1) \,dx \\
&= \frac{f''(μ)}{2} ∫_{x_0}^{x_1} x^2 - xx_1 - xx_0 + x_0x_1 \,dx \\
&= \frac{f''(μ)}{2} \left[\frac{x^3}{3} - \frac{x^2}{2} x_1 - \frac{x^2}{2} x_0 + x_0 x_1 x\right]_{x_0}^{x_1} \\
&= \frac{f''(μ)}{2} \left[\frac{{x_1}^2 - {x_0}^2}{3} - ({x_1}^2 - {x_0}^2) \frac{x_1}{2} - \frac{({x_1}^2 - x_0)x_0}{2} + x_0x_1(x_1 - x_0)\right] \\
&= -\frac{f''(μ)}{2} \frac{(x_1 - x_0)^3}{6} \\
&= -\frac{f''(μ)}{12} h^3 \qquad\qquad\qquad μ ∈ (x_0,x_1)
\end{align*}$
"""

# ╔═╡ 543adfb6-474c-485f-8f4a-bd66f49862c4
md"""
## Weighted MVT for Integrals

Suppose ``f∈C[a,b]``, the Riemann Integral of ``g`` exists on ``[a,b]`` and ``g(x)`` does not change sign on ``[a,b]`` then ``∃c ∈ (a,b)`` with

$∫_a^b f(x) g(x) \,dx = f(c) ∫_a^b g(x) \,dx$

If ``g ≡ 1``, MVT for integrals

$f(c) = \frac{1}{b - a} ∫_a^b f(x) \,dx$
"""

# ╔═╡ f8d40855-02a4-444f-beea-3e59f97adecf
md"""
## Trapezoidal Rule

Trapezoidal rule is exact for any function whose second derivative is zero, i.e., polynomials of degree ≤ 1.
"""

# ╔═╡ c012fbeb-d816-4181-9982-f29b83514fc2
md"""
## Degree of accuracy/precision

The largest positive integer ``n`` such that the quadrature formula is exact for ``x^k`` for each ``k = 0,1,…,n``.
"""

# ╔═╡ 3d70576a-3dff-4460-a92c-d1aa005afa7b
md"""
## Simpson's Rule

To Derive integrate the 2nd Lagrange Polynomial and its error.

Use nodes ``x_0 = a``, ``x_2 = b``, ``x_1 = a + h``, ``h = \frac{b - a}{2}``

$∫_{x_0}^{x_2} f(x) \,dx = \frac{h}{3} [f(x_0) + 4f(x_1) + f(x_2)] - \frac{h^5}{90} f^{(4)}(ξ),\quad ξ ∈ (x_0,x_2)$

Simpson's rule exact for polynomials of degree 3 or less
"""

# ╔═╡ e365f838-47af-4d51-9d2e-59d9bba47436
md"""
## Example

Let ``h = \frac{b-a}{3}``, ``x_0 = a``, ``x_1 = a + h``, ``x_2 = b``

$∫_a^b f(x) \,dx = \frac{9}{4} hf(x_1) + \frac{3}{4} hf(x_2)$

Find the degree of precision.

_**Solution**_

Exact

$∫_a^b 1 \,dx = x \big|_a^b = b - a$

Approx

$∫_a^b 1 \,dx = \frac{9}{4} h + \frac{3}{4} h = \frac{12}{4} h = 3h = 3 \frac{(b-a)}{3} = b - a \quad \text{ ≡ Exact ✓}$

Exact

$∫_a^b x \,dx = \left.\frac{x^2}{2}\right|_a^b = \frac{b^2 - a^2}{2}$

Approx

$\begin{align*}
∫_a^b x \,dx &= \frac{9}{4} h (a + h) + \frac{3}{4} h b \\
&= \frac{3}{4} h \left[3(a+h) + b\right] \\
&= \frac{3}{4} \frac{(b-a)}{3} \left[3\left(a + \frac{b-a}{3}\right) + b\right] \\
&= \frac{b - a}{4} [3a + b - a + b] \\
&= \frac{b - a}{4} [2a + 2b] \\
&= \frac{(b - a)}{2} (a + b) \\
&= \frac{b^2 - a^2}{2}
\quad \text{≡ Exact ✓} \\
\end{align*}$

Keep doing it for ``x^2`` and ``x^3`` to find that the degree of precision is 3.
"""

# ╔═╡ 390940fc-aa00-4b7e-b3d5-101a562900f3
md"""
## Newton-Cotes Formulas

1. Trapezoidal Rule

2. Simpson's Rule

See more formulas in Book.
"""

# ╔═╡ c2715fe7-94f4-4c40-93cf-11827b2efc0b
md"""
## Composite Numerical Integration

Piecewise approach to finding ``∫_a^b f(x) \,dx``

Divide ``[a,b]`` into several subintervals.
On each subinterval apply Trapezoidal/Simpson's formula.
Then add up approximations in each subinterval to get the total sums.
"""

# ╔═╡ 35b2370e-5a2d-45fe-a54c-7bcd74a10775
md"""
## Composite Trapezoidal Rule

Consider an evenly spaced grid ``a = x_0 < x_1 < … < x_n = b``, ``h = \frac{b - a}{n} = x_{j+1} - x_j``, ``j=0,…,n-1``

$∫_{x_j}^{x_{j+1}} f(x) \,dx = \frac{h}{2} [f(x_j) + f(x_{j+1})] - \frac{h^3}{12} f''(ξ_j), \quad x_j < ξ_j < x_{j+1}$

$\begin{align*}
∫_a^b f(x) \,dx &= \sum_{j=0}^{n-1} ∫_{x_j}^{x_{j+1}} f(x) \,dx = \sum_{j=0}^{n-1} \left(\frac{h}{2} [f(x_j) + f(x_{j+1})] - \frac{h^3}{12} f''(ξ_j)\right) \\
&= \frac{h}{2} \left[f(x_0) + 2\sum_{j=1}^{n-1} f(x_j) + f(x_n)\right] - \sum_{j=0}^{n-1} \frac{h^3}{12} f''(ξ_j)
\end{align*}$
"""

# ╔═╡ 423242eb-71fc-45d8-9706-949526c7a793
md"# 2022-10-25"

# ╔═╡ 8537f375-c3e3-479f-b32d-8c3cbfd8f1f3
md"""
## Differential Equations

Ordinary Differential Equations (ODEs)

- ``F = ma``

- ``a = \frac{d^2x}{dt^2}``

- ``\frac{F}{m} = \frac{d^2x}{dt^2}``

- Find ``x(t)``  

Partial Differential Equations (PDEs)

- heat equation ``\frac{dT}{dt} = c \frac{d^2T}{dx^2}``; find ``T``
"""

# ╔═╡ 76c503f6-60b8-4c08-bfe3-be18d80ea818
md"""
## Example ODE (Swinging Pendulum)

$\frac{d^2 θ}{dt^2} + \frac{g}{L} \sin{θ} = 0$

Second order differential equation
"""

# ╔═╡ b06c4517-575c-4bbd-aad2-33d7d9585b71
md"""
## SIR Model

- S - susceptible

- I - infected

- R - recovered

$\frac{ds}{dt} = -bs(t)i(t)$

$\frac{di}{dt} = bs(t)i(t) - ki(t)$

$\frac{dr}{dt} = ki(t)$

b - probability of infection

k - probability of recovery
"""

# ╔═╡ 29ac7486-a3f9-424d-8027-aa8de2f1130b
md"""
## Numerical Analysis of Differential Equations

Solve a differential equation of the form

$\frac{dy}{dt} = f(t,y), \quad a ≤ t ≤ b$

$y(a) = y_0$

Find an approximation to the solution ``y(t)`` - curve/function

"""

# ╔═╡ 2e3b631c-6384-4219-9338-5631b7d3dcd6
md"""
## Example

$\frac{dy}{dt} = e^t$

$∫dy = ∫ e^t \,dt$

$y = e^t + C$
"""

# ╔═╡ bbe829d6-0593-42e8-a36a-c76b1e1c1a34
md"""
## Euler's Method

Differential equation gives formula for computing the slope of the tangent line at each point on the curve ``y(t)``

Consider slope tangent line at ``t_0 → f(t_0,y_0)``

Euler's Method:

$y(t_1) ≈ y_1$

$\frac{y_1 - y_0}{h} = f(t_0,y_0)$

$y_1 = y_0 + hf(t_0,y_0)$

$y_2 = y_1 + hf(t_1,y_1)$

Forward Euler:

$y_{i+1} = y_i + hf(t_i,y_i), \quad \text{ for each } i = 0,1,…,N-1$

Backward Euler:

$y_{i+1} = y_i + hf(t_{i+1},y_{i+1}), \quad \text{ for each } i = 0,1,…,N-1$
"""

# ╔═╡ 0ac51401-144c-46ac-8c70-4441aa95e7a2
md"""
## Error for Forward Euler in one step

Assume ``y(t_i) = y_i``

approx.

$y_{i+1} = y_i + hf(t_i,y_i)$

true:

$\begin{align*}
y(t_{i+1}) &= y(t_i + h) \\
&= y(t_i) + hy'(t_i) + \frac{1}{2} h^2 y''(ξ_i) \qquad t_i < ξ_i < t_{i+1}
\end{align*}$

Local Truncation Error

$e_{i+1} = y(t_{i+1}) - y_{i+1} = \frac{1}{2} h^2 y''(ξ_i)$

$O(h^2)$
"""

# ╔═╡ 521e6bc9-5bbd-4665-9732-92497698b931
md"""
### Global Error

Error in ``N`` steps of Euler's Method

$h = \frac{b - a}{N} → N = \frac{b - a}{h}$

$O\left(\frac{1}{h}\right) \text{ steps}$

Per step → ``O(h^2)``

$O(h^2) O\left(\frac{1}{h}\right) → O(h)$

Euler's Method is ``O(h)`` ⟹ first order

$e_h - O(h)$

$e_{h/2} - O(h/2)$
"""

# ╔═╡ 55d50b79-4199-45e1-a31c-2fb1b1256cca
md"""
## Higher accuracy methods

This class only covers Euler's method.
Other methods covered in the Numerical Analysis II include:

1. Runge-Kutta Methods

   - RK4 fourth order method ``O(h^4)`` (better accuracy)
"""

# ╔═╡ 4ba72e98-73e0-4092-b27c-0a2a28fc35df
md"""
## Forward Difference Algorithm

```matlab
function y = forwardeuler(f,g,y0,t0,tf,N)
% inputs
% f - right hand side function
% g - exact solution
% y0 - initial condition
% t0 - initial time
% tf - final time
% N - number steps

% output
% y - final time

h = (tf-t0)/N;

for i = 1:N
	y = y0 + h*f(t0,y0);
	y0 = y;
	t0 = t0 + h;
	exact = g(t0,y0);
end

end
```
"""

# ╔═╡ 21b1d73e-b3ee-4fe9-b822-bc54b3ab290b
md"# 2022-10-27"

# ╔═╡ 0f128498-7db6-435b-a59b-c71e15667837
md"""
## Linear Systems

Direct Methods

Iterative Methods

$A\bar{x} = \bar{b}$

Suppose we have a system of ``n`` equations ``\{E_i\}_{i=1}^n`` and ``n`` unknowns ``\{x_i\}_{i=1}^n``
"""

# ╔═╡ 897edfe7-c294-464e-9ef5-193c77f89c78
md"""
## Example

Solve

$\begin{bmatrix}
1 & -1 & 2 & -1 \\
2 & -2 & 3 & -3 \\
1 & 1 & 1 & 0 \\
1 & -1 & 4 & 3
\end{bmatrix}
\begin{bmatrix}
x_1 \\ x_2 \\ x_3 \\ x_4
\end{bmatrix} =
\begin{bmatrix}
-8 \\ -20 \\-2 \\ 4
\end{bmatrix}$

"""

# ╔═╡ 513c1774-cfae-489d-9cca-c37930446d24
md"""
## Gaussian Elimination

**Row operations**

1. Scaling ``(λE_i) → E_i``

2. Replacement ``(E_i + λE_j) → E_i``

3. Swap ``(E_i) ↔ (E_j)``
"""

# ╔═╡ d6092ace-93aa-4274-93bd-442b6f82c792
md"""
## Example 1

$A = \begin{bmatrix}
1 & 2 & -1 \\
2 & 1 & -2 \\
-3 & 1 & 1
\end{bmatrix} \qquad b = \begin{bmatrix} 3 \\ 3 \\ -6 \end{bmatrix}$

$A\bar{x} = \bar{b}$

$\begin{bmatrix}
1 & 2 & -1 & 3 \\
2 & 1 & -2 & 3 \\
-3 & 1 & 1 & -6
\end{bmatrix} →
\begin{bmatrix}
1 & 2 & -1 & 3 \\
0 & -3 & 0 & -3 \\
0 & 7 & -2 & 3
\end{bmatrix} →
\begin{bmatrix}
1 & 2 & -1 & 3 \\
0 & -3 & 0 & -3 \\
0 & 0 & -2 & -4
\end{bmatrix}$

row echelon form vs row reduced echelon form

$x_1 + 2x_2 - x_3 = 3$

$-3x_2 = -3 \implies x_2 = 1$

$-2x_3 = -4 \implies x_3 = 2$
"""

# ╔═╡ 51f6a0e3-39ec-46e8-868b-c45e1f1a2c57
md"# 2022-11-01"

# ╔═╡ 77837aab-d3fe-4a6c-8df7-e32404aa5924
md"""
## Gaussian Elimination

$A\bar{x} = \bar{b} \qquad A ∈ ℝ^{n×m}$

$\begin{bmatrix} A & \bar{b} \end{bmatrix}$

reduce to row echelon form

$\begin{bmatrix}
a_{11} & ⋯ & ⋯ & a_{1n} & b_{1} \\
0 & ⋱ & & ⋮ & ⋮ \\
0 & 0 & ⋱ & ⋮ & ⋮ \\
0 & 0 & 0 & a_{nn} & b_n
\end{bmatrix}$

Back substitution to solve for ``\bar{x}``
"""

# ╔═╡ 781aa867-2d53-409f-8905-e0cdf84a708d
md"""
## Elimination Step

```julia
for i = 1,…,n-1
	if abs(aᵢᵢ) < ϵ
		print("error")
	end
	for j = i+1,…,n
		mⱼᵢ = aⱼᵢ / aᵢᵢ
		for k = i+1,…,n+1
			aⱼₖ = aⱼₖ - mⱼᵢaᵢₖ
		end
	end
end
```
"""

# ╔═╡ 6637bdf0-7202-49ea-b482-21bb4c0aa5eb
md"""
## Back Substitution

```julia
xₙ = aₙ,ₙ₊₁ / aₙₙ

for i = n-1,…,1
	xᵢ = aᵢ,ₙ₊₁
	for j = i+1,…,n
		xᵢ = xᵢ - aᵢⱼxⱼ
	end
	xᵢ = xᵢ / aᵢᵢ
end
```
"""

# ╔═╡ b7322a9c-85b1-45df-a4f7-82075d925406
md"""
## Summation formulas

$\sum_{j=1}^m 1 = m$

$\sum_{j=1}^m j = \frac{m(m+1)}{2}$

$\sum_{j=1}^m j^2 = \frac{m(m+1)(2m+1)}{6}$
"""

# ╔═╡ 1dcca983-ec09-4281-80e2-4bcff20814db
md"""
## Operation Count

1. Elimination Step

   in ``k`` loop

   - ``n + 1 - (i + 1) + 1`` (mult)

   - ``n - i + 1`` (add/sub)

   in ``j`` loop

   - ``n - (i + 1) + 1 = n - i``

   - ``(n - i)(n - i + 1)`` (add/sub)

   - ``(n - i)(n - i + 1) + (n - i)`` (mult/div)

   in ``i`` loop

   - add/sub

     $\begin{align*}
     &\sum_{i=1}^{n-1} (n - i) (n - i + 1) \\
     {}=&\sum_{i=1}^{n-1} n^2 - 2ni + i^2 + n - i \\
     {}=&\sum_{i=1}^{n-1} (n - i)^2 + \sum_{i=1}^{n-1} (n - i) \\
     {}=&\sum_{i=1}^{n-1} i^2 + \sum_{i=1}^{n-1} i \\
     {}=&\frac{(n-1)n(2n-1)}{6} \\
     {}=&\frac{n^3 - n}{3}
     \end{align*}$

   - mult/div

     $\sum_{i=1}^{n-1} (n-i)(n-i+2) = \frac{2n^3 + 3n^2 - 5n}{6}$

     Overall operation for elimination

     $\begin{align*}
     &\frac{2n^3 + 3n^2 + 5n}{6} + \frac{2n^3 - 2n}{6} \\
     &{}=\frac{4n^3 + 3n^2 - 7n}{6} \\
     &{}=\frac{2}{3} n^3 + \frac{n^2}{2} - \frac{7}{6} n \qquad O\left(\frac{2}{3}n^3\right)
     \end{align*}$
"""

# ╔═╡ 23c66667-8b5d-4b34-a98c-a9c055b36ce1
md"""
## Gaussian Elimination

1 division for ``x_n``

in ``j`` loop

- ``n - i`` mult

- ``n - i`` add/sub

in ``i`` loop

- ``(n - 1)`` div

mult/div

$1 + \sum_{i=1}^{n-1} (n - i) + 1 = \frac{n^2 + n}{2}$

add/sub

$\sum_{i=1}^{n-1} (n - i) = \frac{n^2 - n}{2}$

Overall ``n^2`` operations for Back substitution

Elimination ``\displaystyle ∼ \frac{2}{3} n^3``

Back Sub ``\displaystyle ∼ n^2``

| ``n`` | Elimination |
|-------|-------------|
| ``10`` | ``⅔(10)^3`` |
| ``100`` | ``⅔(10)^9`` |
"""

# ╔═╡ bd813f79-3ef7-428f-9741-9e199536821f
md"""
## Example

Back substitution ``5000 × 5000 → 0.1 \text{ s}``

Estimate the time needed to solve ``3000 × 3000`` system with Gaussian Elimination with back substitution
"""

# ╔═╡ 2c930938-c716-42d5-8fe9-cff8132f1884
md"""
## Matrix Factorization

$A \bar{x} = \bar{b}$

$A = LU$

``L`` - "lower triangular"

``U`` - "upper triangular"

$LU\bar{x} = \bar{b}$

Let ``\bar{y} = U\bar{x}``, ``L\bar{y} = \bar{b}``

Forward Substitution ``O(n^2)``

$U\bar{x} = \bar{y}$

Backward Substitution ``O(n^2)``

``O(2n^2)`` operations

compound ``O\left(\frac{2}{3} n^3\right)`` operations for full Gaussian Elimination
"""

# ╔═╡ 23ddb491-ca67-4c94-9676-65edeee547b2
md"""
## LU factorization

Matrix representation of Gaussian Elimination
"""

# ╔═╡ c7471e62-f219-425d-a85f-f709abf14127
md"""
## Example 1

$A = \begin{bmatrix} 1 & 1 \\ 3 & -4 \end{bmatrix} \stackrel{?}{=} LU$

$\begin{bmatrix} 1 & 1 \\ 3 & -4 \end{bmatrix} \implies \begin{bmatrix} 1 & 1 \\ 0 & -7 \end{bmatrix}$

$\underset{L}{\begin{bmatrix} 1 & 0 \\ 3 & 1 \end{bmatrix}} \underset{U}{\begin{bmatrix} 1 & 1 \\ 0 & -7 \end{bmatrix}} = \underset{A}{\begin{bmatrix} 1 & 1 \\ 3 & -4 \end{bmatrix}}$
"""

# ╔═╡ dc4ec87b-d94d-418d-b82e-c15a38680859
md"""
## Example 2

$A = \begin{bmatrix}
1 & 2 & -1 \\
2 & 1 & -2 \\
-3 & 1 & 1
\end{bmatrix}
\implies
\begin{bmatrix}
1 & 2 & -1 \\
0 & -3 & 0 \\
0 & 7 & -2
\end{bmatrix}
\implies
\begin{bmatrix}
1 & 2 & -1 \\
0 & -3 & 0 \\
0 & 0 & -2
\end{bmatrix}$

$\underset{L}{\begin{bmatrix}
1 & 0 & 0 \\
2 & 1 & 0 \\
-3 & -\frac{7}{3} & 1
\end{bmatrix}}
\underset{U}{\begin{bmatrix}
1 & 2 & -1 \\
0 & -3 & 0 \\
0 & 0 & -2
\end{bmatrix}} \stackrel{?}{=} A$
"""

# ╔═╡ e972b8d2-10a8-42d5-8274-2e4558e9dff6
md"""
## Gaussian Elimination

Assume Gaussian Elimination without row interchanges.
Do not create augmented matrix.

$A' = A \qquad [a_{ij}] \qquad A ∈ ℝ^{n×n}$

Step 1:

$m_{ji} = \frac{a_{ji}'}{a_{ii}'} \qquad (E_j - m_{ji} E_i) → (E_j)$

$j = 2,…,n$

$M' = \begin{bmatrix}
1 & &  & & & 0 \\
-m_{ji} & & ⋱ & && 0 \\
⋮ & 0 & ⋱ & ⋱ && 0 \\
⋮ & ⋮ &  & ⋱ & ⋱ & 0 \\
-m_{ij} & 0 & ⋯ & ⋯ & 0 & 1
\end{bmatrix}$
"""

# ╔═╡ b0d8f8cb-7a81-4753-91a3-a2c2b2e35f2d
md"# 2022-11-03"

# ╔═╡ c62cde72-01fd-4c60-9aa7-4231f1821b07
md"""
### LU Factorization

$A\bar{x} = \bar{b}$

$LU\bar{x} = \bar{b}$

$LU\bar{x} = \bar{b}_1$
$LU\bar{x} = \bar{b}_2$
$⋮$
$LU\bar{x} = \bar{b}_k$

Gaussian elimination to get LU takes ``O\left(\frac{2}{3} n^3\right)`` operations.

``O(2n^3)`` operations for forward and backward substitution

---

$O\left(\frac{2}{3} kn^3\right)$

---

$A ∈ ℝ^{n × m}$

$A' = A$

$M = \begin{bmatrix}
1 & 0 & ⋯ & 0 \\
-m_{21} & ⋱ & & ⋮ \\
⋮ & & ⋱ & 0 \\
-m_{n1} & & & 1
\end{bmatrix}$

$m_{ji} = \frac{a_{ji}'}{a_{ii}}$

$A^2 = M^1A^1$

---

Step ``k``

``A^k``

$m_{jk} = \frac{a_{jk}^k}{a_{kk}^k}$

$M^k = \begin{bmatrix}
\end{bmatrix}$

$A^{k+1} = M^k A^k = M^k M^{k-1} ⋯ M^1 A^1$

$L^k = (M^k)^{-1}$

Step ``n - 1`` ``A^{n-1}``

$U = A^n = M^{n-1} ⋯ M^1 A^1$

$L^1 ⋯ L^{n-2} L^{n-1} U = A$
"""

# ╔═╡ b89fb5ec-3ac1-4203-bd62-27313f31fc28
md"""
## Theorem 6.19

$A = LU$
"""

# ╔═╡ c9f6212e-572a-41be-83a2-6389b9d546f8
md"""
## Row Interchanges

Let ``A^k`` be the matrix at the beginning of the ``k``th step of Gaussian Elimination

Need to zero out lower triangle

Need to interchange for ``a_{kk}^k = 0``

Find smallest integer ``p > k`` s.t. ``a_{pk}^k ≠ 0``

``m_{jk} ≫ 1``

``a_{kk}^k ≪ a_{jk}^k``
"""

# ╔═╡ 2950a377-bc72-4e80-bf98-0ae57d74e3f7
md"""
## Example 1

4-digit rounding arithmetic

$A = \begin{bmatrix}
0.003 & 59.14 \\
5.291 & -6.130
\end{bmatrix} \qquad \bar{b} = \begin{bmatrix} 59.17 \\ 46.78 \end{bmatrix}$
"""

# ╔═╡ 992028d2-a19c-4d71-8b72-0d29cb055100
md"""
## Partial Pivoting

In step ``k`` of Gaussian Elimination:

Select an element ``a_{pk}^k`` with ``|a_{pk}^k| = \max_{k ≤ i ≤ n} |a_{ik}^k|``
"""

# ╔═╡ 35bf43e3-4685-4a3a-be1e-9cf9e7fd3a37
md"""
## Permutation Matrices
"""

# ╔═╡ 35e96283-f9c0-4871-894e-49426d5006ae
md"""
## Example

Find ``PA = LU`` of

$A = \begin{bmatrix}
2 & 1 & 5 \\ 4 & 4 & -4 \\ 1 & 3 & 1
\end{bmatrix}$
"""

# ╔═╡ be3f3dc0-2a1f-40bb-8dd2-42d6db3d804c
md"# 2022-11-08"

# ╔═╡ 1f78c925-3370-4959-a45d-7ca89759cf1e
md"""
## Linear Systems

$A\bar{x} = \bar{b}$

$LU\bar{x} = \bar{b}$

### Partial Pivoting

$PA\bar{x} = P\bar{b}$

$PA = LU$

$LU\bar{x} = P\bar{b}$
"""

# ╔═╡ 2cee034a-2e51-4672-89b6-2ea699a26b05
md"""
## Special Matrices

Cholesky Factorization

Symmetric Matrices

Positive Definite Matrices
"""

# ╔═╡ 82d7e2aa-34c4-43c9-ae7c-e6d322571e06
md"""
## Norms

Want to compare solutions to linear systems

Need to define distance between two vectors/matrices

Define notation of convergence for vector sequences
"""

# ╔═╡ 9a650864-7aea-4b06-a69d-2f24ffb6b4f9
md"""
## Vector norm in ``ℝ^n``

$\|⋅\| \qquad ℝ^n → ℝ$

### Properties

1. ``\|\bar{x}\| ≥ 0`` for all ``\bar{x} ∈ ℝ^n`` (positivity)

2. ``\|\bar{x}\| = 0`` iff ``\bar{x} = \bar{0}``

3. ``\|α\bar{x}\| = |α|\|\bar{x}\|`` for all ``\bar{x} ∈ ℝ^n`` and ``α ∈ ℝ``

4. ``\|\bar{x} + \bar{y}\| ≤ \|\bar{x}\| + \|\bar{y}\|``

### Example

$\bar{x} = (x_1,x_2,…,x_n)^T$

### Maximum Norm/Infinity Norm/``ℓ_∞``

$\|\bar{x}\|_∞ = \max_{1 ≤ i ≤ n} |x_i|$

### Euclidean Norm/2-norm/``ℓ_2``

$\|\bar{x}\\|_2 = \left(\sum_{i=1}^n x_i^2\right)^{1/2}$

### ``ℓ_p`` norms

$\|\bar{x}\|_p = \left(\sum_{i=1}^n |x_i|^p\right)^{1/p}$
"""

# ╔═╡ fbd6dc6c-087a-465f-aa47-4ac75a0c325f
md"""
## Show that ``\|⋅\|_2`` is a norm

1. ``\|\bar{x}\|_2 > 0`` from definition

2. ``\|\bar{x}\|_2 = 0`` but ``\bar{x} ≠ 0`` then there exists some element ``x_i ≠ 0`` so ``\|\bar{x}\|_2 > 0``

3. ``\|α\bar{x}\|_2 = \sqrt{\sum_{i=1}^n α^2 x_i^2} = \sqrt{α^2 \sum_{i=1}^n x_i^2} = |α| \sqrt{\sum_{i=1}^n x_i^2} = |α|\|\bar{x}\|_2``

4. Triangle inequality
"""

# ╔═╡ 0f2d65d9-2824-415e-b704-f6b87d7d2d0d
md"""
## Cauchy-Bunyakovsky-Schwarz

$\bar{x}^T \bar{y} = \sum_{i=1}^n x_i y_i ≤ \|\bar{x}\|_2 \|\bar{y}\|_2$

Proof:

$\bar{x} = 0 \quad\text{ or }\quad \bar{y} = 0 \quad \text{ Trivial}$

Suppose ``\bar{x} ≠ 0``, ``\bar{y} ≠ 0`` with ``\|\bar{x}\|_2 = \|\bar{y}\|_2 = 1`` then 

$\begin{align*}
0 ≤ \|\bar{x} - \bar{y}\|_2^2 &= \sum_{i=1}^n (x_i - y_i)^2 = \sum_{i=1}^n x_i^2 + \sum_{i=1}^n y_i^2 - \sum_{i=1}^n 2x_iy_i \\
2 \sum_{i=1}^n x_i y_i &≤ \sum_{i=1}^n x_i^2 + \sum_{i=1}^n y_i^2 = \|\bar{x}\|_2^2 + \|\bar{y}\|_2^2
\end{align*}$
"""

# ╔═╡ fd2377f1-1a37-48c4-a994-14de9ad5bbf0
md"""
## Matrix norms on ``ℝ^{n \times n}``

Real valued function ``\|⋅\|`` satisfies the following for all ``A,B ∈ ℝ^{n \times n}`` and ``α ∈ ℝ``

1. ``\|A\| ≥ 0``

2. ``\|A\| = 0`` iff ``A = 0``

3. ``\|α A\| = |α|\|A\|``

4. ``\|A + B\| ≤ \|A\| + \|B\|``

5. ``\|AB\| ≤ \|A\| \|B\|``
"""

# ╔═╡ 76d40428-60f8-4546-a771-df8c67e0b7ff
md"""
## Natural/Induced norms

Associated with vector norms

If ``\|⋅\|`` is vector norm on ``ℝ^n`` then ``\|A\| = \max_{\|\bar{x}\| = 1} \|A\bar{x}\|``, ``\|A\| = \max_{\bar{z} ≠ 0} \frac{\|A\bar{z}\|}{\|\bar{z}\|}``

Let ``\bar{z} ∈ ℝ^n``, ``\bar{z} ≠ 0`` then define ``\bar{x} = \frac{\bar{z}}{\|\bar{z}\|}``

$\max_{\|\bar{x}\| = 1} \|A\bar{x}\| = \max_{\bar{z} ≠ 0} \left\|A \frac{\bar{z}}{\|\bar{z}\|}\right\| = \max_{\bar{z} ≠ 0} \frac{\|A\bar{z}\|}{\|\bar{z}\|}$

for any ``\bar{z} ≠ 0 \qquad \|A\bar{z}\| ≤ \|A\| \|\bar{z}\|``

``\|A\| ≥ \frac{\|A\bar{z}\|}{\|\bar{z}\|}``
"""

# ╔═╡ de343ce0-423b-40f7-90c3-66022d163783
md"""
## ``∞``-norm

$\begin{align*}
\|A\|_∞ &= \max_{\bar{x} ≠ 0} \frac{\|A\bar{x}\|_∞}{\|\bar{x}\|_∞} \\
&= \max_{1 ≤ i ≤ n} \sum_{j=1}^n |a_{ij}|
\end{align*}$
"""

# ╔═╡ 3483eecd-83c0-440f-9723-3782e07e5b8b
md"""
## 2-norm

$\|A\|_2 = \max_{\bar{x} ≠ 0} \frac{\|A\bar{x}\|}{\|\bar{x}\|_2}$

$eig(A^TA)$
"""

# ╔═╡ bdc33d64-dd39-428b-9298-b26c467614cc
md"""
## Errors in Gaussian Elimination using finite digit arithmetic

``\tilde{x}`` is an approximation to the solution of ``A\bar{x} = \bar{b}``

``\bar{r} = \bar{b} - A\tilde{x}`` : residual vector

``\|\bar{r}\| = \|\bar{b} - A\tilde\|`` : norm of the residual

Backward Error

Forward Error ``\|\bar{x} - \tilde{x}\|``

### Expectation

If ``\|\bar{r}\|`` is small then ``\|\bar{x} - \tilde{x}\|`` is small

But this not the case!

### Example

$\begin{bmatrix}
1 & 2 \\ 1.0001 & 2
\end{bmatrix}
\begin{bmatrix}
x_1 \\ x_2
\end{bmatrix}
=
\begin{bmatrix} 3 \\ 3.0001 \end{bmatrix}$
"""

# ╔═╡ 7e5dd46d-c35c-47d1-bb60-9567962b652b
md"# 2022-11-10"

# ╔═╡ 431ba7fb-0d15-448f-8731-f88c06be7f8c
md"""
## Norms

Vector & Matrix

Gaussian Elimination for solving ``A\bar{x} = \bar{b}``

$A ∈ ℝ^{n \times n}$

$\bar{x},\bar{b} ∈ ℝ^n$

``\tilde{x}`` approximation to the solution of ``A\bar{x} = \bar{b}``

``\bar{r} = \bar{b} - A\tilde{x}`` - residual vector

``\|\bar{r}\| = \|\bar{b} - A\tilde{x}\|`` - backward error

``\|\bar{x} - \tilde{x}\|`` - forward error

expectation: if ``\|\bar{r}\|`` is small then ``\|\bar{x} - \tilde{x}\|`` should be small
"""

# ╔═╡ 5a6cb811-dc28-4bac-b92e-8b6fabdffb07
md"""
## Example

$\begin{bmatrix}
1 & 2 \\ 1.0001 & 2
\end{bmatrix}
\begin{bmatrix}
x_1 \\ x_2
\end{bmatrix}
=
\begin{bmatrix}
3 \\ 3.0001
\end{bmatrix}$

$\bar{x} = \begin{bmatrix}
1 \\ 1
\end{bmatrix}$

Assume

$\tilde{x} = \begin{bmatrix}
3 \\ -0.0001
\end{bmatrix}$

$\begin{align*}
\bar{r} &= \begin{bmatrix}
3 \\ 3.0001
\end{bmatrix}
-
\begin{bmatrix}
1 & 2 \\ 1.0001 & 2
\end{bmatrix}
\begin{bmatrix}
3 \\ -0.0001
\end{bmatrix}
\begin{bmatrix}
0.0002 \\ 0
\end{bmatrix}
\end{align*}$

$\|\bar{r}\|_∞ = 0.0002$

$\bar{x} - \tilde{x} = \begin{bmatrix}
-2 \\ 1.0001
\end{bmatrix}$

$\|\bar{x} - \tilde{x}\|_∞ = 2^*$
"""

# ╔═╡ c86d6344-8d17-49ac-a495-20504c90cf5e
md"""
## Conditioning

Measure of sensitivity of the solution to ``A\bar{x} = \bar{b}`` to changes in ``\bar{b}``.

$\begin{align*}
\bar{r} &= \bar{b} - A\tilde{x} \\
&= A\bar{x} - A\tilde{x} \\
&= A(\bar{x} - \tilde{x})
\end{align*}$

$\|\bar{x} - \tilde{x}\| = \|A^{-1} \bar{r}\| ≤ \|A^{-1}\|\|\bar{r}\|$

$\bar{x} ≠ 0, \quad \bar{b} ≠ 0$

$\|\bar{b}\| = \|A\bar{x}\| ≤ \|A\|\|\bar{x}\| \implies \frac{1}{\|\bar{x}\|} ≤ \frac{\|A\|}{\|\bar{b}\|}$

$\frac{\|\bar{x} - \tilde{x}\|}{\|\bar{x}\|} ≤ \|A^{-1}\|\|A\| \frac{\|\bar{r}\|}{\|\bar{b}\|}$

$\frac{\frac{\|\bar{x} - \tilde{x}\|}{\|\bar{x}\|}}{\frac{\|\bar{r}\|}{\|\bar{b}\|}} ≤ \|A^{-1}\|\|A\|$

$I = A^{-1}A$

$1 = \|I\| = \|A^{-1}A\| ≤ \|A^{-1}\|\|A\|$

If ``K(A)`` is close to 1 your matrix ``A`` is well conditioned

If ``K(A) ≫ 1`` then ``A`` is ill-conditioned

$\frac{\|\bar{x} - \tilde{x}\|}{\|\bar{x}\|} ≤ K(A) ⋅ ε_\text{mach.}$

$K(A) ≈ 10^t \implies \text{prepare to lose close to } t \text{ digits of accuracy}.$
"""

# ╔═╡ 71b133db-251a-4bab-932f-0e28c92aad4a
md"# 2022-11-15"

# ╔═╡ f60068d7-5c00-4885-ac97-bb0510ea276f
md"""
## Gaussian Elimination

- ``O(n^3)`` floating point operations

- Need pivoting e.g. partial

- It's exact for infinite precision

- Conditioning/Condition Number ``K(A) = \|A\| \|A^{-1}\|``

  $1 = \|I\| = \|AA^{-1}\| ≤ \|A\|\|A^{-1}\| = K(A)$

  ``K(A) ≫ 1`` then ``A`` is ill-conditioned.

  If ``K(A)`` is close to 1 then ``A`` is well-conditioned
"""

# ╔═╡ 736f59ff-551a-4871-97e6-1f301d6014c8
md"""
## Direct Method

⟹ finite number of steps to get solution to ``A\bar{x} = \bar{b}``

Other methods will depend on some special structure for ``A``

$A = A^T$

$\bar{x}^π A\bar{x} ≥ 0$

$x ∈ ℝ^n$
"""

# ╔═╡ 65016918-e06e-415b-a56c-4a2d5b2f79bf
md"""
## Iterative Methods

Section 7.3

Start with initial guess ``\bar{x}^{(0)}`` and generate a sequence of vectors ``\{\bar{x}^{(k)}\}_{k=0}^∞`` that converges to ``\bar{x}``.

``\{\bar{x}^{(k)}\}_{k=0}^∞`` a sequence of vectors in ``ℝ^n`` converges to ``\bar{x}`` with respect to a norm ``\|⋅\|`` if given ``ε > 0`` ``∃N(ε) ∈ ℤ`` such that ``\|\bar{x}^{(k)} - \bar{x}\| < ε`` for all ``k ≥ N(ε)``
"""

# ╔═╡ 485997bc-cfe5-475d-aad2-ee530362da32
md"""
## Theorem 7.6

``\{\bar{x}^{(k)}\}_{k=0}^∞ → \bar{x}`` in ``ℝ^n`` with respect to the ``ℓ_∞`` norm iff ``\lim_{k→∞} x_i^{(k)} = x_i\quad`` ``∀ i = 1, …, n``.

*Proof.*
Suppose ``\{\bar{x}^{(k)}\}_{k=0}^∞ → \bar{x}``. Given ``ε > 0``, ``∃N(ε) ∈ ℤ^+`` such that ``∀k ≥ N(ε)``

$\max_{i=1,…,n} |x_i^{(k)} - x_i| = \|\bar{x}^{(k)} - \bar{x}\|_∞ < ε$

then ``|x_i^k - x_i| < ε`` for ``i = 1, 2, …, n`` ``\implies \lim_{k→∞} x_i^k = x_i``.
Suppose ``\lim_{k→∞} x_i^{(k)} = x_i`` for ``i = 1,2,…,n``.
Given ``ε > 0``, ``∃N_i(ε) ∈ ℤ^+`` s.t. ``|x_i^{(k)} - x_i| < ε \quad`` ``∀k ≥ N_i(ε)``

Define ``N(ε) = \max_{1 ≤ i ≤ n} N_i(ε)`` then if ``k ≥ N(ε)`` ``\|\bar{x}^k - \bar{x}\|_∞ < ε \implies \{\bar{x}^{(k)}\}_{k=0}^∞ → \bar{x}``

Convergence is equivalent in ``ℝ^n``
"""

# ╔═╡ ca3d96ec-654b-42de-b1d6-8a498631c6ed
md"""
## Use Cases

1. Sparse Matrix computations occurs in solutions to PDEs or equations arising from circuit analysis

2. Can be less expensive if a good guess exists
"""

# ╔═╡ 11162671-2885-4a7f-a20d-9434a801099d
md"""
## Jacobi Iterative Method

Solve the ``i``th equation in ``A\bar{x} = \bar{b}`` for ``x_i`` ``(a_{ii} ≠ 0)``

$\begin{align*}
a_{11} x_1 + a_{12} x_2 + ⋯ + a_{1n} x_n &= b_1 \\
a_{21} x_1 + a_{22} x_2 + ⋯ + a_{2n} x_n &= b_2 \\
a_{i1} x_1 + a_{i2} x_2 + ⋯ + a_{in} x_n &= b_i \\
a_{n1} x_1 + a_{n2} x_2 + ⋯ + a_{nn} x_n &= b_n \\
\end{align*}$

$x_i = \frac{1}{a_i} \left(b_i - \sum_{j = 1, j ≠ i}^n a_{ij} x_j\right)$

for ``k ≥ 1`` ``x_i^{(k)}`` from ``x_i^{(k-1)}`` by

$x_i^{(k)} = \frac{1}{a_{ii}} \left[b_i - \sum_{j=1, j≠i}^n a_{ij} x_j^{(k-1)}\right]$

for ``i = 1,2,…,n``.
"""

# ╔═╡ 5e7e3ceb-85e2-49ed-b3bc-2f195991cc14
md"""
## Example

Solve

$\begin{align*}
3x_1 + x_2 &= 5 \\
x_1 + 2x_2 &= 5
\end{align*}$

Initial guess ``\bar{x}^{(0)} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}``

$x_1^{(k)} = \frac{5 - x_2^{(k-1)}}{3}$

$x_2^{(k)} = \frac{5 - x_1^{(k-1)}}{2}$

$x_{(k)} = \begin{bmatrix} x_1^{(1)} \\ x_2^{(1)} \end{bmatrix} = \begin{bmatrix} \frac{5-0}{3} \\ \frac{5-0}{2} \end{bmatrix} = \begin{bmatrix} 5/3 \\ 5/2 \end{bmatrix}$

$\bar{x}^{(2)} = \begin{bmatrix} x_1^{(2)} \\ x_2^{(2)} \end{bmatrix} = \begin{bmatrix} 5/6 \\ 5/3 \end{bmatrix}$

$\bar{x}^{(3)}  = \begin{bmatrix} x_1^{(3)} \\ x_2^{(3)} \end{bmatrix} = \begin{bmatrix} \frac{5-5/3}{3} \\ \frac{5 - 5/6}{2} \end{bmatrix}$
"""

# ╔═╡ ca24b812-062c-4d82-a168-be286a5dd6ee
md"""
## Stopping Criteria

$\|\bar{x}^{(k)} - \bar{x}^{(k-1)}\| < \text{tol}$

$\frac{\|\bar{x}^{(k)} - \bar{x}^{(k-1)}\|}{\|\bar{x}^{(k)}\|} < \text{tol}$
"""

# ╔═╡ 1b9b128a-5d1f-4ee2-a2a5-2c145417c2fd
md"""
## Matrix Form

$A = \begin{bmatrix}
a_{11} & a_{12} & ⋯ & a_{1n} \\
a_{21} & a_{22} & ⋯ & a_{1n} \\
⋮ & ⋮ & ⋱ & a_{1n} \\
a_{n1} & a_{n2} & ⋯ & a_{nn} \\
\end{bmatrix}$

$D = \begin{bmatrix}
a_{11} & & 0\\
& ⋱ \\
0 & & a_{nn}
\end{bmatrix}$

$U = \begin{bmatrix}
0 & -a_{12} & a_{1n}\\
⋮ & ⋱ & -a_{n-1,n}\\
0 & ⋯ & 0
\end{bmatrix}$

$L = \begin{bmatrix}
0 & ⋯ & 0 \\
-a_{21} & ⋱ & ⋮ \\
-a_{n1} & -a_{n,n-1} & 0
\end{bmatrix}$

$A = D - L - U$

$A\bar{x} = \bar{b}$


$(D - L - U)\bar{x} = \bar{b}$

$D\bar{x} = (L + U)\bar{x} + \bar{b}$

if ``D^{-1}`` exists i.e. ``a_{ii} ≠ 0`` for all ``i``

``\bar{x} = D^{-1} (L + U) \bar{x} + D^{-1} \bar{b}``

$\bar{x}^{(k)} = T_j \bar{x}^{(k-1)} + c_j$

Jacobi Matrix Form

$\bar{x}^{(k)} = \underbrace{D^{-1} (L + U)}_{\text{Jacobi}} \bar{x}^{(k-1)} + \underbrace{D^{-1} \bar{b}}_{c_j}$
"""

# ╔═╡ 47766373-f1da-43b7-a8a1-b1af7d436f6c
md"# 2022-11-17"

# ╔═╡ 133d87ae-8b54-4844-babc-3799bd60e63a
md"""
## Iterative Methods

``g(x) = x``

``f(x) = 0``

Bisection

Newton's Method

Secant Method

Fixed Point Iteration
"""

# ╔═╡ 9a0a3eea-d8fa-4bc8-95f5-681279e454dc
md"""
## Jacobi Iterative Technique

$x_i = \frac{1}{a_{ii}} \left(b_i - \sum_{j=1,j≠i}^n a_{ij} x_j\right)$

for ``i = 1,2,…,n``

Iterate with ``\|\bar{x}^{(k)} - \bar{x}^{(k-1)}\| < \text{TOL}`` or ``\displaystyle \frac{\|\bar{x}^{(k)} - \bar{x}^{(k-1)}\|}{\|\bar{x}^{(k)}\|} < \text{TOL}``

Cost of Jacobi for 1 step ``O(n^2)``

Compare with Gaussian Elimination ``O(n^2)``

$A = D - L - U$

$\bar{x}^{(k)} = \frac{T_j}{D^{-1} (L + U) \bar{x}^{(k-1)} + D^{-1}\bar{b}}$

$\bar{x}^{(k)} = T_j x^{(k-1)} + c_j$
"""

# ╔═╡ 78523245-01ca-4880-9183-de0c17e1e213
md"""
## Jacobi Matrix MATLAB example

```julia
function [x,k] = jacobi(A,b,x0,TOL,maxit)

n = length(b);
x = zeros(n,1);
k=1;

while k<maxit
	x = b;
	for i=1:n
		for j=1:n
			if j ~= i
				x(i) = x(i) - A(i,j)*x0(j);
			end
		end
		x(i) = x(i) / A(i,i);
	end
	if norm(x-x0,"Inf") < TOL
		break
	end
	k = k+1;
	x0 = x;
end

fprintf("failed to converge in given number of iterations \n");

end
```

Driver:

```julia
[x,k] = jacobi(A,b,x0,1e-5,100)
```
"""

# ╔═╡ b2f2e9e8-ec03-44d2-8b3d-01b2bb0b1160
md"""
## Gauss--Seidel

``\bar{x}^{(k-1)} → \bar{x}^{(k)}``

for ``i > 1``, ``x_1^{(k)}, x_2^{(k)}, …, x_{i-1}^{(k)}``

to compute ``x_i^{(k)}``

$x_i^{(k)} = \frac{1}{a_{ii}} \left(b_i - \sum_{j=1}^{i-1} a_{ij}x_j^{(k)} - \sum_{j=i+1}^n a_{ij} x_j^{(k-1)}\right)$

$a_i x_i^{(k)} = b_i = \sum_{j=1}^{i-1} a_{ij} x_j^{(k)} - \sum_{j=i+1}^n a_{ij} x_j^{(k-1)}$

$(D-L)\bar{x}^{(k)} = \bar{b} + U\bar{x}^{(k-1)}$

$\bar{x}^{(k)} = (D-L)^{-1} \bar{b} + (D-L)^{-1}U\bar{x}^{(k-1)}$

``(D-L)^{-1}`` exist iff ``a_{ii} ≠ 0``
"""

# ╔═╡ 7d86565e-72fc-466e-8d56-b97e3555c488
md"""
## Gauss-Seidel MATLAB example


```julia
function [x,k] = gaussseidel(A,b,x0,TOL,maxit)

n = length(b);
x = zeros(n,1);
k=1;

while k<maxit
	x = b;
	for i=1:n
		for j=1:i-1
			x(i) = x(i) - A(i,j)*x(j);
		end
		for j=i+1:n
			x(i) = x(i) - A(i,j)*x0(j);
		end
		x(i) = x(i) / A(i,i);
	end
	if norm(x-x0,"Inf") < TOL
		break
	end
	k = k+1;
	x0 = x;
end

fprintf("failed to converge in given number of iterations \n");

end
```

Driver:

```julia
[x,k] = gaussseidel(A,b,x0,1e-3,20)
```
"""

# ╔═╡ 74fccbd2-e8e9-46aa-9ac3-ec30281f57c6
md"""
## Theorem 7.21 (Sufficient Conditions)

If ``A`` is strictly diagonally dominant then for any choice of ``\bar{x}^0``, both the Jacobi and Gauss-Seidel methods give sequences ``\{\bar{x}^0\}_{k=0}^∞`` that converge to the unique solution of ``A\bar{x} = b``.
"""

# ╔═╡ 94b44f1f-4044-4703-8df4-d958d341d165
md"""
### Strictly diagonally dominant

``A ∈ ℝ^{n \times n}`` is strictly diagonally dominant if

$|a_{ii}| > \sum_{j=1,j≠i}^n |a_{ij}|$
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "ac1187e548c6ab173ac57d4e72da1620216bce54"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"
"""

# ╔═╡ Cell order:
# ╟─0b248756-8475-4c5b-82d6-741ae5d73f8d
# ╟─cffcc58a-27da-4c87-9737-d4ae0a7d19b3
# ╟─eaefdbb1-230c-4558-a5ac-01f22f281c91
# ╟─5c44aabc-247b-11ed-14b8-47bc9938cea5
# ╟─96f88e4d-e634-4c18-944a-ca454965ab6c
# ╟─7845aed3-2d70-4570-a8ad-1dc2e0941487
# ╟─d305f73f-ea44-4199-8938-bb1f04e64652
# ╟─8c31e561-adfd-4bbc-a9d3-363cc5e88508
# ╟─2b5231fa-02b4-4254-adac-1ef4b96cd09b
# ╟─b2eb34c3-c2af-49b0-82d9-e875598ad251
# ╟─3d326dda-53f7-48fe-94cd-ee0529677069
# ╟─b26e2c07-78d0-4b75-bfe3-0d83246ecedc
# ╟─07a24e03-7b90-4779-97f2-84a520e77723
# ╟─28735254-5904-4647-8166-0425b3bb3bce
# ╟─ad74d58e-95d0-4d9f-a5e9-b688573fe58f
# ╟─c7439617-abe9-4e8a-8885-e604ac17da28
# ╟─a1004d29-1815-4ac3-8fef-4ae0b02e0a7d
# ╟─0e5fb862-dc7e-45ac-b0de-ff7746ec6e40
# ╟─147224c2-792d-4dec-8d73-5a97f8190ed4
# ╟─f6656d21-fa78-4049-8101-537e138661a8
# ╟─26694b29-9a85-4bd8-9fba-06f6f8dfe50e
# ╟─a55d2789-ba77-4b12-b822-f1257a1b5944
# ╟─208c5c32-56ce-4a81-9c97-dc504387725a
# ╟─689b1d1e-0b4a-4fc2-b145-8ab5827099b8
# ╟─6f212283-3d93-405b-b711-68bd877e1f99
# ╟─4880f4e7-41f2-4050-9f20-4799d866d2da
# ╟─9cbeca01-50fc-4756-b6af-18765def6329
# ╟─18838092-6a6d-400e-a065-73601b8e5471
# ╟─19878cb0-3c46-43c1-bd81-46e92a7a34ab
# ╟─495c2646-89e4-4b40-a9b1-269bcc4ba4e4
# ╟─30b62c00-4ead-4a5a-99a7-a3ac0428b232
# ╟─f20bddb3-1f65-4cbb-a638-e643079c560a
# ╟─96f0eea8-aad2-43b3-b4a6-0cdb596e71d6
# ╟─7ae9a472-3ea8-4322-bcd6-5461e4e35b1a
# ╟─b8fe81e4-13fe-42f4-9785-8ac09190006e
# ╟─537bf5d9-60dd-4097-858b-e4b7bd79c20d
# ╟─e491d832-35a6-4315-b9b2-289dfe62a05e
# ╟─6428d0f4-243f-417d-a54f-1df72dbec447
# ╟─aa8e7f84-3ae5-40c2-b8ab-c14620d7fa73
# ╟─4192fcba-7380-4142-828e-833544d2089b
# ╟─993ad983-0a87-4d8b-acf5-0680b8c98baf
# ╟─d7ff4882-ad10-4184-85da-11ee43839038
# ╟─ffc001e2-3f2a-458e-b860-2fa72eb6a0ec
# ╟─b69083e6-15cf-4b86-8024-1be1bf0aa5ba
# ╟─7e3e7d9a-70d8-479e-b862-194e03e5ff42
# ╟─3a070391-7df9-4728-a7c6-92d798670206
# ╟─a3fe59f2-95a2-48d6-9ade-ab65a513ff9a
# ╟─5bd94a2f-c956-4e97-8977-82c020270c51
# ╟─4f178cca-2069-491e-a6cc-3ee93d5a9479
# ╟─55e36783-5ede-44fd-8e94-c457310918a4
# ╟─20eddabe-d9ee-4d6f-8a2a-8936ca596f04
# ╟─48e71d08-71f2-4480-ac83-b1583fa8695b
# ╟─564355cd-cd5a-4c94-beca-b127d589b2ee
# ╟─a52a3510-aa63-4c12-a1d4-c59c0b30206a
# ╟─cf1df799-902e-42ba-a229-6423606db4f3
# ╟─08e83883-5c62-46c8-ad6a-6dda06a3f536
# ╟─e7664cd1-19c6-4790-b5d6-40e0876daa68
# ╟─de880347-c6ab-4e65-8963-c78f852d241b
# ╟─d23b4a9f-9bb5-4140-9f94-b754bee8bcea
# ╟─0abe2ab7-ab69-4c3b-89c0-f325b75fa716
# ╟─41c5412c-a8f1-4beb-ade8-91784c30f947
# ╟─c74768f3-2385-4c3a-9ed0-4d70e4ca2760
# ╟─e2ac4adc-d34a-41c0-af13-8f3d2837049c
# ╟─e3db0115-325d-4bbc-bb09-559753338bc2
# ╟─8a2bac83-dd23-40ce-b80a-797f891f5763
# ╟─3d9f33ec-2659-4c5f-bfb5-e4bc43dce23c
# ╟─28ee5df1-fdf6-4ace-ba67-7dbb70828d34
# ╟─b652d9e0-f93d-434f-9f3a-9fba372c4472
# ╟─e7dec4c2-097c-42ae-82ce-244d6d1fc864
# ╟─2b183a03-8a5e-49f4-8e08-a90befad1166
# ╟─72906229-7393-4454-8903-c4a9d0a2769d
# ╟─304463f9-6661-44a4-8e47-1448ecfa314b
# ╟─7148b4c4-1355-4c14-879a-ee8f209ad632
# ╟─82b8af49-59b8-4098-b5df-c8a7681bc5d3
# ╟─2cdcdbd1-1818-4112-9c21-1bc0846ba525
# ╟─4af39427-d6c4-469b-a19a-05ef60c85428
# ╟─f29af101-1a1c-40d7-ac2a-a56fb68539d8
# ╟─89b91125-51a3-4a40-9b70-40408a81162c
# ╟─7c888c5e-8100-44ff-8278-5fe28d608a2b
# ╟─3e1fadd8-4c82-468e-9193-95100f64cd4e
# ╟─3c53c25a-39af-4f36-9a3f-dee81594043b
# ╟─d316dcca-714e-4aa4-93ca-471a8c0161a3
# ╟─64554874-b845-4ef4-9b44-3393cb71c49c
# ╟─ff36b7e9-ff58-430d-ad57-3f3837f943e0
# ╟─006e9988-bb1a-4e6c-b9b0-1e8c3d94ceac
# ╟─a0c82316-6858-4d77-ab5a-1d6115bbe710
# ╟─0c4f8e25-285e-4c82-9752-12bbd1cc7b8c
# ╟─e0f049d9-7cc1-4fb8-81b6-6179795fa2d6
# ╟─e493166b-d34a-48fb-9bd5-c2cf80ade67e
# ╟─707dd81f-399b-4b65-8372-d463993e88d5
# ╟─04531271-325a-4b2e-8b28-fee3ab6d7ee6
# ╟─04ad10ae-4f31-4637-b9c3-32c8321d5391
# ╟─566c6ee2-e808-40c0-b280-08c87cafd12f
# ╟─045f13b9-49cd-4289-be8d-47f7079e3b05
# ╟─38b2b188-1af6-4f40-a81f-73b06eae910b
# ╟─26bf688c-3ea7-4065-b2d2-dc428804383d
# ╟─88c935a5-bd9c-44ca-b982-3fbf83207028
# ╟─d25f08cf-b7ff-4347-883e-ca7107eb231f
# ╟─5a90c5c3-694e-4738-bfa1-cbce1d6e788b
# ╟─89c6e98c-2591-40fc-9524-d4b54381f6e4
# ╟─10cd94af-1625-4ce1-8cda-64d2676aff73
# ╟─76cd9713-d2ce-43bc-b91c-b9b4da4011d8
# ╟─567c5a14-9c99-4c19-beda-7adf207efdb3
# ╟─d3f33cba-f153-4c5d-9729-bf870f8ef4b2
# ╟─d1995034-3ef4-431d-bcb8-37a572703d60
# ╟─bd5e5ea4-b756-4b86-8071-df1cd43afdca
# ╟─9b490af4-91dd-4a10-8f61-a75c07b13f8f
# ╟─b904d122-4f5a-439a-9b0a-2e4c510d08b7
# ╟─a3275b95-737f-4192-9b5b-b1c77ce504d9
# ╟─12d95124-a902-4a58-a58b-97444a5ee419
# ╟─6cf46177-07ba-46e9-8431-20fcbc0eea93
# ╟─9a567690-a7ea-44f8-be63-5ce36eb94cc2
# ╟─dee54fec-59e2-4fa5-a42e-55949df62202
# ╟─85ba31db-57f7-4edb-bcd5-65659cc78eda
# ╟─d919c336-1102-466e-99e3-bb0cc8de38cf
# ╟─e190d5fb-1752-488e-a9d3-0834f0337d92
# ╟─1b4431c5-75c7-4605-8f20-cd3d7f74b8d4
# ╟─6f08e4f1-cdad-4f11-9d86-bb82bcbba034
# ╟─159edd5a-5e7e-498e-bb42-b813257e3747
# ╟─1df0f559-fe05-4741-ae59-d3e19fc799df
# ╟─543adfb6-474c-485f-8f4a-bd66f49862c4
# ╟─f8d40855-02a4-444f-beea-3e59f97adecf
# ╟─c012fbeb-d816-4181-9982-f29b83514fc2
# ╟─3d70576a-3dff-4460-a92c-d1aa005afa7b
# ╟─e365f838-47af-4d51-9d2e-59d9bba47436
# ╟─390940fc-aa00-4b7e-b3d5-101a562900f3
# ╟─c2715fe7-94f4-4c40-93cf-11827b2efc0b
# ╟─35b2370e-5a2d-45fe-a54c-7bcd74a10775
# ╟─423242eb-71fc-45d8-9706-949526c7a793
# ╟─8537f375-c3e3-479f-b32d-8c3cbfd8f1f3
# ╟─76c503f6-60b8-4c08-bfe3-be18d80ea818
# ╟─b06c4517-575c-4bbd-aad2-33d7d9585b71
# ╟─29ac7486-a3f9-424d-8027-aa8de2f1130b
# ╟─2e3b631c-6384-4219-9338-5631b7d3dcd6
# ╟─bbe829d6-0593-42e8-a36a-c76b1e1c1a34
# ╟─0ac51401-144c-46ac-8c70-4441aa95e7a2
# ╟─521e6bc9-5bbd-4665-9732-92497698b931
# ╟─55d50b79-4199-45e1-a31c-2fb1b1256cca
# ╟─4ba72e98-73e0-4092-b27c-0a2a28fc35df
# ╟─21b1d73e-b3ee-4fe9-b822-bc54b3ab290b
# ╟─0f128498-7db6-435b-a59b-c71e15667837
# ╟─897edfe7-c294-464e-9ef5-193c77f89c78
# ╟─513c1774-cfae-489d-9cca-c37930446d24
# ╟─d6092ace-93aa-4274-93bd-442b6f82c792
# ╟─51f6a0e3-39ec-46e8-868b-c45e1f1a2c57
# ╟─77837aab-d3fe-4a6c-8df7-e32404aa5924
# ╟─781aa867-2d53-409f-8905-e0cdf84a708d
# ╟─6637bdf0-7202-49ea-b482-21bb4c0aa5eb
# ╟─b7322a9c-85b1-45df-a4f7-82075d925406
# ╟─1dcca983-ec09-4281-80e2-4bcff20814db
# ╟─23c66667-8b5d-4b34-a98c-a9c055b36ce1
# ╟─bd813f79-3ef7-428f-9741-9e199536821f
# ╟─2c930938-c716-42d5-8fe9-cff8132f1884
# ╟─23ddb491-ca67-4c94-9676-65edeee547b2
# ╟─c7471e62-f219-425d-a85f-f709abf14127
# ╟─dc4ec87b-d94d-418d-b82e-c15a38680859
# ╟─e972b8d2-10a8-42d5-8274-2e4558e9dff6
# ╟─b0d8f8cb-7a81-4753-91a3-a2c2b2e35f2d
# ╟─c62cde72-01fd-4c60-9aa7-4231f1821b07
# ╟─b89fb5ec-3ac1-4203-bd62-27313f31fc28
# ╟─c9f6212e-572a-41be-83a2-6389b9d546f8
# ╟─2950a377-bc72-4e80-bf98-0ae57d74e3f7
# ╟─992028d2-a19c-4d71-8b72-0d29cb055100
# ╟─35bf43e3-4685-4a3a-be1e-9cf9e7fd3a37
# ╟─35e96283-f9c0-4871-894e-49426d5006ae
# ╟─be3f3dc0-2a1f-40bb-8dd2-42d6db3d804c
# ╟─1f78c925-3370-4959-a45d-7ca89759cf1e
# ╟─2cee034a-2e51-4672-89b6-2ea699a26b05
# ╟─82d7e2aa-34c4-43c9-ae7c-e6d322571e06
# ╟─9a650864-7aea-4b06-a69d-2f24ffb6b4f9
# ╟─fbd6dc6c-087a-465f-aa47-4ac75a0c325f
# ╟─0f2d65d9-2824-415e-b704-f6b87d7d2d0d
# ╟─fd2377f1-1a37-48c4-a994-14de9ad5bbf0
# ╟─76d40428-60f8-4546-a771-df8c67e0b7ff
# ╟─de343ce0-423b-40f7-90c3-66022d163783
# ╟─3483eecd-83c0-440f-9723-3782e07e5b8b
# ╟─bdc33d64-dd39-428b-9298-b26c467614cc
# ╟─7e5dd46d-c35c-47d1-bb60-9567962b652b
# ╟─431ba7fb-0d15-448f-8731-f88c06be7f8c
# ╟─5a6cb811-dc28-4bac-b92e-8b6fabdffb07
# ╟─c86d6344-8d17-49ac-a495-20504c90cf5e
# ╟─71b133db-251a-4bab-932f-0e28c92aad4a
# ╟─f60068d7-5c00-4885-ac97-bb0510ea276f
# ╟─736f59ff-551a-4871-97e6-1f301d6014c8
# ╟─65016918-e06e-415b-a56c-4a2d5b2f79bf
# ╟─485997bc-cfe5-475d-aad2-ee530362da32
# ╟─ca3d96ec-654b-42de-b1d6-8a498631c6ed
# ╟─11162671-2885-4a7f-a20d-9434a801099d
# ╟─5e7e3ceb-85e2-49ed-b3bc-2f195991cc14
# ╟─ca24b812-062c-4d82-a168-be286a5dd6ee
# ╟─1b9b128a-5d1f-4ee2-a2a5-2c145417c2fd
# ╟─47766373-f1da-43b7-a8a1-b1af7d436f6c
# ╟─133d87ae-8b54-4844-babc-3799bd60e63a
# ╟─9a0a3eea-d8fa-4bc8-95f5-681279e454dc
# ╟─78523245-01ca-4880-9183-de0c17e1e213
# ╟─b2f2e9e8-ec03-44d2-8b3d-01b2bb0b1160
# ╟─7d86565e-72fc-466e-8d56-b97e3555c488
# ╟─74fccbd2-e8e9-46aa-9ac3-ec30281f57c6
# ╟─94b44f1f-4044-4703-8df4-d958d341d165
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
