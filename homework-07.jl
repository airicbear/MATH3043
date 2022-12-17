### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ 2b7f29ba-51a9-11ed-2e33-8157a7b6b144
md"""
# Homework 7

Eric Nguyen $\qquad$ October 27, 2022
"""

# ╔═╡ 2d0df6ed-3347-4861-a8c2-4d30ac6f194b
md"""
### Problem 4.4 #8 (a,b)

Approximate ``∫_0^2 x^2 e^{-x^2} \,dx`` using ``h = 0.25``.
Use

a. Composite Trapezoidal rule.

b. Composite Simpson's rule.

_**Solution (a).**_
The error form of the Composite Trapezoidal rule is

$\left|\frac{b - a}{12} h^2 f''(μ)\right|$

Calculating the second derivative ``f''(x)`` of the function ``f(x) = x^2 e^{-x^2}`` we get

$\begin{align*}
f'(x) &= 2x e^{-x^2} - 2x^3 e^{-x^2} \\
&= (2x - 2x^3) e^{-x^2} \\
f''(x) &= 2e^{-x^2} - 4x^2 e^{-x^2} - 6x^2 e^{-x^2} + 4x^4 e^{-x^2} \\
&= 2e^{-x^2} - 10x^2 e^{-x^2} + 4x^4 e^{-x^2} \\
&= (2 - 10x^2 + 4x^4) e^{-x^2}
\end{align*}$

Using a graphing calculator we determine

$\max_{x ∈ [0,2]} f''(x) = f''(0) = 2$

The error form is then calculated

$\left|\frac{2}{12} h^2 f''(μ)\right| < \left|\frac{1}{3} h^2\right| < \frac{1}{48}$

Since ``h = 2 / n``, we need

$\frac{4}{3n^2} < \frac{1}{48} \implies \frac{4(48)}{3} < n^2 \implies n ≥ 8$ 

iterations for the Composite Trapezoidal rule.
The Composite Trapezoidal rule with ``n = 8`` gives (using code given below)

$∫_0^2 x^2 e^{-x^2} \,dx ≈ \frac{h}{2} \left[f(0) + 2 \sum_{j=1}^{7} f(x_j) + f(b)\right] = 0.421582$

_**Solution (b).**_
The error form of the Composite Simpson's rule is

$\left|\frac{b - a}{180}\right| h^4 f^{(4)}(μ)$

Calculating the fourth derivative ``f^{(4)}`` we get

$\begin{align*}
f'''(x) &= -4xe^{-x^2} - 20x e^{-x^2} + 20x^3 e^{-x^2} + 16x^3 e^{-x^2} - 8x^5 e^{-x^2} \\
&= -24xe^{-x^2} + 36x^3 e^{-x^2} - 8x^5 e^{-x^2} \\
&= (-24x + 36x^3 - 8x^5) e^{-x^2} \\
f^{(4)}(x) &= (-24+156x^{2}-112x^{4}+16x^{6})e^{-x^{2}}
\end{align*}$

Using a graphing calculator we determine

$\max_{x ∈ [0,2]} f^{(4)}(x) = f^{(4)}(±0.794) = 18.017$

The error form is then calculated

$\left|\frac{2h^4}{180} f^{(4)}(μ)\right| < 0.0007820$

Since ``h = 2 / n``, we need

$\frac{2^5}{180n^4} (18.017) < 0.0007820 \implies n ≥ 8$

iterations for the Composite Simpson's rule.
The Composite Simpson's rule with ``n = 8`` gives (using code given below)

$∫_0^2 x^2 e^{-2x} \,dx ≈ \frac{h}{3} \left[f(0) + 2 \sum_{j=1}^{3} f(x_{2j}) + 4 \sum_{j=1}^4 f(x_{2j-1}) + f(2)\right] = 0.422716$
"""

# ╔═╡ 030a42c5-573c-4906-8b43-48e397e55285
let
	h = 0.25
	a = 0
	b = 2
	n = 8
	f(x) = x^2 * exp(-x^2)
	x(j) = a + j * h
	:trapezoid => (h / 2) * (f(a) + 2 * sum([f(x(j)) for j ∈ 1:(n - 1)]) + f(b)),
	:simpsons => (h / 3) * (f(a) + 2 * sum([f(x(2j)) for j ∈ 1:((n / 2) - 1)]) + 4 * sum([f(x(2j - 1)) for j ∈ 1:(n / 2)]) + f(b))
end

