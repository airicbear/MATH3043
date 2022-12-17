### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ f0948bb0-5e14-11ed-1aff-a5165d9f39f4
begin
	using LinearAlgebra
md"""
# Homework 9

Eric Nguyen $\qquad$ November 10, 2022
"""
end

# ╔═╡ 4b58728a-3b2c-4a08-92d2-527d305862e1
md"""
### Problem 6.5 #7 (a,b)

Modify the ``LU`` Factorization Algorithm so that it can be used to solve a linear system and then solve the following linear systems.

**a.**

$\begin{array}{ccccccc}
2x_1 &- &x_2 &+ &x_3 &= &-1, \\
3x_1 &+ &3x_2 &+ &9x_3 &= &0, \\
3x_1 &+ &3x_2 &+ &5x_3 &= &4.
\end{array}$

**b.**

$\begin{array}{ccccccc}
1.012x_1 &- &2.132x_2 &+ &3.104x_3 &= &1.984, \\
-2.132x_1 &+ &4.096x_2 &- &7.013x_3 &= &-5.049, \\
3.104x_1 &- &7.013x_2 &+ &0.014x_3 &= &-3.895.
\end{array}$
"""

# ╔═╡ 20c112fc-692e-4bb4-a08a-fffbdd7a8181
html"""<div style="height: 40vh"></div>"""

# ╔═╡ 1a79ff75-1eb4-462c-ba89-1a4162f5ca51
md"""
_**Solution (Modified LU Factorization Algorithm).**_
"""

# ╔═╡ a1d2e781-825d-4aec-a022-399131c36c2c
function LU(n, a)
	l = zeros(n,n)
	u = zeros(n,n)
	for i ∈ 1:n
		l[i,i] = 1
		u[i,i] = 1
	end

	u[1,1] = a[1,1]

	for j ∈ 2:n
		u[1,j] = a[1,j] / l[1,1]
		l[j,1] = a[j,1] / u[1,1]
	end

	for i ∈ 2:n-1
		u[i,i] = a[i,i] - sum([l[i,k] * u[k,i] for k ∈ 1:i-1])
		if l[i,i] * u[i,i] == 0
			return "Factorization impossible"
		end

		for j ∈ i+1:n
			u[i,j] = (1 / l[i,i]) * (a[i,j] - sum([l[i,k] * u[k,j] for k ∈ 1:i-1]))
			l[j,i] = (1 / u[i,i]) * (a[j,i] - sum([l[j,k] * u[k,i] for k ∈ 1:i-1]))
		end
	end

	u[n,n] = a[n,n] - sum([l[n,k] * u[k,n] for k ∈ 1:n-1])

	y = zeros(n)
	y[1] = a[1,end] / l[1,1]

	for i ∈ 2:n
		y[i] = (1 / l[i,i]) * (a[i,end] - sum([l[i,j] * y[j] for j ∈ 1:i-1]))
	end

	x = zeros(n)
	x[n] = y[n] / u[n,n]

	for i ∈ n-1:-1:1
		x[i] = (1 / u[i,i]) * (y[i] - sum([u[i,j] * x[j] for j ∈ i+1:n]))
	end

	return x
end;

# ╔═╡ 0207c8e6-3446-4683-81e8-35852b5abb71
md"""
_**Solution (a).**_

$𝐱 = \begin{bmatrix} 1 \\ 2 \\ -1 \end{bmatrix}$
"""

# ╔═╡ 9d7f70b8-c19e-4eb0-a1ca-acef5a82e3f3
let
	A = [2 -1 1
		 3 3 9
		 3 3 5]

	b = [-1; 0; 4]

	"Solution (a)" => LU(3, [A b])
end

# ╔═╡ 9d60666b-c15e-4518-8cf4-bd75122d2997
md"""
_**Solution (b).**_

$𝐱 = \begin{bmatrix} 1 \\ 1 \\ 1 \end{bmatrix}$
"""

