#########################################################
################ Citation functions #####################
################    Kate H. Kim     #####################
#########################################################
#' Obtaining the text or Bibtax to properly cite the data downloaded from the UTD Event data server for publications
#' @description This function returns the citation texts in text and Bibtex formats of data sets a user extracts
#' by the UTDEventData package.
#' @param table_name a name of a data table a user specifies. Your input is NOT
#' case-sensitive.
#' @return The texts of proper citations for publication in text and Bibtex formats
#' @note The citation texts for the package can be found after requesting data with `pullData()` or 'sendQeury()`.
#' @export
#' @examples \dontrun{# citations for Cline Phoenix Event data
#' citeData("cline_Phoenix_swb")
#' # citations for ICEWS
#' citeData("icews")
#' # citations for real-time phoenix data
#' citeData("phoenix_rt")}
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
    full <- "Brandt, Patrick T., Vito D\u0092Orazio, Jennifer Holmes, Latifur Khan, Vincent Ng. 2018. \u0093Phoenix real time event data.\u0094 University of Texas Dallas, http://eventdata.utdallas.edu"
    title <- "Phoenix real time event data"
    autho <- "Brandt, Patrick T.; D\u0092Orazio, Vito; Holmes, Jennifer; Khan, Latifur; Ng, Vincent"
    year <- "2018"
    note <- "University of Texas Dallas"
    url <- "http://eventdata.utdallas.edu"
    cat("For a publication citation: \n\n  ", full, "\n\nFor a Bibtex entry: \n\n @Manual{, \n title={", title, "}, \n author={", author, "},\n year={",year,"},\n note={",note,"}, \n url={",url,"},\n}", sep = "")
  }

  else {
    print("Please check the name of a data table!")
  }
}