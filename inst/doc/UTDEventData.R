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
#  # suggesting a way to avoid repetitive typing an API key into functions
#  k <-"...api key...."
#  DataTables(k)
#  "'PHOENIX_RT', 'CLINE_PHOENIX_SWB', 'CLINE_PHOENIX_FBIS', 'CLINE_PHOENIX_NYT', 'ICEWS'"

## ---- eval = FALSE-------------------------------------------------------
#  tableVar(api_key="...", table = "phoenix_rt")
#  
#  # an easy way of applying a stored API text to avoid the repeation of API key typing
#  k <-"...api key...."
#  tableVar(k, "Phoenix_rt")
#  
#  tableVar(k, "Icews")
#  
#  tableVar(k, "Cline_Phoenix_swb")

## ---- eval = FALSE-------------------------------------------------------
#  tableVar(api_key = "...", table = "icews", lword = "target")
#  
#  # when a user wants to know the attribute that labeled as 'target' in ICEWS
#  k <- "..api key..."
#  tableVar(k, table="icews", lword="target")
#  '" Target Name"    " Target Sectors", ....'

## ---- eval = FALSE-------------------------------------------------------
#  dataSample <- previewData(api_key = " ", table_name = "PHOENIX_RT")
#  View(dataSample)

## ---- eval = FALSE-------------------------------------------------------
#  ## several examples of different data tables with citation texts
#  k <-'api key...'
#  subset1 <- pullData(api_key = k, table_name = "phoenix_rt", country = list('canada','China'), start = '20171101',  end = '20171102', T)
#  
#  # to store the data only
#  data <- subset1$data
#  
#  # to print the citation texts
#  subset1$citation
#  
#  # to avoid the citation texts
#  data <- pullData(k, "phoenix_rt", list('canada','China'), '20171101', '20171102',
#           citation = FALSE)

## ---- eval=FALSE---------------------------------------------------------
#  # creating an object
#  obj <- Table$new()
#  
#  # setting an object of an API key
#  obj$setAPIKey("....")
#  obj$DataTables()  # returns the available data tables in the UTD server
#  obj$tableVar("cline_Phoenix_NYT")
#  
#  # when a user wants to subset real-time data ('phoenix_rt) from 20171101 to 20171102 on MEX(Mexico)
#  obj$pullData("Phoenix_rt", list("MEX"),start="20171101", end="20171102")

## ---- eval=FALSE---------------------------------------------------------
#  # to estimate the data size of the entire Cline_Phoenix_NYT data
#  getQuerySize(api_key = , table_name ='Cline_Phoenix_NYT', query = 'entire')
#  
#  # to download the data
#  data.nyt <- entireData(api_key = , table_name ='Cline_Phoenix_nyt', citation = FALSE)
#  View(data.nyt)

## ---- eval = FALSE-------------------------------------------------------
#  # basic usage
#  sendQuery(api_key='', tabl_name ='', query = list(), citation = TRUE)
#  
#  # to store the ICEWS subset in the vector of myData without the citation
#  # query_block is a list of the quries built by the query block functions illustrated in subchapters
#  myData <- sendQuery(api_key,"icews", query_block, citation = TRUE)
#  # store the data only
#  myData <- myData$data
#  # print citation texts only
#  myData$citation
#  
#  # without the citation text
#  myData <- sendQuery(api_key,"icews", query_block, citation = FALSE)

## ---- eval = FALSE-------------------------------------------------------
#  # genrate a query for all source actors that involved in governments in events
#  govQuery <- returnRegExp( api_key = " " , table_name = "phoenix_rt", pattern = "GOV", field = "src_agent")
#  # to subset the cline_phoenix_nyt data by year == 2001
#  nytQuery <- returnRegExp( api_key = " ", 'cline_phoenix_nyt', '2001', 'year')

## ---- eval = FALSE-------------------------------------------------------
#  # generate a query of the United States and Canada as a country restraint for real-time event data
#  ctr <- returnCountries(table_name = "phoenix_rt", country = list("USA","CAN"))

## ---- eval = FALSE-------------------------------------------------------
#  # generates a query to return all events between July 27, 1980, and December 10, 2004 for ICEWS data
#  time <- returnTimes(table_name = "icews",  start = "19800727", end = "20041210")

## ---- eval = FALSE-------------------------------------------------------
#  # generate a query with a geo-location bountry with the latitude between -80 and 30 and the longitude between 20 and 80
#  locQuery <- returnLatLon(lat1 = -80, lat2 = 30, lon1 = 20, lon2 = 80)

## ---- eval = FALSE-------------------------------------------------------
#  # genrate a query that a source country is Syria and a target country is the United States
#  dyad <- returnDyad(table_name =" " , source = "SYR", target = "USA")

## ---- eval = FALSE-------------------------------------------------------
#  # combine stored query blocks such as 'time' or 'locQuery' created before
#  and_query <- andList(query_prep = list(locQuery, time))
#  
#  # subset with two or more stored query blocks such as 'locQuery' or 'dyad'
#  or_query <- orList(query_prep = list(locQuery, dyad))

## ---- eval=FALSE---------------------------------------------------------
#  
#  # examples of subsetting functions II
#  
#  # creating query blocks
#  # a country constrain of 'CHN' and 'USA'
#  k <- 'api_key'
#  ctr <- returnCountries("phoenix_rt", list("CHN", "USA"))
#  
#  # A query of time between 2017-11-1 and 2017-11-5
#  time <- returnTimes("phoenix_rt", "20171101","20171105")
#  
#  # a boolean logic, or, with the two query blocks
#  or_query <- orList(list(ctr, time))
#  # request a data set to the API server with the package citation
#  d1 <- sendQuery(k,"phoenix_rt",or_query, TRUE)
#  
#  # to view the subset
#  head(d1$data, 10)
#  View(d1)
#  
#  # a boolean logic, and, with the two query blocks
#  and_query <- andList(list(ctr, time))
#  d2 <- sendQuery(k, "phoenix_rt", and_query, TRUE)
#  
#  # to view the subset
#  head(d2$data, 10)
#  View(d2)
#  
#  # when a user wants to extract all event in US and China with the events for which the source was a government actor from the Phoenix real-time data
#  rgex <- returnRegExp(k, "phoenix_rt","GOV", "src_agent")
#  q <- andList(list(ctr, rgex))
#  data  <- sendQuery(k,"phoenix_rt",q , citation = FALSE) # no citation
#  
#  # to view the data
#  # because the option for citation was off, package's citation was not printed.
#  head(data, 10)
#  View(data)
#  

## ---- eval = FALSE-------------------------------------------------------
#  # estimate the data size you want to extract
#  getQuerySize(api_key = " ", table_name = " ", query = list())
#  
#  # if the error message is noted, estimate the data a user has requested
#  getQuerySize(k, 'phoenix_rt', q)
#  
#  # check your memory limit only in the Windows system
#  memory.limit()
#  
#  # increase its size if you need
#  memory.size(max=120000)

## ---- eval = FALSE-------------------------------------------------------
#  # for the citations for Cline Phoenix Event data
#  citeData(table_name = "cline_Phoenix_swb")
#  
#  # for the citations for UTD real-time data
#  citeData(table_name = "Phoenix_rt")
#  
#  # for the citations for ICEWS
#  citeData(table_name = "ICEWS")