# ╔═╡ cbc2215c-45b8-4712-9b37-f00e8805cc30
let
	A = [1.012 -2.132 3.104
		 -2.132 4.096 -7.013
		 3.104 -7.013 0.014]

	b = [1.984; -5.049; -3.895]

	"Solution (b)" => LU(3, [A b])
end

# ╔═╡ 059fedb0-8e7d-49cb-a37e-92312926a42f
let
let
	A = [1 -2 3 0; 3 -6 9 3; 2 1 4 1; 1 -2 2 -2]
	U = copy(A)

	U[2,:] = U[2,:] - 3U[1,:]
	U[3,:] = U[3,:] - 2U[1,:]
	U[4,:] = U[4,:] - U[1,:]

	tmp = U[2,:]
	U[2,:] = U[3,:]
	U[3,:] = tmp

	tmp = U[3,:]
	U[3,:] = U[4,:]
	U[4,:] = tmp

	P = [1 0 0 0; 0 0 1 0; 0 0 0 1; 0 1 0 0]

	L = [1 0 0 0; 2 1 0 0; 1 0 1 0; 3 0 0 1]
	P' * L * U
end
md"""
### Problem 6.5 #9 (b)

Obtain factorizations of the form ``A = P^t LU`` for the following matrices.

**b.**

$A = \begin{bmatrix}
1 & -2 & 3 & 0 \\
3 & -6 & 9 & 3 \\
2 & 1 & 4 & 1 \\
1 & -2 & 2 & -2
\end{bmatrix}$

_**Solution (b).**_

$\begin{align*}
A = \begin{bmatrix}
1 & -2 & 3 & 0 \\
3 & -6 & 9 & 3 \\
2 & 1 & 4 & 1 \\
1 & -2 & 2 & -2
\end{bmatrix}
&\overset{
\begin{align*}
E_2 - 3E_1 &→ E_2 \\
E_3 - 2E_1 &→ E_3 \\
E_4 - E_1 &→ E_4 \\
\end{align*}
}{\xRightarrow{}}
\begin{bmatrix}
1 & -2 & 3 & 0 \\
0 & 0 & 0 & 3 \\
0 & 5 & -2 & 1 \\
0 & 0 & -1 & -2
\end{bmatrix} \\
&\overset{E_2 ↔ E_3}{\xRightarrow{}}
\begin{bmatrix}
1 & -2 & 3 & 0 \\
0 & 5 & -2 & 1 \\
0 & 0 & 0 & 3 \\
0 & 0 & -1 & -2
\end{bmatrix} \\
&\overset{E_3 ↔ E_4}{\xRightarrow{}}
\begin{bmatrix}
1 & -2 & 3 & 0 \\
0 & 5 & -2 & 1 \\
0 & 0 & -1 & -2 \\
0 & 0 & 0 & 3 \\
\end{bmatrix} = U
\end{align*}$

$P = \begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1 \\
0 & 1 & 0 & 0 \\
\end{bmatrix}
\implies
PA = \begin{bmatrix}
1 & -2 & 3 & 0 \\
2 & 1 & 4 & 1 \\
1 & -2 & 2 & -2 \\
3 & -6 & 9 & 3
\end{bmatrix}$

The operations are ``(E_2 - 2E_1) → (E_2)``, ``(E_3 - E_1) → (E_1)``, and ``(E_4 - 3E_1) → (E_4)``.
The nonzero multipliers for ``PA`` are, consequently,

$m_{21} = 2, \quad m_{31} = 1, \quad\text{and}\quad m_{41} = 3,$

and the ``LU`` factorization of ``PA`` is

$PA = \begin{bmatrix}
1 & 0 & 0 & 0 \\
2 & 1 & 0 & 0 \\
1 & 0 & 1 & 0 \\
3 & 0 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
1 & -2 & 3 & 0 \\
0 & 5 & -2 & 1 \\
0 & 0 & -1 & -2 \\
0 & 0 & 0 & 3 \\
\end{bmatrix} = LU.$

Multiplying by ``P^{-1} = P^t`` produces the factorization

$A = P^tLU = \begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 1 \\
0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0
\end{bmatrix}
\begin{bmatrix}
1 & 0 & 0 & 0 \\
2 & 1 & 0 & 0 \\
1 & 0 & 1 & 0 \\
3 & 0 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
1 & -2 & 3 & 0 \\
0 & 5 & -2 & 1 \\
0 & 0 & -1 & -2 \\
0 & 0 & 0 & 3
\end{bmatrix}.$
"""
end

