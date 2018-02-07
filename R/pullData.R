#################################################################
#############    A Main function of subsetting ##################
#############    Combined by Kate Kim          ##################
#############    Last update: 1/18/2018        ##################
#################################################################
#' Extracting event data from the UTD real-time event data server.
#' @description This is the main function to extract subdata from the UTD Event data server by country names and time ranges.
#'              The API key is required and can be obtained after filling out the form in the UTD event data sign-up website (\url{http://149.165.156.33:5002/signup}).
#'              Please follow the direction in the \href{http://149.165.156.33:5002/signup}{UTD sign-up webpage}. \cr
#'              You can also use this function through the reference class, \code{Table()}.
#'              Please find the help document of the \code{Table()} function for more details on its usage.
#' @return Real-time event data
#' @import jsonlite
#' @export
#' @examples pullData(api_key=" ", table_name="Phoenix_rt", country=list("USA","MEX","SYR","CHN"),
#'  start="20171101", end="20171112")
#' @param api_key An API key provided by the server manager at UTD.
#' @param table_name The name of data table you want to have. You may find available data tables from DataTables( )
#' @param country List of countries you want to look for with the \href{https://unstats.un.org/unsd/tradekb/knowledgebase/country-code}{ISO ALPHA-3 Code} format.\cr
#'                e.g. list("USA","CAN")
#' @param start The "YYYYMMDD" format of the first date of a data set.
#' @param end The "YYYYMMDD" format of the end date of a data set.

pullData<-function(api_key=" ", table_name=" ", country=list(), start=" ", end=" "){

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
      query_string = relabel(query_string, "phoenix_rt")
    }
    else if (table_name == "icews") {
      query_string = relabel(query_string, "icews")

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
  }

