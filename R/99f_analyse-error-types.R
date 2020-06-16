library(tidyverse)
library(here)

r_function_list <- list.files(
  path = here("R", "00_functions"), 
  pattern = "R$",
  full.names = TRUE
)
purrr::walk(r_function_list, source)

r_file_list <- list.files(
  path = here("R", "03_analysis", "06_error_type_exploration"), 
  pattern = "R$",
  full.names = TRUE
)
purrr::walk(r_file_list, source)