##################################################
############ Aggregation functions  ##############
############  by Jared Looper       ##############
############  & edited by Kate Kim  ##############
############     March. 2019          ##############
##################################################

#' Creating a query element for country restraint
#' @description This function returns a list of countries a user specifies
#' @return A list of countries
#' @importFrom countrycode countrycode
#' @export
#' @param table_name A name of a data table. Input strings are NOT case-sensitive.
#' @param country A list of countries. We recommend to use the \href{https://unstats.un.org/unsd/tradekb/knowledgebase/country-code}{ISO ALPHA-3 Code} format, but
#' a full country name is also working in this function.\cr Several countries should be entered in the \code{list()} format.
#'      e.g. either \code{list("USA","CAN")} or \code{list("United States", "Canada")} are working and it is case-insensitive.
#' @examples \dontrun{# to have a query of the United States and Canada as a country restraint
#' ctr <- returnCountries("phoenix_rt", list("USA","CAN"))}
returnCountries <- function(table_name =" ", country = list()) {

  # convert the strings to an appropriate format given the database
  table_name = tolower(table_name)
  ISO = TRUE

  for(i in 1:length(country))
    if(nchar(country[i]) != 3) {
      ISO = FALSE
      country[[i]] = gsub("(?<=^| )([a-z])", "\\U\\1", tolower(country[[i]]), perl = T)
      break
    }

  if(ISO == TRUE) {
    if(table_name == "icews"){
      for(i in 1:length(country))
        country[[i]] = countrycode::countrycode(country[[i]],"iso3c", "country.name")
        }
      else if(table_name =="terrier"){
        for(i in 1:length(country))
          country[[i]] = countrycode::countrycode(country[[i]],"iso3c", "iso2c")
      }
  }
  else {
    if(table_name != "icews" & table_name != "terrier"){
      for(i in 1:length(country))
        country[[i]] = countrycode::countrycode(country[[i]],"country.name", "iso3c")
    }
    else if(table_name != "icews" & table_name == "terrier"){
      for(i in 1:length(country))
        country[[i]] = countrycode::countrycode(country[[i]],"country.name", "iso2c")
    }
  }
  #set up the query
  query <- list('<country_code>'= list('$in' = country))
  return(query)
}

#' Creating of a query element of a time period
#' @description This function returns a list of a time range
#' @return A list of dates for start and end of a time range
#' @export
#' @param table_name A name of a data table. Input strings are NOT case-sensitive.
#' @param start The "YYYYMMDD" format of the first date of a data set
#' @param end The "YYYYMMDD" format of the last date of a data set
#' @examples \dontrun{# to create the time ragne between Nov. 2, 2017 and
#' # Nov. 4, 2017 for the subset of real-time Phoenix data
#' t <- returnTimes("phoenix_rt", "20171102","20171104")}
returnTimes <- function(table_name =" ", start = " ", end = " ") {

  table_name = tolower(table_name)

  if(table_name == "icews" || table_name== "cline_phoenix_swb" || table_name=="cline_phoenix_nyt"||
     table_name=="cline_phoenix_fbis") {
    start = paste(substr(start,1,4),"-",substr(start,5,6),"-",substr(start,7,8),sep="")
    end = paste(substr(end,1,4),"-",substr(end,5,6),"-",substr(end,7,8),sep="")
  }

  if(substr(table_name,1,5)=="cline") {
    start = gsub("-", "/", start)
    end = gsub("-", "/", end)
  }

  return(list('<date>'=list('$gte'=start,'$lte'=end)))
}

#' Building a l dayd query element as source and target actors respectively
#' @description This function returns a list of a query element of a source-target country dyad
#' @return A list of a dyad queary element of source and target countries
#' @export
#' @importFrom countrycode countrycode
#' @param table_name A name of a data table. Input strings are NOT case-sensitive.
#' @param source The name of a source country either an ISO code or a country name format
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
    if(table_name == "phoenix_rt"|| table_name== 'cline_phoenix_swb' || table_name=="cline_phoenix_nyt"||
       table_name=='cline_phoenix_fbis' || table_name == "terrier") {
      source = countrycode::countrycode(source, "country.name", "iso3c")
      target = countrycode::countrycode(target,"country.name", "iso3c")
    }
  }
  query = list('<src_actor>'=list('$in'=list(source)),'<tgt_actor>'=list('$in'=list(target)))
  return(query)
}

