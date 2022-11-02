### A Pluto.jl notebook ###
# v0.19.13

using Markdown
using InteractiveUtils

# ╔═╡ 560929d7-a01d-4475-bcd2-516ace7da08f
using DataFrames, CSV, Statistics, PlutoUI

# ╔═╡ e6830c0c-94de-4202-96e3-b4aed698ad46
TableOfContents()

# ╔═╡ 1b29c142-033b-11eb-1fcd-3167939de8d2
md"
# working with tabular data
to load, store, query, filter, sort, group, manipulate, etc. tables of data, we will employ the Julia packages:
* `DataFrames.jl` [documentation](http://juliadata.github.io/DataFrames.jl/stable/)
* `CSV.jl` [documentation](https://juliadata.github.io/CSV.jl/stable/)

## high-level ❓'s

### what's a `DataFrame`?
a `DataFrame` is a convenient data structure (in many languages) for storing data in tabular form.
* rows = instances/examples
* columns = features of those instances/examples

### what does the `DataFrames.jl` package do?
the `DataFrames.jl` package implements the `DataFrame` structure and offers many functions that operate on `DataFrame`'s to _efficiently_ query, filter, group, sort, manipulate etc. tables of data. `DataFrames.jl` handles missing values efficiently via a special type `Missing`.

### what does the `CSV.jl` package do?
the `CSV.jl` package offers functions to quickly and flexibly read CSV (= comma-separated value) files---a common file format for tables of data---and convert them into `DataFrame`'s, as well as to write `DataFrame`'s to a CSV file.
"

# ╔═╡ 31e25766-033c-11eb-3991-d55735f7977f
md"## simple operations on `DataFrames`

### construct from scratch

construct a `DataFrame`, `city_data`, that contains information about cities in the US.

* rows = instances = cities
* columns = features = attributes of cities
"

# ╔═╡ dd6128dd-bdf4-48a2-a6ec-b213231c4ad3
city = ["Corvallis", "Portland", "Eugene"]

# ╔═╡ 4ece318f-e083-40cf-803a-beed87b520fe
population = [57961, 647805, 168916]

# ╔═╡ 2071b5b6-038f-11eb-182d-f392b2198f2e
# city_data = DataFrame(city=city, population=population)
city_data = DataFrame(city=["Corvallis", "Portland", "Eugene"],
	                  population=[57961, 647805, 168916])

# ╔═╡ bc58ac1c-033c-11eb-2698-f5fc4c20b8ce
md"### append rows

append two new rows to `city_data`:
* Bend, OR has a population of 94520.
* Berkeley, CA has a population of 122324.

_approach 1_: think of rows of a `DataFrame` as an `Array`.
"

# ╔═╡ d172a490-033c-11eb-157e-6b95587099dd
begin
	new_row = ["Bend", 94520]
	push!(city_data, new_row)
end

# ╔═╡ 78b1f924-033d-11eb-2937-ff9634f5aa9a
md"
_approach 2_: think of rows of a `DataFrame` as a `Dict`.
"

# ╔═╡ 4c407c9a-0353-11eb-0618-955711917f54
begin
	another_new_row = Dict("population" => 122324, "city" => "Berkeley")
	push!(city_data, another_new_row)
end

# ╔═╡ 5e293c82-033d-11eb-3984-7164bf9a351d
md"### append columns

append another two column to `city_data` giving the (1) annual rainfall in each city and (2) state to which the city belongs.
* Corvallis, OR: 51.0 in
* Portland, OR: 43.0 in
* Eugene, OR: 47.0 in
* Bend, OR: 12.0 in
* Berkeley, CA: 25.0 in

!!! hint
	remember, `:` = \"all the rows\". and `!` in the function name $\implies$ \"modify the argument of this function\"

*approach 1:* view the `DataFrame` as an array.
"

# ╔═╡ 400d2f1a-5033-4581-a5b4-f57f101bef4e
city_data[:, "rain"] = [51.0, 43.0, 47.0, 12.0, 25.0]

# ╔═╡ 452fee83-985a-4eab-9c9d-2223645056f0
city_data

# ╔═╡ 014a4866-a14d-444d-81cb-5c3e242f855d
md"*approach 2:* employ the `insertcols!` function, which allows you to insert a column at a specified location."

# ╔═╡ a5e9fc00-0353-11eb-1443-63b1c2edab7c
insertcols!(city_data, 2, "state" => ["OR", "OR", "OR", "OR", "CA"])

# ╔═╡ c94b33a0-3023-45fb-9c77-354579d742fb
md"*approach 3:* the `transform` function, which transforms current column(s) into a new one. see [the docs](https://dataframes.juliadata.org/stable/lib/functions/#DataFrames.transform!)."

# ╔═╡ 46f095d4-630a-4661-bb37-a0084d11b6b6
transform!(city_data, "rain" => (col -> 2 * col) => "twice_the_rainfall")

# ╔═╡ 5b7446f2-8cbb-462b-9c48-78d45f110d13
md"note `transform` can apply a function that operates on multiple columns. the below does not modify the data frame because we omit the `!` from `transform!`; rather, it returns a copy of it."

# ╔═╡ 49fa8c65-1ac8-46d9-a064-2c24fe76accb
transform(city_data, 
	["city", "state"] => ((col_1, col_2) -> col_1 .* ", " .* col_2) => "city, state")

# ╔═╡ d90a8d38-292f-43e4-ac27-f02e46e0c307
md"### modify a column
e.g. round the `\"population\"` so it contains only two significant digits. we pass `renamecols=false` to `transform!` so that, instead of creating a _new_ column, it modifies the `\"population\"` column.
"

# ╔═╡ 1756c3e7-b0f3-4f4a-927d-e52dc5cef44a
transform(city_data, "population" => 
	col -> Int.(round.(col, sigdigits=2)), 
	renamecols=false)

# ╔═╡ a67b30b0-0353-11eb-2d2f-871d7a5ffd36
md"### count the # of rows/columns"

# ╔═╡ 6249187e-035a-11eb-2f6a-d3318cf2a996
size(city_data) # (# rows, # cols)

# ╔═╡ 6f8ca3cc-5935-4abe-b628-ac3c8cf4cd97
nrow(city_data)

# ╔═╡ 84f3f188-b90c-4fcf-994b-5d32dd0551d5
ncol(city_data)

# ╔═╡ 9b63b70a-7ea6-48a6-a068-602de654681d
md"### retreive the names of the columns"

# ╔═╡ f2cbf254-69fc-4e9f-974d-468ce53040a8
names(city_data)

# ╔═╡ a3421e44-035e-11eb-3cf7-c70142f0591d
md"
### rename a column
"

# ╔═╡ a9d20a30-035e-11eb-14f4-ddf7cdaa34f6
rename!(city_data, "rain" => "rainfall")

# ╔═╡ 63716d2a-0362-11eb-3ce5-3b41d4bef04c
md"
### delete a column

use the `select!` function. see [the docs](https://dataframes.juliadata.org/stable/lib/functions/#DataFrames.select!).
"

# ╔═╡ 5931d59e-0391-11eb-078b-ddb0bcaf6521
select!(city_data, Not("twice_the_rainfall"))

# ╔═╡ 48d7d749-c7d0-407c-8863-8ab7530d6c03
select(city_data, ["city", "state"]) # no !, hence not modified.

# ╔═╡ 581bfc10-0362-11eb-1b29-cfd4320a5130
md"### delete a row"

# ╔═╡ a583d38b-c309-4b61-8820-159d67bf6874
# add a bogus row we'll want to remove
push!(city_data, ["bogus", "blah", 0, 100.0])

# ╔═╡ b7fb0648-0390-11eb-2dc5-8b6935d2545c
delete!(city_data, 6)

# ╔═╡ b8de77aa-0362-11eb-36d9-1d905442ca13
md"
### delete duplicate rows
"

# ╔═╡ 9063e224-053b-46a7-9ff1-bb550fa57964
# add duplicate row we'll want to remove
push!(city_data, ["Berkeley", "CA", 122324, 25.0]) 

# ╔═╡ cbf6250c-0362-11eb-365b-d327617f197e
unique!(city_data)

# ╔═╡ 5d7208d4-035b-11eb-00ef-cd70b6cb79d3
md"
### retreive a...

##### ... column

the columns are `Array`'s. treat the `DataFrame` like a 2D array.
"

# ╔═╡ 8d4f4ede-035b-11eb-2337-7bdb844389ae
city_data[:, "population"]

# ╔═╡ 7daa87e6-035b-11eb-3bb8-ff1bdd95714c
md"
##### ... row
"

# ╔═╡ f735e3ee-035b-11eb-33d1-755a1a9dc0a7
city_data[2, :]

# ╔═╡ 1821e936-035c-11eb-0cb1-014241a2599e
md"
##### ... entry
"

# ╔═╡ 1ad35930-035c-11eb-165d-2d70f7b07713
city_data[2, "population"]

# ╔═╡ 9e01dd3a-0362-11eb-3d19-392ec2d06bd6
md"
### find unique entries in a column
"

# ╔═╡ a6f99cc8-0362-11eb-1801-2dd5fa96efe1
unique(city_data[:, "state"])

# ╔═╡ d663dd98-035a-11eb-156f-ff237a3944b6
md"
## iterate through a `DataFrame`, row by row
"

# ╔═╡ 360eb67a-035b-11eb-2ab3-85adb264a387
for row in eachrow(city_data)
	# inside here, row is a ditionary. keys: column names.
	println(row["city"], " has a population of ", row[:population])
end

# ╔═╡ 366557f2-035c-11eb-31ce-9308dd49ce0c
md"## filter rows on some condition

use the `filter` function. see [the docs](https://dataframes.juliadata.org/stable/lib/functions/#Base.filter).
* first argument: a function that operates on a row of the `DataFrame` (treating the row as a `Dict`) and returns `true` if we want to keep that row and `false` if we want to throw it away.
* the second argument is the `DataFrame`.
* there is also a `filter!` function that will remove these rows from the dataframe instead of returning a copy with the relevant rows removed.

**example 1**: query all rows where the \"city\" column is \"Corvallis\".
"

# ╔═╡ 5abb815e-0392-11eb-3576-a7e39e8ac6af
filter(row -> row["city"] == "Corvallis", city_data)

# ╔═╡ 6ca4c6a8-035d-11eb-158c-3380a0cafdaa
md"**example 2**: query all cities (rows) where the population is less than 500,000."

# ╔═╡ 7dad5c94-035d-11eb-1f7b-2fedd834efaa
filter(row -> row["population"] < 500000, city_data)

# ╔═╡ 7e54ed24-035d-11eb-19e2-4986b3cfcab4
md"**example 3**: ... and that reside in Oregon."

# ╔═╡ 9879f190-035d-11eb-07c6-55453426c704
filter(row -> (row["population"] < 500000) && (row["state"] == "OR"), city_data)

# ╔═╡ 9926bdbc-035d-11eb-1824-438e97d78ab9
md"## sort rows

e.g. permute rows so that cities are listed by `:population` in reverse (`rev`) order
"

# ╔═╡ ab918a54-035d-11eb-27ae-2d70b27460ac
sort!(city_data, "population", rev=true)

# ╔═╡ 9ed15498-035d-11eb-1369-53ae1eac0a27
md"
## group rows

the `groupby` command (common in many languages) partitions the rows in the `DataFrame` into multiple `DataFrame`'s such that the rows in each share a common feature (contained in a column). a `GroupedDataFrame` is useful for performing computations on each group of rows in a `DataFrame` separately. see [the docs](https://dataframes.juliadata.org/stable/lib/functions/#DataFrames.groupby).

e.g., group the cities (rows) in `city_data` by state.
"

# ╔═╡ c1526020-035d-11eb-2d8a-d131aa445738
gb_state = groupby(city_data, "state")

# ╔═╡ c106f1b5-946c-44a1-bb63-ad3342adb6aa
md"the `GroupedDataFrame` works like an array and can be iterated over."

# ╔═╡ ed1a5928-be8b-4cd1-b9b8-2ed8c9e75996
gb_state[1]

# ╔═╡ e80a4a9a-0392-11eb-2d35-09bb527d7a29
for df_by_state in gb_state
	# to which state does this group correspond?
	this_state = df_by_state[1, "state"]
	
	# perform computation on this group
	#  here, we get the rainfalls in this group and take the mean
	avg_rainfall_in_this_state = mean(df_by_state[:, "rainfall"])

	println("average rainfall in ", this_state, " is ", avg_rainfall_in_this_state)
end

# ╔═╡ 4dd5195c-035e-11eb-1991-3fd9e7bf5d25
md"
## split, apply, combine

1. split the rows into groups
2. apply a function to a column (map a column to a number) in each data frame in the group
3. combine the result back into one data frame where each row pertains to a group

##### `combine`
`combine(gdf, \"col\" => f => \"new_col\")` takes as arguments `gdf::GroupedDataFrame`, applies the function `f` to the `\"col\"` column of each data frame in the group, then combines the results into a column `\"new_col\"` in a new `DataFrame`, with each row representing a group. see [docs](https://dataframes.juliadata.org/stable/lib/functions/#DataFrames.combine).

_example 1_: group by state, take `mean` of the rainfall column.
"

# ╔═╡ 03a59b6c-035f-11eb-0a39-79c770bf5544
df_rain = combine(groupby(city_data, "state"), "rainfall" => mean => "avg_rainfall")

# ╔═╡ 02fab01a-e9b8-4a43-aceb-31985194f4c6
md"
_example 2_: group by state, determine if `sum` of the rainfall is less than 50. "

# ╔═╡ a5ad8099-c40a-40c4-9197-a47281937537
combine(groupby(city_data, "state"), 
	"rainfall" => (col -> sum(col) < 50.0) => "little_rainfall")

# ╔═╡ 27391eca-ce4b-434f-bba0-13fe0d700298
md"_example 3_: group by state, compute rainfall per person"

# ╔═╡ a6f0b99d-8b48-4758-89ee-9b2772965cab
combine(groupby(city_data, "state"),
	["population", "rainfall"] => 
	  ((pop_col, rain_col) -> sum(rain_col) / sum(pop_col)) => 
	  "rainfall_per_population"
	)

# ╔═╡ 8226dc8e-0362-11eb-17bf-47cae0df2907
md"## I/O with `.csv` files

use the `CSV.jl` package.

CSV = comma separated value

### `DataFrame` to `.csv`
"

# ╔═╡ 907832ea-0362-11eb-2132-a3abadd4b1ee
CSV.write("rainfall.csv", df_rain)

# ╔═╡ c711c3f8-0393-11eb-2fbc-77693069c73f
run(`cat rainfall.csv`)

# ╔═╡ 08e91b1c-035f-11eb-05d0-9fe60938a4e3
md"### `.csv` to `DataFrame`
first, let's download the `.csv` from Github [here](https://raw.githubusercontent.com/SimonEnsemble/intro_to_data_science_fall_2022/main/data/incomes.csv) into our present working directory (`pwd`).
"

# ╔═╡ fdab541a-0393-11eb-0318-3390bd75a95d
pwd() # present working directory to see where CSV looks for files

# ╔═╡ 2604e77f-7ea0-4049-bb17-d7b5d0ca9c29
readdir()

# ╔═╡ 717b8f72-61ab-431c-9fc8-d518523b4674
url = "https://raw.githubusercontent.com/SimonEnsemble/intro_to_data_science_fall_2022/main/data/incomes.csv"

# ╔═╡ 2823012b-b80f-4532-a614-539eeba366da
download(url, "incomes.csv")

# ╔═╡ 1c01557a-035f-11eb-37e8-e9497003725f
income_data = CSV.read("incomes.csv", DataFrame)

# ╔═╡ 4cf973b8-0361-11eb-1777-cf02396ba052
md"
## joining two tables of data
\"join\" = combine the rows of two tables of data on a \"key\" column.

there are [seven types of joins](http://juliadata.github.io/DataFrames.jl/stable/man/joins/). let's illustrate two here.

_goal_: join information about cities from `city_data` and `income_data`. 
the *key* column here is `\"city\"` since we aim to combine rows of the two `DataFrames` whose feature is the same in this column.

there are two subtleties here:
* the city of San Francisco appears in `income_data` but is missing from `city_data`
* the cities of Bend, Eugene, Portland appear in `city_data` but are missing from `income_data`
`innerjoin` and `outerjoin` are distinguished by how they handle these subtleties.

### inner join
only keep rows where the value in the \"key\" column appears in _both_ `DataFrames`'s
(throw out rows that aren't common between the two)
"

# ╔═╡ 74379f7c-0361-11eb-0192-c59bca513893
data_ij = innerjoin(city_data, income_data, on=:city)

# ╔═╡ 80c12360-0361-11eb-3eb3-eddb35dac4a5
md"
### outer join
keep all rows, fill entries with `missing` if an attribute is missing in either `DataFrame`.

note the `?` appears in the type under the column name to indicate some entries are `missing`.
"

# ╔═╡ 02bef8b2-0362-11eb-130f-f99cc7311f5a
data_oj = outerjoin(city_data, income_data, on=:city)

# ╔═╡ 098a5628-0362-11eb-33af-9fc2fbceddba
md"## missing values
Julia has a data type to efficiently handle missing values.
"

# ╔═╡ 12deee64-0362-11eb-3612-ed369a623583
missing

# ╔═╡ 977c25ce-0394-11eb-0076-0955dcfe0ca1
typeof(missing)

# ╔═╡ 1e41218c-0362-11eb-2ae3-17339b033f7a
md"columns with missing values are arrays of whatever type but `Union`'d with the `Missing` type"

# ╔═╡ 25a8858c-0362-11eb-3405-95aeea8c1338
typeof(data_oj[:, "state"])

# ╔═╡ 2f441675-6930-4f97-b7e1-dfc1c25cdbc6
md"### removing rows with `missing` entries"

# ╔═╡ 86ec1cfe-d75e-4f90-a7e7-ed438517641f
data_oj

# ╔═╡ 2fb25d0c-0362-11eb-16b3-b75f845f82a9
md"..._all_ rows with a missing entry."

# ╔═╡ 36ba914e-0362-11eb-0aa7-6fda9f1b4d02
dropmissing(data_oj)

# ╔═╡ 38ab5560-0362-11eb-15cb-4595de21d218
md"...only rows with a `missing` entry in a certain column.

(note: `dropmissing!` is a function that modifies the `DataFrame` passed as an argument.)
"

# ╔═╡ 3edf858c-0362-11eb-3b47-5f53c1360718
dropmissing(data_oj, "state")

# ╔═╡ da29ea48-7cda-4286-8c59-a5b845268d6d
md"convert `missing` entries to something different."

# ╔═╡ 2919a4e2-895e-4ac7-b5eb-7f635519847c
coalesce.(data_oj, "?")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
CSV = "~0.10.4"
DataFrames = "~1.3.6"
PlutoUI = "~0.7.40"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings"]
git-tree-sha1 = "873fb188a4b9d76549b81465b1f75c82aaf59238"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.4"

[[CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "5856d3031cdb1f3b2b6340dfdc66b6d9a149a374"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.2.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[DataAPI]]
git-tree-sha1 = "1106fa7e1256b402a86a8e7b15c00c85036fef49"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.11.0"

[[DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "db2a9cb664fcea7836da4b414c3278d71dd602d2"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.6"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "e27c4ebe80e8699540f2d6c805cc12203b614f12"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.20"

[[FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "d19f9edd8c34760dca2de2b503f969d8700ed288"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.1.4"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

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
git-tree-sha1 = "3d5bf43e3e8b412656404ed9466f1dcbf7c50269"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "a602d7b0babfca89005da04d89223b867b55319f"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.40"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a6062fe4063cdafe78f4a0a81cfffb89721b30e7"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.2"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

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

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "db8481cf5d6278a121184809e9eb1628943c7704"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.13"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

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

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "7149a60b01bf58787a1b83dad93f90d4b9afbe5d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.8.1"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "8a75929dcd3c38611db2f8d08546decb514fcadf"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.9"

[[Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

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
# ╠═560929d7-a01d-4475-bcd2-516ace7da08f
# ╠═e6830c0c-94de-4202-96e3-b4aed698ad46
# ╟─1b29c142-033b-11eb-1fcd-3167939de8d2
# ╟─31e25766-033c-11eb-3991-d55735f7977f
# ╠═dd6128dd-bdf4-48a2-a6ec-b213231c4ad3
# ╠═4ece318f-e083-40cf-803a-beed87b520fe
# ╠═2071b5b6-038f-11eb-182d-f392b2198f2e
# ╟─bc58ac1c-033c-11eb-2698-f5fc4c20b8ce
# ╠═d172a490-033c-11eb-157e-6b95587099dd
# ╟─78b1f924-033d-11eb-2937-ff9634f5aa9a
# ╠═4c407c9a-0353-11eb-0618-955711917f54
# ╟─5e293c82-033d-11eb-3984-7164bf9a351d
# ╠═400d2f1a-5033-4581-a5b4-f57f101bef4e
# ╠═452fee83-985a-4eab-9c9d-2223645056f0
# ╟─014a4866-a14d-444d-81cb-5c3e242f855d
# ╠═a5e9fc00-0353-11eb-1443-63b1c2edab7c
# ╟─c94b33a0-3023-45fb-9c77-354579d742fb
# ╠═46f095d4-630a-4661-bb37-a0084d11b6b6
# ╟─5b7446f2-8cbb-462b-9c48-78d45f110d13
# ╠═49fa8c65-1ac8-46d9-a064-2c24fe76accb
# ╟─d90a8d38-292f-43e4-ac27-f02e46e0c307
# ╠═1756c3e7-b0f3-4f4a-927d-e52dc5cef44a
# ╟─a67b30b0-0353-11eb-2d2f-871d7a5ffd36
# ╠═6249187e-035a-11eb-2f6a-d3318cf2a996
# ╠═6f8ca3cc-5935-4abe-b628-ac3c8cf4cd97
# ╠═84f3f188-b90c-4fcf-994b-5d32dd0551d5
# ╟─9b63b70a-7ea6-48a6-a068-602de654681d
# ╠═f2cbf254-69fc-4e9f-974d-468ce53040a8
# ╟─a3421e44-035e-11eb-3cf7-c70142f0591d
# ╠═a9d20a30-035e-11eb-14f4-ddf7cdaa34f6
# ╟─63716d2a-0362-11eb-3ce5-3b41d4bef04c
# ╠═5931d59e-0391-11eb-078b-ddb0bcaf6521
# ╠═48d7d749-c7d0-407c-8863-8ab7530d6c03
# ╟─581bfc10-0362-11eb-1b29-cfd4320a5130
# ╠═a583d38b-c309-4b61-8820-159d67bf6874
# ╠═b7fb0648-0390-11eb-2dc5-8b6935d2545c
# ╟─b8de77aa-0362-11eb-36d9-1d905442ca13
# ╠═9063e224-053b-46a7-9ff1-bb550fa57964
# ╠═cbf6250c-0362-11eb-365b-d327617f197e
# ╟─5d7208d4-035b-11eb-00ef-cd70b6cb79d3
# ╠═8d4f4ede-035b-11eb-2337-7bdb844389ae
# ╟─7daa87e6-035b-11eb-3bb8-ff1bdd95714c
# ╠═f735e3ee-035b-11eb-33d1-755a1a9dc0a7
# ╟─1821e936-035c-11eb-0cb1-014241a2599e
# ╠═1ad35930-035c-11eb-165d-2d70f7b07713
# ╟─9e01dd3a-0362-11eb-3d19-392ec2d06bd6
# ╠═a6f99cc8-0362-11eb-1801-2dd5fa96efe1
# ╟─d663dd98-035a-11eb-156f-ff237a3944b6
# ╠═360eb67a-035b-11eb-2ab3-85adb264a387
# ╟─366557f2-035c-11eb-31ce-9308dd49ce0c
# ╠═5abb815e-0392-11eb-3576-a7e39e8ac6af
# ╟─6ca4c6a8-035d-11eb-158c-3380a0cafdaa
# ╠═7dad5c94-035d-11eb-1f7b-2fedd834efaa
# ╟─7e54ed24-035d-11eb-19e2-4986b3cfcab4
# ╠═9879f190-035d-11eb-07c6-55453426c704
# ╟─9926bdbc-035d-11eb-1824-438e97d78ab9
# ╠═ab918a54-035d-11eb-27ae-2d70b27460ac
# ╟─9ed15498-035d-11eb-1369-53ae1eac0a27
# ╠═c1526020-035d-11eb-2d8a-d131aa445738
# ╟─c106f1b5-946c-44a1-bb63-ad3342adb6aa
# ╠═ed1a5928-be8b-4cd1-b9b8-2ed8c9e75996
# ╠═e80a4a9a-0392-11eb-2d35-09bb527d7a29
# ╟─4dd5195c-035e-11eb-1991-3fd9e7bf5d25
# ╠═03a59b6c-035f-11eb-0a39-79c770bf5544
# ╟─02fab01a-e9b8-4a43-aceb-31985194f4c6
# ╠═a5ad8099-c40a-40c4-9197-a47281937537
# ╟─27391eca-ce4b-434f-bba0-13fe0d700298
# ╠═a6f0b99d-8b48-4758-89ee-9b2772965cab
# ╟─8226dc8e-0362-11eb-17bf-47cae0df2907
# ╠═907832ea-0362-11eb-2132-a3abadd4b1ee
# ╠═c711c3f8-0393-11eb-2fbc-77693069c73f
# ╟─08e91b1c-035f-11eb-05d0-9fe60938a4e3
# ╠═fdab541a-0393-11eb-0318-3390bd75a95d
# ╠═2604e77f-7ea0-4049-bb17-d7b5d0ca9c29
# ╠═717b8f72-61ab-431c-9fc8-d518523b4674
# ╠═2823012b-b80f-4532-a614-539eeba366da
# ╠═1c01557a-035f-11eb-37e8-e9497003725f
# ╟─4cf973b8-0361-11eb-1777-cf02396ba052
# ╠═74379f7c-0361-11eb-0192-c59bca513893
# ╟─80c12360-0361-11eb-3eb3-eddb35dac4a5
# ╠═02bef8b2-0362-11eb-130f-f99cc7311f5a
# ╟─098a5628-0362-11eb-33af-9fc2fbceddba
# ╠═12deee64-0362-11eb-3612-ed369a623583
# ╠═977c25ce-0394-11eb-0076-0955dcfe0ca1
# ╟─1e41218c-0362-11eb-2ae3-17339b033f7a
# ╠═25a8858c-0362-11eb-3405-95aeea8c1338
# ╟─2f441675-6930-4f97-b7e1-dfc1c25cdbc6
# ╠═86ec1cfe-d75e-4f90-a7e7-ed438517641f
# ╟─2fb25d0c-0362-11eb-16b3-b75f845f82a9
# ╠═36ba914e-0362-11eb-0aa7-6fda9f1b4d02
# ╟─38ab5560-0362-11eb-15cb-4595de21d218
# ╠═3edf858c-0362-11eb-3b47-5f53c1360718
# ╟─da29ea48-7cda-4286-8c59-a5b845268d6d
# ╠═2919a4e2-895e-4ac7-b5eb-7f635519847c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
