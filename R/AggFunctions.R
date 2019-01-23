##################################################
############ Aggregation functions  ##############
############  by Jared Looper       ##############
############  & edited by Kate Kim  ##############
############     Jan. 2019           ##############
##################################################

#' Creating a query block of countries
#' @description This function returns the list of countries a user specifies
#' @return A list of country query blocks
#' @importFrom countrycode countrycode
#' @export
#' @param table_name a name of a data table a user specifies. Your input is NOT
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
    if(table_name == "icews"|| table_name== 'cline_phoenix_swb' || table_name=="cline_phoenix_nyt"|| table_name=='cline_phoenix_fbis')
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

#' Creating of a query block of a time range
#' @description This function returns the time range a user specifies in the funtion
#' @return A list of dates for start and end of a time range
#' @export
#' @param table_name A name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param start The "YYYYMMDD" format of the first date of a data set
#' @param end The "YYYYMMDD" format of the last date of a data set
#' @examples # to create the time ragne between Nov. 2, 2017 and
#' # Nov. 4, 2017 for data aggretation
#' t <- returnTimes("phoenix_rt", "20171102","20171104")
returnTimes <- function(table_name =" ", start = " ", end = " ") {

  if(table_name == "icews" || table_name== 'cline_phoenix_swb' || table_name=="cline_phoenix_nyt"|| table_name=='cline_phoenix_fbis') {
    start = paste(substr(start,1,4),"-",substr(start,5,6),"-",substr(start,7,8),sep="")
    end = paste(substr(end,1,4),"-",substr(end,5,6),"-",substr(end,7,8),sep="")
  }
  if(substr(table_name,1,5)=="cline") {
    start = paste(substr(start,1,4),"/",substr(start,5,6),"/",substr(start,7,8),sep="")
    end = paste(substr(end,1,4),"/",substr(end,5,6),"/",substr(end,7,8),sep="")
  }
  return(list('<date>'=list('$gte'=start,'$lte'=end)))
}

#' Creating a list of the dayd countries of source and target actors
#' @description This function returns a vector of query syntax for a dayd information
#' @return A list of the queary syntax of source and target countries
#' @export
#' @importFrom countrycode countrycode
#' @param table_name a name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param soure The name of a source country either an ISO code or a country name
#' @param target The name of a target country either an ISO code or a country name
#' @examples  # When you have a dyad query of Syria as a source and the United State as a target
#' dyad <- returnDayd("pheonix_rt", "SYR", "USA")
returnDyad <- function(table_name, source, target) {
  ISO = TRUE

  if(nchar(source) != 3 || nchar(target) != 3) {
    ISO = FALSE
    country[[i]] = gsub("(?<=^| )([a-z])", "\\U\\1", tolower(country[[i]]), perl = T)
    break
  }

  if(ISO == TRUE) {
    if(table_name == "icews") {
      source = countrycode::countrycode(source,"iso3c", "country.name")
      target = countrycode::countrycode(target,"iso3c", "country.name")
    }
  }
  else {
    if(table_name != "icews"|| table_name== 'cline_phoenix_swb' || table_name=="cline_phoenix_nyt"|| table_name=='cline_phoenix_fbis') {
      source = countrycode::countrycode(source, "country.name", "iso3c")
      target = countrycode::countrycode(target,"country.name", "iso3c")
    }
  }
  query = list('<src_actor>'=list('$in'=list(source)),'<tgt_actor>'=list('$in'=list(target)))
  return(query)
}

#' Creating the location query block of longitudes and lattidues
#' @description This function returns a block of query syntax for geo-locations
#' @return A list of queary syntax of latidues and longitudes
#' @export
#' @param lat1 the minimum value of lattitude of a target boundary
#' @param lat2 the maximum value of latitidue of a target boundary
#' @param log1 the minimum value of longitude of a target boundary
#' @param log2 the maximum value of longitude of a target boundary
#' @examples q <- returnLatLon(-80,30,20,80)
returnLatLon <- function(lat1, lat2, lon1, lon2) {
  return(list('<latitude>'=list('$gte'=lat1,'$lte'=lat2),'<longitude>'=list('$gte'=lon1,'$lte'=lon2)))
}

