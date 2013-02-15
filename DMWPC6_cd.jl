### Data Cleaning
unmunged = readlines(open("toMunge/DMWPC6_cd.txt"))
unmunged = convert(Array{ASCIIString, 1}, unmunged)
unmunged = ["%%\r\n", unmunged, "%%\r\n"]
unmungedlist = split(join(unmunged, "@"), "%%\r\n")[2:end - 1]
unmungedlist = map(x -> split(x, "@"), unmungedlist)
unmungedlist = map(x -> x[2:end - 1], unmungedlist)
unmungedlist = map(y -> map(x -> replace(x, "\r\n", ""), y), unmungedlist)
varname = unique(map(y -> map(x -> x[1], map(x -> split(x, ":"), y)), unmungedlist))
varname = reduce(hcat, varname)
value = map(y -> map(x -> x[2], map(x -> split(x, ": "), y)), unmungedlist)
value = reduce(hcat, value)'


import DataFrames
using DataFrames
dat = DataFrame(value, varname)
size(dat)

DataFrames.csvDataFrame("./Munged/DMWPC6_cd.csv", value)
### writecsv("./Munged/DMWPC6_cd.csv", dat)

describe(dat)
dat[["Name", "Year"]]
ref(dat, 1:3, 2)
names(dat)
rbind(dat, dat)
hcat(dat, dat)
