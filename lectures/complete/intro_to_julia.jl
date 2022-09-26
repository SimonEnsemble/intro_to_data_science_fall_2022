### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 23c448da-3628-4db1-b91f-b7fa2ac2d843
using PlutoUI, PlutoTeachingTools

# ╔═╡ 209e3d26-fd35-11ea-3916-853482bfa1bc
using Random, StatsBase

# ╔═╡ 3b6ceee5-0817-4b19-a597-7c98ed230130
TableOfContents()

# ╔═╡ 1f74ddfe-fd19-11ea-1a0f-678021182d2c
md"
# introduction

## the Julia programming language
![Julia logo](https://julialang.org/assets/infra/logo.svg)

_why Julia?_
* free, open-source
* high-level, thus easy to use
* dynamic, thus feels interactive
* expressive, read-like-a-book syntax
* high-performance (fast) (design choices allow just-in-time compiler to make optimizations, resulting in fast code)
* safety (offers optional type assertion)
* designed especially for scientific computing
* easy parallelization accross cores
* multiple dispatch (we'll see later)

> Julia: A language that walks like Python, runs like C

[link to Julia website](https://julialang.org/)

[link to _Nature_ article on Julia](https://www.nature.com/articles/d41586-019-02310-3)

_resources_:
* [Julia documentation](https://docs.julialang.org/en/v1/)
* [Learn Julia in Y minutes](https://learnxinyminutes.com/docs/julia/)
* [Julia express](http://bogumilkaminski.pl/files/julia_express.pdf)
* [list of learning resources maintained by Julia](https://julialang.org/learning/)
"

# ╔═╡ 2f9e20c0-fd1c-11ea-1064-411a3bbb014e
md"
## the Pluto notebook

(we're in one)

a [`Pluto` notebook](https://github.com/fonsp/Pluto.jl) is a simple dynamic, interactive Julia programming environment composed of:
* code cells, containing modular snippets of Julia code
* Markdown cells, containing text to explain and document your code. Markdown is a plain-text language to create formatted text. see [here](https://docs.julialang.org/en/v1/stdlib/Markdown/) for the formatting possibilities.
* a [built-in package manager](https://github.com/fonsp/Pluto.jl/wiki/%F0%9F%8E%81-Package-management) to easily install packages and store their versions.

as scientists/engineers, `Pluto` allows us to create sharable, reproducible, self-contained documents. more, `Pluto` is _reactive_. i.e. if we modify a function or variable in a code cell, Pluto automatically updates all cells dependent on that changed function or variable. this helps avoid bugs.

YouTube videos on `Pluto` at [JuliaCon 2020](https://www.youtube.com/watch?v=IAF8DjrQSSk) and [JuliaCon 2021](https://www.youtube.com/watch?v=HiI4jgDyDhY).

🐸 activities:
* move your cursor to the top left and click the eye to make this cell unhidden and see the text to compose this cell.
* create your own Markdown cell below this cell (click \"+\")!

code formatting:
- inline `f(x)=cos(3.0 * π)`
- in display:
```julia
function f(x)
	return cos(3.0 * π)
end
```

math formatting via ``\LaTeX``:
- inline $f(x)=x^2\sin(x)$
- in display: 
```math
f(x)=x^2 \sin(x)
```
"

# ╔═╡ f3fee3ca-fd1c-11ea-2906-9d8d6b874f66
md"
# learn Julia by example

## variable assignment

> an assignment statement sets and/or re-sets the value stored in the storage location(s) denoted by a variable name; in other words, it copies a value into the variable - [Wikipedia](https://en.wikipedia.org/wiki/Assignment_(computer_science))
"

# ╔═╡ b99409d6-fd1f-11ea-1cd5-e97615600cea
x = 5.3 # not "x equals 5.3" but, "assign x to be 5.3"

# ╔═╡ e267492c-fd1f-11ea-20a3-9f7759e16280
md"
\"we assign `x` to be 5.3\" $\neq$ \"x equals 5.3\"!

read [here](https://en.wikipedia.org/wiki/Assignment_(computer_science)#Assignment_versus_equality).
"

# ╔═╡ 0ae926cc-fd20-11ea-3e7f-1b8af64f05d8
x == 5.3

# ╔═╡ 21ec295a-7b45-4db5-8b58-942180413f33
md"## the reactive nature of Pluto
compute `2x² + 1` in a code cell below, then change the value of `x` above. note, the cell below will automatically update.
"

# ╔═╡ b23f0981-af7a-4302-84fb-556cdb906c4d
2 * x ^ 2 + 1

# ╔═╡ 181fec1c-fd21-11ea-042c-23828f908e52
md"## basic types

### `Float64`

in the [double-precision floating point format](https://en.wikipedia.org/wiki/Double-precision_floating-point_format) of a number, the number is represented on your computer using a chuck of memory consisting of 64 bits (bit = binary digit).

![](https://upload.wikimedia.org/wikipedia/commons/a/a9/IEEE_754_Double_Floating_Point_Format.svg)

"

# ╔═╡ 11aa062e-fd21-11ea-068b-495c13f48386
typeof(x)

# ╔═╡ 16342ee8-b797-4c37-8b21-20fa4fa3999b
sizeof(x) # bytes

# ╔═╡ 32d07345-7f33-4d6f-a601-862e9a2e5919
md"### `Int64`
an integer is represented by 64 bits as well.
"

# ╔═╡ 2d622f08-fd22-11ea-2d6a-6bd48280b429
y = 5 # not 5.0

# ╔═╡ 315b0efe-fd22-11ea-1cdd-a5ded834ab2a
typeof(y)

# ╔═╡ 31055b1d-eabc-40ea-a860-d50923018c2c
sizeof(y)

# ╔═╡ 2b0adfe9-028b-437c-99cc-39b993e036fa
md"### `String`

text is represented as a `String`."

# ╔═╡ 2ecab27a-fd22-11ea-09f6-03f120a4e4e2
my_name = "Cory" # construct strings with quotation marks

# ╔═╡ d9b74a2e-fd22-11ea-39e1-7311dbdfdfa7
typeof(my_name)

# ╔═╡ e87a9ca8-fd22-11ea-28f2-b55daeb0032e
md"
### `Symbol`
a `Symbol` is an [interned string](https://en.wikipedia.org/wiki/String_interning), which e.g. makes string comparison operations faster. a more advanced discussion on `Symbol`'s is [here](https://stackoverflow.com/questions/23480722/what-is-a-symbol-in-julia#).

!!! hint
    the function `pointer_from_objref` gives the memory address of a variable. experiment with a `Symbol` and `String` to illustrate that `Symbol`s are *interned* strings. 
"

# ╔═╡ 97e1060a-fd23-11ea-0724-b57130b840a0
dog_name = :Oslo # or Symbol("Oslo")

# ╔═╡ ad38b10e-fd23-11ea-39c7-abec457dd0a9
typeof(dog_name)

# ╔═╡ b8b5d778-b3e5-4c04-9e73-43a43017d75e
md"### `Bool`
a Boolean variable is either `true` or `false`.
"

# ╔═╡ 73201488-bd70-473b-b12c-0cff76189138
oslo_is_a_dog = true

# ╔═╡ bca6e98c-fd23-11ea-3435-7de54b441520
typeof(oslo_is_a_dog)

# ╔═╡ c6038724-fd23-11ea-26f1-95f83c18b73a
md"## other important data structures
### `Dict`

a dictionary stores an unordered collection of (key, value) pairs. it stores a mapping from keys to values.
"

# ╔═╡ df7265ae-fd23-11ea-2062-590489759192
atom_to_mass = Dict("C" => 12.01, 
				   "N" => 14.0067, 
	               "O" => 15.999, 
	               "H" => 1.01)
# note the order is not the same as when we constructed the dictionary... so never assume the dictionary is in a certain order. for ordered elements, use an `Array`

# ╔═╡ a5eef120-fd24-11ea-1fbc-9716cad65315
typeof(atom_to_mass)

# ╔═╡ 06068334-fd25-11ea-380c-adf3a922c2ee
keys(atom_to_mass)

# ╔═╡ 0bcf7bea-fd25-11ea-02fd-734a32e86dfc
values(atom_to_mass)

# ╔═╡ f8d312f4-1c16-4f97-abc3-767030b794c8
md"query a dictionary"

# ╔═╡ ef434eee-fd23-11ea-19e3-2578be44f9a0
atom_to_mass["O"]

# ╔═╡ 62d22a05-8971-43d5-99ba-c98eed82ed5f
md"add a new (key, value) pair"

# ╔═╡ fdc4e874-fd23-11ea-19e4-b3cfa1e8f9b4
begin
	atom_to_mass["He"] = 4.0 # add a (key, value) pair
	atom_to_mass
end

# ╔═╡ d9bc41ea-fbd2-4102-8bbb-2cb0a3ba987d
md"iterate through the (key, value) pairs of a dictionary"

# ╔═╡ 197e253a-fd24-11ea-3ba6-2bb768ca610a
for (element, mass) in atom_to_mass # iterate over, unpack the (key, value) pairs
	println("the atomic mass of ", element, " is ", mass)
end

# ╔═╡ 7b440f50-fd24-11ea-24e6-43ea33e3a9bb
md"### `Array`

an array is an ordered list of objects (could be `Float64`'s, `Int64`'s, `String`'s, etc.).

construct an array of `Float64`'s.
"

# ╔═╡ 92493d42-fd24-11ea-277e-73ee6f34697f
z = [6.3, 1.2, 8.2] # column vector

# ╔═╡ a1574ae0-fd24-11ea-1d13-6bd7232b61dd
typeof(z)

# ╔═╡ 6303f191-f5c8-4681-babe-368910562b6c
md"query, change an element (indexing starts at `1`).
"

# ╔═╡ 598be54f-01cc-4a17-94db-b0bb2d011d22
z[3]

# ╔═╡ 9b569d44-fd24-11ea-3ae9-d9e86b734398
begin
	z[3] = -1.0
	z
end

# ╔═╡ 0a366ce0-59e0-4c06-a00a-7d9f14bb4931
md"what is the length of the array?"

# ╔═╡ bdd6b318-fd24-11ea-03ca-05534b38845d
length(z)

# ╔═╡ d363b716-fd25-11ea-11c9-8905dd4f3dc4
md"iterating through an array (3 ways)

1. iterating through the indices
"

# ╔═╡ b0312d60-fd24-11ea-2338-e33d7b7c7326
for i in eachindex(z)
	println("z[$i] = ", z[i])
end

# ╔═╡ 61f2c93c-c003-4b4a-b96e-f4f0a718f814
md"2. directly iterating through the elements (if we don't need the indices inside the loop)"

# ╔═╡ 2bf8581d-d343-416d-921d-d0f92b257d5a
for zᵢ in z
	println(zᵢ)
end

# ╔═╡ 69fb90f3-9a18-4bc4-912f-2b1cd45e04c7
md"3. iterating through both the indices and the elements"

# ╔═╡ 40f9dac7-9ab9-47e3-8655-b346b51f2aca
for (i, zᵢ) in enumerate(z)
	println("z[$i] = $zᵢ")
end

# ╔═╡ 88989cc8-fd26-11ea-2ad1-e54b6dfa0d75
md"adding elements to an array

... at the end
"

# ╔═╡ 8d7abd34-fd26-11ea-2ac8-59aa1152a963
begin
	push!(z, 23.0) # exlamation => function will modify its argument
	z
end

# ╔═╡ 305e9461-7fda-4bc0-9140-c4fccfd3fc22
md"...at the beginning"

# ╔═╡ 9c9cf930-fd26-11ea-369d-05487ebb4a2c
begin
	pushfirst!(z, 0.0) # exlamation => function will modify its argument
	z
end

# ╔═╡ adea9760-fd26-11ea-0507-db19248c356d
md"slicing an array

1. by indices"

# ╔═╡ b37ab55c-fd26-11ea-0d2f-43020e094843
begin
	ids_i_want = [1, 4]
	z[ids_i_want]
end

# ╔═╡ 126a590e-fd28-11ea-1c02-c3262b85add7
z[1:4]

# ╔═╡ 185775c2-fd28-11ea-03b1-a50001c813db
z[3:end]

# ╔═╡ 74f433aa-4cd3-4fc6-b33c-15598b32aefc
md"2. by an array of `Bool`s"

# ╔═╡ 259be740-fd28-11ea-3cce-0959719ea489
begin
	i_want = [true, false, false, true, false] # a Vector{Bool}
	z[i_want]
end

# ╔═╡ 6081e190-fd28-11ea-37d5-81d995c5da53
md"filtering an array. i.e. retreive all values (in the same order) that satisfy some condition.
"

# ╔═╡ 7b50b3a5-ef8c-4a3b-982f-df6a53cdf5ca
z

# ╔═╡ c8a37d7a-3479-482a-a54a-a69e90d83b32
md"1. via `Vector{Bool}` slicing"

# ╔═╡ 75e95b6a-fd28-11ea-3574-09b696391ec0
z .> 0.0 # dot is for "apply element-wise"

# ╔═╡ 8c4574e6-fd28-11ea-2d7b-41a82e763605
z[z .> 0.0]

# ╔═╡ 054070f8-9aa4-43c7-a419-d96d14c8b397
md"2. the `filter` function."

# ╔═╡ c5d16e3a-da25-428c-b998-a06bde5a2779
filter(zᵢ -> zᵢ > 0, z)

# ╔═╡ 382d122a-fd29-11ea-136e-3763d3b27fff
md"multi-dimensional arrays"

# ╔═╡ 3df06fcc-fd29-11ea-242e-459a5796c5e8
u = [1 3 1; 
    0 8 3]

# ╔═╡ 47a89d1c-fd29-11ea-1249-716bfbaff87d
size(u) # two rows, three columns

# ╔═╡ 56adbdc6-fd29-11ea-219a-07848f5ddbfd
u[2, 1] # second row, first column

# ╔═╡ 4d477196-fd29-11ea-1eeb-dd8885fafa93
u[:, 2] # all the rows, second column

# ╔═╡ 8cafc58a-fd2a-11ea-2d83-7fb53e343317
md"constructing an array, without typing out each entry manually

1. list comprehension (fast, beautiful)
"

# ╔═╡ 9a16deb6-fd2a-11ea-1810-8d0c1c22a39a
v₁ = [2.0 * i for i = 1:5] # think "what do I want in element i?"

# ╔═╡ 5ae77a48-537d-4d9e-828d-8b3f362ed6a1
md"2. pre-allocate memory, fill in (fast, flexible, clear, but takes a few lines)"

# ╔═╡ 7a9e8be2-f906-4208-8816-7837e884ea2d
begin
	v₂ = zeros(Float64, 5) # construct a 5-element array with zeros
	for i = 1:5
		v₂[i] = 2 * i
	end
	v₂
end

# ╔═╡ 5ebbbb2b-2c58-4219-9c79-dc33a8b000a3
md"3. start with empty array, add values (slow; only do when you don't know the size beforehand)"

# ╔═╡ 1c1caef9-3a3a-4ad5-a72c-3a69bb83f7f5
begin
	v₃ = Float64[]
	for i = 1:5
		push!(v₃, 2 * i)
	end
	v₃
end

# ╔═╡ 4b34114b-df6e-4e76-9704-30c1e1986285
md"4. special constructors"

# ╔═╡ e3ecf6eb-52ba-4219-bc78-244801b33908
zeros(3)

# ╔═╡ d94ab0cd-c061-4277-b116-04301de1b91d
ones(3, 4)

# ╔═╡ d5bb8a81-e46d-4db0-9a19-7f1451373add
falses(4)

# ╔═╡ b9cce99e-fd2a-11ea-03fe-3d20bfb629a7
begin
	t = range(0.0, stop=1.0, length=5)
	collect(t) # collect to actually build the array
end

# ╔═╡ 8349134c-fd2b-11ea-3426-7f3ad78a3384
md"element-wise operations on arrays"

# ╔═╡ 8d985c22-fd2b-11ea-38c8-25c40abddf44
begin
	a = [0.0, 1.0, 2.0]
	b = [5.0, 6.0, 7.0]
	
	a .* b # dot for element-wise
end

# ╔═╡ a0a2a016-fd2b-11ea-1be7-595c50ab3751
2.0 * a

# ╔═╡ a5c49b8a-fd2b-11ea-317a-814aa9d072ff
sin.(a) # dot to apply function element-wise

# ╔═╡ bb84580c-fd2b-11ea-34fe-03e69a043bc4
md"matrix multiplication"

# ╔═╡ c8fe380e-fd2b-11ea-3d76-edf4546e3d6b
A = rand(3, 3) # 3 × 3 matrix with random U[0, 1] entries

# ╔═╡ cc7c41c4-fd2b-11ea-0fdc-9d18add5fea4
A * b

# ╔═╡ 644e6466-edc8-4aa0-93b0-6d5250262da4
md"concatenate two arrays together, either vertically or horizontally.
"

# ╔═╡ dcaf697f-10c6-4ee4-b2a8-05179beffcd4
begin
	# two column vectors
	u₁ = [1.0, 2.0]
	u₂ = [3.0, 4.0]
end

# ╔═╡ d5df7396-cb2a-48b1-8d6d-f4078b992542
vcat(u₁, u₂)

# ╔═╡ a52e18c1-8441-4cca-b474-abbdc533d721
hcat(u₁, u₂)

# ╔═╡ e3af0b56-fd2b-11ea-1a50-cd73d2d9fd48
md"### custom data structure"

# ╔═╡ e9f164b4-fd2b-11ea-1b4b-4b95e685950a
begin
	struct Molecule
	    species::String
	    atoms::Vector{String}
		coords::Matrix{Float64}
	end
	
	molecule = Molecule("water", 
		                ["H", "H", "O"],
						[0.0   0.0 0.0;
			             0.759 0.0 0.504;
			             0.759 0.0 -0.504])
	
	molecule.coords # access attributes
end

# ╔═╡ 376ef642-fd2d-11ea-10e8-c35996c11e35
md"## `function`'s

a function maps an input to an output:

$$x \mapsto f(x)$$
"

# ╔═╡ b0432b82-4189-4df2-8072-896ce3ece6b8
md"1. inline construction (if a short function)"

# ╔═╡ 05f1d5ae-ad6b-4d9c-908c-da80373711d9
f₁(x) = 2 * x + 3

# ╔═╡ d1d463b4-8771-432a-af8b-0c5661fee1a3
md"2. expanded construction (if more code involved)"

# ╔═╡ 51d6689e-d3f2-49f2-ae65-66699eb2f4d8
function f₂(x)
	y = 2 * x
	return y + 3
end

# ╔═╡ 65ceb9db-57d8-4487-adf2-7f8511f68a66
md"evaluating a function"

# ╔═╡ 47fdafd4-8ff2-4735-b63f-f928d93d6569
f₁(2.0)

# ╔═╡ 90f43dd5-22bc-4c06-b4d9-1f740924aa07
f₂(2.0)

# ╔═╡ cd43a9d8-b891-44b2-803b-25f422b2e551
md"apply our function to each element of an array.

1. via the `.` syntax, indicating element-wise operation.
"

# ╔═╡ 805bf238-4d54-4649-8d77-d6a12622f6b6
f₂.(z)

# ╔═╡ c9989f22-7f2a-415e-9932-5ff83f677eee
md"2. via `map` and an anonomous function"

# ╔═╡ 9a496a9a-fd2d-11ea-036e-05a28c1882d9
# https://docs.julialang.org/en/v1/manual/functions/#man-anonymous-functions-1
# "primary use for anonymous functions is passing them 
#   to functions which take other functions as arguments"
map(x -> 2 * x + 3, z)

# ╔═╡ 94901605-67b0-409b-bb20-a0955f5ae2ea
md"functions with multiple arguments"

# ╔═╡ d7cf8796-fd2d-11ea-2dae-13cf938bd877
begin
	g(x, y) = x + y
	g(2.0, 3.0)
end

# ╔═╡ ea3373ca-fd2d-11ea-25d4-0942d7faeb0b
md"optional positional arguments

> In many cases, function arguments have sensible default values and therefore might not need to be passed explicitly in every call. [source](https://docs.julialang.org/en/v1/manual/functions/#Optional-Arguments-1)

say `b` is almost always 0.0. let's not force the user to pass this arugment, yet let's also allow some flexibility if the user wants to change `b` from the default of `b=0.0`."

# ╔═╡ 066b7bfa-fd2e-11ea-34b5-5d23f5a433e4
begin
	# constructor
	h(x, m, b=0.0) = m * x + b
	
	h(2.0, 1.0) # b assumed zero
end

# ╔═╡ 1781a568-fd2e-11ea-1280-43c4591acacd
h(2.0, 1.0, 3.0) # the third argument is assumed `b` if passed

# ╔═╡ 28534fae-fd2e-11ea-3f5a-836d16c725f8
md"optional keyword arguments

> Some functions need a large number of arguments, or have a large number of behaviors. Remembering how to call such functions can be difficult. Keyword arguments can make these complex interfaces easier to use and extend by allowing arguments to be identified by name instead of only by position. [source](https://docs.julialang.org/en/v1/manual/functions/#Keyword-Arguments-1)
"

# ╔═╡ 334d0616-fd2e-11ea-2d83-3d37fee60a74
begin
	θ(x; m=3.0, b=0.0) = m * x + b
	θ(2.0, b=1.0)
end

# ╔═╡ 6a9fd648-fd2e-11ea-09f8-098fd33d82ff
md"type declarations in functions
> The :: operator can be used to attach type annotations to expressions and variables in programs. There are two primary reasons to do this:
> * As an assertion to help confirm that your program works the way you expect,
> * To provide extra type information to the compiler, which can then improve performance in some cases
> When appended to an expression computing a value, the :: operator is read as \"is an instance of\". It can be used anywhere to assert that the value of the expression on the left is an instance of the type on the right.
> [source](https://docs.julialang.org/en/v1/manual/types/index.html#Type-Declarations-1)"

# ╔═╡ 8c73923c-fd2e-11ea-2520-1736af901c1f
ξ(x::Float64) = sqrt(x)

# ╔═╡ d833eeef-32ae-4622-b411-78e25ed68551
ξ(4.0)

# ╔═╡ 0485bc6e-fd2f-11ea-36c9-05455f0b59e3
ξ(3) # wrong type!

# ╔═╡ dd21f7a1-d76a-4a00-b036-db307ce67666
md"functions can take in our custom data types"

# ╔═╡ 0dacb54c-fd2f-11ea-05ff-4df8be2ef053
"""
calculate and return the molecular weight of a molecule
"""
function molecular_wt(molecule::Molecule, atom_to_mass::Dict{String, Float64})
	mw = 0.0
	for atom in molecule.atoms
		mw += atom_to_mass[atom]
	end
	return mw
end

# ╔═╡ 8eb9d71d-7755-458a-92ab-b429d6b121d5
molecular_wt(molecule, atom_to_mass)

# ╔═╡ 0e0a8cba-fd31-11ea-26ed-2d27f95f54ff
md"## control flow
> a control flow statement is a statement, the execution of which results in a choice being made as to which of two or more paths a computer program will follow - [Wikipedia](https://en.wikipedia.org/wiki/Control_flow)

e.g., is the indoor air temperature comfortable? what is your preferred drink based on the air temperature?
"

# ╔═╡ d21c1ce4-33fe-48ca-8fd1-422ad1667d2d
temperature = 45.0 # °F

# ╔═╡ 933d5544-fd33-11ea-06af-8debefdb728a
my_drink = (temperature > 74.0) ? "ice water" : "hot tea"

# ╔═╡ 9ff8ba12-fd33-11ea-2eca-0fe897359d25
# && = "and"
comfy = temperature > 65.0 && temperature < 75.0

# ╔═╡ 21153e31-158f-47c5-a918-ae0d1a18812d
md"e.g. write a function to determine if a `Molecule` is a hydrocarbon or not."

# ╔═╡ 82eb1752-fd31-11ea-17be-11666cb6e2e8
function is_hydrocarbon(molecule::Molecule)
	for atom in molecule.atoms
		if ! ((atom == "C") || (atom == "H"))
			return false
		end
	end
	return true # if made it this far, all atoms are :C or :H
end

# ╔═╡ da8ea3cd-a6dd-4e33-89dc-627d917c4b82
is_hydrocarbon(molecule)

# ╔═╡ 19cddf3a-fd35-11ea-328f-9397bc118698
md"## randomness, sampling
"

# ╔═╡ 85dc7b27-b5bc-41c1-941e-7053531270b8
md"generate a uniformly distributed number in $[0, 1]$"

# ╔═╡ 27ef6938-fd35-11ea-07e2-0b28886507bb
rand()

# ╔═╡ 47edae53-22a0-413e-9708-15089cd97aef
md"flip a coin"

# ╔═╡ 31f083f4-fd35-11ea-34d3-81f1d3e8dc6b
landed_on_tails = rand() < 0.5

# ╔═╡ d65edc64-2b36-435e-ad92-22931078da45
md"generate a normally distributed number (μ = 0, σ = 1)"

# ╔═╡ 37b27476-fd35-11ea-1892-79927795db0f
randn()

# ╔═╡ 11537618-9916-485e-a6ca-a92756d87166
md"shuffle an array"

# ╔═╡ 4f4660e0-fd35-11ea-1186-252d22ca1c33
z

# ╔═╡ 55288cb8-fd35-11ea-3d35-e548167cb52e
begin
	shuffle!(z)
	z
end

# ╔═╡ d8dc6878-fa05-4508-a1c0-1a1f7dfa8021
md"sample elements from an array (uniform)"

# ╔═╡ 62314e4a-fd35-11ea-271c-d90066d6cdd9
sample(z, 4, replace=true) # sample four elements randomly, with replacement

# ╔═╡ a2693913-4e59-4d16-839c-ab83a18e7e11
md"sample elements from an array (nonuniform)"

# ╔═╡ 7432ae22-fd35-11ea-35f2-170288e9c358
# simulate the weather:
#  rainy 10%, cloudy 60%, sunny 30%
sample(["rainy", "cloudy", "sunny"], ProbabilityWeights([0.1, 0.6, 0.3]))

# ╔═╡ 8554b92a-fd35-11ea-2956-cdf98a96f9d1
md"## mutable vs. immutable data structures

let's illustrate by creating a data structure for a tree that keeps track of its species and height, then writing a function to simulate tree growth.
"

# ╔═╡ 1966f615-5abc-4de7-9bdf-b0b91a8046e6
mutable struct Tree
	species::String
	height::Float64 # m
end

# ╔═╡ 2f4ae3e2-eca8-4d9a-9da3-5ea3da8fc76f
function grow!(tree::Tree)
	tree.height += 0.1 * rand()
end

# ╔═╡ 73055b2c-8627-46c6-bb4a-b31c0baba986
tree = Tree("oak", 1.0)

# ╔═╡ d97bcb89-85b3-448f-a32d-aade11747a0e
grow!(tree)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"

[compat]
PlutoTeachingTools = "~0.2.3"
PlutoUI = "~0.7.9"
StatsBase = "~0.33.10"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "1833bda4a027f4b2a1c984baddcf755d77266818"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.1.0"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "4866e381721b30fac8dda4c8cb1d9db45c8d2994"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.37.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "0f960b1404abb0b244c1ece579a0ec78d056a5d1"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.15"

[[LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "ab9aa169d2160129beb241cb2750ca499b4e90e9"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.17"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "dedbebe234e06e1ddad435f5c6f4b85cd8ce55f7"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "2.2.2"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "438d35d2d95ae2c5e8780b330592b6de8494e779"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.3"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "0e8bcc235ec8367a8e9648d48325ff00e4b0a545"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.5"

[[PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "LaTeXStrings", "Latexify", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "d8be3432505c2febcea02f44e5f4396fae017503"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.3"

[[PlutoUI]]
deps = ["Base64", "Dates", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "Suppressor"]
git-tree-sha1 = "44e225d5837e2a2345e69a1d1e01ac2443ff9fcb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.9"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[Revise]]
deps = ["CodeTracking", "Distributed", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "Pkg", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "dad726963ecea2d8a81e26286f625aee09a91b7c"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.4.0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8cbbc098554648c84f79a463c9ff0fd277144b6c"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.10"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╠═23c448da-3628-4db1-b91f-b7fa2ac2d843
# ╠═3b6ceee5-0817-4b19-a597-7c98ed230130
# ╟─1f74ddfe-fd19-11ea-1a0f-678021182d2c
# ╟─2f9e20c0-fd1c-11ea-1064-411a3bbb014e
# ╟─f3fee3ca-fd1c-11ea-2906-9d8d6b874f66
# ╠═b99409d6-fd1f-11ea-1cd5-e97615600cea
# ╟─e267492c-fd1f-11ea-20a3-9f7759e16280
# ╠═0ae926cc-fd20-11ea-3e7f-1b8af64f05d8
# ╟─21ec295a-7b45-4db5-8b58-942180413f33
# ╠═b23f0981-af7a-4302-84fb-556cdb906c4d
# ╟─181fec1c-fd21-11ea-042c-23828f908e52
# ╠═11aa062e-fd21-11ea-068b-495c13f48386
# ╠═16342ee8-b797-4c37-8b21-20fa4fa3999b
# ╟─32d07345-7f33-4d6f-a601-862e9a2e5919
# ╠═2d622f08-fd22-11ea-2d6a-6bd48280b429
# ╠═315b0efe-fd22-11ea-1cdd-a5ded834ab2a
# ╠═31055b1d-eabc-40ea-a860-d50923018c2c
# ╟─2b0adfe9-028b-437c-99cc-39b993e036fa
# ╠═2ecab27a-fd22-11ea-09f6-03f120a4e4e2
# ╠═d9b74a2e-fd22-11ea-39e1-7311dbdfdfa7
# ╟─e87a9ca8-fd22-11ea-28f2-b55daeb0032e
# ╠═97e1060a-fd23-11ea-0724-b57130b840a0
# ╠═ad38b10e-fd23-11ea-39c7-abec457dd0a9
# ╟─b8b5d778-b3e5-4c04-9e73-43a43017d75e
# ╠═73201488-bd70-473b-b12c-0cff76189138
# ╠═bca6e98c-fd23-11ea-3435-7de54b441520
# ╟─c6038724-fd23-11ea-26f1-95f83c18b73a
# ╠═df7265ae-fd23-11ea-2062-590489759192
# ╠═a5eef120-fd24-11ea-1fbc-9716cad65315
# ╠═06068334-fd25-11ea-380c-adf3a922c2ee
# ╠═0bcf7bea-fd25-11ea-02fd-734a32e86dfc
# ╟─f8d312f4-1c16-4f97-abc3-767030b794c8
# ╠═ef434eee-fd23-11ea-19e3-2578be44f9a0
# ╟─62d22a05-8971-43d5-99ba-c98eed82ed5f
# ╠═fdc4e874-fd23-11ea-19e4-b3cfa1e8f9b4
# ╟─d9bc41ea-fbd2-4102-8bbb-2cb0a3ba987d
# ╠═197e253a-fd24-11ea-3ba6-2bb768ca610a
# ╟─7b440f50-fd24-11ea-24e6-43ea33e3a9bb
# ╠═92493d42-fd24-11ea-277e-73ee6f34697f
# ╠═a1574ae0-fd24-11ea-1d13-6bd7232b61dd
# ╟─6303f191-f5c8-4681-babe-368910562b6c
# ╠═598be54f-01cc-4a17-94db-b0bb2d011d22
# ╠═9b569d44-fd24-11ea-3ae9-d9e86b734398
# ╟─0a366ce0-59e0-4c06-a00a-7d9f14bb4931
# ╠═bdd6b318-fd24-11ea-03ca-05534b38845d
# ╟─d363b716-fd25-11ea-11c9-8905dd4f3dc4
# ╠═b0312d60-fd24-11ea-2338-e33d7b7c7326
# ╟─61f2c93c-c003-4b4a-b96e-f4f0a718f814
# ╠═2bf8581d-d343-416d-921d-d0f92b257d5a
# ╟─69fb90f3-9a18-4bc4-912f-2b1cd45e04c7
# ╠═40f9dac7-9ab9-47e3-8655-b346b51f2aca
# ╟─88989cc8-fd26-11ea-2ad1-e54b6dfa0d75
# ╠═8d7abd34-fd26-11ea-2ac8-59aa1152a963
# ╟─305e9461-7fda-4bc0-9140-c4fccfd3fc22
# ╠═9c9cf930-fd26-11ea-369d-05487ebb4a2c
# ╟─adea9760-fd26-11ea-0507-db19248c356d
# ╠═b37ab55c-fd26-11ea-0d2f-43020e094843
# ╠═126a590e-fd28-11ea-1c02-c3262b85add7
# ╠═185775c2-fd28-11ea-03b1-a50001c813db
# ╟─74f433aa-4cd3-4fc6-b33c-15598b32aefc
# ╠═259be740-fd28-11ea-3cce-0959719ea489
# ╟─6081e190-fd28-11ea-37d5-81d995c5da53
# ╠═7b50b3a5-ef8c-4a3b-982f-df6a53cdf5ca
# ╟─c8a37d7a-3479-482a-a54a-a69e90d83b32
# ╠═75e95b6a-fd28-11ea-3574-09b696391ec0
# ╠═8c4574e6-fd28-11ea-2d7b-41a82e763605
# ╟─054070f8-9aa4-43c7-a419-d96d14c8b397
# ╠═c5d16e3a-da25-428c-b998-a06bde5a2779
# ╟─382d122a-fd29-11ea-136e-3763d3b27fff
# ╠═3df06fcc-fd29-11ea-242e-459a5796c5e8
# ╠═47a89d1c-fd29-11ea-1249-716bfbaff87d
# ╠═56adbdc6-fd29-11ea-219a-07848f5ddbfd
# ╠═4d477196-fd29-11ea-1eeb-dd8885fafa93
# ╟─8cafc58a-fd2a-11ea-2d83-7fb53e343317
# ╠═9a16deb6-fd2a-11ea-1810-8d0c1c22a39a
# ╟─5ae77a48-537d-4d9e-828d-8b3f362ed6a1
# ╠═7a9e8be2-f906-4208-8816-7837e884ea2d
# ╟─5ebbbb2b-2c58-4219-9c79-dc33a8b000a3
# ╠═1c1caef9-3a3a-4ad5-a72c-3a69bb83f7f5
# ╟─4b34114b-df6e-4e76-9704-30c1e1986285
# ╠═e3ecf6eb-52ba-4219-bc78-244801b33908
# ╠═d94ab0cd-c061-4277-b116-04301de1b91d
# ╠═d5bb8a81-e46d-4db0-9a19-7f1451373add
# ╠═b9cce99e-fd2a-11ea-03fe-3d20bfb629a7
# ╟─8349134c-fd2b-11ea-3426-7f3ad78a3384
# ╠═a0a2a016-fd2b-11ea-1be7-595c50ab3751
# ╠═8d985c22-fd2b-11ea-38c8-25c40abddf44
# ╠═a5c49b8a-fd2b-11ea-317a-814aa9d072ff
# ╟─bb84580c-fd2b-11ea-34fe-03e69a043bc4
# ╠═c8fe380e-fd2b-11ea-3d76-edf4546e3d6b
# ╠═cc7c41c4-fd2b-11ea-0fdc-9d18add5fea4
# ╟─644e6466-edc8-4aa0-93b0-6d5250262da4
# ╠═dcaf697f-10c6-4ee4-b2a8-05179beffcd4
# ╠═d5df7396-cb2a-48b1-8d6d-f4078b992542
# ╠═a52e18c1-8441-4cca-b474-abbdc533d721
# ╟─e3af0b56-fd2b-11ea-1a50-cd73d2d9fd48
# ╠═e9f164b4-fd2b-11ea-1b4b-4b95e685950a
# ╟─376ef642-fd2d-11ea-10e8-c35996c11e35
# ╟─b0432b82-4189-4df2-8072-896ce3ece6b8
# ╠═05f1d5ae-ad6b-4d9c-908c-da80373711d9
# ╟─d1d463b4-8771-432a-af8b-0c5661fee1a3
# ╠═51d6689e-d3f2-49f2-ae65-66699eb2f4d8
# ╟─65ceb9db-57d8-4487-adf2-7f8511f68a66
# ╠═47fdafd4-8ff2-4735-b63f-f928d93d6569
# ╠═90f43dd5-22bc-4c06-b4d9-1f740924aa07
# ╟─cd43a9d8-b891-44b2-803b-25f422b2e551
# ╠═805bf238-4d54-4649-8d77-d6a12622f6b6
# ╟─c9989f22-7f2a-415e-9932-5ff83f677eee
# ╠═9a496a9a-fd2d-11ea-036e-05a28c1882d9
# ╟─94901605-67b0-409b-bb20-a0955f5ae2ea
# ╠═d7cf8796-fd2d-11ea-2dae-13cf938bd877
# ╟─ea3373ca-fd2d-11ea-25d4-0942d7faeb0b
# ╠═066b7bfa-fd2e-11ea-34b5-5d23f5a433e4
# ╠═1781a568-fd2e-11ea-1280-43c4591acacd
# ╟─28534fae-fd2e-11ea-3f5a-836d16c725f8
# ╠═334d0616-fd2e-11ea-2d83-3d37fee60a74
# ╟─6a9fd648-fd2e-11ea-09f8-098fd33d82ff
# ╠═8c73923c-fd2e-11ea-2520-1736af901c1f
# ╠═d833eeef-32ae-4622-b411-78e25ed68551
# ╠═0485bc6e-fd2f-11ea-36c9-05455f0b59e3
# ╟─dd21f7a1-d76a-4a00-b036-db307ce67666
# ╠═0dacb54c-fd2f-11ea-05ff-4df8be2ef053
# ╠═8eb9d71d-7755-458a-92ab-b429d6b121d5
# ╟─0e0a8cba-fd31-11ea-26ed-2d27f95f54ff
# ╠═d21c1ce4-33fe-48ca-8fd1-422ad1667d2d
# ╠═933d5544-fd33-11ea-06af-8debefdb728a
# ╠═9ff8ba12-fd33-11ea-2eca-0fe897359d25
# ╟─21153e31-158f-47c5-a918-ae0d1a18812d
# ╠═82eb1752-fd31-11ea-17be-11666cb6e2e8
# ╠═da8ea3cd-a6dd-4e33-89dc-627d917c4b82
# ╠═19cddf3a-fd35-11ea-328f-9397bc118698
# ╠═209e3d26-fd35-11ea-3916-853482bfa1bc
# ╟─85dc7b27-b5bc-41c1-941e-7053531270b8
# ╠═27ef6938-fd35-11ea-07e2-0b28886507bb
# ╟─47edae53-22a0-413e-9708-15089cd97aef
# ╠═31f083f4-fd35-11ea-34d3-81f1d3e8dc6b
# ╟─d65edc64-2b36-435e-ad92-22931078da45
# ╠═37b27476-fd35-11ea-1892-79927795db0f
# ╟─11537618-9916-485e-a6ca-a92756d87166
# ╠═4f4660e0-fd35-11ea-1186-252d22ca1c33
# ╠═55288cb8-fd35-11ea-3d35-e548167cb52e
# ╟─d8dc6878-fa05-4508-a1c0-1a1f7dfa8021
# ╠═62314e4a-fd35-11ea-271c-d90066d6cdd9
# ╟─a2693913-4e59-4d16-839c-ab83a18e7e11
# ╠═7432ae22-fd35-11ea-35f2-170288e9c358
# ╟─8554b92a-fd35-11ea-2956-cdf98a96f9d1
# ╠═1966f615-5abc-4de7-9bdf-b0b91a8046e6
# ╠═2f4ae3e2-eca8-4d9a-9da3-5ea3da8fc76f
# ╠═73055b2c-8627-46c6-bb4a-b31c0baba986
# ╠═d97bcb89-85b3-448f-a32d-aade11747a0e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
