library(tidyverse)
library(ggforce)
library(here)

r_file_list <- list.files(
  path = c(
    here("02_data", "R", "01_make-data"),
    here("02_data", "R", "02_make-data-checks")
  ), 
  pattern = "R$",
  full.names = TRUE
)
map(r_file_list, source)