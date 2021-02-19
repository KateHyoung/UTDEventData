## function for indicating a specific data table in MongoDB
## Currently updated on APR. 2019
## Kate Kim
## this returns all data tables the UTD database has
####################################################################
#' Searching data tables in the UTD event data server
#' @description This function returns the list of data tables in the UTD server and requires an API key.
#' The API key can be obtained after filling out the form in the UTD event data sign-up website
#' (http://eventdata.utdallas.edu/signup). Please follow the direction in the \href{http://149.165.156.33:5002/signup}{UTD sign-up webpage}. \cr
#' You can also use this function through the reference class, \code{Table()}. \cr
#' The option of storing an API key in an environment variable is prepared to run the function without passing an API key every time. Please see the examples bellow.
#'
#' The details of data tables are illustrated in the linked websites. \cr
#' \itemize{
#' \item {Phoenix_RT:} {Real-time data from Oct. 2017 to today, please see more details in \href{http://openeventdata.org/}{Open Event Data Alliance}}.\cr
#' \item {ICEWS:} {Integrated Crisis Early Warning System from Harvard Dataerse from 1995 to Oct. 2018. Please see more details in \href{https://dataverse.harvard.edu/dataverse/icews}{ICEWS Dataverse}.}
#' \item {Phoenix NYT:} {accumulated from 1945 to 2005, information of Phoenix Event Data is found at \href{http://www.clinecenter.illinois.edu/data/event/phoenix/}{the Cline Center}.}
#' \item {Phoenix FBIS:} {accumulated from 1995 to 2004, information of Phoenix Event Data is found at \href{http://www.clinecenter.illinois.edu/data/event/phoenix/}{the Cline Center}.}
#' \item {Phoenix SWB:} {accumulated from 1979 to 2015, information of Phoenix Event Data is found at \href{http://www.clinecenter.illinois.edu/data/event/phoenix/}{the Cline Center}.}
#' \item {TERRIER:} {accumulated from 1979 to 2016, information of TERRIER political event data is found at \href{http://terrierdata.org/}{Terrierdata.org}. }
#'  }
#' @return A list of the data tables currently downloadable from the UTD server as a character format
#' @param utd_api_key an API key provided by the UTD server manager
#' @export
#' @examples \dontrun{DataTables(utd_api_key=' your API key')
#'  # method 1: passing a UTD API KEY as the first argument
#'  k <- "utd_api_key"
#'  DataTables(k)
#'
#'  # method 2: storing a UTD API KEY in an environment variable
#'  Sys.setenv(UTDAPIKEY = "...your API key...")
#'  DataTables()}

DataTables<-function (utd_api_key=NULL)
{
  if (is.null(utd_api_key)) utd_api_key <- Sys.getenv("UTDAPIKEY", unset=NA)
  if (is.null(utd_api_key)) print("No API key set. Instructions on how to set the API key are available in the documentation.")

  # constructing a url
  url <- 'https://eventdata.utdallas.edu/api/datasources?api_key='
  url_submit = paste(url,utd_api_key,sep='')
  # getting table names
  TableList <- readLines(url_submit, warn=FALSE)
  List<-gsub(".*\\[(.*)\\].*", "\\1", TableList)
  List<-toupper(List)
  ER <- strsplit(List, "'")
  if(grepl("INVALID API KEY", ER)==TRUE) {
    {print("This API key is invalid. Please check that you have entered your key correctly.")}
  }

  else {return(List)}
}


#' Searching the variables in a particular data table
#' @description Searching the list of variables in the data table a user specifies.
#' It returns variable names and requires an API key. \cr
#' You can also look up a particular word of variabla names such as "day", "month", or "src" so that you can find whether or not a
#' specified data table has the certain variables you need. \cr
#' The API key can be obtained after submitting the form in the UTD event data sign-up website
#' (http://eventdata.utdallas.edu/signup). Please follow the direction in the \href{http://149.165.156.33:5002/signup}{UTD sign-up webpage}. \cr
#' You can also use this function through the reference class, \code{Table()}. \cr
#' The option of storing an API key in an environment variable is prepared to run the function without passing an API key every time. Please see the examples bellow.
#' @param utd_api_key an API key from the developer at UTD
#' @param table a specific data table a user wants to explore its variables
#' @param lword a look-up word for a particular variable name you need
#' @return A list of variable names of the specified data table
#' @export
#' @examples
#' \dontrun{
#' # when searching the variables in Phoenix_RT
#' tableVar(table="phoenix_rt", utd_api_key="...")
#'
#' # when searhing the variable which includes the word of "tar" in ICEWS
#' tableVar(table="icews", lword="tar", utd_api_key="...")
#'
#' # method 1: passing a key as the first argument
#' k <- "utd_api_key"
#' tableVar(table="phoenix_rt", utd_api_key = k)
#' tableVar(table="icews", utd_api_key = k, lword="target")
#'
#' # Method 2: storing the key in an environment variable
#' Sys.setenv(UTDAPIKEY = "...your API key...")
#' tableVar(table = "icews", lword = "target")}

