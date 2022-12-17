### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ 129e90fe-4f18-11ed-2058-2f9a506850e1
md"""
# Homework 6

Eric Nguyen $\qquad$ October 18, 2022
"""

# ╔═╡ 853a567c-7c5a-4b67-b335-bf89e73d332a
let
let
	X = [1.0,1.2,1.4]
	Y = [1.0000,1.2625,1.6595]
	
	f(x) = if x ∈ X
		Dict([(a,b) for (a,b) ∈ zip(X,Y)])[x]
	else
		0
	end

	h = 0.2
	[
		[(f(x0 + h) - f(x0)) / h for x0 ∈ X[1:end-1]];
		[(f(x0 - h) - f(x0)) / -h for x0 ∈ X[end]]
	]
end
md"""
### Problem 4.1 #2 (b)

Use the forward-difference formulas and backward-difference formulas to determine each missing entry in the following tables.

b.

| ``x`` | ``f(x)`` | ``f'(x)`` |
|-------|----------|-----------|
| 1.0 | 1.0000 | |
| 1.2 | 1.2625 | |
| 1.4 | 1.6595 | |

_**Solution (b).**_
Let ``h = 0.2``.
The forward ``(h > 0)`` or backward ``(h < 0)``-difference formula is

$f'(x_0) = \frac{f(x_0 + h) - f(x_0)}{h}$

Using forward-difference:

$f'(1.0) = \frac{f(1.2) - f(1.0)}{0.2} = \frac{1.2625 - 1.0000}{0.2} = 1.3125$

$f'(1.2) = \frac{f(1.4) - f(1.2)}{0.2} = \frac{1.6595 - 1.2625}{0.2} = 1.9850$

Using backward-difference:

$f'(1.4) = \frac{f(1.2) - f(1.4)}{-0.2} = \frac{1.6595 - 1.2625}{0.2} = 1.9850$

Fill in the table:

| ``x`` | ``f(x)`` | ``f'(x)`` |
|-------|----------|-----------|
| 1.0 | 1.0000 | 1.3125 |
| 1.2 | 1.2625 | 1.985 |
| 1.4 | 1.6595 | 1.985 |
"""
end

# ╔═╡ d6db16bc-b8c9-4794-a05c-9c2cafdac7f2
let
let
	X = [-0.3,-0.2,-0.1,0]
	Y = [-0.27652,-0.25074,-0.16134,0]
	f(x) = Dict([(a,b) for (a,b) in zip(X,Y)])[round(x,digits=1)]
	
	endpoint(x0,h) = (1/2h) * (-3f(x0) + 4f(x0 + h) - f(x0 + 2h))
	midpoint(x0,h) = (1/2h) * (f(x0 + h) - f(x0 - h))

	dfi = endpoint(X[1],0.1)
	dfm = midpoint.(X[2:3],0.1)
	dff = endpoint(X[end],-0.1)
	df = [dfi; dfm; dff]
end
md"""
### Problem 4.1 #6 (a)

Use the most accurate three-point formula to determine each missing entry in the following tables.

a.

| ``x`` | ``f(x)`` | ``f'(x)`` |
|-------|----------|-----------|
| -0.3 | -0.27652 | |
| -0.2 | -0.25074 | |
| -0.1 | -0.16134 | |
| 0 | 0 | |

_**Solution (a).**_
Let ``h = 0.1``.
The Three-Point Endpoint Formula is

$f'(x_0) = \frac{1}{2h} [-3f(x_0) + 4f(x_0 + h) - f(x_0 + 2h)]$

and the Three-Point Midpoint Formula is

$f'(x_0) = \frac{1}{2h} [f(x_0 + h) - f(x_0 - h)]$

Three-Point Endpoint forward-difference formula:

$f'(-0.3) = \frac{1}{0.2} [-3f(-0.3) + 4f(-0.2) - f(-0.1)] = -0.06030$

Three-Point Midpoint forward-difference formula:

$f'(-0.2) = \frac{1}{0.2} [f(-0.1) - f(-0.3)] = 0.57590$

$f'(-0.1) = \frac{1}{0.2} [f(-0.2) - f(0)] = 1.25370$

Three-Point Endpoint backward-difference formula:

$f'(0) = \frac{1}{-0.2} [-3f(0) + 4f(-0.1) - f(-0.2)] = 1.97310$

Fill in the table:

| ``x`` | ``f(x)`` | ``f'(x)`` |
|-------|----------|-----------|
| -0.3 | -0.27652 | -0.06030 |
| -0.2 | -0.25074 | 0.57590 |
| -0.1 | -0.16134 | 1.25370 |
| 0 | 0 | 1.97310 |
"""
end

# ╔═╡ 7362b268-f3cd-4856-9e22-4e90a9453819
let
let
	X = [1.20,1.29,1.30,1.31,1.40]
	Y = [11.59006,13.78176,14.04276,14.30741,16.86187]
	f(x) = Dict([(a,b) for (a,b) ∈ zip(X,Y)])[round(x,digits=2)]

	midpoint(x0,h) = (1/h^2) * (f(x0 - h) - 2f(x0) + f(x0 + h))

	midpoint(1.3,0.1), midpoint(1.3,0.01)
