## ---- eval = FALSE-------------------------------------------------------
#  # install the package without the vignette
#  devtools::install_github("KateHyoung/UTDEventData")
#  
#  # install the package with the vignette
#  devtools::install_github("KateHyoung/UTDEventData", build_vignettes=TRUE)

## ----eval = FALSE--------------------------------------------------------
#  # returning all data table the server contains with entering an API key
#  DataTables(api_key = " ")
#  "'PHOENIX_RT', 'CLINE_PHOENIX_SWB', 'CLINE_PHOENIX_FBIS', 'CLINE_PHOENIX_NYT', 'ICEWS'"
#  
#  # Save an API key as a string value and use it so as not to repeat typing the key string
#  # in other functions
#  k<-"...api key...."
#  DataTables(k)
#  "'PHOENIX_RT', 'CLINE_PHOENIX_SWB', 'CLINE_PHOENIX_FBIS', 'CLINE_PHOENIX_NYT', 'ICEWS'"

## ---- eval = FALSE-------------------------------------------------------
#  tableVar(api_key="...", table="phoenix_rt")
#  
#  # with the manner of using a saved API string to avoid the repeation of API key typing
#  k<-"...api key...."
#  tableVar(k, "Phoenix_rt")
#  
#  tableVar(k, "Icews")
#  
#  tableVar(k, "Cline_Phoenix_swb")

## ---- eval = FALSE-------------------------------------------------------
#  tableVar(api_key="...", table="icews", lword="target")
#  
#  # When a user wants to know the attribute that labeled as 'target' in ICEWS
#  k <- "..api key..."
#  tableVar(k, table="icews", lword="target")
#  " Target Name"    " Target Sectors", ....

## ---- eval = FALSE-------------------------------------------------------
#  pullData(api_key=" ", table_name="Phoenix_rt", country=list("USA","MEX","SYR","CHN"),
#           start="20171101", end="20171112", citation = TRUE)
#  
#  ## several examples of different data tables with citation texts
#  k<-'api key...'
#  subset1 <- pullData(k, "phoenix_rt", list('canada','China'), '20171101', '20171102')
#  subset2 <- pullData(k, "icews", list('can', 'usa'), '20010101','20010110')
#  subset3 <- pullData(k, 'cline_Phoenix_NYT',list('South Korea','canada'),
#                      '19551105','19581215')
#  
#  # without citation texts
#  pullData(k, "phoenix_rt", list('canada','China'), '20171101', '20171102',
#           citation = FALSE)

## ---- eval=FALSE---------------------------------------------------------
#  # Creating an object
#  obj<-Table$new()
#  
#  # Setting an object of an API key
#  obj$setAPIKey("....")
#  obj$DataTables()  # returns the available data tables in the UTD server
#  obj$tableVar("cline_Phoenix_NYT")
#  
#  # when a user wants to subset real-time data ('phoenix_rt) from 20171101 to 20171102
#  # on MEX(Mexico)
#  obj$pullData("Phoenix_rt", list("MEX"),start="20171101", end="20171102")

## ---- eval = FALSE-------------------------------------------------------
#  # Generating a query of the United States and Canada as a country restraint
#  ctr <- returnCounries("phoenix_rt", list("USA","CAN"))

## ---- eval = FALSE-------------------------------------------------------
#  # Generates a query to return all events between July 27, 1980,
#  # and December 10, 2004
#  time <- returnTimes(table_name,  "19800727", "20041210")

## ---- eval = FALSE-------------------------------------------------------
#  # Generate a query with a geo-location bountry with the longitude between -80 and 30
#  # and the longitude between 20 and 80
#  q <- returnLatLon(-80,30,20,80)

## ---- eval = FALSE-------------------------------------------------------
#  # Genrate a query that a source country is Syria and a target country is the United States
#  dyad <- returnDyad(table_name, "SYR", "USA")

## ---- eval = FALSE-------------------------------------------------------
#  # Genrate a query for all source actors that involved in governments in events
#  others <- returnRegExp( api_key, table_name,"GOV","Source Name")

## ---- eval = FALSE-------------------------------------------------------
#  # combine stored query blocks such as 'time' or 'q' created before
#  and_query <- andList(list(q,time))
#  
#  # subset with two or more stored query blocks such as 'q' or 'dyad'
#  or_query <- orList(list(q,dyad))

## ---- eval = FALSE-------------------------------------------------------
#  # Request a data set with the list of created queries
#  sendQuery(api_key='', tabl_name ='', query = list(), citation = TRUE)
#  
#  # Examples of subsetting functions
#  
#  # creating query blocks
#  # A country constrain of 'CHN' and 'USA'
#  k <- 'api_key'
#  ctr <- returnCountries("phoenix_rt",list("CHN", "USA"))
#  
#  # A query of time between 2017-11-1 and 2017-11-5
#  time <- returnTimes("phoenix_rt","20171101","20171105")
#  
#  # A boolean logic, or, with the two query blocks
#  or_query <- orList(list(ctr, time))
#  # request a data set to the API server with the package citation
#  d1 <- sendQuery(k,"phoenix_rt",or_query, TRUE)
#  
#  # to view the subset
#  head(d1$data, 10)
#  
#  # A boolean logic, and, with the two query blocks
#  and_query <- andList(list(ctr, time))
#  d2 <- sendQuery(k,"phoenix_rt",and_query, TRUE)
#  
#  # To view the subset
#  head(d2$data, 10)
#  
#  # When a user wants to extract all event in US and China with the events for which
#  # the source was a government actor from the Phoenix real-time table
#  rgex<- returnRegExp(k, "phoenix_rt","GOV", "src_agent")
#  q <- andList(list(ctr, rgex))
#  data  <- sendQuery(k,"phoenix_rt",q, citation = FALSE) # no citation
#  
#  # To view the data
#  # because the option for citation was off, package's citation was not printed.
#  head(data, 10)

## ---- eval = FALSE-------------------------------------------------------
#  # Estimate the data size you want to extract
#  getQuerySize('api_key', 'table_name',query objecct)
#  
#  # If the error message is noted, estimate the data a user has requested
#  getQuerySize(k, 'phoenix_rt', q)
#  
#  # Check your memory limit only in the Windows system
#  memory.limit()
#  # Increase its size if you need
#  memory.size(max=120000)

## ---- eval = FALSE-------------------------------------------------------
#  # citations for Cline Phoenix Event data
#  citeData(table_name = "cline_Phoenix_swb")
#  
#  # citations for UTD real-time data
#  citeData(table_name = "Phoenix_rt")
#  
#  # citations for ICEWS
#  citeData(table_name = "ICEWS")

