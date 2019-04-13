## ---- eval = FALSE-------------------------------------------------------
#  # install the package without the vignette
#  devtools::install_github("KateHyoung/UTDEventData")
#  
#  # install the package with the vignette
#  devtools::install_github("KateHyoung/UTDEventData", build_vignettes=TRUE)

## ---- eval = FALSE-------------------------------------------------------
#  # to cite the package
#  citation("UTDEventData")
#  
#  # to cite a data table
#  citeData(table_name = "Data table name")

## ----eval = FALSE--------------------------------------------------------
#  # returning all data table the server contains with entering an API key
#  DataTables(utd_api_key = " ")
#  "'PHOENIX_RT', 'CLINE_PHOENIX_SWB', 'CLINE_PHOENIX_FBIS', 'CLINE_PHOENIX_NYT', 'ICEWS'"
#  
#  # suggesting a way to avoid repetitive typing an API key into functions
#  k <-"...api key...."
#  DataTables(k)
#  "'PHOENIX_RT', 'CLINE_PHOENIX_SWB', 'CLINE_PHOENIX_FBIS', 'CLINE_PHOENIX_NYT', 'ICEWS'"

## ---- eval = FALSE-------------------------------------------------------
#  tableVar(utd_api_key="...", table = "phoenix_rt")
#  
#  # an easy way of applying a stored API text to avoid the repeation of API key typing
#  k <-"...api key...."
#  tableVar(k, "Phoenix_rt")
#  
#  tableVar(k, "Icews")
#  
#  tableVar(k, "Cline_Phoenix_swb")

## ---- eval = FALSE-------------------------------------------------------
#  tableVar(utd_api_key = "...", table = "icews", lword = "target")
#  
#  # when a user wants to know the attribute that labeled as 'target' in ICEWS
#  k <- "..api key..."
#  tableVar(k, table="icews", lword="target")
#  '" Target Name"    " Target Sectors", ....'

## ---- eval = FALSE-------------------------------------------------------
#  dataSample <- previewData(utd_api_key = " ", table_name = "PHOENIX_RT")
#  View(dataSample)

## ---- eval = FALSE-------------------------------------------------------
#  ## several examples of different data tables with citation texts
#  k <-'utd api key...'
#  subset1 <- pullData(utd_api_key = k, table_name = "phoenix_rt", country = list('canada','China'), start = '20171101',  end = '20171102', T)
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
#  k <- '...your API key....'
#  DataTables(k)

## ---- eval=FALSE---------------------------------------------------------
#  Sys.setenv(UTDAPIKEY = "...your API key...")
#  DataTables(Sys.getenv("UTDAPIKEY"))

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
#  getQuerySize(utd_api_key = , table_name ='Cline_Phoenix_NYT', query = 'entire')
#  
#  # to download the data
#  data.nyt <- entireData(utd_api_key = , table_name ='Cline_Phoenix_nyt', citation = FALSE)
#  View(data.nyt)

## ---- eval = FALSE-------------------------------------------------------
#  # basic usage
#  sendQuery(utd_api_key='', tabl_name ='', query = c(), citation = TRUE)
#  
#  # to store the ICEWS subset in the vector of myData without the citation
#  # query_block is a list of the quries built by the query block functions illustrated in subchapters
#  dyad <- returnDyad('icews', 'PAK', 'IND')
#  time <- returnTimes("icews","20180901","20181031")
#  query_block <- andList(c(time, dyad))
#  myData <- sendQuery('utd_api_key',"icews", query_block, citation = TRUE)
#  # store the data only
#  myData <- myData$data
#  # print citation texts only
#  myData$citation
#  
#  # without the citation text
#  myData <- sendQuery(utd_api_key,"icews", query_block, citation = FALSE)

## ---- eval = FALSE-------------------------------------------------------
#  # genrate a query for all source actors that involved in governments in events
#  govQuery <- returnRegExp( utd_api_key = " " , table_name = "phoenix_rt", pattern = "GOV", field = "src_agent")
#  # to subset the cline_phoenix_nyt data by year == 2001
#  nytQuery <- returnRegExp( utd_api_key = " ", 'cline_phoenix_nyt', '2001', 'year')

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
#  and_query <- andList(query_prep = c(locQuery, time))
#  
#  # subset with two or more stored query blocks such as 'locQuery' or 'dyad'
#  or_query <- orList(query_prep = c(locQuery, dyad))

## ---- eval = FALSE-------------------------------------------------------
#  # estimate the data size you want to extract
#  getQuerySize(utd_api_key = " ", table_name = " ", query = list())
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

