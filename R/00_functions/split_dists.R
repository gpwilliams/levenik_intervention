split_dists <- function(data, col_id = Parameter, parameters = c("phi", "zoi", "coi"), fill_missing = "mu") {
  
  # define regex for capturing labels from the parameters
  regex_terms <- paste0(parameters, collapse = "|")
  
  # define regex for removing labels from the parameters (separated by _)
  regex_terms_replace <- paste0(paste0(parameters, "_"), collapse = "|")
  
  # create a new column by extracting all parameters, then filling in missing terms
  # with the one provided by the user (typically mu in distributional models)
  # then remove these terms from the labels in the original column
  data %>% 
    mutate(
      distribution = unlist(replace_na(str_extract_all({{col_id}}, regex_terms), fill_missing)),
      {{col_id}} := str_replace({{col_id}}, regex_terms_replace, "")
    ) %>% 
    select(distribution, everything())
}