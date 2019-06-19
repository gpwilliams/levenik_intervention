library(tidyverse)
library(ggforce) # for facet_wrap_paginate
library(ggrepel) # for direct labels
library(here)
library(ggridges)

r_file_list <- list.files(
  path = c(
    here("R", "01a_make-data"),
    here("R", "01b_make-data-checks"),
    here("R", "01c_make-data-summary")
  ), 
  pattern = "R$",
  full.names = TRUE
)
purrr::walk(r_file_list, source)