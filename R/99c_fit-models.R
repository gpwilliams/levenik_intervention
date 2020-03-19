library(tidyverse)
library(rlang) # required for user-defined functions
library(here)
library(brms)

# which models to fit?
models_to_fit <- "full" # can take "aggregate", "full", or "both"

# load functions
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
    here("R", "03_analysis", "03_fit-models")
  ),
  pattern = "R$",
  full.names = TRUE
)

# run requested models
if(models_to_fit == "aggregate") {
  r_file_list <- str_subset(
    r_file_list, 
    "03a_run-analyses.R", 
    negate = TRUE
  )
} else if(models_to_fit == "full") {
  r_file_list <- str_subset(
    r_file_list, 
    "03b_run-analyses_agg.R",
    negate = TRUE
  )
} else if(models_to_fit == "both") {
  # do nothing
} else{
  stop("Please specify models to fit. Stopping fitting.")
}
purrr::walk(r_file_list, source)
# purrr::walk(r_file_list[1:9], source) # for testing