# ╔═╡ 7e58206b-9c55-4988-abdd-d5c096c9b014
md"""
### Problem 4.4 #9

Suppose that ``f(0) = 1``, ``f(0.5) = 2.5``, ``f(1) = 2``, and ``f(0.25) = f(0.75) = α``.
Find ``α`` if the Composite Trapezoidal rule with ``n = 4`` gives the value ``1.75`` for ``∫_0^1 f(x) \,dx``.

_**Solution.**_
The Composite Trapezoidal rule with ``h = 0.25`` and ``n = 4`` gives

$\begin{align*}
∫_0^1 f(x) \,dx &= \frac{0.25}{2} \left[f(0) + 2 \sum_{j=1}^3 f(x_j) + f(1)\right] \\
1.75 &= \frac{1}{8} \left[1 + 2 (f(0.25) + f(0.5) + f(0.75)) + 2\right] \\
\frac{7}{4} &= \frac{1}{8} \left[3 + 2 (f(0.5) + 2α)\right] \\
\frac{7}{4} &= \frac{1}{8} \left[3 + 2 f(0.5) + 4α\right] \\
\frac{7}{4} &= \frac{1}{8} (8 + 4α) \\
14 &= (8 + 4α) \\
α &= 1.5
\end{align*}$
"""

# ╔═╡ 2ac927c4-788e-43db-b938-52796beb3988
let
	
let
	f = 705.36
	a = 0
	b = 2
	ϵ = 1e-4
	h = sqrt(ϵ / (((b - a) / 12) * f))
	n = 2 / h
	:h => h, :n => n
	2/0.000922296
	# h
end

let
	ϵ = 1e-4
	a = 0
	b = 2
	f = 2844.784
	x = ((b - a) / 180 * f)
	h = (ϵ / x)^(1/4)
	# n = 2 / h
	n = ((x * 2^4) / 1e-4)^(1/4)
end
md"""
### Problem 4.4 #11 (a,b)

Determine the values of ``n`` and ``h`` required to approximate

$∫_0^2 e^{2x} \sin{3x} \,dx$

to within ``10^{-4}``.
Use

a. Composite Trapezoidal rule.

b. Composite Simpson's rule.

_**Solution (a).**_
The error form of the Composite Trapezoidal rule is

$\left|\frac{b - a}{12} h^2 f''(μ)\right|$

Calculating the second derivative ``f''(x)`` of the function ``f(x) = e^{2x} \sin{3x} \,dx`` we get

$\begin{align*}
f'(x) &= 2e^{2x} \sin{3x} + 3e^{2x} \cos{3x} \\
&= (2 \sin{3x} + 3 \cos{3x}) e^{2x} \\
f''(x) &= 4e^{2x} \sin{3x} + 6e^{2x} \cos{3x} + 6e^{2x} \cos{3x} - 9e^{2x} \sin{3x} \\
&= -5e^{2x} \sin{3x} + 12e^{2x} \cos{3x} \\
&= (-5 \sin{3x} + 12 \cos{3x}) e^{2x}
\end{align*}$

Using a graphing calculator we determine

$\max_{x ∈ [0,2]} f''(x) = f''(2) = 705.36$

The error form is then calculated

$\left|\frac{2}{12} h^2 f''(μ)\right| < \left|117.56 h^2\right| < 10^{-4} \implies h = 0.000922296$

Since ``h = 2 / n``, we need

$\frac{117.56(4)}{n^2} < 10^{-4} \implies n ≥ 2168$ 

iterations for the Composite Trapezoidal rule.

_**Solution (b).**_
The error form of the Composite Simpson's rule is

$\left|\frac{b - a}{180}\right| h^4 f^{(4)}(μ)$

Calculating the fourth derivative ``f^{(4)}`` we get

$\begin{align*}
f'''(x) &= -10e^{2x} \sin{3x} - 15 e^{2x} \cos{3x} + 24e^{2x} \cos{3x} - 36e^{2x} \sin{3x} \\
&= (-46e^{2x} \sin{3x} + 9e^{2x} \cos{3x}) e^{2x} \\
f^{(4)}(x) &= (-120 \cos{3x} - 119 \sin{3x})e^{2x}
\end{align*}$

Using a graphing calculator we determine

$\max_{x ∈ [0,2]} f^{(4)}(x) = f^{(4)}(1.504) = 2844.784$

The error form is then calculated

$\left|\frac{2h^4}{180} f^{(4)}(μ)\right| < |31.6087h^4| < 10^{-4} \implies h = 0.04217434$

Since ``h = 2 / n``, we need

$\frac{31.6087(2^4)}{n^4} < 10^{-4} \implies n ≥ 47$
"""
end

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
# ╟─2b7f29ba-51a9-11ed-2e33-8157a7b6b144
# ╟─2d0df6ed-3347-4861-a8c2-4d30ac6f194b
# ╠═030a42c5-573c-4906-8b43-48e397e55285
# ╟─7e58206b-9c55-4988-abdd-d5c096c9b014
# ╟─2ac927c4-788e-43db-b938-52796beb3988
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
