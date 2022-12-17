### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ ff07bd1c-32d0-11ed-0815-2bfba1adcab6
md"""
# Homework 2

Eric Nguyen $\qquad$ September 15, 2022
"""

# ╔═╡ 93c6e04c-b60f-4981-b13f-855e45be28c1
md"""
### Problem 2.1 #2 (b)

Let ``f(x) = 3(x + 1)(x - \frac{1}{2})(x - 1) = 0``.
Use the Bisection method on the following intervals to find ``p_3``.

(b) ``[-1.25, 2.5]``

_**Solution (b).**_

$p_1 = \frac{2.5 - 1.25}{2} = 0.625 ⟹ f(0.625) ≈ -0.29 < 0 ⟹ a_2 = 0.625$
$p_2 = \frac{2.5 + 0.625}{2} = 1.5625 ⟹ f(1.5625) ≈ 4.6 > 0 ⟹ b_2 = 1.5625$
$p_3 = \frac{1.5625 + 0.625}{2} = 1.09375$
"""

# ╔═╡ e6283b0d-b863-4d66-83f9-a828646d6047
md"""
### Problem 2.1 #18

Use Theorem 2.1 to find a bound for the number of iterations needed to achieve an approximation with accuracy ``10^{-3}`` to the solution of ``x^3 + x - 4 = 0`` lying in the interval ``[1,4]``.

_**Solution.**_

$\begin{align*}
|p_N - p| ≤ 2^{-N} (b - a) = 3×2^{-N} &< 10^{-3} \\
\log_{10}{3} -N \log_{10}{2} &< -3 \\
-N \log_{10}{2} &< -3 - \log_{10}{3} \\
N &> \frac{3 - \log_{10}{3}}{\log_{10}{2}} ≈ 8.38
\end{align*}$

9 iterations are required for an approximation accurate to within ``10^{-3}``.
"""

# ╔═╡ b6e52728-c52a-413e-8a61-7573ecad21b6
md"""
### Problem 2.2 #10

Use Theorem 2.3 to show that ``g(x) = 2^{-x}`` has a unique fixed point on ``[\frac{1}{3},1]``.
Use Corollary 2.5 to estimate the number of iterations required to achieve ``10^{-4}`` accuracy.

_**Solution.**_
The maximum or minimum values of ``g(x)`` for ``x`` in ``[\frac{1}{3},1]`` must occur when ``x`` is an endpoint of the interval or when the derivative is ``0``.
Since ``g'(x) = -2^{-x} \log{2}``, the function ``g`` is continuous, and ``g'(x)`` exists on ``[\frac{1}{3},1]``.
The maximum and minimum values of ``g(x)`` occur at ``x = \frac{1}{3}`` or ``x = 1``.
Since ``g(\frac{1}{3}) ≈ 0.79`` and ``g(1) = 0.5`` we have an absolute minimum for ``g(x)`` at ``x = 1`` and absolute maximum for ``g(x)`` at ``x = \frac{1}{3}``.
Also

$|g'(x)| = \left|-2^{-x} \log{2}\right| ≤ \frac{\log{2}}{2}, \quad\text{ for all } x ∈ \left[\frac{1}{3}, 1\right]$

So ``g`` satisfies all the hypotheses of  Theorem 2.3 and has a unique fixed point in ``[\frac{1}{3},1]``.

Let ``p_0 = 1`` and ``p_1 = g(p_0) = g(1) = 2^{-1} = 0.5``.
Using Corollary 2.5,

$|p_n - p| ≤ \frac{(\log{(2)} / 2)^n}{1 - \log{(2)}/2} |p_1 - p_0| = \frac{(\log{(2)} / 2)^n}{2(1 - \log{(2)}/2)} = 10^{-4}$

Solving for ``n``, we get

$\begin{align*}
(\log{(2)} / 2)^n &= \left[2(1 - \log{(2)}/2)\right] × 10^{-4} \\
n &= \frac{\log\left[(2 - \log{(2)}) × 10^{-4}\right]}{\log((\log{(2)} / 2))} ≈ 4.7 \\
\end{align*}$

So we need at least 5 iterations to achieve ``10^{-4}`` accuracy.
"""

