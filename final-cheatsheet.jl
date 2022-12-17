### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ 89889634-74e2-11ed-2352-e11935e401e0
md"""
# MATH3043 Final Exam Cheatsheet
"""

# ╔═╡ 471206a7-b7ff-4b1c-9986-39de2b87a55c
md"""
**Theorem 1.7 (Rolle's Theorem)**
Suppose ``f ∈ C[a,b]`` and ``f`` is differentiable on ``(a,b)``.
If ``f(a) = f(b)``, then a number ``c`` in ``(a,b)`` exists with ``f'(c) = 0``.
"""

# ╔═╡ e5e7c2c6-0d65-43f6-919d-45622ae37618
md"""
**Theorem 1.8 (Mean Value Theorem)**
If ``f ∈ C[a,b]`` and ``f`` is differentiable on ``(a,b)``, then a number ``c`` in ``(a,b)`` exists with

$f'(c) = \frac{f(b) - f(a)}{b - a}.$
"""

# ╔═╡ db4a14bd-1e64-475a-b9f6-9398eb8c7bed
md"""
**Theorem 1.9 (Extreme Value Theorem)**
If ``f ∈ C[a,b]``, then ``c_1,c_2 ∈ [a,b]`` exist with ``f(c_1) ≤ f(x) ≤ f(c_2)``, for all ``x ∈ [a,b]``.
In addition, if ``f`` is differentiable on ``(a,b)``, then the numbers ``c_1`` and ``c_2`` occur either at the endpoints of ``[a,b]`` or where ``f'`` is zero.
"""

# ╔═╡ 47ba8a35-38ea-44cb-9676-9bbd74b33911
md"""
**Theorem 1.14 (Taylor's Theorem)**
Suppose ``f ∈ C^n[a,b]``, ``f^{(n+1)}`` exists on ``[a,b]``, and ``x_0 ∈ [a,b]``.
For every ``x ∈ [a,b]``, there exists a number ``ξ(x)`` between ``x_0`` and ``x`` with

$f(x) = P_n(x) + R_n(x),$

where

$\begin{align*}
P_n(x) &= f(x) + f'(x_0) (x - x_0) + \frac{f''(x_0)}{2!}(x-x_0)^2 + ⋯ + \frac{f^{(n)}(x_0)}{n!}(x - x_0)^n \\
&= \sum_{k=0}^n \frac{f^{(k)}(x_0)}{k!} (x - x_0)^k
\end{align*}$

and

$R_n(x) = \frac{f^{(n+1)}(ξ(x))}{(n+1)!} (x - x_0)^{n+1}.$
"""

# ╔═╡ 1dc7f36b-4062-4536-94ab-fb4e75f17e3e
md"""
**Definition 2.2**
The number ``p`` is a **fixed point** for a given function ``g`` if ``g(p) = p``.
"""

# ╔═╡ 6f41c444-a271-4e61-ae83-580d481bd4e1
md"""
**Theorem 2.3**

- **(i)** If ``g ∈ C[a,b]`` and ``g(x) ∈ [a,b]`` for all ``x ∈ [a,b]``, then ``g`` has at least one fixed point in ``[a,b]``.

- **(ii)** If, in addition, ``g'(x)`` exists on ``(a,b)`` and a positive constant ``k < 1`` exists with

  $|g'(x)| ≤ k, \quad\text{for all } x ∈ (a,b),$

  then there is exactly one fixed point in ``[a,b]``.
"""

# ╔═╡ d2627b82-8e7e-4a81-9bd7-297ae9a5f262
md"""
**Theorem 2.4 (Fixed-Point Theorem)**
Let ``g ∈ C[a,b]`` be such that ``g(x) ∈ [a,b]``, for all ``x`` in ``[a,b]``.
Suppose, in addition, that ``g'`` exists on ``(a,b)`` and that a constant ``0 < k < 1`` exists with

$|g'(x)| ≤ k, \quad\text{for all } x ∈ (a,b).$

Then, for any number ``p_0`` in ``[a,b]``, the sequence defined by

$p_n = g(p_{n-1}), \quad n ≥ 1,$

converges to the unique fixed point ``p`` in ``[a,b]``.
"""

