### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ 1261493e-6f3d-11ed-321f-d32bb0759d8c
begin
	using LinearAlgebra
md"""
# Homework 10

Eric Nguyen $\qquad$ November 28, 2022
"""
end

# ╔═╡ 5ad68f98-3ef1-4447-9e16-1b781f809090
md"""
### Problem 7.1 #6 (c,d)

Find the ``l_∞`` norm of the matrices.

c. ``\begin{bmatrix} \sqrt{2}/2 & -\sqrt{2}/2 & 1 \\ 1 & 0 & 0 \\ π & -1 & 2 \end{bmatrix}``

d. ``\begin{bmatrix} 1/3 & -1/3 & 1/3 \\ -1/4 & 1/2 & 1/4 \\ 2 & -2 & -1 \end{bmatrix}``

_**Solution (c).**_

$\sum_{j=1}^3 |a_{1j}| = |\sqrt{2}/2| + |{-}\sqrt{2}/2| + |1| = \sqrt{2} + 1$

$\sum_{j=1}^3 |a_{2j}| = |1| + |0| + |0| = 1$

$\sum_{j=1}^3 |a_{3j}| = |π| + |-1| + |2| = 3π$

$\|A\|_∞ = \max\{\sqrt{2}+1,1,3π\} = 3π$

_**Solution (d).**_

$\sum_{j=1}^3 |a_{1j}| = |1/3| + |-1/3| + |1/3| = 1$

$\sum_{j=1}^3 |a_{2j}| = |-1/4| + |1/2| + |1/4| = 1$

$\sum_{j=1}^3 |a_{3j}| = |2| + |-2| + |-1| = 5$

$\|A\|_∞ = \max\{1,1,5\} = 5$
"""

# ╔═╡ 093b8aa8-9a02-442d-a3a4-e3379f888e7a
let
let
	A = [0.04 0.01 -0.01; 0.2 0.5 -0.2; 1 2 4]
	b = [0.06; 0.3; 11]
	x = [1.827586, 0.6551724, 1.965517]
	x̄ = [1.8, 0.64, 1.9]
	norm(x - x̄, Inf), norm(A*x̄ - b, Inf)
end
md"""
### Problem 7.1 #7 (d)

The following linear systems ``A𝐱 = 𝐛`` have ``𝐱`` as the actual solution and ``\bar{𝐱}`` as an approximate solution.
Compute ``\|𝐱 - \bar{𝐱}\|_∞`` and ``\|A\bar{𝐱} - 𝐛\|_∞``.

d. $\begin{array}{cccccc}
   0.04x_1 &+ &0.01x_2 &- &0.01x_3 &= &0.06, \\
   0.2x_1 &+ &0.5x_2 &- &0.2x_3 &= &0.3, \\
   x_1 &+ &2x_2 &+ &4x_3 &= &11,
   \end{array}$

   $\begin{align*}
   𝐱 &= (1.827586, 0.6551724, 1.965517)^t, \\
   \bar{𝐱} &= (1.8, 0.64, 1.9)^t.
   \end{align*}$

_**Solution (d).**_

$𝐱 - \bar{𝐱} = (0.027586, 0.0151724, 0.065517)^t \implies \|𝐱 - \bar{𝐱}\|_∞ = 0.065517$

$A\bar{𝐱} - 𝐛 = (-0.0006, 0, -0.32)^t \implies \|A\bar{𝐱} - 𝐛\|_∞ = 0.32$
"""
end

# ╔═╡ 965f4995-7d7f-464e-acbb-8ecc32ea773f
md"""
### Problem 7.5 #2 (c)

Compute the condition numbers of the following matrices relative to ``\|⋅\|_∞``.

c. ``\begin{bmatrix} 1 & -1 & -1 \\ 0 & 1 & -1 \\ 0 & 0 & -1 \end{bmatrix}``

_**Solution (c).**_

$A^{-1} = \begin{bmatrix} 1 & 1 & -2 \\ 0 & 1 & -1 \\ 0 & 0 & -1 \end{bmatrix}$

$K(A) = \|A\|_∞ ⋅ \|A^{-1}\|_∞ = 3 ⋅ 4 = 12$
"""

