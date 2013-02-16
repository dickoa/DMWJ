homicides = readlines(open("./toMunge/homicides.txt"))
homicides = convert(Array{String}, homicides)

map(x -> search(x, r"(|-)\d{2}\.\d{6}"), homicides)

### TO BE DONE