#' Creating a geo-location query element with longitudes and lattidues
#' @description This function returns a list of a query element of geo-locations
#' @return A list of geo-location query elements
#' @export
#' @param lat1 the minimum value of lattitude of a geo-location boundary
#' @param lat2 the maximum value of latitidue of a geo-location boundary
#' @param lon1 the minimum value of longitude of a geo-location boundary
#' @param lon2 the maximum value of longitude of a geo-location boundary
#' @examples \dontrun{# to build a location constraint with the ranges of latitudes the longitudes
#' geo <- returnLatLon(-10,30,40,70)}
returnLatLon <- function(lat1, lat2, lon1, lon2) {
  return(list('<latitude>'=list('$gte'=lat1,'$lte'=lat2),'<longitude>'=list('$gte'=lon1,'$lte'=lon2)))
}

#' Building a query element, which indicates a certain pattern of variables in a particular data table
#' @description This function creates a query element to indicate a certain pattern of a variable
#' @return A list of the query element of a certain pattern of a particular variable in a data table
#' @importFrom stats setNames
#' @export
#' @param utd_api_key An API key provided by a UTD server manager
#' @param table_name A name of a data table. Input strings are NOT case-sensitive.
#' @param pattern A pattern or a feature of a specified variable
#' @param field A field (variable) of a data table
#' @note Please use this function only with the field that is not used in the other query element function.
#' For instance; if you subset the data with a certain country, use the function, `returnCountries()`.
#' @examples \dontrun{
#' # to get all source actors related to governments in ICEWS
#' reg <- returnRegExp(utd_api_key, "icews","GOV","Source Name")
#' # to subset the cline_phoenix_nyt data by year == 2001
#' nytQuery <- returnRegExp(utd_api_key, 'cline_phoenix_nyt', '2001', 'year')
#' myNYTdata <- sendQuery(utd_api_key, 'cline_phoenix_nyt', nytQuery, citation = F)}
returnRegExp <- function(utd_api_key = "", table_name = "", pattern = "", field = "") {
  f = paste("",field, sep='')
  if(is.element(f, tableVar(utd_api_key, table_name))) {
    query = list('field'= list('$regex' = pattern))
    return(setNames(query,field))
  }
  else {print("Please check the field and the pattern with tableVar()")}
}

#' Obtaining an OR query to combine two and more query elements
#' @description This function retuns  a list of a combination two or more query elements.
#' @return A list of several query elements corresponding to a particular data table
#' @export
#' @param query_prep one or more query vectors created by other query functions.
#' if query vectors are more than one than \code{c()} should be used for lising within the function.
#' @note Please make sure that specifying the same data table in all query element functions to avoid errors \cr
#' This query may build a large data set that could cause the data size issue in a Windows machine.
#' @examples \dontrun{# to subset real-time data with the constraint of a time range and a dyad
#' t <- returnTimes("phoenix_rt", "20171015", "20171215")
#' dyad <- returnDyad('Phoexnix_rt', 'RUS', 'SYR')
#' # building an OR-query of a certain time and the country dyad
#' or_query <- orList(c(t,dyad)) # it requires a large memory size to retrieve the data set}
orList <- function(query_prep = c()) {
  return(list('$or'= list(query_prep)))
}

