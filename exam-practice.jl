### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ b59dcc54-432c-11ed-3ed9-15d20bd54d91
md"# MATH3043 Exam Practice"

# ╔═╡ 83572829-c871-4d05-b772-ac47c0628e3d
md"""
### Problem 1 (20 points)

Build the degree three Taylor polynomial of the function ``f(x) = \sinh(4x)`` around the point ``x_0 = 0``.
Use this to approximate ``\sinh\left(\frac{4}{5}\right)``.
You may write your answer as a formula involving only numbers (you do not need to simplify).
[Hint: ``\sinh(u) = \frac{1}{2} (e^u - e^{-u})``]

_**Solution.**_
For a general solution ``f``, its third degree expansion is

$f(x) ≈ f(x_0) + f'(x_0)(x - x_0) + \frac{f''(x_0)}{2!}(x - x_0)^2 + \frac{f^{(3)}(x_0)}{3!} (x - x_0)^3$

For this problem, we have

$f(x) ≈ f(0) + f'(0)x + \frac{f''(0)}{2!}x^2 + \frac{f^{(3)}(0)}{3!} x^3$

Let's rewrite ``f(x)`` as

$f(x) = \sinh(4x) = \frac{1}{2} \left(e^{4x} - e^{-4x}\right) = \frac{1}{2} e^{4x} - \frac{1}{2} e^{-4x}$

then its derivatives are

$f'(x) = 2e^{4x} + 2e^{-4x}, \implies f'(0) = 4$

$f''(x) = 8e^{4x} - 8e^{-4x}, \implies f''(0) = 0$

$f^{(3)}(x) = 32e^{4x} + 32e^{-4x}, \implies f^{(3)}(0) = 64$

Thus, the degree three Taylor polynomial for the function ``f(x) = \sinh(4x)`` is

$f(x) ≈ 4x + \frac{64}{6} x^3$

Using this polynomial to approximate ``\sinh\left(\frac{4}{5}\right)`` we get

$\sinh\left(\frac{4}{5}\right) = \sinh\left(4 ⋅ \frac{1}{5}\right) = f\left(\frac{1}{5}\right) ≈ 4 \left(\frac{1}{5}\right) + \frac{64}{6} ⋅ \left(\frac{1}{5}\right)^3 = \frac{4}{5} + \frac{32}{375}.$
"""

# ╔═╡ 9826cde1-c53f-40dc-947f-a34049da47b5
md"""
### Problem 2 (5 points)

How can the values of ``f(x) = \sqrt{x + 4} - 2`` be computed accurately to avoid loss of significant digits when ``x`` is small?

_**Solution.**_
Subtraction can be problematic.
Cancellation errors (catastrophic cancellation).
If ``x`` is small, ``\sqrt{x + 4} ≈ 2`` which leads to potential catastrophic cancellation when subtracting.

$f(x) = \sqrt{x + 4} - 2 \left(\frac{\sqrt{x + 4} + 2}{\sqrt{x + 4} + 2}\right) = \frac{x + 4 - 4}{\sqrt{x + 4} + 2} = \frac{x}{\sqrt{x + 4} + 2}$

Now try using your computer to compute for ``x = 10^{-20}``.
"""

# ╔═╡ 56722920-9c82-4d20-8f8d-9b6148d1958d
let
	f1(x) = sqrt(x + 4) - 2
	f2(x) = x / (sqrt(x + 4) + 2)
	"f1(1e-20)" => f1(1e-20), "f2(1e-20)" => f2(1e-20)
end

