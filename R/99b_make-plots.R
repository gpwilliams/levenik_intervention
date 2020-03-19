library(tidyverse)
library(ggforce) # for facet_wrap_paginate
library(ggrepel) # for direct labels
library(here)

r_function_list <- list.files(
  path = here("R", "00_functions"), 
  pattern = "R$",
  full.names = TRUE
)
purrr::walk(r_function_list, source)

r_file_list <- list.files(
  path = here("R", "02_make-plots"), 
  pattern = "R$",
  full.names = TRUE
)
purrr::walk(r_file_list, source)