tableVar <-function(table='', utd_api_key=NULL, lword='')
{
  if (is.null(utd_api_key)) utd_api_key <- Sys.getenv("UTDAPIKEY", unset=NA)
  if (is.null(utd_api_key)) print("No API key set. Instructions on how to set the API key are available in the documentation.")
  # transfroming a string to lower cases
  tb=tolower(table)
  # searching variables in Terrier
  if (tb=='terrier'){

  url <- 'https://eventdata.utdallas.edu/api/fields?datasource='
  url_submit = paste(url,tb,'&api_key=',utd_api_key,sep='')
  # getting variables names
  VarList <- readLines(url_submit, warn=FALSE)
  List<-gsub(".*\\[(.*)\\].*", "\\1", VarList)
  List<-gsub("u'", "", List);List<-gsub("'","",List)
  varList<-strsplit(List, ",")[[1]]
  varList<-trimws(varList, "left")
  # varList[1] <- paste(" ", varList[1], sep="")

  # looking up a word of variables
  if (!is.null(lword)){ w<- grep(lword, varList, ignore.case = TRUE)
  return(varList[w])}

  else(varList)}


  # searching variables in Phoenix-rt
  if (tb=='phoenix_rt'){

    url <- 'https://eventdata.utdallas.edu/api/fields?datasource='
    url_submit = paste(url,tb,'&api_key=',utd_api_key,sep='')
    # getting variables names
    VarList <- readLines(url_submit, warn=FALSE)
    List<-gsub(".*\\[(.*)\\].*", "\\1", VarList)
    List<-gsub("u'", "", List);List<-gsub("'","",List)
    varList<-strsplit(List, ",")[[1]]
    varList<-trimws(varList, "left")
    # varList[1] <- paste(" ", varList[1], sep="")

     # looking up a word of variables
       if (!is.null(lword)){ w<- grep(lword, varList, ignore.case = TRUE)
       return(varList[w])}

      else(varList)}

  # searching variables in cline_Phoenix_nyt
  if (tb=='cline_phoenix_nyt'){

    url <- 'https://eventdata.utdallas.edu/api/fields?datasource='
    url_submit = paste(url,tb,'&api_key=',utd_api_key,sep='')
    # getting variables names
    VarList <- readLines(url_submit, warn=FALSE)
    List<-gsub(".*\\[(.*)\\].*", "\\1", VarList)
    List<-gsub("u'", "", List);List<-gsub("'","",List)
    varList<-strsplit(List, ",")[[1]]
    varList<-trimws(varList, "left")
    # varList[1] <- paste(" ", varList[1], sep="")

    # looking up a word of variables
    if (!is.null(lword)){ w<- grep(lword, varList, ignore.case = TRUE)
    return(varList[w])}

    else(varList)}

  # searching variables in cline_Phoenix_fbis
  if (tb=='cline_phoenix_fbis'){

    url <- 'https://eventdata.utdallas.edu/api/fields?datasource='
    url_submit = paste(url,tb,'&api_key=',utd_api_key,sep='')
    # getting variables names
    VarList <- readLines(url_submit, warn=FALSE)
    List<-gsub(".*\\[(.*)\\].*", "\\1", VarList)
    List<-gsub("u'", "", List);List<-gsub("'","",List)
    varList<-strsplit(List, ",")[[1]]
    varList<-trimws(varList, "left")
    # varList[1] <- paste(" ", varList[1], sep="")

    # looking up a word of variables
    if (!is.null(lword)){ w<- grep(lword, varList, ignore.case = TRUE)
    return(varList[w])}

    else(varList)}

  # searching variables in cline_Phoenix_swb
  if (tb=='cline_phoenix_swb'){

    url <- 'https://eventdata.utdallas.edu/api/fields?datasource='
    url_submit = paste(url,tb,'&api_key=',utd_api_key,sep='')
    # getting variables names
    VarList <- readLines(url_submit, warn=FALSE)
    List<-gsub(".*\\[(.*)\\].*", "\\1", VarList)
    List<-gsub("u'", "", List);List<-gsub("'","",List)
    varList<-strsplit(List, ",")[[1]]
    varList<-trimws(varList, "left")
    # varList[1] <- paste(" ", varList[1], sep="")

    # looking up a word of variables
    if (!is.null(lword)){ w<- grep(lword, varList, ignore.case = TRUE)
    return(varList[w])}

    else(varList)}

  # searching variables in Icews
  if (tb=='icews'){

    url <- 'https://eventdata.utdallas.edu/api/fields?datasource='
    url_submit = paste(url,tb,'&api_key=',utd_api_key,sep='')
    # getting variables names
    VarList <- readLines(url_submit, warn=FALSE)
    List<-gsub(".*\\[(.*)\\].*", "\\1", VarList)
    List<-gsub("u'", "", List);List<-gsub("'","",List)
    varList<-strsplit(List, ",")[[1]]
    varList<-trimws(varList, "left")
    # varList[1] <- paste(" ", varList[1], sep="")

    # looking up a word of variables
    if (!is.null(lword)){ w<- grep(lword, varList, ignore.case = TRUE)
    return(varList[w])}

    else(varList)}

  else print('Please check the table name!')
}
