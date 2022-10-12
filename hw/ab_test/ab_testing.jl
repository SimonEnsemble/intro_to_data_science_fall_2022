### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ 8dd3c444-0e36-11eb-1ea4-557fcf1612ff
md"
# A/B testing (permutation tests)

background reading:
* [Ch. 11, testing hypotheses](https://inferentialthinking.com/chapters/11/Testing_Hypotheses.html)
* [Ch. 12, comparing two samples](https://inferentialthinking.com/chapters/12/Comparing_Two_Samples.html)

learning objectives:
* formulate competing hypotheses
* conduct A/B tests via simulation (permutation tests)
* explain and interpret p-values
"

# ╔═╡ 80649d66-5e4a-4a2a-85c6-a3053329e2c2
# using X, using Y... put what packages you need here.

# ╔═╡ 5b6651ce-0e37-11eb-2b5a-c3f876485e83
md"

## a RCT on treating back pain with a drug

our objective is to reproduce the A/B test [here](https://inferentialthinking.com/chapters/12/2/Causality.html#treating-chronic-back-pain-a-randomized-controlled-trial).

> Low-back pain in adults can be very persistent and hard to treat. Common methods run the gamut from corticosteroids to acupuncture. A randomized controlled trial (RCT) examined the effect of using Botulinum Toxin A (BTA) as a treatment. Botulinum toxin is a neurotoxic protein that causes the disease botulism; Wikipedia says that botulinum “is the most acutely lethal toxin known.” There are seven types of botulinum toxin. Botulinum Toxin A is one of the types that can cause disease in humans, but it is also used in medicine to treat various diseases involving the muscles. The RCT analyzed by Foster, Clapp, and Jabbari in 2001 examined it as a treatment for low back pain.

> Thirty one patients with low-back pain were randomized into treatment and control groups, with 15 in the treatment group and 16 in control. The control group was given normal saline, and the trials were run double-blind so that neither doctors nor patients knew which group they were in.

> Eight weeks after the start of the study, nine of the 15 in the treatment group and two of the 16 in the control group had pain relief (according to a precise definition used by the researchers).
"

# ╔═╡ 37030888-af3f-4643-8373-28d91d283bdc
md"🐶 read in the raw data from the trial, [here](https://raw.githubusercontent.com/data-8/textbook/main/assets/data/bta.csv), as a `DataFrame`."

# ╔═╡ 70e96138-7b94-4bf6-b07d-c28072a525f9


# ╔═╡ 3a1ee822-c0a2-4510-b703-d0b5b194c3db


# ╔═╡ 11f17eb2-0e3a-11eb-0f12-9fbbcb70332b
md"
🐶 use the `combine` and `groupby` function to group the patients according to the group to which they were assigned (treatment or control) and compute the fraction of patients within each group that experienced pain relief.

i.e. create a `DataFrame` that looks like:

| Group  |  Fraction with pain relief |
| --- | --- |
| Control | xx |
| Treatment | xx |
"

# ╔═╡ 2b4e1258-0e3a-11eb-3d68-554a7486c259


# ╔═╡ 4814fe24-0e3a-11eb-0ce5-8793afbab239
md"
🐶 to visualize the outcome of the trial, draw a bar plot.
* two bars, one for the control group, the other for the treatment group.
* the height of each bar represents the respective proportion of patients in the group that experienced pain relief
* label your x-axis, y-axis, and x-ticks
* make the two bars two different colors colors
* since proportions lie in $[0,1]$ set the y-axis limits from 0 to 1 to give perspective
"

# ╔═╡ c3c5c224-0e3a-11eb-0150-d96fbd4db956


# ╔═╡ 1f7f9ff4-0e54-11eb-0f1e-7909d4d9461c
md"🐶 to set up an A/B test, formulate a null hypothesis and an alternative hypothesis that pertains to this drug trial. state the hypotheses below.

"

# ╔═╡ 5a362726-0e54-11eb-32c0-cf0e21babba0
md"
_null hypothesis_: ...

_alternative hypothesis_: ...
"

# ╔═╡ 66504e7e-0e54-11eb-2f1e-dd6b1841e2d3
md"
🐶 define an appropriate test statistic that would differ depending on whether the null or alternative hypothesis were true.
"

# ╔═╡ b247bd58-0e54-11eb-1388-eb9db4242ab2
md"
_test statistic_:= ...

"

# ╔═╡ 33101196-eb2c-4690-80f4-cccb9862745d
md"🐶 imagine we are at the beginning of the experiment where we randomly allocate each patient to the control or treatment group.

under the null hypothesis, the outcome of whether or not any given patient experienced pain relief would be the same regardless of the group to which the patient happened to be allocated. thus, we can simulate a repitition of this random allocation _under the null hypothesis_ by randomly permuting the labels in the `\"Group\"` column of the data frame.

simulate one repetition of the trial _under the assumption that the null hypothesis is true_ by randomly permuting the labels in the `\"Group\"` column. assign the permuted labels to be a new column in the data frame, called `\"Sim Group under Null\"`."

# ╔═╡ ed76f990-e893-4ab6-83ed-052967b568de


# ╔═╡ 3eae9a47-ee77-4ecf-94c1-9afc4498a610


# ╔═╡ bd0e1900-0e54-11eb-36b7-1f30224eaf0f
md"🐶 write a function `proportion_w_pain_relief` that takes in three arguments (inputs):
* `data::DataFrame`: the data from the trial (with the additional column you added)
* `group_col::String`: the name of the column in `data` that gives the column indicating the group (we may wish to use `\"Group\"` or `\"Sim Group under Null\"` to compute the test statistic).
* `group::String`: the name of the group we we consider (`\"Control\"` or `\"Treatment\"`)
and returns (outputs) the proportion of patients in the `group` group (according to the labels in the `group_col` column) that experienced pain relief.
"

# ╔═╡ f38c766e-0e56-11eb-3d94-95d4607bb78f


# ╔═╡ f4124710-0e56-11eb-1e43-215ae7cf4b15
md"🐶 test your function `proportion_w_pain_relief` below on the `\"Group\"` column (you computed what the function should return, above)."

# ╔═╡ 186fdb18-0e57-11eb-193f-fbb753faa244


# ╔═╡ 18fd84e0-0e57-11eb-36a6-c72f5f1db6a6


# ╔═╡ 19e4df3e-0e57-11eb-34b1-496c40474b94
md"
🐶 write a function `test_statistic` that takes in two arguments:
* `data::DataFrame` same as above
* `group_col::String` same as above
and returns the test statistic. 

!!! hint
    inside this function, call `proportion_w_pain_relief` twice.
"

# ╔═╡ 6523fe3a-0e57-11eb-08a7-dfc38a3df774


# ╔═╡ a13b76c8-0e57-11eb-07af-770597bed043
md"🐶 use your function `test_statistic` to compute the actual, observed (as opposed to simulated under the null hypothesis, which we will do next) test statistic of the outcome of the trail. assign it as a variable.
"

# ╔═╡ e55a31dc-0e57-11eb-182d-9f02479717d3


# ╔═╡ f72ccbbe-0e58-11eb-143e-09c728ac7abd
md"🐶 _operating under the assumption that the null hypothesis is true_:

(a) simulate 10,000 repetitions of the randomized controlled experiment. keep track of the test statistic observed from each simulation by storing each test statistic in an array.

(b) plot the distribution of the test statistic as a histogram (bin width = 0.1). draw a red, vertical line at the actual test statistic observed in the trail outcome.

(c) compute the p-value associated with our null hypothesis that you obtained from your _permutation test_."

# ╔═╡ 1438de8a-0e59-11eb-2bff-effebb5c898b


# ╔═╡ 4c5d30c2-0e59-11eb-3987-3bc356bb1f66


# ╔═╡ 5b2e1530-0e59-11eb-055a-e38373f7005d


# ╔═╡ 1573d0fc-0e59-11eb-14de-0710879b5f16
md" 🐶 provide an interpretation/explanation of the p-value in this context."

# ╔═╡ 28b13f36-0e59-11eb-215a-6b7f4198ec0b
md"the p-value is ..."

# ╔═╡ 66ca616c-0e59-11eb-30e1-132f15afa55d
md"
🐶 do you reject or accept the null hypothesis?

🐶 what level of significance are you using, and why?

🐶 did you choose a one- or two-sided hypothesis? why? what is the difference? note, there is a convention of which to choose for medical studies, see the data8 textbook...

🐶 since this is a randomized controlled experiment, is the outcome of this A/B test evidence that the drug _caused_ pain relief?

🐶 what if, instead, each patient here had been allowed to _choose_ the control or treatment group? then, would this outcome be evidence that the drug causes pain relief? provide an example confounding variable explaining why not.
"

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
# ╟─8dd3c444-0e36-11eb-1ea4-557fcf1612ff
# ╠═80649d66-5e4a-4a2a-85c6-a3053329e2c2
# ╟─5b6651ce-0e37-11eb-2b5a-c3f876485e83
# ╟─37030888-af3f-4643-8373-28d91d283bdc
# ╠═70e96138-7b94-4bf6-b07d-c28072a525f9
# ╠═3a1ee822-c0a2-4510-b703-d0b5b194c3db
# ╟─11f17eb2-0e3a-11eb-0f12-9fbbcb70332b
# ╠═2b4e1258-0e3a-11eb-3d68-554a7486c259
# ╟─4814fe24-0e3a-11eb-0ce5-8793afbab239
# ╠═c3c5c224-0e3a-11eb-0150-d96fbd4db956
# ╟─1f7f9ff4-0e54-11eb-0f1e-7909d4d9461c
# ╠═5a362726-0e54-11eb-32c0-cf0e21babba0
# ╟─66504e7e-0e54-11eb-2f1e-dd6b1841e2d3
# ╠═b247bd58-0e54-11eb-1388-eb9db4242ab2
# ╟─33101196-eb2c-4690-80f4-cccb9862745d
# ╠═ed76f990-e893-4ab6-83ed-052967b568de
# ╠═3eae9a47-ee77-4ecf-94c1-9afc4498a610
# ╟─bd0e1900-0e54-11eb-36b7-1f30224eaf0f
# ╠═f38c766e-0e56-11eb-3d94-95d4607bb78f
# ╟─f4124710-0e56-11eb-1e43-215ae7cf4b15
# ╠═186fdb18-0e57-11eb-193f-fbb753faa244
# ╠═18fd84e0-0e57-11eb-36a6-c72f5f1db6a6
# ╟─19e4df3e-0e57-11eb-34b1-496c40474b94
# ╠═6523fe3a-0e57-11eb-08a7-dfc38a3df774
# ╟─a13b76c8-0e57-11eb-07af-770597bed043
# ╠═e55a31dc-0e57-11eb-182d-9f02479717d3
# ╟─f72ccbbe-0e58-11eb-143e-09c728ac7abd
# ╠═1438de8a-0e59-11eb-2bff-effebb5c898b
# ╠═4c5d30c2-0e59-11eb-3987-3bc356bb1f66
# ╠═5b2e1530-0e59-11eb-055a-e38373f7005d
# ╟─1573d0fc-0e59-11eb-14de-0710879b5f16
# ╠═28b13f36-0e59-11eb-215a-6b7f4198ec0b
# ╠═66ca616c-0e59-11eb-30e1-132f15afa55d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
