##################################################
############ Aggregation functions  ##############
############  by Jared Looper       ##############
############  & edited by Kate Kim  ##############
############     Jan. 2019           ##############
##################################################

#' Creating a query block of countries before applying the query block to `sendQuery()`
#' @description This function returns the list of countries a user specifies
#' @return A list of country query blocks
#' @importFrom countrycode countrycode
#' @export
#' @param table_name A name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param country A list of countries. We recommend to use the \href{https://unstats.un.org/unsd/tradekb/knowledgebase/country-code}{ISO ALPHA-3 Code} format, but
#' the full country name is also working in this function.\cr
#'      e.g. either \code{list("USA","CAN")} or \code{list("United States", "Canada")} are working and not case-sensitive.
#' @examples # to have a query block of the United States and Canada as a country restraint
#' ctr <- returnCounries("phoenix_rt", list("USA","CAN"))
returnCountries <- function(table_name =" ", country = list()) {

  # convert the strings to an appropriate format given the database
  ISO = TRUE

  for(i in 1:length(country))
    if(nchar(country[i]) != 3) {
      ISO = FALSE
      country[[i]] = gsub("(?<=^| )([a-z])", "\\U\\1", tolower(country[[i]]), perl = T)
      break
    }

  if(ISO == TRUE) {
    if(table_name == "icews")
      for(i in 1:length(country))
        country[[i]] = countrycode::countrycode(country[[i]],"iso3c", "country.name")
  }
  else {
    if(table_name != "icews")
      for(i in 1:length(country))
        country[[i]] = countrycode::countrycode(country[[i]],"country.name", "iso3c")
  }
  #set up the query
  query <- list('<country_code>'= list('$in' = country))
  return(query)
}

#' Creating of a query block of a time range before applying the query to `sendQuery()`
#' @description This function returns the list of a time range a user specifies
#' @return A list of dates for start and end of a time range
#' @export
#' @param table_name A name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param start The "YYYYMMDD" format of the first date of a data set
#' @param end The "YYYYMMDD" format of the last date of a data set
#' @examples \donotrun{# to create the time ragne between Nov. 2, 2017 and
#' # Nov. 4, 2017 for the subset of real-time Phoenix data
#' t <- returnTimes("phoenix_rt", "20171102","20171104")}
returnTimes <- function(table_name =" ", start = " ", end = " ") {

  table_name = tolower(table_name)

  if(table_name == "icews" || table_name== 'cline_phoenix_swb' || table_name=="cline_phoenix_nyt"|| table_name=='cline_phoenix_fbis') {
    start = paste(substr(start,1,4),"-",substr(start,5,6),"-",substr(start,7,8),sep="")
    end = paste(substr(end,1,4),"-",substr(end,5,6),"-",substr(end,7,8),sep="")
  }
  if(substr(table_name,1,5)=="cline") {
    start = gsub("-", "/", start)
    end = gsub("-", "/", end)
  }
  return(list('<date>'=list('$gte'=start,'$lte'=end)))
}

#' Building a list of the dayd query block as source and target actors respectively
#' @description This function returns a list of a query block of a source-target country dyad
#' @return A list of the queary block of source and target countries
#' @export
#' @importFrom countrycode countrycode
#' @param table_name A name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param soure The name of a source country either an ISO code or a country name format
#' @param target The name of a target country either an ISO code or a country name format
#' @note Please use the consistent format for source and target countries such as `"USA", "CAN"`` or `"Uniated States", "Canada"`
#' @examples  \dontrun{# building a dyad query of Syria as a source and the United State as a target
#' dyad <- returnDayd("pheonix_rt", "SYR", "USA")}
returnDyad <- function(table_name, source, target) {
  ISO = TRUE
  table_name = tolower(table_name)

  if(nchar(source) != 3 || nchar(target) != 3) {
    ISO = FALSE
    source = tolower(source)
    target = tolower(target)
  }

  if(ISO == TRUE) {
    if(table_name == "icews") {
      source = countrycode::countrycode(source,"iso3c", "country.name")
      target = countrycode::countrycode(target,"iso3c", "country.name")
    }
  }
  else {
    if(table_name == "phoenix_rt"|| table_name== 'cline_phoenix_swb' || table_name=="cline_phoenix_nyt"|| table_name=='cline_phoenix_fbis') {
      source = countrycode::countrycode(source, "country.name", "iso3c")
      target = countrycode::countrycode(target,"country.name", "iso3c")
    }
  }
  query = list('<src_actor>'=list('$in'=list(source)),'<tgt_actor>'=list('$in'=list(target)))
  return(query)
}

