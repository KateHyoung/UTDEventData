#' Search data tables in the UTD Event data server
#' @description Searching data tables in the UTD server.
#' It returns the list of data table in the UTD server.
#' Currently only Pheonix is available.
#' @return The name of data table the UTD server has
#' @export
#' @examples > DataTables( )
#' [1] "Pheonix" "OK-LN" "ICEWS"
## function for indicating a specific data table in MongoDB
## Now only 'Phoenix' table is available
## Current updated date: 11/15/2017
## Kate Kim

## No options for a user
## this returns all talbes the UTD database can connect
DataTables<-function (   )
{
  Tablelists<-c('Pheonix','OK-LN','ICEWS')
  return(Tablelists)
}


#' Search variables in a particular data table
#' @description Searching the list of variablees in the data table a user specifies. It returns the list of variables.
#' @param table= the string of data table name such as 'Pheonix'
#' @param lword= a word a user wants to look up in variable list of a data table
#' @return a list of variables
#' @export
#' @examples > tableVar(table="Pheonix")
#' [1] "code"        "src_actor"       "month"    "tgt_actor"   "country_code"
#' [6] "year"        "id"              "source"   "date8"       "src_agent"
#' [11] "latitude"   "src_other_agent" "geoname"  "quad_class"  "source_text"
#' [16] "root_code"  "tgt_other_agent" "day"      "target"      "goldstein"
#' [21] "tgt_agent"  "longitude"       "url"      "_id"
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


  else {print("Not available now")
  }
}

