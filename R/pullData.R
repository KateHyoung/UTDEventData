#################################################################
#############    A Main function of subsetting ##################
#############    Combined by Kate Kim          ##################
#############    Last update: Jan. 2019        ##################
#################################################################
#' Extracting event data from the UTD real-time event data server.
#' @description This is the main function to extract subdata from the UTD Event data server by country names and time ranges.
#'              The API key is required and can be obtained after filling out the form in the UTD event data sign-up website (\url{http://eventdata.utdallas.edu/signup}).
#'              Please follow the direction in the \href{http://149.165.156.33:5002/signup}{UTD sign-up webpage}.\cr
#'              You can also use this function through the reference class, \code{Table()}.
#'              Please find the help document of the \code{Table()} function for more details for its usage.
#' @return A list with components
#'     \itemize{
#'          \item{}{\code{$data}   a data frame of requested data. An attribute of the data can be formatted as data.frame, please check the features of data if it's necessary}
#'          \item{}{\code{$citation}    a text of data citation}
#'           }
#' @importFrom jsonlite fromJSON
#' @importFrom countrycode countrycode
#' @importFrom rjson toJSON
#' @export
#' @examples pullData(api_key=" ", table_name="Phoenix_rt", country=list("USA","MEX","SYR","CHN"),
#'  start="20171101", end="20171112", citation = TRUE)
#'
#'  ## Another way to avoid repeating an API key into the function
#'  k <- '...api key...'
#'  subset1 <- pullData(k, "phoenix_rt", list('canada','China'), '20171101', '20171102')
#'  subset2 <- pullData(k, "icews", list('can', 'usa'), '20010101','20010110')
#'  subset3 <- pullData(k, 'cline_Phoenix_NYT',list('South Korea','canada'), '19551105','19581215')
#'
#'  ## Data retreval without the citation
#'  pullData(k, "phoenix_rt", list("USA"), "20171115", "20171120", citation = FALSE)
#' @param api_key An API key provided by the server manager at UTD.
#' @param table_name The name of data table you want to have. You may find available data tables from DataTables( )
#' @param country List of countries. We recommend to use the \href{https://unstats.un.org/unsd/tradekb/knowledgebase/country-code}{ISO ALPHA-3 Code} format, but
#' the full country name is also working in this function.\cr
#'      e.g. either \code{list("USA","CAN")} or \code{list("United States", "Canada")} are working and not case-sensitive.
#' @param start The "YYYYMMDD" format of the first date of a data set
#' @param end The "YYYYMMDD" format of the end date of a data set
#' @param citation The option for printing a package citation at the end of data retrival.
#' The defualt is TRUE, and you can trun it off by adding FALSE in the option.

pullData<-function(api_key=" ", table_name=" ", country=list(), start=" ", end=" ", citation = TRUE){

    ISO = TRUE

    for(i in 1:length(country))
      if(nchar(country[i]) != 3) {
        ISO = FALSE
        country[[i]] = gsub("(?<=^| )([a-z])", "\\U\\1", tolower(country[[i]]), perl = T)
        break
      }

    if(ISO == TRUE) {
      if(table_name == "icews"|| table_name== 'cline_phoenix_swb' || table_name=="cline_phoenix_nyt" || table_name=='cline_phoenix_fbis')
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

    if (citation) {
      return(list(data=parsed_data, citation=citation("UTDEventData")))
    }

    else {
      return(parsed_data)
    }
}