# ╔═╡ a9153ddf-21e9-44a3-a32b-851fde538b18
md"""
### Problem 2.2 #20 (a,b)

Let ``A`` be a given positive constant and ``g(x) = 2x - Ax^2``.

a. Show that if fixed-point iteration converges to a nonzero limit, then the limit is ``p = 1/A``, so the inverse of a number can be found using only multiplications and subtractions.

b. Find an interval about ``1/A`` for which fixed-point iteration converges, provided ``p_0`` is in that interval.

_**Solution (a).**_
A fixed point ``p`` for ``g`` has the property that

$p = g(p) = 2p - Ap^2, \quad\text{ which implies that }\quad 0 = p (1 - Ap)$

A fixed point for ``g`` occurs when ``y = g(x)`` intersects with ``y = x``, so ``g`` has two fixed points, one at ``p = 0`` and the other at ``p = \frac{1}{A}``.

_**Solution (b).**_
The interval about ``1 / A`` for which fixed-point iteration converges, provided ``p_0`` is in that interval, is the interval when

$|g'(x)| = |2 - 2Ax| < 1$

Solving for ``x`` we get the interval ``\displaystyle \left[\frac{1}{2A}, \frac{3}{2A}\right]``.
"""

# ╔═╡ 6968d4bf-6810-4b1a-a81c-3dc310544fd8
md"""
### Additional Problem #1

Use the Intermediate Value Theorem to find an interval of length one that contains a root of the equation ``\cos^2{x} + 6 = x``.

_**Solution.**_
Let ``f(x) = \cos^2{x} + 6 - x``.
``f(6) ≈ 0.92`` and ``f(7) ≈ -0.43`` so there exists a root in the interval ``[6,7]``.
"""

# ╔═╡ 3340c208-31f7-4494-bd47-17e87048b48e
md"""
### Additional Problem #2

State a root-finding problem that can be used to find an approximation to ``\sqrt{2}`` with the Bisection Method.

_**Solution.**_

$f(x) = x - \sqrt{2} = 0$
"""

# ╔═╡ 9453b830-ecfa-4b4c-9b79-8713ef399c51
md"""
### Additional Problem #3

Find all fixed points of ``\displaystyle g(x) = \frac{8 + 2x}{2 + x^2}``.

_**Solution.**_
The fixed-point ``p`` of ``g`` is

$\begin{align*}
p = g(p) &= \frac{8 + 2p}{2 + p^2} \\
p(2 + p^2) &= 8 + 2p \\
p^3 &= 8 \\
p &= \sqrt[3]{8} = 2
\end{align*}$
"""

# ╔═╡ ea0d9627-54d7-48e8-b1b5-ecebf936ad54
md"""
### Additional Problem #4

Express ``x^3 - x + e^x = 0`` as a fixed point problem in two different ways.

_**Solution.**_
Let ``f(x) = x^3 - x + e^x``.
Given a root-finding problem ``f(p) = 0`` can define two different functions ``g_1`` and ``g_2`` like so:

$g_1(x) = f(x) + x = x^3 + e^x \quad\text{ and }\quad g_2(x) = f(x) - x = x^3 - 2x + e^x$

Then we have two different fixed-point problems:

$x = g_1(x) = x^3 + e^x \quad\text{ and }\quad x = g_2(x) = x^3 - 2x + e^x$
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─ff07bd1c-32d0-11ed-0815-2bfba1adcab6
# ╟─93c6e04c-b60f-4981-b13f-855e45be28c1
# ╟─e6283b0d-b863-4d66-83f9-a828646d6047
# ╟─b6e52728-c52a-413e-8a61-7573ecad21b6
# ╟─a9153ddf-21e9-44a3-a32b-851fde538b18
# ╟─6968d4bf-6810-4b1a-a81c-3dc310544fd8
# ╟─3340c208-31f7-4494-bd47-17e87048b48e
# ╟─9453b830-ecfa-4b4c-9b79-8713ef399c51
# ╟─ea0d9627-54d7-48e8-b1b5-ecebf936ad54
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
