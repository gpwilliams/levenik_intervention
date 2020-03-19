merge_CI_limits <- function(data, lower, upper, round = TRUE, decimals = 2) {
  # Pastes two columns together in brackets separated by a comma
  # Use: used to paste lower and upper CI together after tidying model with
  #       tidy_ordinal_model()
  # Inputs: data = data.frame with lower and upper CI bounds as columns
  #         lower = bare (unquoted) name of lower confidence limit column name
  #         upper = bare (unquoted) name of upper confidence limit column name
  #         round = TRUE (default), logical indicating whether or not to round
  #                 values in the CI columns prior to pasting (recommended)
  #         decimals = 2 (default), integer indicating how many values to
  #             round numbers by if rounding occurs. Ignored if round = FALSE.
  # Returns: data.frame with merged CI levels in one column, with prior
  #           lower and upper bound columns removed.
  
  # force standard evaluation; used with !! later
  
  if(round == TRUE) {
    data %>% mutate("interval" = paste0(
      "[", 
      # formatC used to force R to keep trailing zeroes
      formatC(round({{lower}}, decimals), format = "f", digits = decimals), 
      ", ", 
      formatC(round({{upper}}, decimals), format = "f", digits = decimals),
      "]"
    )) %>%
      select(-{{lower}}, -{{upper}})
  } else {
    data %>% 
      mutate("interval" = paste0("[", {{lower}}, ", ", {{upper}}, "]")) %>%
      select(-{{lower}}, -{{upper}})
  }
}