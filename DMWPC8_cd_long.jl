### DMWP
unmunged = readlines(open("toMunge/DMWPC8_cd_long.txt"))
unmunged = map(x -> replace(x, "\r\n", ""), unmunged) | x -> convert(Array{String}, x)
## skip the 3 first line and last line ( metadata )
unmunged = unmunged[4:end-2]

## take the header
names = split(unmunged[1])

### each field length
ncharlist = map(length, names)

### without the header
unmunged = unmunged[2:end]
## remove empty line
unmunged = unmunged[map(y -> length(y) > 0, unmunged)]

## remove lines with "-------"
unmunged = unmunged[!(map(y -> ismatch(r"^\-", y), unmunged) | x -> convert(Array{Bool}, x))]
CD = unmunged[!(map(y -> ismatch(r"^\+", y), unmunged) | x -> convert(Array{Bool}, x))]
newtrack = unmunged[(map(y -> ismatch(r"^\+", y), unmunged) | x -> convert(Array{Bool}, x))]
newtrack = map(x -> replace(x, "\+", ""), newtrack)

resultclean = map(x -> split(x, "  "), CD)
ind = map(x -> map(str -> length(str) > 0, x), resultclean)
resultclean = [resultclean[i][ind[i]] for i in 1:length(resultclean)]

import DataFrames
using DataFrames

othertrack = reduce(hcat, resultclean)'
othertrack = map(strip, othertrack)

res = reduce(vcat, [vcat(othertrack[x,:], othertrack[x,:]) for x in 1:size(othertrack)[1]])
res = hcat(res, newtrack)

### save data
writecsv("./Munged/DMWPC8_cd_long.csv", res)








