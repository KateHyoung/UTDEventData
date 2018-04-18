#########################################################
################ Citation functions #####################
################    Kate H. Kim     #####################
#########################################################
#' Properly citing data tables in the UTD Event data server for publications.
#' @description This function returns the citation texts in text and Bibtex formats of data sets a user extracts
#' by the UTDEventData package with a data table name.
#' @param table_name a name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @return The texts of propor citations for publication in text and Bibtex formats
#' @export
#' @examples # citations for Cline Phoenix Event data
#' citeData("cline_Phoenix_swb")
#' # citations for ICEWS
#' citeData("icews")
#' # citation for real-time phoenix data
#' citeData("phoenix_rt")
citeData <- function(table_name = "") {

  tn <- tolower(table_name)
  # ut <- citation("UTDEventData")

  if(tn == 'cline_phoenix_nyt' || tn == 'cline_phoenix_swb' || tn == 'cline_phoenix_fbis'){
   full <- "Althaus, Scott, Joseph Bajjalieh, John F. Carter, Buddy Peyton, and Dan  A. Shalmon. 2017. Cline Center Historical Phoenix Event Data. v.1.0.0. Distributed by Cline Center for Advanced Social Research. June 30."
   title <- "Cline Center Historical Phoenix Event Data. v.1.0.0."
   author <- "Althaus, Scott, Joseph Bajjalieh, John F. Carter, Buddy Peyton, and Dan  A. Shalmon."
   year <- "2017"
   note <- "Distributed by Cline Center for Advanced Social Research."
   cat("For a publication citation: \n\n  ", full, "\n\nFor a Bibtex entry: \n\n @Manual{, \n title={", title, "}, \n author={", author, "},\n year={",year,"},\n note={",note,"},\n}", sep = "")
  }

  else if(tn == 'icews') {
    full <- "Boschee, Elizabeth; Lautenschlager, Jennifer; O'Brien, Sean; Shellman, Steve; Starz, James; Ward, Michael, 2015, 'ICEWS Coded Event Data', https://doi.org/10.7910/DVN/28075, Harvard Dataverse, V22"
    title <- "ICEWS Coded Event Data"
    author <- "Boschee, Elizabeth; Lautenschlager, Jennifer; O'Brien, Sean; Shellman, Steve; Starz, James; Ward, Michael"
    year <- "2015"
    note <- "Harvard Dataverse, V22"
    url <- "https://doi.org/10.7910/DVN/28075"
    cat("For a publication citation: \n\n  ", full, "\n\nFor a Bibtex entry: \n\n @Manual{, \n title={", title, "}, \n author={", author, "},\n year={",year,"},\n note={",note,"}, \n url={",url,"},\n}", sep = "")
  }

  else if(tn == 'phoenix_rt'){
    print("The citation is in preparation and coming soon.")
  }

  else {
    print("Please check the name of a data table!")
  }
}