#' Obtaining a list of query that use the variables in a particular data table
#' @description This function retuns general query syntax for sepcfied data table
#' @return A list of the query block with variable's features
#' @export
#' @param api_key An API key provided by a UTD server manager
#' @param table_name A name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param pattern A pattern or feature of a specified variable
#' @param field A field (variable) of a data table
#' @examples # when a user wants to get all source actors related to governments in ICEWS
#' f <- returnRegExp( k, "icews","GOV","Source Name")
#'
returnRegExp <- function(api_key = "", table_name = "", pattern = "", field = "") {
  f = paste(" ",field,sep='')
  if(is.element(f,tableVar(api_key,table_name))) {
    query = list('field'= list('$regex' = pattern))
    return(setNames(query,field))
  }
}

#' Obtaining an OR syntax to use two and more query lists
#' @description This function retuns the syntax to combine several query lists
#' @return A list of several query blocks corresponding to a particular data table
#' @export
#' @param query_prep A list of other query blocks that should be entered in `list()`
#' @examples # If you want to combine stored query blocks such as q or f,
#' or_query <- orList(list(q,f))
#'
orList <- function(query_prep = list()) {
  return(list('$or'=query_prep))
}

#' Obtaining an AND query syntax to use two and more query blocks
#' @description This function retuns the list of comination two or more query blocks.
#' @return A list of several query blocks corresponding to a particular data table
#' @export
#' @param query_prep A list of other query blocks that should be entered in `list()`
#' @examples # If you want to subset with two or more stored query blocks such as q or f
#' and_query <- andList(list(q,f))
#'
andList <- function(query_prep = list()) {
  return(list('$and'=query_prep))
}

#' Sending queries to the API server in order to retrieve the data set
#' @description This function retruns the data a user requests by a composition of query blocks
#' @return A list of data and citation texts
#' @importFrom jsonlite fromJSON
#' @importFrom rjson toJSON
#' @export
#' @param api_key An API key provided by a server manager at UTD
#' @param table_name A name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param query A list of query blocks a user builds with other query block functions
#' If you enter `query = "entire"`, then the entire data will be returned.
#' Please note the size of the data you request. It may cause a memory issue on your device.
#' @param citation The option for printing a package citation at the end of data retrival. The default of option is TRUE.
#' @examples sendQuery(api_key,"icews", query_block, citation = FALSE)
#' # To retrieve the entire data of phoenix_rt
#' data <- sendQuery(api_key, "phoenix_rt", "entire", citation = FALSE)
sendQuery <- function(api_key = "", table_name = "", query = list(), citation = TRUE){
  if(is.null(query)) {
    print("The query is empty.")
    return(list())
  }
  else if (query == 'entire'){
    query_string = '{}'
  }
  else {
  query_string = rjson::toJSON(query)
  query_string = gsub("\\", '', query_string, fixed=TRUE)
  }
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
#' @return A data size in bytes
#' @importFrom rjson toJSON
#' @export
#' @param api_key An API key provided by a server manager at UTD
#' @param table_name A name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param query A list of query blocks a user builds with other query block functions
#' If you enter `query = "entire"`, then the size of the entire data will be returned.
#' @examples getQuerySize(api_key,"Phoenix_rt", query_blocks)
#' # To get the size of entire data of ICEWS
#' getQuerySize(api_key, "icews", "entire")
getQuerySize <- function(api_key = "", table_name = "", query = list()) {
  if(is.null(query)) {
    print("The query is empty.")
    return(list())
  }
  else if (query == 'entire'){
    query_string = '{}'
  }
  else {
    query_string = rjson::toJSON(query)
    query_string = gsub("\\", '', query_string, fixed=TRUE)
  }
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