# ╔═╡ e7c5b960-0136-490e-a672-e15b2353ea2b
md"""
### Problem 3 (15 points)

The equation ``f(x) = 2 - x^2 \sin{x} = 0`` has a solution in the interval ``[0,\frac{π}{2}]``.

(a) Verify that the Bisection method can be applied to the function ``f(x)`` on ``[0,\frac{π}{2}]``.

(b) Using the error formula for the Bisection method find the number of iterations needed for accuracy ``0.000001``.
Do not do the Bisection calculation.

_**Solution (a).**_
Bisection converges to a root in ``[a,b]``

1. If ``f(a)`` and ``f(b)`` have opposite signs

2. ``f ∈ C[a,b]`` (Why? Answer: Intermediate Value Theorem.)

Show (1) holds:

$f(0) = 2 > 0, \quad f\left(\frac{π}{2}\right) = 2 - \frac{π^2}{4} < 0$

Show (2) holds:

$2 - x^2 \sin{x} ∈ C\left[0,\frac{π}{2}\right] \;\text{ because }\; \begin{cases} 2 ∈ C[0,\frac{π}{2}] \\ x^2 ∈ C[0,\frac{π}{2}] \\ \sin{x} ∈ C[0,\frac{π}{2}] \end{cases}$

_**Solution (b).**_
Bisection terminates when

$\frac{b - a}{2^n} < \text{tol}$

i.e., if you cut interval in half ``n`` times we want the interval length < tol.

$\begin{align*}
\frac{\frac{π}{2}}{2^n} < 10^{-6} &\implies \frac{\pi}{2^{n+1}} < 10^{-6} \\
&\implies 2^{n+1} > π10^6 \\
&\implies \log_2\left(2^{n+1}\right) > \log_2\left(π10^6\right) \\
&\implies n + 1 > \log_2\left(π 10^6\right) \\
&\implies n > \log_2\left(π 10^6\right) - 1
\end{align*}$
"""

# ╔═╡ 3f6ef41b-e50b-45dc-8f75-03de66512ec9
md"""
### Problem 4 (15 points)

The following refer to the fixed-point problem

(a) State the theorem which gives conditions for a fixed-point sequence to converge to a unique fixed point.

(b) Given ``g(x) = π + \frac{1}{2} \sin(\frac{π}{2})``, use the theorem to show that the fixed-point sequence will converge to the unique fixed-point of ``g`` for any ``p_0`` in ``[0,2π]``.

_**Solution (a).**_
If ``g ∈ C[a,b]`` and ``g`` maps ``[a,b]`` to ``[a,b]`` and if in addition ``g'`` exists on ``(a,b)`` with ``|g'(x)| < k`` for some ``0 < k < 1`` for all ``x ∈ (a,b)`` then the fixed point sequence with ``p_n = g(p_{n-1})`` converges to a unique fixed point.

_**Solution (b).**_
``g(x) = π + \frac{1}{2} \sin(\frac{x}{2})`` is continuous on ``[0,2π]``.
``g'(x) = \frac{1}{4} \cos(\frac{x}{2})`` exists on ``(0,2π)``.

$\max_{x ∈ [0,2π]} |g'(x)| = \max_{x∈[0,2π]} \left|\frac{1}{4} \cos{\left(\frac{x}{2}\right)}\right| = \frac{1}{4}$

since ``\cos(x)`` is largest at 1, so ``k = \frac{1}{4} < 1``.
Does ``g : [0,2π] → [0,2π]``?

$g(0) = π, \qquad g(2π) = π$

Critical point:

$g'(x) = 0 = \frac{1}{4} \cos{\left(\frac{x}{2}\right)} \quad\text{ for }\quad x = π$

$g(π) = π + \frac{1}{2}$

so ``g`` maps ``[0,2π]`` to ``[0,2π]``.
With all conditions satisfied the fixed point sequence will converge for any starting ``p_0 ∈ [0,2π]``.
"""

