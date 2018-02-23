#' Searching data tables in the UTD event data server
#' @description Searching available data tables in the event data server.
#' It returns the list of data tables in the UTD server and requires an API key.
#' The API key can be obtained after filling out the form in the UTD event data sign-up website
#' (http://eventdata.utdallas.edu/signup). Please follow the direction in the \href{http://149.165.156.33:5002/signup}{UTD sign-up webpage}. \cr
#' You can also use this function through the reference class, \code{Table()}.
#' Please find the help document of the \code{Table()} function for more details on its usage.\cr
#'
#' The details of data tables are illustrated in the linked websites. \cr
#' \itemize{
#' \item {Phoenix_RT:} {Real-time data from Oct. 2017 to today, please see more details in \href{http://openeventdata.org/}{Open Event Data Alliance}}.\cr
#' \item {ICEWS:} {Integrated Crisis Early Warning System from Harvard Dataerse from 1995 to Sep. 2016. Please see more details in \href{https://dataverse.harvard.edu/dataverse/icews}{ICEWS Dataverse}.}
#' \item {Phoenix NYT:} {accumulated from 1945 to 2005, information of Phoenix Event Data are found at \href{http://www.clinecenter.illinois.edu/data/event/phoenix/}{the Cline Center}.}
#' \item {Phoenix FBIS:} {accumulated from 1995 to 2004, the information of Phoenix Event Data are found at \href{http://www.clinecenter.illinois.edu/data/event/phoenix/}{the Cline Center}.}
#' \item {Phoenix SWB:} {accumulated from 1979 to 2015, the information of Phoenix Event Data are found at \href{http://www.clinecenter.illinois.edu/data/event/phoenix/}{the Cline Center}.}
#'  }
#' @return The list of data table the UTD server has
#' @export
#' @examples > DataTables(api_key=" ")
#'  [1] "'PHOENIX_RT', 'CLINE_PHOENIX_SWB', 'CLINE_PHOENIX_FBIS', 'CLINE_PHOENIX_NYT', 'ICEWS'"
## function for indicating a specific data table in MongoDB
## Currently updated on 2/21/2018
## Kate Kim
## this returns all data tables the UTD database has
DataTables<-function (api_key=" ")
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
#' @description Searching the list of variables in the data table a user specifies.
#' It returns variables names and requires an API key. \cr
#' You can also look up a particular word for variabla names such as "day", "month", or "src" so that you can find whether or not a
#' specified data table has the certain variables you need. \cr
#' The API key can be obtained after filling out the form in the UTD event data sign-up website
#' (http://eventdata.utdallas.edu/signup). Please follow the direction in the \href{http://149.165.156.33:5002/signup}{UTD sign-up webpage}. \cr
#' You can also use this function through the reference class, \code{Table()}.
#' Please find the help document of the \code{Table()} function for more details on its usage.
#' @param api_key an API key from the developer at UTD
#' @param table a specific data table a user want to exploer its variables
#' @param lword a look-up word for a particular variable name you need
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
tableVar <-function(api_key=' ', table=' ', lword=' ')
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

  # searching variables in cline_Phoenix_nyt
  if (tb=='cline_phoenix_nyt'){

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

  # searching variables in cline_Phoenix_fbis
  if (tb=='cline_phoenix_fbis'){

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

  # searching variables in cline_Phoenix_swb
  if (tb=='cline_phoenix_swb'){

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



