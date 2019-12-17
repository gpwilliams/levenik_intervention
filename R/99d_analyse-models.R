library(tidyverse)
library(rlang) # required for user-defined functions
library(here)
library(brms)
library(tidybayes) # simple draws from fitted model
library(bayestestR) # for ROPE calculations
library(modelr) # for defining conditions for draws from posterior
library(ggforce) # for arrows
library(readr) # for reading and writing rds files

# which models to summarise?
models_to_summarise <- "full" # can take "aggregate", "full", or "both"
models <- list()
r_file_list <- list()

# load models
if(models_to_summarise %in% c("aggregate", "both")) {
  
  models[["exposure_agg"]] <- read_rds(here(
      "04_analysis", 
      "01_models", 
      "exposure_model_agg.rds"
    ))
  
  models[["testing_agg"]] <- read_rds(here(
      "04_analysis", 
      "01_models", 
      "testing_model_agg.rds"
    ))
  
  models[["testing_cov_agg"]] <- read_rds(here(
      "04_analysis", 
      "01_models", 
      "testing_cov_model_agg.rds"
    ))  
}

if(models_to_summarise %in% c("full", "both")) {
  
  models[["exposure"]] <- read_rds(here(
      "04_analysis", 
      "01_models", 
      "exposure_model.rds"
    ))
  
  models[["testing"]] = read_rds(here(
      "04_analysis", 
      "01_models", 
      "testing_model.rds"
    ))
  
  models[["testing_cov"]] = read_rds(here(
      "04_analysis", 
      "01_models", 
      "testing_cov_model.rds"
    ))  
}

# load functions
r_function_list <- list.files(
  path = here("R", "00_functions"), 
  pattern = "R$",
  full.names = TRUE
)
purrr::walk(r_function_list, source)

# source files
if(models_to_summarise %in% c("aggregate", "both")) {
  
  r_file_list <- c(
    r_file_list, 
    list.files(
      path = c(
        here("R", "03_analysis"),
        here("R", "03_analysis", "04_analyse-models", "01_aggregate-data")
      ),
      pattern = "R$",
      full.names = TRUE
    )
  )
}

if(models_to_summarise %in% c("full", "both")) {
  
  r_file_list <- c(
    r_file_list,
    list.files(
      path = c(
        here("R", "03_analysis"),
        here("R", "03_analysis", "04_analyse-models", "02_full-data")
      ),
      pattern = "R$",
      full.names = TRUE
      )
    )
}
# remove duplicates
r_file_list <- unique(r_file_list)

purrr::walk(r_file_list, source)