# ╔═╡ f524c542-cee3-4767-a501-4a883c9b0254
md"""
### Problem 7.5 #7

The linear system

$\begin{bmatrix} 1 & 2 \\ 1.0001 & 2 \end{bmatrix} \begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} 3 \\ 3.0001 \end{bmatrix}$

has solution ``(1,1)^t``.
Change ``A`` slightly to

$\begin{bmatrix} 1 & 2 \\ 0.9999 & 2 \end{bmatrix}$

and consider the linear system

$\begin{bmatrix} 1 & 2 \\ 0.9999 & 2 \end{bmatrix} \begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} 3 \\ 3.0001 \end{bmatrix}.$

Compute the new solution using five-digit rounding arithmetic and compare the actual error to the estimate ``(7.25)``.
Is ``A`` ill conditioned?

_**Solution.**_

$\begin{bmatrix}
1 & 2 & 3 \\
0.9999 & 2 & 3.0001
\end{bmatrix} \overset{E_2 - 0.99990E_1 → E_2}{\xRightarrow{}}
\begin{bmatrix}
1 & 2 & 3 \\
0 & 0.0002 & 0.0004 \\
\end{bmatrix} \overset{\frac{1}{0.0002}E_2 → E_2}{\xRightarrow{}}
\begin{bmatrix}
1 & 2 & 3 \\
0 & 1 & 2
\end{bmatrix}$

The new solution is

$\tilde{𝐱} = \begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} -1 \\ 2 \end{bmatrix}$

The actual error is

$\|𝐱 - \tilde{𝐱}\|_∞ = \max\{|1 - (-1)|, |1 - 2|\} = 2$

To determine whether ``A`` is ill conditioned, we find its condition number ``K(A) = \|A\|_∞ \|A^{-1}\|_∞`` where

$A = \begin{bmatrix} 1 & 2 \\ 1.0001 & 2 \end{bmatrix} \quad\text{and}\quad A^{-1} = \begin{bmatrix} -10000 & 10000 \\ 5000.5 & -5000 \end{bmatrix}$

$\|A\|_∞ = 3.0001 \quad\text{and}\quad \|A^{-1}\|_∞ = 20000$

so

$K(A) = \|A\|_∞ \|A^{-1}\|_∞ = (3.0001)(20000) = 60002$

We have ``K(A) ≫ 1`` so ``A`` is ill conditioned.
Comparing the actual error to the estimate ``(7.25)``, we have

$δA = \begin{bmatrix} 0 & 0 \\ -0.0002 & 0 \end{bmatrix}$

and the inequality

$\|δA\|_∞ < \frac{1}{\|A^{-1}\|_∞}$

does not hold since ``\|δA\|_∞ = 0.0002 < \frac{1}{\|A^{-1}\|_∞} = 0.00005``, therefore the estimate given by ``(7.25)`` is not applicable.
"""

# ╔═╡ 1dc6f4e1-3fa5-4507-8465-23ef61eba8b8
# Find inverse of A
let
	A = [1 2; 1.0001 2]
	inv(A)
end

# ╔═╡ f02cbabd-bb99-454d-9860-1dd9e5f1cb98
md"""
### Problem 7.3 #2 (c)

Find the first two iterations of the Jacobi method for the following linear systems, using ``𝐱^{(0)} = \bf{0}``:

c. $\begin{array}{rcrcrcrcl}
   4x_1 &+ &x_2 &- &x_3 &+ &x_4 &= &-2, \\
   x_1 &+ &4x_2 &- &x_3 &- &x_4 &= &-1, \\
   -x_1 &- &x_2 &+ &5x_3 &+ &x_4 &= &0, \\
   x_1 &- &x_2 &+ &x_3 &+ &3x_4 &= &1.
   \end{array}$

_**Solution (c).**_
We first solve equation ``E_i`` for ``x_i``, for each ``i = 1,2,3,4``, to obtain

$\begin{array}{crrrcrcrcl}
x_1 &= & &- &\displaystyle \frac{1}{4}x_2 &+ &\displaystyle \frac{1}{4}x_3 &- &\displaystyle \frac{1}{4}x_4 &- &\displaystyle \frac{1}{2}, \\
x_2 &= &\displaystyle -\frac{1}{4}x_1 & & &+ &\displaystyle \frac{1}{4}x_3 &+ &\displaystyle \frac{1}{4}x_4 &- &\displaystyle \frac{1}{4}, \\
x_3 &= &\displaystyle \frac{1}{5}x_1 &+ &\displaystyle \frac{1}{5}x_2 & & &- &\displaystyle \frac{1}{5} x_4, \\
x_4 &= &\displaystyle -\frac{1}{3}x_1 &+ &\displaystyle \frac{1}{3} x_2 &- &\displaystyle \frac{1}{3}x_3 & & &+ &\displaystyle \frac{1}{3}.
\end{array}$

From the initial approximation ``𝐱^{(0)} = (0,0,0,0)^t`` we have

$𝐱^{(1)} = \begin{bmatrix}
\frac{1}{4}x_2^{(0)} + \frac{1}{4}x_3^{(0)} - \frac{1}{4}x_4^{(0)} - \frac{1}{2} \\
-\frac{1}{4}x_1^{(0)} + \frac{1}{4}x_3^{(0)} + \frac{1}{4}x_4^{(0)} - \frac{1}{4} \\
\frac{1}{5}x_1^{(0)} + \frac{1}{5}x_2^{(0)} - \frac{1}{5} x_4^{(0)} \\
-\frac{1}{3}x_1^{(0)} + \frac{1}{3} x_2^{(0)} - \frac{1}{3}x_3^{(0)} + \frac{1}{3}
\end{bmatrix} = \begin{bmatrix} -\frac{1}{2} \\ -\frac{1}{4} \\ 0 \\ \frac{1}{3} \end{bmatrix}$

which then gives us

$𝐱^{(2)} = \begin{bmatrix}
\frac{1}{4}x_2^{(1)} + \frac{1}{4}x_3^{(1)} - \frac{1}{4}x_4^{(1)} - \frac{1}{2} \\
-\frac{1}{4}x_1^{(1)} + \frac{1}{4}x_3^{(1)} + \frac{1}{4}x_4^{(1)} - \frac{1}{4} \\
\frac{1}{5}x_1^{(1)} + \frac{1}{5}x_2^{(1)} - \frac{1}{5} x_4^{(1)} \\
-\frac{1}{3}x_1^{(1)} + \frac{1}{3} x_2^{(1)} - \frac{1}{3}x_3^{(1)} + \frac{1}{3}
\end{bmatrix} = \begin{bmatrix} -\frac{25}{48} \\ -\frac{1}{24} \\ -\frac{13}{60} \\ \frac{5}{12} \end{bmatrix}$
"""

