# Research Questions 

## Window Functions vs GROUP BY:

|GROUP BY|Window Functions|
|:----|:----|
|`Reduces` the **granularity** of the result|Do `NOT` reduce **granularity**|
|It collapses multiple rows into **one row** per group|They perform calculations across rows but **keep** every original row|
|The number of rows in the output becomes `smaller`|The number of rows stays `the same`|

>**GROUP BY** changes the level of detail by aggregating rows into groups,
while **window functions** preserve the original row-level granularity and add calculations alongside it.