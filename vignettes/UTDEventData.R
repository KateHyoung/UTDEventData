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
#  # By using the saved API key to avoid the repeation of API key typing
#  k<-"...api key...."
#  tableVar(k, "Phoenix_rt")
#  
#  tableVar(k, "Icews")
#  
#  tableVar(k, "Cline_Phoenix_swb")

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

## ---- eval = FALSE-------------------------------------------------------
#  # generating a query of the United States and Canada as a country restraint
#  ctr <- returnCounries("phoenix_rt", list("USA","CAN"))

## ---- eval = FALSE-------------------------------------------------------
#  # generates a query to return all events between the dates July 27, 1980, and December 10, 2004
#  time <- returnCounries(table_name,  "19800727", "20041210")

## ---- eval = FALSE-------------------------------------------------------
#  # generate a query with a geo-location bountry with the longitude between -80 and 30 and the longitude between 20 and 80
#  q <- returnLatLon(-80,30,20,80)

## ---- eval = FALSE-------------------------------------------------------
#  # genrate a query that a source country is Syria and a target country is the United States
#  dyad <- returnDayd(table_name, "SYR", "USA")

## ---- eval = FALSE-------------------------------------------------------
#  # genrate a query for all source actors that involved in governments in events
#  others <- returnRegExp( api_key, table_name,"GOV","Source Name")

## ---- eval = FALSE-------------------------------------------------------
#  # combine stored query blocks such as q or f
#  and_query <- andList(list(q,f))
#  # subset with two or more stored query blocks such as q or f
#  or_query <- orList(list(q,f))

## ---- eval = FALSE-------------------------------------------------------
#  # request a data set with the list of created queries
#  sendQuery(api_key, tabl_name, and_query)
#  
#  # examples of subsetting functions
#  
#  # creating query blocks
#  # a country constrain of CHN and USA
#  k <- 'api_key'
#  ctr <- returnCountries("phoenix_rt",list("CHN", "USA"))
#  
#  # the time range between 2017-11-1 and 2017-11-5
#  time <- returnTimes("phoenix_rt","20171101","20171105")
#  
#  # A boolean logic, or, with the two query blocks
#  or_query <- orList(list(ctr, time))
#  # request a data set to the API server
#  d1 <- sendQuery(k,"phoenix_rt",or_query)
#  
#  # A boolean logic, and, with the two query blocks
#  and_query <- andList(list(ctr, time))
#  d2 <- sendQuery(k,"phoenix_rt",and_query)
#  
#  # When a user wants to extract all event in US and China with the events for which the source was a government actor from the Phoenix real-time table
#  rgex<- returnRegExp(k, "phoenix_rt","GOV", "src_agent")
#  q <- andList(list(ctr, rgex))
#  data  <- sendQuery(k,"phoenix_rt",q)

## ---- eval = FALSE-------------------------------------------------------
#  # check your memory limit only in the Windows system
#  memory.limit()
#  # increase its size
#  memory.size(max=120000)   ## then d1 can be obtained.

