# ------------------------------------------------------- #
#               Data preview function                     #
# ------------------------------------------------------- #
#' Checking the data frame of a particular data table
#' @description This function retruns the 100 obsertations of a particular data table at the UTD API server
#' @return A data frame of a specified data table.
#' @note The retrived data are shown in `View()`, but the class of the variable, `_id`, is a dataframe. To check the data
#' with `edit()` with no warning or error, the variable of `_id` need to be dropped.
#' @importFrom jsonlite fromJSON
#' @export
#' @param api_key An API key provided by a server manager at UTD
#' @param table_name A name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @examples \dontrun{ data <- previewData(api_key, "icews")
#' View(data) # the 100 observations of ICEWS data are shown }
previewData <- function(api_key = "", table_name = ""){
  url <- 'http://149.165.156.33:5002/api/data?api_key='
  url_submit = ''
  table_name = tolower(table_name)
  url_submit = paste(url_submit,url, api_key,'&query={}', '&limit=100', sep='','&datasource=',table_name)
  url_submit = gsub('"',"%22",url_submit, fixed=TRUE)
  url_submit = gsub(' ',"%20",url_submit, fixed=TRUE)
  retrieved_data <- readLines(url_submit, warn=FALSE)
  parsed_data <- jsonlite::fromJSON(retrieved_data)$data
}