## ---- eval = F, fig.height=3, fig.width=5--------------------------------
#  
#  # Option 1: pullData()
#  # Note: k <- "...provided API key"
#  dt <- pullData(k, "Phoenix_rt", list("RUS", "SYR"),start="20180101", end="20180331", citation = F)
#  
#  # Option 2: SendQuery() and the query block functions: returnTimes(), returnCountries()
#  
#  ctr<- returnCountries("Phoenix_rt", list('RUS', 'SYR'))
#  t <- returnTimes("Phoenix_rt", "20180101", '20180331')
#  q <- andList(c(ctr, t))
#  dt1 <- sendQuery(k, "Phoenix_rt", q, citation = F)
#  
#  ## querying the fight event by CAMEO codes
#  Fgt <- dt[dt$code=="190" | dt$code=="191" | dt$code=="192" |
#            dt$code=="193" | dt$code=="194" | dt$code=="195" |
#            dt$code=="1951" | dt$code=="1952" | dt$code=="196",]
#  
#  Fgt <- Fgt[,1:23] ## removing url and oid
#  
#  tb <- table(Fgt$country_code, Fgt$month) # monthly incidents
#  
#  barplot(tb, main = "Monthly Fight Incidents between RUS and SYR", col=c("darkblue", "red"),
#          legend = rownames(tb), beside=TRUE,  xlab="Month in 2018")
#  

## ---- eval=FALSE, message=FALSE, warning=FALSE, results="asis"-----------
#  # creating the query of source = 'PAK' and target = 'IND' for ICEWS
#  query <- returnDyad('icews', 'PAK', 'IND')
#  tmp <- sendQuery(k, 'icews', query, citation = F)
#  # the query for Phoenix_Cline_SWB
#  q.cline.swb <- returnDyad('cline_phoenix_swb', 'PAK', 'IND')
#  tmp.swb <- sendQuery(k, 'cline_phoenix_swb', q.cline.swb, F)
#  # the query for Phoenix_Cline_FBIS
#  q.cline.fbis <- returnDyad('cline_phoenix_fbis', 'PAK', 'IND')
#  tmp.fbis <- sendQuery(k, 'cline_phoenix_fbis', q.cline.fbis, F)
#  # the query for Phoenix_Cline_NYT
#  q.cline.nyt <- returnDyad('cline_phoenix_nyt', 'PAK', 'IND')
#  tmp.nyt <- sendQuery(k, 'cline_phoenix_nyt', q.cline.nyt, F)
#  # save each observation as a data set and print it
#  Compare <- as.matrix(cbind(nrow(tmp), nrow(tmp.swb), nrow(tmp.fbis), nrow(tmp.nyt)))
#  colnames(Compare) <- c("ICEWS", "Phoenix SWB", "Phoenix FBIS", "Phoenix NYT")
#  knitr::kable(Compare)

## ---- eval=FALSE, message=FALSE, warning=FALSE, results="asis"-----------
#  # sorce actor is EU
#  eu <- returnRegExp(k,"Phoenix_rt","IGOEUREEC", "source")
#  # target actor is UK
#  uk <- returnRegExp(k,"Phoenix_rt","GBR", "target")
#  dyad1 <- andList(c(eu,uk))
#  dd1 <- sendQuery(k, "Phoenix_rt", dyad1, F)
#  
#  # source actor is UK
#  uk2 <- returnRegExp(k,"Phoenix_rt","GBR", "source")
#  # target actor is EU
#  eu2 <- returnRegExp(k,"Phoenix_rt","IGOEUREEC", "target")
#  dyad2 <- andList(c(eu2,uk2))
#  dd2 <- sendQuery(k, "Phoenix_rt", dyad2, F)
#  
#  # reshaping data
#  EU_UK <- as.data.frame(table(dd1$date8, dd1$quad_class))
#  colnames(EU_UK) <- c("day", "quadclass", "count")
#  EU_UK  <- reshape(EU_UK, idvar = "day", timevar = "quadclass", direction = "wide")
#  colnames(EU_UK) <- c("date","qc0","qc1","qc2","qc3","qc4")
#  EU_UK <- t(EU_UK)
#  EU_UK <- EU_UK[-1,]
#  
#  UK_EU <- as.data.frame(table(dd2$date8, dd2$quad_class))
#  colnames(UK_EU) <- c("day", "quadclass", "count")
#  UK_EU  <- reshape(UK_EU, idvar = "day", timevar = "quadclass", direction = "wide")
#  colnames(UK_EU) <- c("date","qc0","qc1","qc2","qc3","qc4")
#  UK_EU <- as.matrix(UK_EU)
#  UK_EU <- t(UK_EU)
#  colnames(UK_EU) <- UK_EU[1,]
#  UK_EU <- UK_EU[-1,]
#  
#  # plotting
#  par(mfrow=c(2,1))
#  barplot(EU_UK, col=c("white","blue","purple","orange", "red"),
#          ylab= "Event counts",
#          main = expression(source:~E.U. %->% ~target:~U.K.))
#  legend("topright", c("Neutral", "Verbal Cooperation", "Material Cooperation",
#                       "Verbal Conflict", "Material Conflict"),
#         fill=c("white","blue","purple","orange", "red"))
#  barplot(UK_EU, col=c("white","blue","purple","orange", "red"),
#          ylab= "Event counts",
#          main = expression(source:~U.K. %->% ~target:~E.U.))

