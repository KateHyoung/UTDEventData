# ------------------------------------------------------- #
#               Data preview function                     #
# ------------------------------------------------------- #
#' Previewing a data structure and its variables which a user requests
#' @description This function retruns the e00 observations of a particular data table
#' @return A data frame of a specified data table.
#' @note The retrived data are invoked in a spreadsheet-style by `View()`, but the class of the variable, `_id`,
#' in the data is a datafame, so it returns error if you view them by `edit()`. To check the data
#' with `edit()`, the variable of `_id` needs to be dropped.
#' @importFrom jsonlite fromJSON
#' @export
#' @param utd_api_key An API key provided by a server manager at UTD
#' @param table_name A name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @examples \dontrun{ data <- previewData(utd_api_key, "icews")
#' View(data) # the 100 observations of ICEWS data are shown }
previewData <- function(utd_api_key = "", table_name = ""){
  url <- 'http://149.165.156.33:5002/api/data?api_key='
  url_submit = ''
  table_name = tolower(table_name)
  url_submit = paste(url_submit,url, utd_api_key,'&query={}', '&limit=100', sep='','&datasource=',table_name)
  url_submit = gsub('"',"%22",url_submit, fixed=TRUE)
  url_submit = gsub(' ',"%20",url_submit, fixed=TRUE)
  retrieved_data <- readLines(url_submit, warn=FALSE)
  parsed_data <- jsonlite::fromJSON(retrieved_data)$data
}
