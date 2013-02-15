unmunged = readlines(open("./toMunge/wrangler_crimedat.txt"))
unmunged = convert(Array{String}, unmunged)

### empty line starting with ","
bool = map(x -> ismatch(r"^\,|^\n", x), unmunged)
unmunged = map(x -> replace(x, "\n", ""), unmunged[!bool])

### extract City name
unmunged = map(x -> replace(x, r"^Reported crime in ", ""), unmunged)

### find cities namey
state = unmunged[map(x -> search(x, r"^[A-Za-z]"), unmunged) .!= (0, 0)]
state = map(x -> replace(x, r",", ""), state)

unmunged = unmunged[map(x -> search(x, r"^[A-Za-z]"), unmunged) .== (0, 0)]


### number of repetition for each cities name (repeat it )
## number of repetition length(unmunged) / length(state)
state = vcat(state, state, state, state, state)

unmunged = [strcat(unmunged[i], ",", state[i]) for i in 1:length(unmunged)]

writecsv("./Munged/wrangler_crimedat.csv", unmunged)









