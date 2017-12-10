#' A Reference class for applying an API key to all data extracting functions.
#'@export Table
#'@field a string of the API key from the developer at UTD
#'@method pullData( ) R functions in the UTDEventData package for
#'subsetting the real-time data
Table <- setRefClass("Table",
                     fields = list (api_key = "character"),
                     methods = list(
                       setAPIKey = function(key) {
                         api_key <<- key
                       },
                       pullData = function(table_name, country, start, end) {
                         country_constraint = list('<country_code>'= list('$in'= country))

                         date_constraint = list('<date>'=list('$gte'=start,'$lte'=end))

                         all_constraints = list(country_constraint, date_constraint)
                         query = list('$and'=all_constraints)
                         # Convert the data structure into a string
                         # The gsub removes the backslashes, but they get visually re-added when printing to console
                         query_string = gsub("\\", '', rjson::toJSON(query), fixed=TRUE)
                         if (table_name=="Phoenix") {
                           query_string = relabel(query_string, "phoenix_api")

                           # Request data from API
                           url <- 'http://149.165.156.33:5002/api/data?api_key='
                           url_submit <- paste(url, api_key,'&query=', query_string, sep='')
                         }
                         else if (table_name == "ICEWS") {
                           query_string = relabel(query_string, "icews_local")

                           # Request data from API
                           url <- 'http://149.165.156.33:5002/api/data?api_key='
                           url_submit <- paste(url, api_key,'&query=', query_string, sep='')
                         }
                         else {
                           print("Not available now")
                           return(query_string)
                         }

                         # getting data from url formatting
                         retrieved_data <- readLines(url_submit, warn=FALSE)
                         parsed_data <- jsonlite::fromJSON(retrieved_data)$data
                         return(parsed_data)
                       },
                       # Searching for other data tables
                       DataTables=function (  )
                       {
                         # constructing a url
                         url = 'http://149.165.156.33:5002/api/datasources?api_key='
                         url_submit = paste(url,api_key,sep='')
                         # getting table names
                         TableList <- readLines(url_submit, warn=FALSE)
                         List<-gsub(".*\\[(.*)\\].*", "\\1", TableList)
                         List<-toupper(List)
                         return(List)
                       }
                     ))


