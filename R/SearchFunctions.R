#' Searching data tables in the UTD Event data server
#' @description Searching data tables in the UTD server.
#' It returns the list of data table in the UTD server.
#' It requires an API key from the developer at UTD.
#' @return The name of data table the UTD server has
#' @export
#' @examples > DataTables(api_key=" ")
## function for indicating a specific data table in MongoDB
## Current updated date: 12/10/2017
## Kate Kim
## this returns all data tables the UTD database has
DataTables<-function (api_key)
{
  # constructing a url
  url = 'http://149.165.156.33:5002/api/datasources?api_key='
  url_submit = paste(url,api_key,sep='')
  # getting table names
  TableList <- readLines(url_submit, warn=FALSE)
  List<-gsub(".*\\[(.*)\\].*", "\\1", TableList)
  List<-toupper(List)
  return(List)
}


#' Searching the variables in a particular data table
#' @description Searching the list of variablees in the data table a user specifies. It returns the list of variables.
#' @param api_key an API key from the developer at UTD
#' @param table a specific data table a user want to exploer its variables
#' @param lword a look-up word for a particular variable name in a data table
#' @return The variables list in a particular data table
#' @export
#' @examples > tableVar(api_key="...", table="phoenix_rt")
#'  # when searching the variables in Phoenix_RT
#' [1] " code", "src_actor", "month", "tgt_actor", ....
#' > tableVar(api_key="...", table="icews", lword="tar")
#'  # when searhing the variable which includes the word of "tar" in ICEWS
#' [1] " Target Name"    " Target Sectors", ....

## Searching variable nemes under a data table
## returns the variables names a specified table has
tableVar <-function(api_key=' ', table='table_name', lword=' ')
{
  # transfroming a string to lower cases
  tb=tolower(table)

  # searching variables in Phoenix-rt
  if (tb=='phoenix_rt'){

    url = 'http://149.165.156.33:5002/api/fields?datasource='
    url_submit = paste(url,tb,'&api_key=',api_key,sep='')
    # getting variables names
    VarList <- readLines(url_submit, warn=FALSE)
    List<-gsub(".*\\[(.*)\\].*", "\\1", VarList)
    List<-gsub("u'", "", List);List<-gsub("'","",List)
    varList<-strsplit(List, ",")[[1]]

     # looking up a word of variables
       if (!is.null(lword)){ w<- grep(lword, varList, ignore.case = TRUE)
       return(varList[w])}

     else(varList)}

  # searching variables in Icews
  if (tb=='icews'){

    url = 'http://149.165.156.33:5002/api/fields?datasource='
    url_submit = paste(url,tb,'&api_key=',api_key,sep='')
    # getting variables names
    VarList <- readLines(url_submit, warn=FALSE)
    List<-gsub(".*\\[(.*)\\].*", "\\1", VarList)
    List<-gsub("u'", "", List);List<-gsub("'","",List)
    varList<-strsplit(List, ",")[[1]]

    # looking up a word of variables
    if (!is.null(lword)){ w<- grep(lword, varList, ignore.case = TRUE)
    return(varList[w])}

    else(varList)}

  else{print('Please check the table name!')}

}



