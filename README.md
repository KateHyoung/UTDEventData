# UTDEventData ver. 0.8.0

This R package helps users to extract data from the UTD Event Data server by country names and time ranges. The project of the UTDEventData R package has not fully completed and is daily updated. Your comments, feedback, and suggestions are welcome to enhence the package.   
If you have any question regarding the package, please contact Kate Kim (<hyoungah.kim@utdallas.edu>).

This R package is part of a project, titled "Modernizing Political Event Data for Big Data Social Science Research". More information can be found on [the project webpage](http://eventdata.utdallas.edu/data.html).

Several functions to explore and extract data in this package are listed below. More details of these methods are illustrated in the vignette of this package. 

- Table: a reference class 
- citeData( ): for citing the package and data tables in the UTD server for publications
- DataTable( ): for looking up data tables in the UTD server 
- tableVar( ): for looking up the variables of a data table
- previewData( ): for previewing the data structure of a data table
- pullData( ): for extracting data by countries and time periods 
- entireData( ): for extracting the entire data of a data table
- getQuerySize(): for measuring the size of requested data from the UTD server
- sendQuery( ): for requesting the built query from the API server to download data

****
The Query Block functions:

- retrunTimes( ): creating a query block by time periods
- returnCountries( ): creating a query block by countries
- returnLatLon( ): creating a query block of region(s) with latitude and longitude
- returnDyad( ): creating a dyad query of both source and target actors
- returnRegExp( ): creating a query block by pattern of attributes in a data table
- orList( ): creating a union of the query blocks 
- andList( ): creating an intersection of the query blocks

This package requires you to have an API key to access to the UTD data server. Please find the following link and fill out the form to obtain an API key. 
<http://eventdata.utdallas.edu/signup>

## Installation

```
# without the vignette
devtools::install_github("KateHyoung/UTDEventData") 

# with the vignette
devtools::install_github("KateHyoung/UTDEventData", build_vignettes=TRUE)
```
## Vignette
The vignette is shown after installing the package and typing the following code in R console.

```
# access to the UTDEventData document 
vignette("UTDEventData")
```
Download the PDF version [here](https://github.com/KateHyoung/UTDEventData/raw/UTDEventData/UTDEventData.pdf)


## Authors  
Dr. Patrick T. Brandt <pbrandt@utdallas.edu>  
Dr. Vito D'Orazio <dorazio@utdallas.edu>  
Micheal J. Shoemate <michael.shoemate@utdallas.edu>  
Jared Looper <jrl140030@utdallas.edu>  
Hyoungah (Kate) Kim <hyoungah.kim@utdallas.edu>  

## License
GPL-3 <br/>
*This package is supported by the RIDIR project funded by National Science Foundatioin, Grant No. SBE-SMA-1539302.*