# ╔═╡ bf2aea84-6feb-449f-a341-c58e2112e1aa
let
md"""
The criteria you need for Newton's Method to converge quadratically is

- ``f ∈ C^2[a,b]`` containing the root (``C^2`` means ``f,f',f''`` are all continuous on ``[a,b]``)

- If ``f(p) = 0``, ``f'(p) ≠ 0``

- Initial guess ``h_0`` "sufficiently close" to the root

- Proof: Use Taylor's theorem around root ``p``.

- General algorithm for quadratic convergence:

  $\lim_{h→∞} \frac{|x_{k+1} - x^*|}{|x_k - x^*|^2} = \text{constant}$

$\begin{align*}
h_k - p &= g(h_{k-1}) - g(p) \\
&= \left(h_{k-1} - \frac{f(h_{k-1})}{f'(h_{k-1})}\right) - \left(p - \frac{f(p)}{f'(p)}\right) \\
&= h_{k-1} - p - \frac{f(h_{k-1})}{f'(h_{k-1})}
\end{align*}$
"""
md"""
### Problem 5 (20 points)

Fluid flow in an open channel with a small bump may be modeled using Bernoulli's equation,

$\frac{Q^2}{2ρb^2w^2} + w = \frac{Q^2}{2ρb^2h^2} + h + H,$

where ``Q`` is the volume rate of flow, ``ρ`` is the acceleration due to gravity, ``b`` is the width of the channel, ``w`` is the upstream water height, ``H`` is the bump height, and ``h`` is the water level above the bump.
Given ``Q,ρ,b,w``, and ``H``, and we wish to find the height of the water above the bump, ``h``.

(a) Formulate this as a fixed-point problem.
What is your ``g(h)``?

(b) Formulate this as a root-finding problem.
What is your ``f(h)``?

(c) Write the iteration formula for a single step ``h_{k-1} → h_k`` of Newton's method on this problem - compute all necessary derivatives, but you do not need to simplify your answer.

(d) What are the conditions for Newton's method to converge quadratically?

_**Solution (a).**_
``g(h)`` = fixed-point function based on this.
Say ``h^*`` is my fixed point; i.e., ``h^* = g(h^*)``.
Let's get just an ``h`` on one side, and something in terms of ``h`` on the right (my ``g(h)``).

$h = \frac{Q^2}{2ρb^2 w^2} + w - \frac{Q^2}{2ρb^2h^2} - H$

$\implies g(h) = \frac{Q^2}{2ρb^2 w^2} + w - \frac{Q^2}{2ρb^2h^2} - H$

_**Solution (b).**_
Need some function ``f(h)`` such that a root ``h^*`` exists (i.e., ``f(h^*) = 0``).
Let's get ``0`` on one side, and something in terms of ``h`` on the other (my ``f(h)``).
In general, with a fixed point function ``g(h)``, our root-finding function is ``f(h) = h - g(h)``.

$\implies f(h) = h - \frac{Q^2}{2ρb^2w^2} - w + \frac{Q^2}{2ρb^2h^2} + H$

_**Solution (c).**_
Newton's Method.

$h_k = h_{k-1} - \frac{f(h_{k-1})}{f'(h_{k-1})}$

What is ``f'(h)``?

$f'(h) = 1 - \frac{Q^2}{ρb^2h^3}$

Then our expanded expression for Newton's Method is

$h_k = h_{k-1} - \frac{h_{k-1} - \frac{Q^2}{2ρb^2w^2} - w + \frac{Q^2}{2ρb^2{h_{k-1}}^2} + H}{1 - \frac{Q^2}{ρb^2{h_{k-1}}^3}}$

Side note: Newton's Method is basically fixed-point iteration where ``g(h) = \frac{f(h_{k-1})}{f'(h_{k-1})}``.

_**Solution (d).**_
If ``f`` is twice continuously differentiable with ``f(p) = 0`` and ``f'(p) ≠ 0`` then Newton's Method converges quadratically for guesses sufficiently close to ``p``.
"""
end

# ╔═╡ 53ab5099-2499-4acc-a930-df90e92aa880
md"""
### Problem 6 (10 points)

Find the maximum error in using the nodes ``x_0 = -1, x_1 = 0, x_2 = 1`` to approximate ``f(x) = e^{2x}`` with a polynomial on the interval ``[-1,1]``.

_**Solution.**_
Error formula for degree ``n`` interpolant

$f(x) - P_n(x) = \frac{f^{(n+1)} (ξ(x))}{(n + 1)!} \prod_{k=0}^n (x - x_k), \quad ξ(x) ∈ [x_0,x_n].$

In this problem ``(n = 2)`` we have

$\begin{align*}
f(x) - P_2(x) &= \frac{f^{(3)}(ξ(x))}{3!} (x - x_0)(x - x_1)(x - x_2), & ξ(x) &∈ [x_0,x_2] \\
&= \frac{8e^{2ξ(x)}}{3!} (x + 1) x (x - 1), & ξ(x) &∈ [-1,1].
\end{align*}$

$\begin{align*}
\max \text{absolute error} &= \max_{x ∈ [-1,1]} |f(x) - P_2(x)| \\
&= \max_{x ∈ [-1,1]} \left|\frac{8e^{2ξ(x)}}{3!} (x + 1) x (x - 1)\right| \\
&≤ \max_{x ∈ [-1,1]} \left|\frac{8e^{2x}}{3!}\right| ⋅ \max_{x ∈ [-1,1]} \left|(x + 1) x (x - 1)\right| \\
&= \frac{8}{3!} e^2 ⋅ \frac{2}{3\sqrt{3}} \\
&= \frac{16}{18 \sqrt{3}} e^2 \qquad \text{Maximum error (upper bound)} \\
\end{align*}$

Aside: To find the max of ``(x + 1)x(x - 1)`` let ``g(x) = (x + 1)x(x - 1) = x^3 - x``.
The derivative of ``g'(x) = 3x^2 - 1`` gives the critical points ``x = ±\frac{1}{\sqrt{3}}``.

$\begin{align*}
g(-1) &= 0 \\
g(1) &= 0 \\
g\left(\frac{1}{\sqrt{3}}\right) &= \frac{1}{3\sqrt{3}} - \frac{1}{\sqrt{3}} = \frac{-2}{3\sqrt{3}} \\
g\left(\frac{-1}{\sqrt{3}}\right) &= \frac{-1}{3\sqrt{3}} + \frac{1}{\sqrt{3}} = \frac{2}{3\sqrt{3}}
\end{align*}$

So the max of ``(x + 1)x(x - 1)`` is ``\frac{2}{3\sqrt{3}}``.
"""