# ╔═╡ fbab666e-cb25-4669-8da3-59f65dd1a667
let
	x0 = [0; 0; 0; 0]
	x1 = [
		(-1//4)x0[2] + (1//4)x0[3] - (1//4)x0[4] + (-1//2)
		(-1//4)x0[1] + (1//4)x0[3] + (1//4)x0[4] + (-1//4)
		(1//5)x0[1] + (1//5)x0[2] - (1//5)x0[4] + (0)
		(-1//3)x0[1] + (1//3)x0[2] - (1//3)x0[3] + (1//3)
	]
	x2 = [
		(-1//4)x1[2] + (1//4)x1[3] - (1//4)x1[4] + (-1//2)
		(-1//4)x1[1] + (1//4)x1[3] + (1//4)x1[4] + (-1//4)
		(1//5)x1[1] + (1//5)x1[2] - (1//5)x1[4] + (0)
		(-1//3)x1[1] + (1//3)x1[2] - (1//3)x1[3] + (1//3)
	]
	"x⁽¹⁾" => x1, "x⁽²⁾" => x2
end

# ╔═╡ 48fbe3fd-59ef-4101-9ab5-4ec59f08c14a
let
let
	x0 = [0; 0; 0; 0]
	x1_1 = (-1//4)x0[2] + (1//4)x0[3] - (1//4)x0[4] + (-1//2)
	x1_2 = (-1//4)x1_1 + (1//4)x0[3] + (1//4)x0[4] + (-1//4)
	x1_3 = (1//5)x1_1 + (1//5)x1_2 - (1//5)x0[4] + (0)
	x1_4 = (-1//3)x1_1 + (1//3)x1_2 - (1//3)x1_3 + (1//3)
	x1 = [x1_1; x1_2; x1_3; x1_4]
	x2_1 = (-1//4)x1[2] + (1//4)x1[3] - (1//4)x1[4] + (-1//2)
	x2_2 = (-1//4)x2_1 + (1//4)x1[3] + (1//4)x1[4] + (-1//4)
	x2_3 = (1//5)x2_1 + (1//5)x2_2 - (1//5)x1[4] + (0)
	x2_4 = (-1//3)x2_1 + (1//3)x2_2 - (1//3)x2_3 + (1//3)
	x2 = [x2_1; x2_2; x2_3; x2_4]
end
md"""
### Problem 7.3 #4 (c)

Repeat Exercise 2 using the Gauss-Siedel method.

_**Solution (c).**_
Modifying the procedure used in Exercise 2 according to the Gauss-Siedel method, we get

$𝐱^{(1)} = \begin{bmatrix}
\frac{1}{4}x_2^{(0)} + \frac{1}{4}x_3^{(0)} - \frac{1}{4}x_4^{(0)} - \frac{1}{2} \\
-\frac{1}{4}x_1^{(1)} + \frac{1}{4}x_3^{(0)} + \frac{1}{4}x_4^{(0)} - \frac{1}{4} \\
\frac{1}{5}x_1^{(1)} + \frac{1}{5}x_2^{(1)} - \frac{1}{5} x_4^{(0)} \\
-\frac{1}{3}x_1^{(1)} + \frac{1}{3} x_2^{(1)} - \frac{1}{3}x_3^{(1)} + \frac{1}{3}
\end{bmatrix} = \begin{bmatrix} -\frac{1}{2} \\ -\frac{1}{8} \\ -\frac{1}{8} \\ \frac{1}{2} \end{bmatrix}$

which then gives us

$𝐱^{(2)} = \begin{bmatrix}
\frac{1}{4}x_2^{(1)} + \frac{1}{4}x_3^{(1)} - \frac{1}{4}x_4^{(1)} - \frac{1}{2} \\
-\frac{1}{4}x_1^{(2)} + \frac{1}{4}x_3^{(1)} + \frac{1}{4}x_4^{(1)} - \frac{1}{4} \\
\frac{1}{5}x_1^{(2)} + \frac{1}{5}x_2^{(2)} - \frac{1}{5} x_4^{(1)} \\
-\frac{1}{3}x_1^{(2)} + \frac{1}{3} x_2^{(2)} - \frac{1}{3}x_3^{(2)} + \frac{1}{3}
\end{bmatrix} = \begin{bmatrix} -\frac{5}{8} \\ 0 \\ -\frac{9}{40} \\ \frac{37}{60} \end{bmatrix}$
"""
end

# ╔═╡ 01f64b47-2420-4465-a5b2-c41af7a1477a
let
	x0 = [0; 0; 0; 0]
	
	x1_1 = (-1//4)x0[2] + (1//4)x0[3] - (1//4)x0[4] + (-1//2)
	x1_2 = (-1//4)x1_1 + (1//4)x0[3] + (1//4)x0[4] + (-1//4)
	x1_3 = (1//5)x1_1 + (1//5)x1_2 - (1//5)x0[4] + (0)
	x1_4 = (-1//3)x1_1 + (1//3)x1_2 - (1//3)x1_3 + (1//3)
	x1 = [x1_1; x1_2; x1_3; x1_4]
	
	x2_1 = (-1//4)x1[2] + (1//4)x1[3] - (1//4)x1[4] + (-1//2)
	x2_2 = (-1//4)x2_1 + (1//4)x1[3] + (1//4)x1[4] + (-1//4)
	x2_3 = (1//5)x2_1 + (1//5)x2_2 - (1//5)x1[4] + (0)
	x2_4 = (-1//3)x2_1 + (1//3)x2_2 - (1//3)x2_3 + (1//3)
	x2 = [x2_1; x2_2; x2_3; x2_4]
	
	"x⁽¹⁾" => x1, "x⁽²⁾" => x2
end

# ╔═╡ 16ea5f0e-a356-47e5-a16e-381000bd499a
md"""
### Problem 7.3 #11 (a--d)

The linear system

$\begin{array}{rcrcrl}
x_1 & & &- &x_3 &= &0.2, \\
-\displaystyle \frac{1}{2}x_1 &+ &x_2 &- &\displaystyle \frac{1}{4} x_3 &= &-1.425, \\
x_1 &- &\displaystyle \frac{1}{2} x_2 &+ &x_3 &= &2,
\end{array}$

has the solution ``(0.9, -0.8, 0.7)^t``.

a. Is the coefficient matrix

$A = \begin{bmatrix} 1 & 0 & -1 \\ -\frac{1}{2} & 1 & -\frac{1}{4} \\ 1 & -\frac{1}{2} & 1 \end{bmatrix}$

   strictly diagonally dominant?

b. Compute the spectral radius of the Gauss-Seidel matrix ``T_g``.

c. Use the Gauss-Siedel iterative method to approximate the solution to the linear system with a tolerance of ``10^{-2}`` and a maximum of 300 iterations.

d. What happens in part (c) when the system is changed to the following?

$\begin{array}{rcrcrl}
x_1 & & &- &2x_3 &= &0.2, \\
\displaystyle -\frac{1}{2}x_1 &+ &x_2 &- &\displaystyle \frac{1}{4}x_3 &= &-1.425, \\
x_1 &- &\frac{1}{2} x_2 &+ &x_3 &= &2.
\end{array}$

_**Solution (a).**_
No, the coefficient matrix ``A`` is not strictly diagonally dominant because the sum of the absolute value of the off-diagonal values in the first row is not strictly less than the absolute value of the diagonal value itself.
In this case, ``|1| ≯ |0| + |-1|``.

_**Solution (b).**_

$D = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 1 \end{bmatrix}$

$L = \begin{bmatrix} 0 & 0 & 0 \\ \frac{1}{2} & 0 & 0 \\ -1 & \frac{1}{2} & 0 \end{bmatrix}$

$U = \begin{bmatrix} 0 & 0 & 1 \\ 0 & 0 & \frac{1}{4} \\ 0 & 0 & 0 \end{bmatrix}$

$T_g = (D - L)^{-1}U = \begin{bmatrix} 0 & 0 & 1 \\ 0 & 0 & \frac{3}{4} \\ 0 & 0 & -\frac{5}{8} \end{bmatrix}$

$ρ(T_g) = 0.625$

_**Solution (c).**_
Using ``𝐱^{(0)} = (0,0,0)^t``, I obtained ``𝐱^{(13)} = (0.897513, -0.801865, 0.701554)^t``.

_**Solution (d).**_
This modified system has

$T_g = \begin{bmatrix} 0 & 0 & 2 \\ 0 & 0 & \frac{5}{4} \\ 0 & 0 & -\frac{11}{8} \end{bmatrix} \implies ρ(T_g) = 1.375 > 1$

so the Gauss-Seidel method does not converge.
"""

# ╔═╡ fb9550fa-b715-4c40-a699-c0fcd3668395
# Part (b)
let
	A = [1 0 -1; -1//2 1 -1//4; 1 -1//2 1]
	D = [A[1,1] 0 0; 0 A[2,2] 0; 0 0 A[3,3]]
	L = [0 0 0; -A[2,1] 0 0; -A[3,1] -A[3,2] 0]
	U = [0 -A[1,2] -A[1,3]; 0 0 -A[2,3]; 0 0 0]
	Tg = inv(D - L) * U
	eigvals(Tg)
end

# ╔═╡ 1e88d1fd-7911-4211-ae23-dc1dfafa8f9d
# Part (c)
function gaussseidel(n, A, b, XO, TOL, N)
	k = 1
	x = zeros(n)
	while k ≤ N
		for i ∈ 1:n
			x[i] = (1 / A[i,i]) * (-sum([A[i,j] * x[j] for j ∈ 1:i-1]) - sum([A[i,j] * XO[j] for j ∈ i+1:n]) + b[i])
		end

		if norm(x - XO) < TOL
			return "x($k)" => x
		end

		k += 1

		for i ∈ 1:n
			XO[i] = x[i]
		end

	end

	return "Maximum number of iterations exceeded"
end;

# ╔═╡ af4fef22-bdaa-4e76-84ab-c91138336455
let
	A = [1 0 -1; -1//2 1 -1//4; 1 -1//2 1]
	b = [0.2; -1.425; 2]

	gaussseidel(3, A, b, zeros(3), 1e-2, 300)
end

# ╔═╡ 4203d600-4b39-4579-a0d1-48451914f1b2
# Part (d)
let
	A = [1 0 -2; -1//2 1 -1//4; 1 -1//2 1]
	D = [A[1,1] 0 0; 0 A[2,2] 0; 0 0 A[3,3]]
	L = [0 0 0; -A[2,1] 0 0; -A[3,1] -A[3,2] 0]
	U = [0 -A[1,2] -A[1,3]; 0 0 -A[2,3]; 0 0 0]
	Tg = inv(D - L) * U
	eigvals(Tg)
end

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
# ╟─1261493e-6f3d-11ed-321f-d32bb0759d8c
# ╟─5ad68f98-3ef1-4447-9e16-1b781f809090
# ╟─093b8aa8-9a02-442d-a3a4-e3379f888e7a
# ╟─965f4995-7d7f-464e-acbb-8ecc32ea773f
# ╟─f524c542-cee3-4767-a501-4a883c9b0254
# ╠═1dc6f4e1-3fa5-4507-8465-23ef61eba8b8
# ╟─f02cbabd-bb99-454d-9860-1dd9e5f1cb98
# ╠═fbab666e-cb25-4669-8da3-59f65dd1a667
# ╟─48fbe3fd-59ef-4101-9ab5-4ec59f08c14a
# ╠═01f64b47-2420-4465-a5b2-c41af7a1477a
# ╟─16ea5f0e-a356-47e5-a16e-381000bd499a
# ╠═fb9550fa-b715-4c40-a699-c0fcd3668395
# ╠═1e88d1fd-7911-4211-ae23-dc1dfafa8f9d
# ╠═af4fef22-bdaa-4e76-84ab-c91138336455
# ╠═4203d600-4b39-4579-a0d1-48451914f1b2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
