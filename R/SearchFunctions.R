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
#' @param table= the string of data table name such as 'Pheonix'
#' @param lword= a word  or a letter a user wants to look up in the variable list of a data table
#' @return a list of variables
#' @export
#' @examples > tableVar("Pheonix", " ") if you want to have the list of all variables in the Phoenix table
#' [1] "code"        "src_actor"       "month"    "tgt_actor"   "country_code"
#' [6] "year"        "id"              "source"   "date8"       "src_agent"
#' [11] "latitude"   "src_other_agent" "geoname"  "quad_class"  "source_text"
#' [16] "root_code"  "tgt_other_agent" "day"      "target"      "goldstein"
#' [21] "tgt_agent"  "longitude"       "url"      "_id"
#' > tableVar("Phoenix", "act") if you want to look up the variables that contains "act" in thier names.
#' [1] "src_actor" "tgt_actor"

## Searching variable nemes under a data table
## returns the variables names a specified table has
tableVar <-function(table='table_name', lword=' ')
{                                     ## wait for the query from Sayeed
  if (table=='Phoenix'){

    Phoenix<-c("code" , "src_actor" ,  "month" , "tgt_actor" ,  "country_code"  ,
               "year",  "id" , "source", "date8", "src_agent",
               "latitude","src_other_agent", "geoname", "quad_class", "source_text",
               "root_code", "tgt_other_agent", "day", "target", "goldstein",
               "tgt_agent",   "longitude", "url", "_id")

    if (!is.null(lword)){ w<- grep(lword, Phoenix, ignore.case = TRUE)
    return(Phoenix[w])}

    return(Phoenix)}


  if (table=='ICEWS'){
    ICEWS<-c("_id", "Province","Publisher","Target Name", "District", "City",
             "Country", "CAMEO Code",  "Source Country", "Source Sectors", "Event Date",
             "Source Name","Source Name", "Intensity", "Story ID","Target Sectors",
             "Event Text", "Longitude" , "Target Country" , "Sentence Number","Event ID")

    if (!is.null(lword)){ w<- grep(lword, ICEWS, ignore.case = TRUE)
    return(ICEWS[w])}

  return(ICEWS)
  }

  else {print("Not available now")
  }
}