# ╔═╡ 39cf5d56-a87b-467e-bff8-3c8247ec4fbc
md"""
### Problem 7 (15 points)

Construct the Hermite interpolation polynomial of degree 3 for the function ``f(x) = x^5`` using the points ``x_0 = 0, x_1 = 1``.

_**Solution.**_

$\begin{align*}
f(x) &= x^5, & f'(x) &= 5x^4 \\
f(0) &= 0, & f'(0) &= 0 \\
f(1) &= 1, & f'(1) &= 5
\end{align*}$

$H_3(x) = \sum_{j=0}^1 f(x_j) H_{1,j}(x) + \sum_{j=0}^1 f'(x_j) \hat{H}_{1,j}(x) = H_{1,1}(x) + 5\hat{H}_{1,1}(x)$

$L_{1,1}(x) = \frac{(x - 0)}{(1 - 0)} = x, \qquad L_{1,1}'(x) = 1$

$\begin{align*}
H_{1,1}(x) &= [1 - 2(x - 1)L_{1,1}'(x)] L_{1,1}^2(x) \\
&= (1 - 2x + 2)x^2 \\
&= (3 - 2x)x^2 \\
&= 3x^2 - 2x^3
\end{align*}$

$\hat{H}_{1,1}(x) = (x - 1)x^2 = x^3 - x^2$

$H_3(x) = 3x^2 - 2x^3 + 5x^3 - 5x^2 = 3x^3 - 2x^2$

Use Newton's Divided Differences:
Since it's a degree 3 Hermite polynomial, we need at least 4 data points.
The 4 interpolation points we're going to use are ``(x_0,f(x_0)), (x_0,f'(x_0)), (x_1,f(x_1)), (x_1,f'(x_1))``.

$\begin{array}{c|c|c|c|c|c}
x & y & 1\text{st} & 2\text{nd} & 3\text{rd} \\
\hline
x_0 & f(x_0) \\
& & f'(x_0) = 0 \\
x_0 & f'(x_0) && 1 \\
& & \frac{f(x_1) - f(x_0)}{x_1 - x_0} = 1 && 0 \\
x_1 & f(x_1) && 0 \\
& & f'(x_1) = 1 \\
x_1 & f'(x_1)
\end{array}$

The polynomial is

$H_3(x) = 0 + 0(x - 0) + 1(x - 0)(x - 0) + 0(x - 0)(x - 0)(x - 1) = x^2$
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
# ╟─b59dcc54-432c-11ed-3ed9-15d20bd54d91
# ╟─83572829-c871-4d05-b772-ac47c0628e3d
# ╟─9826cde1-c53f-40dc-947f-a34049da47b5
# ╠═56722920-9c82-4d20-8f8d-9b6148d1958d
# ╟─e7c5b960-0136-490e-a672-e15b2353ea2b
# ╟─3f6ef41b-e50b-45dc-8f75-03de66512ec9
# ╟─bf2aea84-6feb-449f-a341-c58e2112e1aa
# ╟─53ab5099-2499-4acc-a930-df90e92aa880
# ╟─39cf5d56-a87b-467e-bff8-3c8247ec4fbc
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
