### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ e6e223ba-426d-11ed-3eae-0de245acacb0
using RDKitMinimalLib

# ╔═╡ f0e15a56-feb8-472b-aa25-ebc3fa9f434b
md"# RDKit to work with molecules

[RDKit](https://www.rdkit.org/) = a widely-used open-source cheminformatics tookit.

[RDKitMinimalLib](https://github.com/eloyfelix/RDKitMinimalLib.jl) = a minimal library to call RDKit C code from Julia.
"

# ╔═╡ f41c3360-2741-4cfe-aef7-28866514089e
md"
## SMILES strings

SMILES = simplified molecular-input line-entry system. i.e., a way to specify the chemical structure of a molecule (as a vertex- and edge-labeled graph) via a `String`. see [here](https://en.wikipedia.org/wiki/Simplified_molecular-input_line-entry_system).
"

# ╔═╡ 7bc23995-fc43-4bcf-a814-0d68822b2a5a
smiles = "COc1cc(C=O)ccc1O" # Vanillin = 4-Hydroxy-3-methoxybenzaldehyde

# ╔═╡ f2427808-66a4-46c3-8aa5-126625738834
molecule = get_mol(smiles)

# ╔═╡ 565f892e-c34f-4a8a-9b69-c2fd4f0bfbf1
md"## visualize a molecule"

# ╔═╡ 63af0cf2-0e70-4e7f-b63f-5df126e8bf1f
HTML(get_svg(molecule))

# ╔═╡ ef13a487-497c-4c27-8240-2f3b3d52aab2
md"## search a molecule for substructures

our goal is to search a molecule for a substructure.

SMARTS patterns are strings used to describe query patterns in molecules. see [here](https://www.daylight.com/dayhtml/doc/theory/theory.smarts.html).

e.g., search for C-C-OH.
"

# ╔═╡ 7fa078f8-b9d8-4994-bd6a-6f4405874316
pattern = get_qmol("ccO") # q for query

# ╔═╡ 8b3b0194-7a0a-40ec-a4a7-90e1857e2f6e
smatch = get_substruct_match(molecule, pattern)

# ╔═╡ 0ee6db62-83c4-4bef-838b-fde609ae304c
HTML(get_svg(molecule, smatch))

# ╔═╡ 719ec42e-bdbf-4c87-b7ed-c6651cd7e3d3
md"e.g., search for a six-membered ring"

# ╔═╡ a2e3fa31-5b33-464f-b771-3afc594bb99b
pattern2 = get_qmol("*1~*~*~*~*~*~1")

# ╔═╡ 11586325-10c0-4cca-9529-0fe5f8258a7d
smatch2 = get_substruct_match(molecule, pattern2)

# ╔═╡ 7e9c8824-d7fc-49bf-9899-3fd79d9de6f8
HTML(get_svg(molecule, smatch2))

# ╔═╡ 834bc425-1ddc-4004-847f-ff4c42c31edd
md"e.g. search for a C=O group"

# ╔═╡ 4049c0b3-b305-474d-9a71-2cb3264cc796
pattern3 = get_qmol("[#6]=[#8]")

# ╔═╡ 18ec0411-fd02-4021-a427-0833a95eb97b
smatch3 = get_substruct_match(molecule, pattern3)

# ╔═╡ 228f389c-e1d8-4fcd-b855-667b77de332f
HTML(get_svg(molecule, smatch3))

# ╔═╡ 1f279b48-27b7-49e1-bb6d-e704bbe6f69c
md"e.g., search for an aromatic ring. look for _all_ matches."

# ╔═╡ 76f8eb69-afb5-4a5e-9bea-c1f35b333020
pattern4 = get_qmol("a")

# ╔═╡ af7ed773-540a-46f8-bd8b-c2f7fdc05225
smatch4 = get_substruct_matches(molecule, pattern4)

# ╔═╡ 1e1b595a-34ca-4174-bebe-67a7535812aa
length(smatch4)

# ╔═╡ 494c9252-5c40-44c9-a784-57153d6d8336
HTML(get_svg(molecule, smatch4[1]))

# ╔═╡ c075cd96-bf9a-4657-ad98-b636a20344f9
md"what happens when a pattern does not exist? also useful info."

# ╔═╡ cd1fa5ef-086b-41df-aeee-a096f50e7f48
pattern5 = get_qmol("[CH3]~[CH2]~*")

# ╔═╡ e67b59e9-8837-4566-8bea-12ce0012d8eb
smatch5 = get_substruct_match(molecule, pattern5)

# ╔═╡ 278d6d8c-351e-406b-b0a0-2c4e83b65ba7
length(smatch5)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
RDKitMinimalLib = "44044271-7623-48dc-8250-42433c44e4b7"

[compat]
RDKitMinimalLib = "~1.1.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "5ca93a03f0c759f451a9f97ed2e81b85c3e53ca6"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

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

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

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

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "3d5bf43e3e8b412656404ed9466f1dcbf7c50269"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.RDKitMinimalLib]]
deps = ["JSON", "RDKit_jll"]
git-tree-sha1 = "2742115d8d4071b3f7000e235ef082b320b9ba95"
uuid = "44044271-7623-48dc-8250-42433c44e4b7"
version = "1.1.0"

[[deps.RDKit_jll]]
deps = ["Artifacts", "FreeType2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll", "boost_jll"]
git-tree-sha1 = "3b4dcfd3d448cb90d2d69c829bcaa03b5bc068de"
uuid = "03d1d220-30e6-562a-9e1a-3062d7b56d75"
version = "2022.3.1+0"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.boost_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "7a89efe0137720ca82f99e8daa526d23120d0d37"
uuid = "28df3c45-c428-5900-9ff8-a3135698ca75"
version = "1.76.0+1"

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
# ╟─f0e15a56-feb8-472b-aa25-ebc3fa9f434b
# ╠═e6e223ba-426d-11ed-3eae-0de245acacb0
# ╟─f41c3360-2741-4cfe-aef7-28866514089e
# ╠═7bc23995-fc43-4bcf-a814-0d68822b2a5a
# ╠═f2427808-66a4-46c3-8aa5-126625738834
# ╟─565f892e-c34f-4a8a-9b69-c2fd4f0bfbf1
# ╠═63af0cf2-0e70-4e7f-b63f-5df126e8bf1f
# ╟─ef13a487-497c-4c27-8240-2f3b3d52aab2
# ╠═7fa078f8-b9d8-4994-bd6a-6f4405874316
# ╠═8b3b0194-7a0a-40ec-a4a7-90e1857e2f6e
# ╠═0ee6db62-83c4-4bef-838b-fde609ae304c
# ╟─719ec42e-bdbf-4c87-b7ed-c6651cd7e3d3
# ╠═a2e3fa31-5b33-464f-b771-3afc594bb99b
# ╠═11586325-10c0-4cca-9529-0fe5f8258a7d
# ╠═7e9c8824-d7fc-49bf-9899-3fd79d9de6f8
# ╟─834bc425-1ddc-4004-847f-ff4c42c31edd
# ╠═4049c0b3-b305-474d-9a71-2cb3264cc796
# ╠═18ec0411-fd02-4021-a427-0833a95eb97b
# ╠═228f389c-e1d8-4fcd-b855-667b77de332f
# ╟─1f279b48-27b7-49e1-bb6d-e704bbe6f69c
# ╠═76f8eb69-afb5-4a5e-9bea-c1f35b333020
# ╠═af7ed773-540a-46f8-bd8b-c2f7fdc05225
# ╠═1e1b595a-34ca-4174-bebe-67a7535812aa
# ╠═494c9252-5c40-44c9-a784-57153d6d8336
# ╟─c075cd96-bf9a-4657-ad98-b636a20344f9
# ╠═cd1fa5ef-086b-41df-aeee-a096f50e7f48
# ╠═e67b59e9-8837-4566-8bea-12ce0012d8eb
# ╠═278d6d8c-351e-406b-b0a0-2c4e83b65ba7
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