#' Creating the location query block with the longitudes and lattidues
#' @description This function returns a list of a query block of geo-locations
#' @return A list of geo-location query blocks
#' @export
#' @param lat1 the minimum value of lattitude of a event boundary
#' @param lat2 the maximum value of latitidue of a event boundary
#' @param log1 the minimum value of longitude of a event boundary
#' @param log2 the maximum value of longitude of a event boundary
#' @examples \dontrun{# to build the location constraint with the ranges of latitudes the longitudes
#' geo <- returnLatLon(-10,30,40,70)}
returnLatLon <- function(lat1, lat2, lon1, lon2) {
  return(list('<latitude>'=list('$gte'=lat1,'$lte'=lat2),'<longitude>'=list('$gte'=lon1,'$lte'=lon2)))
}

#' Building a query block that indicating a certain pattern of the variables in a particular data table
#' @description This function retuns a query block to indicate the certain pattern of a variable
#' @return A list of the query block of a certain pattern of a particular variable in a data table
#' @export
#' @param api_key An API key provided by a UTD server manager
#' @param table_name A name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param pattern A pattern or a feature of a specified variable
#' @param field A field (variable) of a data table
#' @note Please use this function only with the field that is not used in the other query block function.
#' For instance; if you subset the data with a certain country, use the function, `returnCountries()`.
#' @examples \dontrun{# to get all source actors related to governments in ICEWS
#' reg <- returnRegExp(api_key, "icews","GOV","Source Name")
#' # to subset the cline_phoenix_nyt data by year == 2001
# nytQuery <- returnRegExp(api_key, 'cline_phoenix_nyt', '2001', 'year')
#' myNYTdata <- sendQuery(api_key, 'cline_phoenix_nyt', nytQuery, citation = F)}
returnRegExp <- function(api_key = "", table_name = "", pattern = "", field = "") {
  f = paste(" ",field,sep='')
  if(is.element(f, tableVar(api_key, table_name))) {
    query = list('field'= list('$regex' = pattern))
    return(setNames(query,field))
  }
  else {print("Please check the field and the pattern with tableVar()")}
}

#' Obtaining an OR query to use two and more query blocks
#' @description This function retuns  the list of comination two or more query blocks.
#' @return A list of several query blocks corresponding to a particular data table
#' @export
#' @param query_prep A list of query blocks that should be entered in the `list()` format
#' @note Please make sure that specifying the same data table in all query block functions to avoid errors \cr
#' This query may build a large data set that could cause the data size issue in a Windows machine.
#' @examples \dontrun{# to subset real-time data with the constraint of a time range and a dyad
#' t <- returnTimes("phoenix_rt", "20171015", "20171215")
#' dyad <- returnDyad('Phoexnix_rt', 'RUS', 'SYR')
#' # building an OR-query of a certain time and the country dyad
#' or_query <- orList(list(t,dyad)) # it requires a large memory size to retrieve the data set}
orList <- function(query_prep = list()) {
  return(list('$or'=query_prep))
}

#' Obtaining an AND query syntax to use two and more query blocks
#' @description This function retuns the list of comination two or more query blocks.
#' @return A list of several query blocks corresponding to a particular data table
#' @export
#' @param query_prep A list of query blocks that should be entered in `the list()` format
#' @note Please make sure that specifying the same data table in all query block functions to avoid errors
#' @examples \dontrun{# to subset real-time data with the constraint of a time range and a dyad
#' t <- returnTimes("phoenix_rt", "20171015", "20171215")
#' dyad <- returnDyad('Phoexnix_rt', 'RUS', 'SYR')
#' # building an AND-query of a certain time and the country dyad
#' and_query <- andList(list(t,dyad))}
andList <- function(query_prep = list()) {
  return(list('$and'=query_prep))
}

