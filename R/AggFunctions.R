##################################################
############ Aggregation functions  ##############
############  by Jared Looper       ##############
############  & edited by Kate Kim  ##############
############     May 2018           ##############
##################################################
#'
#' Creating a vector of countries names for the data aggretaion.
#' @description This function returns the list of countries a user specifies
#' @return A list of countries
#' @importFrom countrycode countrycode
#' @export
#' @param table_name a name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param country List of countries. We recommend to use the \href{https://unstats.un.org/unsd/tradekb/knowledgebase/country-code}{ISO ALPHA-3 Code} format, but
#' the full country name is also working in this function.\cr
#'      e.g. either \code{list("USA","CAN")} or \code{list("United States", "Canada")} are working and not case-sensitive.
#' @examples # When you have a query of the United States and Canada as a country restraint
#' ctr <- returnCounries("phoenix_rt", list("USA","CAN"))
returnCountries <- function(table_name="", country = list()) {

  #convert the strings to an appropriate format given the database
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

#' Setting a time range for data aggretations
#' @description This function returns the time range a user specifies in the funtion
#' @return A vector of a time range
#' @export
#' @param table_name a name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param start The "YYYYMMDD" format of the first date of a data set.
#' @param end The "YYYYMMDD" format of the end date of a data set.
#' @examples When creating the time ragne between Nov. 2, 2017 and Nov. 4, 2017 for data aggretation
#' t <- returnTimes("pheonix_rt", "20171102","20171104")
returnTimes <- function(table_name, start, end) {

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
#' @return A queary syntax of source and target countries
#' @export
#' @importFrom countrycode countrycode
#' @param table_name a name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param soure The name of a source country either an ISO code or a country name
#' @param target The name of a target country either an ISO code or a country name
#' @examples  When you have a dyad query of Syria and the United State
#' dyad <- returnDayd("pheonix_rt", "SYR", "USA")
returnDyad <- function(table_name,source,target) {
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

#' Creating the location boundaries with longitudes and lattidues
#' @description This function returns a vector of query syntax for geo-locations
#' @return A vector of queary syntax of latidues and longitudes
#' @export
#' @param lat1 the minimum value of lattitude of a target boundary
#' @param lat2 the maximum value of latitidue of a target boundary
#' @param log1 the minimum value of longitude of a target boundary
#' @param log2 the maximum value of longitude of a target boundary
#' @examples q <- returnLatLon(-80,30,20,80)
returnLatLon <- function(lat1, lat2, lon1, lon2) {
  return(list('<latitude>'=list('$gte'=lat1,'$lte'=lat2),'<longitude>'=list('$gte'=lon1,'$lte'=lon2)))
}

#' Obtaining a regular expression for API queries based on a specified data table
#' @description This function retuns general query syntax for sepcfied data table
#' @return JSON query syntax
#' @export
#' @param api_key An API key provided by a UTD server manager
#' @param table_name A name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param pattern A pattern of an actor in events
#' @param field A field of a data table
#' @examples # when a user wants to get all source actors related to governments
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
#' @return Or query syntax
#' @export
#' @param query_prep A list of other queris stored
#' @examples # If you want to combine stored query blocks such as q or f,
#' and_query <- andList(list(q,f))
#'
orList <- function(query_prep = list()) {
  return(list('$or'=query_prep))
}

#' Obtaining an AND syntax to use two and more query lists
#' @description This function retuns the syntax to combine several query lists
#' @return AND query syntax
#' @export
#' @param query_prep A list of other queris stored
#' @examples # If you want to subset with two or more stored query blocks such as q or f,
#' or_query <- orList(list(q,f))
#'
andList <- function(query_prep = list()) {
  return(list('$and'=query_prep))
}

#' Sending queries to the API server
#' @description This function retruns the data a user requests by a query compositions of
#' aggretation functions
#' @return A data set with the R-package citation
#' @importFrom jsonlite fromJSON
#' @importFrom rjson toJSON
#' @export
#' @param api_key An API key provided by a server manager at UTD
#' @param table_name A name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @param query List of queries a user builds with othter aggretation functions.
#' The defualt is TRUE, and you can trun it off by adding FALSE in the option.
#' @param citation The option for printing a package citation at the end of data retrival.
#' @examples sendQuery(api_key,"icews",and_query)
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
      message("Error. Consider to increae memory limits. Use getQuerySize() to see the data size estimate.")
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
#' @param query List of queries a user builds with othter aggretation functions.
#' @examples getQuerysize(api_key,"Phoenix_rt", query_list)
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
  query_string = relabel(query_string,table_name)
  url_submit = paste(url_submit,url, api_key,'&query=', query_string, sep='','&datasource=',table_name)
  url_submit = gsub('"',"%22",url_submit, fixed=TRUE)
  url_submit = gsub(' ',"%20",url_submit, fixed=TRUE)
  print(url_submit)
  size = readLines(url_submit, warn=FALSE)
  size = unlist(strsplit(size, split = ':', fixed=TRUE))[2]
  size = gsub('}', "", size)
  cat("Its size is:", size, "bytes")
}
