## ---- eval = FALSE-------------------------------------------------------
#  # installing the package without the vignette
#  devtools::install_github("KateHyoung/UTDEventData")
#  
#  # installing the package with the vignette
#  devtools::install_github("KateHyoung/UTDEventData", build_vignettes=TRUE)

## ----eval = FALSE--------------------------------------------------------
#  # Direct way as inputing an API key
#  DataTables(api_key = " ")
#  "'PHOENIX_RT', 'CLINE_PHOENIX_SWB', 'CLINE_PHOENIX_FBIS', 'CLINE_PHOENIX_NYT', 'ICEWS'"
#  
#  # Save an API key as a string value and use it so as not to repeat typing the key string in other functions
#  k<-"...api key...."
#  DataTables(k)
#  "'PHOENIX_RT', 'CLINE_PHOENIX_SWB', 'CLINE_PHOENIX_FBIS', 'CLINE_PHOENIX_NYT', 'ICEWS'"

## ---- eval = FALSE-------------------------------------------------------
#  tableVar(api_key="...", table="phoenix_rt")
#  
#  # with the saved API key to avoid the repeation of API key typing
#  k<-"...api key...."
#  tableVar(k, "phoenix_rt")
#  
#  tableVar(k, "icews")
#  
#  tableVar(k, "cline_Phoenix_swb")

## ---- eval = FALSE-------------------------------------------------------
#  tableVar(api_key="...", table="icews", lword="target")
#  
#  k <- "..api key..."
#  tableVar(k, table="icews", lword="target")
#  " Target Name"    " Target Sectors", ....

## ---- eval = FALSE-------------------------------------------------------
#  pullData(api_key=" ", table_name="Phoenix_rt", country=list("USA","MEX","SYR","CHN"), start="20171101", end="20171112", citation = TRUE)
#  
#  ## When you avoid repeating an API key into the function
#  k<-'api key...'
#  subset1 <- pullData(k, "phoenix_rt", list('canada','China'), '20171101', '20171102')
#  subset2 <- pullData(k, "icews", list('can', 'usa'), '20010101','20010110')
#  subset3 <- pullData(k, 'cline_Phoenix_NYT',list('South Korea','canada'), '19551105','19581215')
#  
#  # without citation
#  pullData(k, "phoenix_rt", list('canada','China'), '20171101', '20171102', citation = FALSE)

## ---- eval=FALSE---------------------------------------------------------
#  # Creating an object
#  obj<-Table$new()
#  
#  # Setting an object of an API key
#  obj$setAPIKey("....")
#  obj$DataTables()  # returns the available data tables in the UTD server
#  obj$tableVar("cline_Phoenix_NYT")
#  
#  # when a user wants to subset real-time data ('phoenix_rt) from 20171101 to 20171102 on MEX(Mexico)
#  obj$pullData("Phoenix_rt", list("MEX"),start="20171101", end="20171102")

## ---- eval = FALSE-------------------------------------------------------
#  # citations for Cline Phoenix Event data
#  citeData(table_name = "cline_Phoenix_swb")
#  
#  # citations for UTD real-time data
#  citeData(table_name = "Phoenix_rt")
#  
#  # citations for ICEWS
#  citeData(table_name = "ICEWS")

