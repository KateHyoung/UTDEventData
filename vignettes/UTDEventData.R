## ----style, echo = FALSE, results = 'asis'---------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ---- eval = FALSE---------------------------------------------------------
#  devtools::install_github("KateHyoung/UTDEventData")

## ---- echo=FALSE, results='asis'-------------------------------------------
knitr::kable(head(mtcars, 10))