#' Obtaining an AND query syntax to use two and more query elements
#' @description This function retuns a list of a comination two or more query elements.
#' @return A list of several query elements corresponding to a particular data table
#' @export
#' @param query_prep ne or more query vectors created by other query functions.
#' if query vectors are more than one than \code{c()} should be used for lising within the function.
#' @examples \dontrun{# to subset real-time data with the constraint of a time range and a dyad
#' t <- returnTimes("phoenix_rt", "20171015", "20171215")
#' dyad <- returnDyad('Phoexnix_rt', 'RUS', 'SYR')
#' # building an AND-query of a certain time and the country dyad
#' and_query <- andList(c(t,dyad))}
andList <- function(query_prep = c()) {
  return(list('$and'= list(query_prep)))
}

#' Sending queries to the UTD API server in order to download data with a built query
#' @description This function retruns the data and a package citation
#' @return A list with components
#'     \itemize{
#'          \item{}{\code{$data    }   a data frame of requested data. An attribute of the data can be formatted as data.frame. Please check the features of data if it's necessary}
#'          \item{}{\code{$citation}   a text of the package citation}
#'           }
#' @importFrom jsonlite fromJSON
#' @importFrom rjson toJSON
#' @importFrom curl curl
#' @export
#' @param utd_api_key An API key provided by a server manager at UTD
#' @param table_name A name of a data table. Input strings are NOT case-sensitive.
#' @param query A list of query elements or a single query element a user builds with other query functions.
#' @note If an error message is returned, please increase the memory size of R. This error is more
#' frequently occurred in a Windows machine.
#' @param citation logical; If \code{TRUE}, then a package citation will be printed at the end of data retrival.
#' @examples \dontrun{ # to store the ICEWS subset in the vector of myData without the citation
#' myData <- sendQuery(utd_api_key,"icews", query_element, citation = FALSE)}
sendQuery <- function(utd_api_key = NA, table_name = "", query = list(), citation = TRUE){
  if (is.na(utd_api_key)) utd_api_key <- Sys.getenv("UTDAPIKEY", unset=NA)
  if (is.na(utd_api_key)) print("No API key set. Instructions on how to set the API key are available in the documentation.")

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
  else if(table_name == "terrier"){
    query_string = relabel(query_string, "terrier")
  }
  url_submit = paste(url_submit,url, utd_api_key,'&query=', query_string, sep='','&datasource=',table_name)
  url_submit = gsub('"',"%22",url_submit, fixed=TRUE)
  url_submit = gsub(' ',"%20",url_submit, fixed=TRUE)
  print(url_submit)

  # Apply tryCatch for large data
  tryCatch({
    retrieved_data <- readLines(curl::curl(url_submit), warn=FALSE)},
    error = function(e){
      message("Error. Consider to increase your memory limit of R. Use getQuerySize() to see the data size estimated.")
      message(e)}
  )
  # end tryCatch
  closeAllConnections()
  parsed_data <- jsonlite::fromJSON(retrieved_data)$data

    # package citation
  if (citation) {
    return(list(data=parsed_data, citation=citation("UTDEventData")))
  }

  else {
    return(parsed_data)
  }
}