# ╔═╡ 82ae1fb8-e73f-467d-b53e-79b0588c055a
md"""
**Newton's Method (Root-finding problem)**

$p_n = g(p_{n-1}) = p_{n-1} - \frac{f(p_{n-1})}{f'(p_{n-1})}, \quad\text{for } n ≥ 1.$
"""

# ╔═╡ 4c395671-0b19-4c2c-ae16-df5954dcf468
md"""
**Secant Method (Root-finding problem)**

$p_n = p_{n - 1} - \frac{f(p_{n-1})(p_{n-1} - p_{n-2})}{f(p_{n-1}) - f(p_{n-2})}$
"""

# ╔═╡ 65663bb4-0be2-476e-82af-88bc682296e7
md"""
**Definition 2.7 (Order of Convergence)**
Suppose ``\{p_n\}_{n=0}^∞`` is a sequence that converges to ``p``, with ``p_n ≠ p`` for all ``n``.
If positive constants ``λ`` and ``α`` exist with

$\lim_{n→∞} \frac{|p_{n+1} - p|}{|p_n - p|^α} = λ,$

then ``\{p_n\}_{n=0}^∞`` **converges to ``p`` of order ``α``, with asymptotic error constant ``λ``**.
"""

# ╔═╡ be1953eb-666d-4228-89d7-57a84f353239
md"""
**Theorem 3.2**
If ``x_0,x_1,…,x_n`` are ``n + 1`` distinct numbers and ``f`` is a function whose values are given at these numbers, then a unique polynomial ``P(x)`` of degree at most ``n`` exists with

$f(x_k) = P(x_k), \quad \text{for each } k = 0, 1, …, n.$

This polynomial is given by

$P(x) = f(x_0) L_{n,0}(x) + ⋯ + f(x_n) L_{n,n}(x) = \sum_{k=0}^n f(x_k) L_{n,k}(x),$

where, for each ``k = 0, 1, …, n``.

$\begin{align*}
L_{n,k}(x) &= \frac{(x-x_0)(x-x_1)⋯(x-x_{k-1})(x-x_{k+1})⋯(x - x_n)}{(x_k - x_0)(x_k - x_1) ⋯ (x_k - x_{k-1})(x_k - x_{k+1}) ⋯ (x_k - x_n)} \\
&= \prod_{\substack{i=0\\i≠k}}^n \frac{(x - x_i)}{(x_k - x_i)}.
\end{align*}$
"""

# ╔═╡ fcf4e3a8-3c1d-4e3a-8803-be4c6a147c75
md"""
**Theorem 3.3 (Lagrange Error)**
Suppose ``x_0,x_1,…,x_n`` are distinct numbers in the interval ``[a,b]`` and ``f ∈ C^{n+1}[a,b]``.
Then, for each ``x`` in ``[a,b]``, a number ``ξ(x)`` (generally unknown) between ``\min\{x_0,x_1,…,x_n\}``, and the ``\max\{x_0,x_1,…,x_n\}`` and hence in ``(a,b)``, exists with

$f(x) = P(x) + \frac{f^{(n+1)}(ξ(x))}{(n+1)!} (x - x_0)(x - x_1) ⋯ (x - x_n),$

where ``P(x)`` is the interpolating polynomial given in Eq. (3.1).
"""

