#'A hiden function for relabeling query strings of one data format to the other
#'@param queryString a querying sentence of a data format
#'@param format a format returned
#'@import jsonlite
#'@keywords internal
#'@author Micheal J. Shoemate

relabel = function(queryString, format) {

  jsonFormat = loadFormat(format)
  key = names(jsonFormat)

  for (i in 1:length(jsonFormat)) {
    if(grepl(key[[i]],queryString,fixed=TRUE) && !is.null(jsonFormat[[i]]$name))
      queryString = gsub(key[[i]], jsonFormat[[i]]$name, queryString)
  }
  return(queryString)
}


#'A hiden function for relabeling query strings of one data format to the other
#'@param format a format returned
#'@import jsonlite
#'@keywords internal

loadFormat <- function(format) {
  if(format == "phoenix_rt")
    return(f1())
  else (format== "icews")
    return(f2())
}

#'A hiden function for relabeling query strings of one data format to the other
#'@import jsonlite
#'@keywords internal

### phoenix_rt
f1 <- function() {
    jsontext = jsonlite::fromJSON("[{
                      \"<event_id>\": {
                      \"name\": \"event_id\",
                      \"format\": \".\"
                      },
                      \"<date>\": {
                      \"name\": \"date8\",
                      \"format\": \"^\\\\d{8}$\"
                      },
                      \"<year>\": {
                      \"name\": \"year\",
                      \"format\": \"^\\\\d{4}$\"
                      },
                      \"<month>\": {
                      \"name\": \"month\",
                      \"format\": \"^([1-9]|1[0-2])$\"
                      },
                      \"<day>\": {
                      \"name\": \"day\",
                      \"format\": \"^([1-9]|[12]\\\\d|3[01])$\"
                      },
                      \"<source>\": {
                      \"name\": \"source\",
                      \"format\": \"^(\\\\p{L}\\\\p{L}\\\\p{L})*$\"
                      },
                      \"<src_actor>\": {
                      \"name\": \"src_actor\",
                      \"format\": \"^\\\\p{L}\\\\p{L}\\\\p{L}$\"
                      },
                      \"<src_agent>\": {
                      \"name\": \"src_agent\",
                      \"format\": \"^(|\\\\p{L}\\\\p{L}\\\\p{L})$\"
                      },
                        \"<src_other_agent>\": {
                        \"name\": \"src_other_agent\",
                        \"format\": \"^(|(\\\\p{L}\\\\p{L}\\\\p{L}(|;))*)$\"
                        },
                      \"<target>\": {
                      \"name\": \"target\",
                      \"format\": \"^(\\\\p{L}\\\\p{L}\\\\p{L})*$\"
                      },
                      \"<tgt_actor>\": {
                      \"name\": \"tgt_actor\",
                      \"format\": \"^\\\\p{L}\\\\p{L}\\\\p{L}$\"
                      },
                      \"<tgt_agent>\": {
                      \"name\": \"tgt_agent\",
                      \"format\": \"^(|\\\\p{L}\\\\p{L}\\\\p{L})$\"
                      },
                      \"<tgt_other_agent>\": {
                      \"name\": \"tgt_other_agent\",
                      \"format\": \"^(|(\\\\p{L}\\\\p{L}\\\\p{L}(|;))*)$\"
                      },
                      \"<root_code>\": {
                      \"name\": \"root_code\",
                      \"format\": \"^(|1)\\\\d$\"
                      },
                      \"<quad_class>\": {
                      \"name\": \"quad_class\",
                      \"format\": \"^[0-4]$\"
                      },
                      \"<goldstein>\": {
                      \"name\": \"goldstein\",
                      \"format\": \"^[+-]?\\\\d+\\\\.?\\\\d+$\"
                      },
                      \"<latitude>\": {
                      \"name\": \"latitude\",
                      \"format\": \"^(NA|[+-]?\\\\d?\\\\d\\\\.?\\\\d+)$\"
                      },
                      \"<longitude>\": {
                      \"name\": \"longitude\",
                      \"format\": \"^(NA|[+-]?\\\\d?\\\\d\\\\.?\\\\d+)$\"
                      },
                      \"<geoname>\": {
                      \"name\": \"geoname\",
                      \"format\": \"^(|[\\\\p{L}\\\\s]+)$\"
                      },
                      \"<cameo>\": {
                      \"name\": \"code\",
                      \"format\": \"^\\\\d+$\"
                      },
                      \"<country_code>\": {
                      \"name\": \"country_code\",
                      \"format\": \"^(|\\\\p{L}\\\\p{L}\\\\p{L})$\"
                      },
                      \"<admin_info>\": {
                      \"name\": \"admin_info\",
                      \"format\": \"^(|[\\\\p{L}\\\\s]+)$\"
                      },
                      \"<id>\": {
                      \"name\": \"id\",
                      \"format\": \".\"
                      },
                      \"<url>\": {
                      \"name\": \"url\",
                      \"format\": \".\"
                      },
                      \"<publisher>\": {
                      \"name\": \"source_text\",
                      \"format\": \".\"
                      }
                      }]")
  #newjson = jsonlite::toJSON(jsontext, pretty = TRUE, auto_unbox = TRUE)
  return(jsontext)
}

