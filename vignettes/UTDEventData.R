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
#  # save an API key as a string value and use it so as not to repeat typing the key string in other functions
#  k <-"...api key...."
#  DataTables(k)
#  "'PHOENIX_RT', 'CLINE_PHOENIX_SWB', 'CLINE_PHOENIX_FBIS', 'CLINE_PHOENIX_NYT', 'ICEWS'"

## ---- eval = FALSE-------------------------------------------------------
#  tableVar(api_key="...", table="phoenix_rt")
#  
#  # with the manner of using a saved API string to avoid the repeation of API key typing
#  k <-"...api key...."
#  tableVar(k, "Phoenix_rt")
#  
#  tableVar(k, "Icews")
#  
#  tableVar(k, "Cline_Phoenix_swb")

## ---- eval = FALSE-------------------------------------------------------
#  tableVar(api_key="...", table="icews", lword="target")
#  
#  # when a user wants to know the attribute that labeled as 'target' in ICEWS
#  k <- "..api key..."
#  tableVar(k, table="icews", lword="target")
#  '" Target Name"    " Target Sectors", ....'

## ---- eval = FALSE-------------------------------------------------------
#  pullData(api_key=" ", table_name="Phoenix_rt", country=list("USA","MEX","SYR","CHN"),
#           start="20171101", end="20171112", citation = TRUE)
#  
#  ## several examples of different data tables with citation texts
#  k <-'api key...'
#  subset1 <- pullData(k, "phoenix_rt", list('canada','China'), '20171101', '20171102')
#  subset2 <- pullData(k, "icews", list('can', 'usa'), '20010101','20010110')
#  subset3 <- pullData(k, 'cline_Phoenix_NYT',list('South Korea','canada'),
#                      '19551105','19581215')
#  
#  # if you don't want to prnt the data citation texts
#  pullData(k, "phoenix_rt", list('canada','China'), '20171101', '20171102',
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

## ---- eval = FALSE-------------------------------------------------------
#  # generating a query of the United States and Canada as a country restraint for real-time event data
#  ctr <- returnCounries("phoenix_rt", list("USA","CAN"))

## ---- eval = FALSE-------------------------------------------------------
#  # generates a query to return all events between July 27, 1980, and December 10, 2004 for ICEWS data
#  time <- returnTimes("icews",  "19800727", "20041210")

## ---- eval = FALSE-------------------------------------------------------
#  # generate a query with a geo-location bountry with the longitude between -80 and 30 and the longitude between 20 and 80
#  q <- returnLatLon(-80,30,20,80)

## ---- eval = FALSE-------------------------------------------------------
#  # genrate a query that a source country is Syria and a target country is the United States
#  dyad <- returnDyad(table_name, "SYR", "USA")

## ---- eval = FALSE-------------------------------------------------------
#  # genrate a query for all source actors that involved in governments in events
#  others <- returnRegExp( api_key, table_name,"GOV","Source Name")

## ---- eval = FALSE-------------------------------------------------------
#  # combine stored query blocks such as 'time' or 'q' created before
#  and_query <- andList(list(q,time))
#  
#  # subset with two or more stored query blocks such as 'q' or 'dyad'
#  or_query <- orList(list(q,dyad))

## ---- eval = FALSE-------------------------------------------------------
#  # request a data set with the list of created queries
#  sendQuery(api_key='', tabl_name ='', query = list(), citation = TRUE)
#  
#  # examples of subsetting functions
#  
#  # creating query blocks
#  # A country constrain of 'CHN' and 'USA'
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
#  
#  # a boolean logic, and, with the two query blocks
#  and_query <- andList(list(ctr, time))
#  d2 <- sendQuery(k,"phoenix_rt",and_query, TRUE)
#  
#  # to view the subset
#  head(d2$data, 10)
#  
#  # when a user wants to extract all event in US and China with the events for which the source was a government actor from the Phoenix real-time data
#  rgex <- returnRegExp(k, "phoenix_rt","GOV", "src_agent")
#  q <- andList(list(ctr, rgex))
#  data  <- sendQuery(k,"phoenix_rt",q, citation = FALSE) # no citation
#  
#  # to view the data
#  # because the option for citation was off, package's citation was not printed.
#  head(data, 10)

## ---- eval = FALSE-------------------------------------------------------
#  # estimate the data size you want to extract
#  getQuerySize('api_key', 'table_name', "query object")
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

## ---- echo=FALSE---------------------------------------------------------
# loading the package
library(UTDEventData)
k <- 'CD75737EF4CAC292EE17B85AAE4B6'

## ---- fig.height=3, fig.width=5------------------------------------------
# Note: k <- "...provided API key"
dt <- pullData(k, "Phoenix_rt", list("RUS", "SYR"),start="20180101", end="20180331", citation = F)

## querying the fight event by CAMEO codes
Fgt <- dt[dt$code=="190" | dt$code=="191" | dt$code=="192" |
          dt$code=="193" | dt$code=="194" | dt$code=="195" |
          dt$code=="1951" | dt$code=="1952" | dt$code=="196",]

Fgt <- Fgt[,1:23] ## removing url and oid

tb <- table(Fgt$country_code, Fgt$month) # monthly incidents

barplot(tb, main = "Monthly Fight Incidents between RUS and SYR", col=c("darkblue", "red"),
        legend = rownames(tb), beside=TRUE,  xlab="Month in 2018")


## ---- fig.height=3, fig.width=6, message=FALSE, warning=FALSE------------
# querying the fight event by CAMEO codes
# please checking the variable features and formats in a data set. Attribute names and formats vary by data tables

ctr<- returnCountries('icews', list('RUS', 'SYR'))
t <- returnTimes('icews', "20170101", '20171231')
qr <- andList(list(ctr, t))
dt1 <- sendQuery(k, 'icews', qr, citation = F)

dt1$`Event Date1` <- as.POSIXct(dt1$`Event Date`)
dt1$Month <-format.Date(dt1$`Event Date1`,"%m")
tab <- table(dt1$Country,  dt1$Month)

barplot(tab, col="gray", ylab='Frequency', xlab = "Month",
        main = "Monthly Event Frequency of Syria in 2017 (ICEWS)")

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
#  xtable(Compare)

## ---- eval=FALSE, message=FALSE, warning=FALSE, results="asis"-----------
#  # sorce actor is EU
#  eu <- returnRegExp(k,"Phoenix_rt","IGOEUREEC", "source")
#  # target actor is UK
#  uk <- returnRegExp(k,"Phoenix_rt","GBR", "target")
#  dyad1 <- andList(list(eu,uk))
#  dd1 <- sendQuery(k, "Phoenix_rt", dyad1, F)
#  
#  # source actor is UK
#  uk2 <- returnRegExp(k,"Phoenix_rt","GBR", "source")
#  # target actor is EU
#  eu2 <- returnRegExp(k,"Phoenix_rt","IGOEUREEC", "target")
#  dyad2 <- andList(list(eu2,uk2))
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
#  # Put the plots together
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