# ╔═╡ 2d04bb2e-f858-4cd0-b8b9-a67ba8fe4484
md"""
**Theorem 3.9**
If ``f ∈ C^1[a,b]`` and ``x_0,…,x_n ∈ [a,b]`` are distinct, the unique polynomial of at least degree agreeing with ``f`` and ``f'`` at ``x_0, …, x_n`` is the Hermite polynomial of degree at most ``2n + 1`` given by

$H_{2n+1}(x) = \sum_{j=0}^n f(x_j) H_{n,j}(x) + \sum_{j=0}^n f'(x_j) \hat{H}_{n,j}(x),$

where, for ``L_{n,j}(x)`` denoting the ``j``th Lagrange coefficient polynomial of degree ``n``, we have

$H_{n,j}(x) = [1 - 2(x - x_j) L_{n,j}'(x_j)] L_{n,j}^2 (x) \quad\text{and}\quad \hat{H}_{n,j}(x) = (x - x_j) L_{n,j}^2(x).$

Moreover, if ``f ∈ C^{2n + 2}[a,b]``, then

$f(x) = H_{2n+1}(x) + \frac{(x - x_0)^2 ⋯ (x - x_n)^2}{(2n + 2)!} f^{(2n + 2)}(ξ(x)),$

for some (generally unknown) ``ξ(x)`` in the interval ``(a,b)``.
"""

# ╔═╡ 7938e808-47a4-427e-9f65-7c37e1499d85
md"""
**Quadrature formula**

$∫_a^b f(x) \,dx ≈ \sum_{i=0}^n a_i f(x_i)$
"""

# ╔═╡ 1d9fa0a5-ffc5-4a14-a433-78ee8d7bd75c
md"""
**Quadrature error**

$E(f) = \frac{1}{(n + 1)!} ∫_a^b \prod_{i=0}^n (x - x_i) f^{(n+1)}(ξ(x)) \,dx$
"""

# ╔═╡ d5c4cbc7-96b8-4636-848f-29f3f528ec05
md"""
**Trapezoidal Rule**

$∫_a^b f(x) \,dx  = \frac{h}{2} [f(x_0) + f(x_1)] - \frac{h^3}{12} f''(ξ)$
"""

# ╔═╡ 682cdd5f-c761-4f09-95fa-edc9ea8de692
md"""
**Simpson's Rule**

$∫_{x_0}^{x_2} f(x) \,dx = \frac{h}{3} [f(x_0) + 4f(x_1) + f(x_2)] - \frac{h^5}{90} f^{(4)}(ξ)$
"""

# ╔═╡ 14f8094a-67fe-4f3e-8810-44bf049e4331
md"""
**Definition 4.1**
The **degree of accuracy**, or **precision**, of a quadrature formula is the largest positive integer ``n`` such that the formula is exact for ``x_k``, for each ``k = 0, 1, …, n``.
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
# ╟─89889634-74e2-11ed-2352-e11935e401e0
# ╟─471206a7-b7ff-4b1c-9986-39de2b87a55c
# ╟─e5e7c2c6-0d65-43f6-919d-45622ae37618
# ╟─db4a14bd-1e64-475a-b9f6-9398eb8c7bed
# ╟─47ba8a35-38ea-44cb-9676-9bbd74b33911
# ╟─1dc7f36b-4062-4536-94ab-fb4e75f17e3e
# ╟─6f41c444-a271-4e61-ae83-580d481bd4e1
# ╟─d2627b82-8e7e-4a81-9bd7-297ae9a5f262
# ╟─82ae1fb8-e73f-467d-b53e-79b0588c055a
# ╟─4c395671-0b19-4c2c-ae16-df5954dcf468
# ╟─65663bb4-0be2-476e-82af-88bc682296e7
# ╟─be1953eb-666d-4228-89d7-57a84f353239
# ╟─fcf4e3a8-3c1d-4e3a-8803-be4c6a147c75
# ╟─2d04bb2e-f858-4cd0-b8b9-a67ba8fe4484
# ╟─7938e808-47a4-427e-9f65-7c37e1499d85
# ╟─1d9fa0a5-ffc5-4a14-a433-78ee8d7bd75c
# ╟─d5c4cbc7-96b8-4636-848f-29f3f528ec05
# ╟─682cdd5f-c761-4f09-95fa-edc9ea8de692
# ╟─14f8094a-67fe-4f3e-8810-44bf049e4331
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
