# UTDEventData ver. 1.0.0

This R package helps users to extract data from the UTD Event Data server by country names and time ranges. The project of the UTDEventData R package has not fully completed and is daily updated. Your comments, feedback, and suggestions are welcome to enhence the package.   
If you have any question regarding the package, please contact Kate Kim (<hyoungah.kim@utdallas.edu>).

This R package is part of a project, titled "Modernizing Political Event Data for Big Data Social Science Research". More information can be found on [the project webpage](http://eventdata.utdallas.edu/data.html).

Several functions to explore and extract data in this package are listed below. More details of these methods are illustrated in the vignette of this package. 

- Table: a reference class 
- citeData( ): for citing the package and data tables in the UTD server for publications
- DataTable( ): for looking up data tables in the UTD server 
- tableVar( ): for looking up the variables of a data table
- previewData( ): for previewing the data structure of a data table
- pullData( ): for downloading data by countries and time periods 
- entireData( ): for downloading an entire data table
- getQuerySize(): for measuring the size of requested data from the UTD server
- sendQuery( ): for requesting built queries from the API server to download data

****
The Query Block functions:

- retrunTimes( ): creating a query block by time periods
- returnCountries( ): creating a query block by countries
- returnLatLon( ): creating a query block of region(s) with latitude and longitude
- returnDyad( ): creating a dyad query of both source and target actors
- returnRegExp( ): creating a query block by pattern of attributes in a data table
- orList( ): creating a union of query blocks 
- andList( ): creating an intersection of query blocks

This package requires you to have an API key to access to the UTD data server. Please find the following link and fill out the form to obtain an API key. 
<http://eventdata.utdallas.edu/signup>

## Installation

```
# without the vignette
devtools::install_github("KateHyoung/UTDEventData") 

# with the vignette
devtools::install_github("KateHyoung/UTDEventData", build_vignettes=TRUE)
```
## UTD API key
This package requires users to have a UTD API key to access to the UTD data server. Please find the following link and fill out the form to obtain an API key: <http://eventdata.utdallas.edu/signup>.

### Handling an API key
#### Store an API key in a R memory
This approach is to simply store an API key in a global environment of R and call it when you want to use it. Although it is simple, the API key should be re-entered when a R is re-run. 
```
k <- '...your API key....'
DataTables(k)
```

#### Store an API key as an environment variable 
This option is to declare user's API key as an environemtn variable and use it by `Sys.getenv()`. This option helps users to avoid a hassle to input the key each time. 
```
Sys.setenv(UTDAPIKEY = "...your API key...")
DataTables(Sys.getenv("UTDAPIKEY"))
```

## Data Samples
Users can download 100 observations of data tables stored in the UTD server.
```
dataSample <- previewData(utd_api_key = " ", table_name = "PHOENIX_RT")
View(dataSample)
```
## Downloading Data
The simaple way to retreive data is using `pullData()` with country names and date of interestring events. 
```
k <-'utd api key...'
subset1 <- pullData(utd_api_key = k, table_name = "phoenix_rt", country = list('canada','China'), start = '20171101',  end = '20171102', T)
```
This package also prepares the more flexible and customer building data query method with the `sendQuery()` function. More details on this method is illustrated in package's vignette. 

## Vignette
The vignette is shown after installing the package and typing the following code in R console.

```
# access to the UTDEventData document 
vignette("UTDEventData")
```
Download the PDF version [here](https://github.com/KateHyoung/UTDEventData/raw/UTDEventData/UTDEventData.pdf)


## Authors  
Hyoungah (Kate) Kim <hyoungah.kim@utdallas.edu> (Maintainer)  
Dr. Patrick T. Brandt <pbrandt@utdallas.edu>  
Dr. Vito D'Orazio <dorazio@utdallas.edu>  
Dr. Latifur Khan <lkhan@utdallas.edu>  
Micheal J. Shoemate <michael.shoemate@utdallas.edu>   
Sayeed Salam <sxs149331@utdallas.edu>  
Jared Looper <jrl140030@utdallas.edu>    
 
 
## Community Guidelines
This project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms. Feedback, bug reports, and feature requests [here](hhttps://github.com/KateHyoung/UTDEventData/issues). In addition to this R library contributions, you can request to store a dataset in the UTD Event Data server by contacting one of the authors. Those who request to store data as collaborators also agree to abide by its terms specified in the [Contributor Code of Conduct](CONDUCT.md).


## License
GPL-3 <br/>
*This package is supported by the RIDIR project funded by National Science Foundatioin, Grant No. SBE-SMA-1539302.*
