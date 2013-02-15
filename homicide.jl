homicides = readlines(open("./toMunge/homicides.txt"))
homicides = convert(Array{String}, homicides)

map(x -> search(x, r"(|-)\d{2}\.\d{6}"), homicides)

## lat long
latlong <- str_extract_all(homicides, "(|-)\\d{2}\\.\\d{6}")
lat <- as.numeric(sapply(latlong, '[', 1))
long <- as.numeric(sapply(latlong, '[', 2))

nameregex <-  "[[:alpha:]]+([[:space:]]+[[:alpha:]]+[[:punct:]][[:space:]]+[[:alpha:]]+|[[:space:]]+[[:alpha:]]+[[:space:]]+[[:alpha:]]+[[:punct:]]|[[:space:]]+[[:alpha:]]+| [[:alpha:]]+[[:punct:]][[:alpha:]]+|[[:space:]]+[[:alpha:]]+[[:punct:]][[:space:]]+[[:alpha:]]+[[:space:]]+[[:alpha:]]+[[:punct:]])(|</a>)</dt>"
victimname <- str_extract(homicides, nameregex)
victimname <- str_replace(victimname, "<(.*)>", "")

address <- str_extract(homicides, "(N\\.|\\d+) (.*?)<br />")
address <- str_replace(address, "<(.*)>", "")

zipcode <- str_extract(homicides, "Baltimore, MD \\d+")
zipcode <- str_replace(zipcode, "Baltimore, MD ", "")

victimsex <- str_extract(homicides, "(female|male)")

victimrace <- str_extract(homicides, "([Bb]lack|[Ww]hite|[Hh]ispanic|[Aa]sian)")
victimrace <- tolower(victimrace)

victimage <- str_extract(homicides, "\\d+ (years|year) old")
victimage <- as.numeric(str_extract(victimage, "\\d+"))


dateofcrime <- str_extract(homicides, "<dd>[F|f]ound(.*?)</dd>")
dateofcrime <- str_replace_all(dateofcrime, "<dd>[F|f]ound on |</dd>", "")
dateofcrime <- as.Date(dateofcrime, "%B %d, %Y")

placeofcrime <- str_extract(homicides, "<dd>Victim(.*?)</dd>")
placeofcrime <- str_replace_all(placeofcrime, "<dd>Victim died at |</dd>", "")

causeofdeath <- str_extract(homicides, "<dd>Cause(.*?)</dd>")
causeofdeath <- str_replace_all(causeofdeath, "<dd>Cause: |</dd>", "")

link <- str_extract(homicides, "http(.*?)\"")
link <- str_replace_all(link, "\"", "")


result <- data.frame(lat = lat,
                     long = long,
                     victimname = victimname,
                     address = address,
                     zipcode = zipcode,
                     victimrace = victimrace,
                     victimsex = victimsex,
                     victimage = victimage,
                     dateofcrime = dateofcrime,
                     placeofcrime = placeofcrime,
                     causeofdeath = causeofdeath,
                     journallink = link)

### ligne vide
result <- result[-515,]

write.csv(result, "Munged/homicide.csv", row.names = FALSE)
homicides[455]