end
md"""
### Problem 4.1 #20

Let ``f(x) = 3xe^x - \cos{x}``.
Use the following data and Eq. (4.9) to approximate ``f''(1.3)`` with ``h = 0.1`` and with ``h = 0.01``.

| ``x`` | ``f(x)`` |
|-------|----------|
| 1.20 | 11.59006 |
| 1.29 | 13.78176 |
| 1.30 | 14.04276 |
| 1.31 | 14.30741 |
| 1.40 | 16.86187 |

_**Solution.**_
The Second Derivative Midpoint Formula is

$f''(x_0) = \frac{1}{h^2} [f(x_0 - h) - 2f(x_0) + f(x_0 + h)]$

Using ``h = 0.1``:

$f''(1.3) = \frac{1}{0.01} [f(1.2) - 2f(1.3) + f(1.4)] = 36.641$

Using ``h = 0.01``:

$f''(1.3) = \frac{1}{0.0001} [f(1.29) - 2f(1.3) + f(1.31)] = 36.5$
"""
end

# ╔═╡ 301f60c6-5bd9-4877-ad8f-8faaa7f50e7d
let
let
	a = 0.75
	b = 1.3
	h = b - a

	f(x) = sin(x)^2 - 2x * sin(x) + 1
	(h / 2) * (f(a) + f(b))
end
md"""
### Problem 4.3 #2 (c)

Approximate the following integrals using the Trapezoidal rule.

c. ``\displaystyle ∫_{0.75}^{1.3} ((\sin{x})^2 - 2x \sin{x} + 1) \,dx``

_**Solution.**_
The Trapezoidal Rule is

$∫_a^b f(x) \,dx = \frac{h}{2} [f(x_0) + f(x_1)]$

Let ``f(x) = (\sin{x})^2 - 2x \sin{x} + 1``, ``x_0 = a = 0.75``, and ``x_1 = b = 1.3``.
Using the Trapezoidal Rule with ``h = b - a = 0.55``:

$∫_{0.75}^{1.3} ((\sin{x})^2 - 2x \sin{x} + 1) \,dx = \frac{0.55}{2} [f(0.75) + f(1.3)] = -0.037024$
"""
end

# ╔═╡ 4d212b3b-fcb8-43e4-991f-c43dc1009b71
let
let
	a = 0.75
	b = 1.3
	h = (b - a) / 2
	x0 = a
	x1 = a + h
	x2 = b
	f(x) = sin(x)^2 - 2x * sin(x) + 1
	(h / 3) * (f(x0) + 4f(x1) + f(x2))
end
md"""
### Problem 4.3 #6

Repeat Exercise 2 using Simpson's rule.

_**Solution.**_
Simpson's rule is

$∫_{x_0}^{x_2} f(x) \,dx = \frac{h}{3} [f(x_0) + 4f(x_1) + f(x_2)]$

Using Simpson's Rule with ``h = (b-a) / 2 = 0.275``, ``x_1 = a + h = 1.05``, and ``x_2 = b = 1.3``:

$∫_{0.75}^{1.3} f(x) \,dx = \frac{0.275}{3} [f(0.75) + 4f(1.05) + f(1.3)] = -0.02027159$
"""
end

# ╔═╡ d952c9ac-1be5-489b-8502-3a67ec24bc1f
md"""
### Problem 4.3 #22

The quadrature formula ``∫_0^2 f(x) \,dx = c_0 f(0) + c_1 f(1) + c_2 f(2)`` is exact for all polynomials of degree less than or equal to two.
Determine ``c_0``, ``c_1``, and ``c_2``.

_**Solution.**_
This quadrature formula follows the closed Newton-Cotes formula ``n = 2`` (Simpson's rule).

$∫_{x_0}^{x_2} f(x) \,dx = \frac{h}{3} [f(x_0) + 4f(x_1) + f(x_2)]$

Let ``h = 2 - 0 = 2``, so we have

$∫_0^2 f(x) \,dx = \frac{2}{3} f(0) + \frac{8}{3} f(1) + \frac{2}{3} f(2)$

Thus, the constants are ``c_0 = \frac{2}{3}``, ``c_1 = \frac{8}{3}``, and ``c_2 = \frac{2}{3}``.
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
# ╟─129e90fe-4f18-11ed-2058-2f9a506850e1
# ╟─853a567c-7c5a-4b67-b335-bf89e73d332a
# ╟─d6db16bc-b8c9-4794-a05c-9c2cafdac7f2
# ╟─7362b268-f3cd-4856-9e22-4e90a9453819
# ╟─301f60c6-5bd9-4877-ad8f-8faaa7f50e7d
# ╟─4d212b3b-fcb8-43e4-991f-c43dc1009b71
# ╟─d952c9ac-1be5-489b-8502-3a67ec24bc1f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
