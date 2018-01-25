#'A hiden function for relabeling query strings of one data format to the other
#'@param queryString a querying sentence of a data format
#'@param format a format returned
#'@import jsonlite
#'@keywords internal
#'@author Micheal J. Shoemate

relabel = function(queryString, format) {

  jsonFormat = jsonlite::fromJSON(readLines(paste("~/UTDEventData/R/", format, '.json', sep="")));
  key = names(jsonFormat)

  for (i in 1:length(jsonFormat)) {
    queryString = gsub(key[[i]], jsonFormat[[i]]$name, queryString)
  }
  return(queryString)
}