#'A hiden function for relabeling query strings of one data format to the other
#'@import jsonlite
#'@keywords internal
##### icews
f2 <- function() {
  jsontext = jsonlite::fromJSON("{
                      \"<event_id>\": {
                      \"name\": \"Event ID\",
                      \"format\": \".\"
                      },
                      \"<date>\": {
                      \"format\": \"^\\\\d{4}-\\\\d{2}-\\\\d{2}$\"
                      },
                      \"<src_name>\": {
                      \"name\": \"Source Name\",
                      \"format\": \".*\"
                      },
                      \"<src_sectors>\": {
                      \"name\": \"Source Sectors\",
                      \"format\": \".*\"
                      },
                      \"<src_country>\": {
                      \"name\": \"Source Country\",
                      \"format\": \".*\"
                      },
                      \"<tgt_name>\": {
                      \"name\": \"Target Name\",
                      \"format\": \".*\"
                      },
                      \"<tgt_sectors>\": {
                      \"name\": \"Target Sectors\",
                      \"format\": \".*\"
                      },
                      \"<tgt_country>\": {
                      \"name\": \"Target Country\",
                      \"format\": \".\"
                      },
                      \"<goldstein>\": {
                      \"name\": \"Intensity\",
                      \"format\": \"^[+-]?\\\\d*\\\\.?\\\\d?+$\"
                      },
                      \"<latitude>\": {
                      \"name\": \"Latitude\",
                      \"format\": \"^(|NA|[+-]?\\\\d*\\\\.?\\\\d+)$\"
                      },
                      \"<longitude>\": {
                      \"name\": \"Longitude\",
                      \"format\": \"^(|NA|[+-]?\\\\d*\\\\.?\\\\d+)$\"
                      },
                      \"<city>\": {
                      \"name\": \"City\",
                      \"format\": \".*\"
                      },
                      \"<district>\": {
                      \"name\": \"District\",
                      \"format\": \".*\"
                      },
                      \"<province>\": {
                      \"name\": \"Province\",
                      \"format\": \".*\"
                      },
                      \"<country>\": {
                      \"name\": \"Country\",
                      \"format\": \".*\"
                      },
                      \"<cameo>\": {
                      \"name\": \"CAMEO Code\",
                      \"format\": \"^\\\\d+$\"
                      },
                      \"<event_text>\": {
                      \"name\": \"Event Text\",
                      \"format\": \".*\"
                      },
                      \"<id>\": {
                      \"name\": \"Story ID\",
                      \"format\": \".\"
                      },
                      \"<sentence_number>\": {
                      \"name\": \"Sentence Number\",
                      \"format\": \".*\"
                      },
                      \"<publisher>\": {
                      \"name\": \"Publisher\",
                      \"format\": \".*\"
                      }
                      }")
  return(jsontext)
}
