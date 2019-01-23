#' A reference class to apply a given API key to extracting functions in this package
#'
#'@description  Once a referece class is set, a user does not need to repeatedly put an API key into a function.
#'An API key can be obtained after filling out the form in the UTD event data sign-up website (\url{http://eventdata.utdallas.edu/signup}).
#'Please follow the direction in the \href{http://149.165.156.33:5002/signup}{UTD sign-up webpage}.
#'@name Table
#'@field api_key An API key obtained from the \href{http://149.165.156.33:5002/signup}{UTD sign-up webpage}
#'@export Table
#'@exportClass Table
#'@examples # Creating an object
#'obj<-Table$new()
#'
#'# Setting an object of an API key
#'obj$setAPIKey("....")
#'
#'# Once the object of an API is set, a user no need to repeat typing an API key to use the subsetting functions
#'obj$DataTable()  # returns the available data tables in the UTD server
#'
#'# when a user wants to subset real-time data ('phoenix_rt) from 20171101 to 20171102 on MEX(Mexico)
#'obj$pullData("Phoenix_rt", list("MEX"),start="20171101", end="20171102")

Table <- setRefClass("Table",
                     fields = list (api_key = "character"),
                     methods = list(
                       setAPIKey = function(key) {
                         api_key <<- key
                       },
                       pullData = function(table_name, country, start, end) {
                         "This is the main function to extract subdata from
                         the UTD Event data server by country names and time ranges.
                         \\subsection{Parameters}{\\itemize{
                         \\item{\\code{table_name} a name of data table.}
                         \\item{\\code{country} a list of countires with the ISO code format or full names.}
                         \\item{\\code{start} a string format of yyyymmdd as a starting date of a data set}
                         \\item{\\code{end} a string format of yyymmdd as an end date of a data set}
                         }}
                         \\subsection{Return Value}{real-time data or subseted data}"
                         ISO = TRUE

                         for(i in 1:length(country))
                           if(nchar(country[i]) != 3) {
                             ISO = FALSE
                             country[[i]] = gsub("(?<=^| )([a-z])", "\\U\\1", tolower(country[[i]]), perl = T)
                             break
                           }

                         if(ISO == TRUE) {
                           if(table_name == "icews"| table_name== 'cline_phoenix_swb' | table_name=="cline_phoenix_nyt"| table_name=='cline_phoenix_fbis')
                             for(i in 1:length(country))
                               country[[i]] = countrycode::countrycode(country[[i]],"iso3c", "country.name")
                         }

                         else {
                           if(table_name != "icews")
                             for(i in 1:length(country))
                               country[[i]] = countrycode::countrycode(country[[i]],"country.name", "iso3c")
                         }

                         if(table_name == "icews") {
                           start = paste(substr(start,1,4),"-",substr(start,5,6),"-",substr(start,7,8),sep="")
                           end = paste(substr(end,1,4),"-",substr(end,5,6),"-",substr(end,7,8),sep="")
                         }

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
                         if (table_name=="phoenix_rt" ) {
                           query_string = relabel(query_string, "phoenix_rt")
                         }
                         else if (table_name== 'cline_phoenix_swb' || table_name=="cline_phoenix_nyt"|| table_name=='cline_phoenix_fbis'){
                           query_string = relabel(query_string, "cline")
                         }
                         else if(table_name == "icews") {
                           query_string = relabel(query_string, "icews")
                         }
                         # getting data from url formatting
                         url_submit = paste(url_submit,url, api_key,'&query=', query_string, sep='','&datasource=',table_name)
                         url_submit = gsub('"',"%22",url_submit, fixed=TRUE)
                         url_submit = gsub(' ',"%20",url_submit, fixed=TRUE)
                         retrieved_data <- readLines(url_submit, warn=FALSE)
                         parsed_data <- jsonlite::fromJSON(retrieved_data)$data
                         return(parsed_data)
                       },
                       # Searching for other data tables
                       DataTables=function (  )
                       {
                         "This function returns the names of data tables.
                         \\subsection{Return Value}{a list of a data table}"
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
                       {
                         "This function returns the variable list a spcified data set.
                         \\subsection{Parameters}{\\itemize{
                         \\item{\\code{table} data table name a user wants.}
                         \\item{\\code{lword} a look-up word of variable names.}
                         }}
                         \\subsection{Return Value}{a list of variables in a data table}"

                         # transfroming a string to lower cases
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