#' Estimating a size of data queries that will be requested to the UTD API server
#' @description This function retruns a data size in a string format
#' @return A text of the data size in bytes
#' @importFrom rjson toJSON
#' @importFrom curl curl
#' @export
#' @param utd_api_key An API key provided by a server manager at UTD
#' @param table_name A name of a data table. Input strings are NOT case-sensitive.
#' @param query A list of query elements a user builds with other query element functions.
#' Please type in "entire" to find the total size of a data table.
#' @examples \dontrun{ # to measure the size of the query elements builded with the other functions
#' getQuerySize(utd_api_key = "", table_name = "Phoenix_rt", query = list(q1, q2))
#' # to get the size of the entire Real-time Phoenix data
#' getQuerySize(utd_api_key = , table_name = "Phoenix_rt", query = "entire")}
getQuerySize <- function(utd_api_key = NA, table_name = "", query = list()) {
  if (is.na(utd_api_key)) utd_api_key <- Sys.getenv("UTDAPIKEY", unset=NA)
  if (is.na(utd_api_key)) print("No API key set. Instructions on how to set the API key are available in the documentation.")
  table_name = tolower(table_name)
  url <- 'http://149.165.156.33:5002/api/data?size_only=True&api_key='
  url_submit = ''

  if(is.null(query)) {
    print("The query is empty.")
    return(list())
  }
  if(query == 'entire'){
    query_string = '{}'
    }

  else {query_string = rjson::toJSON(query)
    if (table_name=="phoenix_rt" ) {
      query_string = relabel(query_string, "phoenix_rt")
    }
    else if (table_name== 'cline_phoenix_swb' || table_name=="cline_phoenix_nyt"|| table_name=='cline_phoenix_fbis'){
      query_string = relabel(query_string, "cline")
    }
    else if(table_name == "icews") {
      query_string = relabel(query_string, "icews")
    }
    else if(table_name == "terrier"){
    query_string = relabel(query_string, "terrier")
    }
  }

  url_submit = paste(url_submit,url, utd_api_key,'&query=', query_string, sep='','&datasource=',table_name)
  url_submit = gsub('"',"%22",url_submit, fixed=TRUE)
  url_submit = gsub(' ',"%20",url_submit, fixed=TRUE)
  print(url_submit)
  size = readLines(curl::curl(url_submit), warn=FALSE)
  closeAllConnections()
  size = unlist(strsplit(size, split = ':', fixed=TRUE))[2]
  size = gsub('}', "", size)
  cat("Its size is:", size, "bytes")
}


#' Extracting the entire data of a specified data table
#' @description This function allows users to obtain a entire dataset of a data table. The package
#' citation is also printed . In the method, the entire data are directly downloaded to disk of a local machine,
#' so please make sure that you have enough space for the data on your device. The size of
#' a particular data set can be estimated by \code{getQuerySize()}.
#' @return A list of data and an object of class \code{$citation}
#' @note Some datasets are greather than 10GB. Please check a size of a dataset before downloading it on your device.
#' @importFrom curl curl_download
#' @export
#' @param utd_api_key An API key provided by a server manager at UTD
#' @param table_name A name of a data table. Input strings are NOT case-sensitive.
#' @param citation a logical indicating whether the package citation is printed (default is TRUE) or not.
#' @examples \dontrun{
#' # to get the size of the entire data for Cline_Phoeinx_NYT
#' getQuerySize(utd_api_key = , table_name ='Cline_Phoenix_NYT', query = 'entire')
#' # to download the entire data of Cline_Phoeinx_NYT after confirming its size
#' data.nyt <- entireData(utd_api_key = , table_name ='Cline_Phoenix_nyt', citation = FALSE)}

entireData <- function(utd_api_key = NA, table_name = "", citation = TRUE){
  if (is.na(utd_api_key)) utd_api_key <- Sys.getenv("UTDAPIKEY", unset=NA)
  if (is.na(utd_api_key)) print("No API key set. Instructions on how to set the API key are available in the documentation.")

  table_name = tolower(table_name)
    if(table_name == 'cline_phoenix_swb' || table_name=="cline_phoenix_nyt"
     || table_name=='cline_phoenix_fbis'||table_name == 'icews' ||
     table_name == "phoenix_rt" || table_name =="terrier"){

    url <- 'http://149.165.156.33:5002/api/data?api_key='
    url_submit = ''
    url_submit = paste(url_submit,url, utd_api_key,'&query={}', sep='','&datasource=',table_name)
    url_submit = gsub('"',"%22",url_submit, fixed=TRUE)
    url_submit = gsub(' ',"%20",url_submit, fixed=TRUE)
    print(url_submit)

    # download data to disk
    tmp <- tempfile()
    curl::curl_download(url_submit, tmp)

    # read the stored data
    retrieved_data <- readLines(tmp, warn=FALSE)
    parsed_data <- jsonlite::fromJSON(retrieved_data)$data

    # package citation
    if (citation) {
      return(list(data=parsed_data, citation=citation("UTDEventData")))
      }
    else {
      return(parsed_data)
      }
    }
  else {
    print("Please check the table name!")}
}
