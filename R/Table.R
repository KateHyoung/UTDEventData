#' A Reference class for applying an API key to all data extracting functions.
#'@description  Once a referece class is set, a user does not need to go through an API key
#'to call searching functions
#'@export Table
#'@import methods
#'@field api_key An API key from the developer at UTD
#'@examples >obj<-Table$new() for creating an object
#'>obj$setAPIKey("....")
#'>obj$DataTable()
#'@method pullData(), DataTables()
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
                         url <- 'http://149.165.156.33:5002/api/data?api_key='
                         url_submit = ''
                         table_name = tolower(table_name)
                         if (table_name=="phoenix_rt" || table_name=='cline_phoenix_swb' || table_name=="cline_phoenix_nyt"|| table_name=='cline_phoenix_fbis') {
                           query_string = relabel(query_string, "phoenix_api")
                         }
                         else if (table_name == "icews") {
                           query_string = relabel(query_string, "icews_local")

                         }
                         else {
                           print("Not available now")
                           return(query_string)
                         }
                         # getting data from url formatting
                         url_submit = paste(url_submit,url, api_key,'&query=', query_string, sep='','&datasource=',table_name)
                         url_submit = gsub('"',"%22",url_submit, fixed=TRUE)
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
                       },
                       # searching for a variable list in a data table
                       tableVar = function(table='table_name',lword=' ')
                       {# transfroming a string to lower cases
                         tb=tolower(table)

                         url = 'http://149.165.156.33:5002/api/fields?datasource='

                         # searching variables in different data tables
                         if (tb=='phoenix_rt' || tb=='icews' || tb=='cline_phoenix_swb' || tb=='cline_phoenix_fbis' || tb=='cline_phoenix_nyt'){

                           url_submit = paste(url,tb,'&api_key=',api_key,sep='')

                           # getting variable names
                           VarList <- readLines(url_submit, warn=FALSE)
                           List<-gsub(".*\\[(.*)\\].*", "\\1", VarList)
                           List<-gsub("u'", "", List);List<-gsub("'","",List)
                           varList<-strsplit(List, ",")[[1]]

                           # looking up a word of variables
                           if (!is.null(lword)){ w<- grep(lword, varList, ignore.case = TRUE)
                           return(varList[w])}

                           else(varList)

                          }
                         else{print('Please check the table name!')
                           return(list())}



                       }
                     ))
