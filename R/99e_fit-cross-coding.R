# Inter-rater reliability and coding checks ----

# Runs checks of IRR (mainly ICC) and
# saves anything with missing nLEDS (for manual checks after coding)

library("here")
library("tidyverse")
library("irr")

r_function_list <- list.files(
  path = here("R", "00_functions"), 
  pattern = "R$",
  full.names = TRUE
)
purrr::walk(r_function_list, source)

# get file paths
r_file_list <- list.files(
  path = c(
    here("R", "03_analysis"),
    here("R", "03_analysis", "05_cross-coding")
  ),
  pattern = "R$",
  full.names = TRUE
)

purrr::walk(r_file_list, source)