#' Sending queries to the API server in order to retrieve the data set
#' @description This function retruns the data and the package citation a user requests
#' @return A list with components
#'     \itemize{
#'          \item{}{\code{$data    }   a data frame of requested data. An attribute of the data can be formatted as data.frame. Please check the features of data if it's necessary}
#'          \item{}{\code{$citation}   a text of the package citation}
#'           }
#' @importFrom jsonlite fromJSON
#' @importFrom rjson toJSON
#' @export
#' @param api_key An API key provided by a server manager at UTD
#' @param table_name A name of a data table a user specifies. Your input is NOT case-sensitive.
#' @param query A list of query blocks or a single query block a user builds with the other query functions.
#' @note If an error message is returned, please increase the memory size your R is allocated. This error is more
#' frequently occurred in a Windows machine.
#' @param citation The option for printing a package citation at the end of data retrival. The default of option is TRUE.
#' @examples \dontrun{ # to store the ICEWS subset in the vector of myData without the citation
#' # query_block means the list of queries created from other functions such as `returnDyad()` or `returnTimes()`
#' myData <- sendQuery(api_key,"icews", query_block, citation = FALSE)}
sendQuery <- function(api_key = "", table_name = "", query = list(), citation = TRUE){
  if(is.null(query)) {
    print("The query is empty.")
    return(list())
  }
  query_string = rjson::toJSON(query)
  query_string = gsub("\\", '', query_string, fixed=TRUE)
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
  url_submit = paste(url_submit,url, api_key,'&query=', query_string, sep='','&datasource=',table_name)
  url_submit = gsub('"',"%22",url_submit, fixed=TRUE)
  url_submit = gsub(' ',"%20",url_submit, fixed=TRUE)
  print(url_submit)
  # Apply tryCatch for large data
  tryCatch({
    retrieved_data <- readLines(url_submit, warn=FALSE)},
    error = function(e){
      message("Error. Consider to increase your memory limit of R. Use getQuerySize() to see the data size estimated.")
      message(e)}
  )
  # end tryCatch
  parsed_data <- jsonlite::fromJSON(retrieved_data)$data

  # package citation
  if (citation) {
    return(list(data=parsed_data, citation=citation("UTDEventData")))
  }

  else {
    return(parsed_data)
  }
}

#' Estimating a size of data a user requests to the API server
#' @description This function retruns a data size in a string format
#' @return A text of the data size in bytes
#' @importFrom rjson toJSON
#' @export
#' @param api_key An API key provided by a server manager at UTD
#' @param table_name A name of a data table a user specifies. Your input is NOT case-sensitive.
#' @param query A list of query blocks a user builds with other query block functions
#' @examples \dontrun{ # to measure the size of the query blocks builded with the other functions
#' getQuerySize(api_key,"Phoenix_rt", query_blocks)}
getQuerySize <- function(api_key = "", table_name = "", query = list()) {
  if(is.null(query)) {
    print("The query is empty.")
    return(list())
  }
  query_string = rjson::toJSON(query)
  query_string = gsub("\\", '', query_string, fixed=TRUE)
  url <- 'http://149.165.156.33:5002/api/data?size_only=True&api_key='
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
  url_submit = paste(url_submit,url, api_key,'&query=', query_string, sep='','&datasource=',table_name)
  url_submit = gsub('"',"%22",url_submit, fixed=TRUE)
  url_submit = gsub(' ',"%20",url_submit, fixed=TRUE)
  print(url_submit)
  size = readLines(url_submit, warn=FALSE)
  size = unlist(strsplit(size, split = ':', fixed=TRUE))[2]
  size = gsub('}', "", size)
  cat("Its size is:", size, "bytes")
}
