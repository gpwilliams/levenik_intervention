rename_parameters <- function(model_summary, col_id = Parameter, replacements = NULL) {
  # Renames terms by collapsing strings and replacing individual
  # elements with pretty formatted elements.
  # This way, terms to replace do not need to exactly match
  # the entire string. 
  # e.g. replacing "time" with "Time" affects all terms including "time"
  # rather than the exact match of "time".
  # Inputs: 
  #   model_summary = a model summary, typically an
  #     lmer model tidied using the tidy_lme() function.
  #   col_id = a column name by which to replace all strings 
  #               (defaults to Parameter)
  # replacements = named characters by which to rename items in the column. 
  #                 (defaults to NULL)
  # Outputs: a tidied model with pretty formatted names in the col_name column,
  #         with underscores replaced with spaces, and : replaced with times symbol
  
  # backslashes escape backslashes in R so it can parse them as a string
  # you thus need four to make LaTeX symbols e.g. $\times$ = $\\\\times$
  col_names <- model_summary %>% 
    pull({{col_id}}) %>%
    str_c(collapse = "---") %>% 
    str_replace_all(c(
      replacements,
      "_" = " ",
      ":" = " : " # for LaTeX use: " $\\\\times$ "; 4 escapes properly in kableExtra
    )) %>% 
    str_split(pattern = "---") %>% 
    unlist()
  
  model_summary %>% 
    mutate({{col_id}} := str_to_title(col_names))
}