#########################################################
################ Citation functions #####################
################    Kate H. Kim     #####################
#########################################################
#' Properly citing data tables in the UTD Event data server for publications.
#' @description This function returns the citation texts of data sets a user extracts
#' by the UTDEventData package with a data table name.
#' @param table_name a name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @return The texts of propor citations for publication in text and Bibtex formats
#' @export
#' @examples # citations for Cline Phoenix Event data
#' citeData(table_name = "cline_Phoenix_swb")
#' # citations for ICEWS or UTD real-time data
#' citeData(table_name = "Phoenix_rt")
citeData <- function(table_name = "") {

  tn <- tolower(table_name)
  ut <- citation("UTDEventData")

  if(tn == 'cline_phoenix_nyt' || tn == 'cline_phoenix_swb' || tn == 'cline_phoenix_fbis'){
   full <- "Althaus, Scott, Joseph Bajjalieh, John F. Carter, Buddy Peyton, and Dan  A. Shalmon. 2017. Cline Center Historical Phoenix Event Data. v.1.0.0. Distributed by Cline Center for Advanced Social Research. June 30."
   title <- "Cline Center Historical Phoenix Event Data. v.1.0.0."
   author <- "Althaus, Scott, Joseph Bajjalieh, John F. Carter, Buddy Peyton, and Dan  A. Shalmon."
   year <- "2017"
   note <- "Distributed by Cline Center for Advanced Social Research."
   print(ut)
   cat("For a publication citation: \n\n  ", full, "\n\nFor a Bibtex entry: \n\n @Manual{, \n title={", title, "}, \n author={", author, "},\n year={",year,"},\n note={",note,"},\n}", sep = "")
  }

  else if(tn == 'phoenix_rt' | tn == 'icews') {
    print(ut)
  }
  else {
    print("Please check the name of a data table!")
  }
}
