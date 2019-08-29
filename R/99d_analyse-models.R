library(tidyverse)
library(rlang) # required for user-defined functions
library(here)
library(brms)
library(tidybayes) # simple draws from fitted model
library(bayestestR) # for ROPE calculations
library(modelr) # for defining conditions for draws from posterior
library(ggforce) # for arrows

# load models
models <- list(
  exposure_agg = read_rds(here(
    "04_analysis", 
    "01_models", 
    "exposure_model_agg.rds"
  )),
  testing_agg = read_rds(here(
    "04_analysis", 
    "01_models", 
    "testing_model_agg.rds"
  )),
  testing_cov_agg = read_rds(here(
    "04_analysis", 
    "01_models", 
    "testing_cov_model_agg.rds"
  ))  
)

# load functions
r_function_list <- list.files(
  path = here("R", "00_functions"), 
  pattern = "R$",
  full.names = TRUE
)
purrr::walk(r_function_list, source)

# source files
r_file_list <- list.files(
  path = c(
    here("R", "03_analysis"),
    here("R", "03_analysis", "04_analyse-models")
  ),
  pattern = "R$",
  full.names = TRUE
)
purrr::walk(r_file_list, source)