# ╔═╡ 9fbb8cbf-8f02-4b83-8b92-12c9ab7152c6
let
let
	A = [3 1 2; 6 3 4; 3 1 5]
	b = [0; 1; 3]

	U = [A b]
	U[2,:] = U[2,:] - 2U[1,:]
	U[3,:] = U[3,:] - U[1,:]
	
	L = [1 0 0; 2 1 0 ; 1 0 1]
	L * U

	LU(3, [A b])
	A \ b
end
md"""
### Additional Problem 1

Solve the system by finding the ``PA = LU`` factorization and then carrying out forward and back substitution

$\begin{bmatrix}
3 & 1 & 2 \\
6 & 3 & 4 \\
3 & 1 & 5
\end{bmatrix}
\begin{bmatrix}
x_1 \\ x_2 \\ x_3
\end{bmatrix}
\begin{bmatrix}
0 \\ 1 \\ 3
\end{bmatrix}$

_**Solution.**_

$\begin{align*}
A = \begin{bmatrix}
3 & 1 & 2 \\
6 & 3 & 4 \\
3 & 1 & 5
\end{bmatrix}
&\overset{\begin{align*}
E_2 - 2E_1 &→ E_2 \\
E_3 - E_1 &→ E_3
\end{align*}}{\xRightarrow{}}
\begin{bmatrix}
3 & 1 & 2 \\
0 & 1 & 0 \\
0 & 0 & 3
\end{bmatrix} = U
\end{align*}$

$L = \begin{bmatrix}
1 & 0 & 0 \\
2 & 1 & 0 \\
1 & 0 & 1
\end{bmatrix}$

$P = I$

$PA = \begin{bmatrix}
1 & 0 & 0 \\
2 & 1 & 0 \\
1 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
3 & 1 & 2 \\
0 & 1 & 0 \\
0 & 0 & 3
\end{bmatrix} = LU$

$L𝐲 = 𝐛 \implies \begin{bmatrix}
1 & 0 & 0 & 0 \\
2 & 1 & 0 & 1 \\
1 & 0 & 1 & 3
\end{bmatrix} \implies 𝐲 = \begin{bmatrix}
0 \\ 1 \\ 3
\end{bmatrix} \quad \text{(Using forward substitution.)}$

$𝐲 = U𝐱 \implies \begin{bmatrix}
3 & 1 & 2 & 0 \\
0 & 1 & 0 & 1 \\
0 & 0 & 3 & 3
\end{bmatrix} \implies 𝐱 = \begin{bmatrix}
-1 \\ 1 \\ 1
\end{bmatrix} \quad \text{(Using backward substitution.)}$
"""
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
# ╟─f0948bb0-5e14-11ed-1aff-a5165d9f39f4
# ╟─4b58728a-3b2c-4a08-92d2-527d305862e1
# ╟─20c112fc-692e-4bb4-a08a-fffbdd7a8181
# ╟─1a79ff75-1eb4-462c-ba89-1a4162f5ca51
# ╠═a1d2e781-825d-4aec-a022-399131c36c2c
# ╟─0207c8e6-3446-4683-81e8-35852b5abb71
# ╠═9d7f70b8-c19e-4eb0-a1ca-acef5a82e3f3
# ╟─9d60666b-c15e-4518-8cf4-bd75122d2997
# ╠═cbc2215c-45b8-4712-9b37-f00e8805cc30
# ╟─059fedb0-8e7d-49cb-a37e-92312926a42f
# ╟─9fbb8cbf-8f02-4b83-8b92-12c9ab7152c6
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
