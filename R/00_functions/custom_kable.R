custom_kable <- function(data, add_footer = FALSE, ...) {
  #' Custom styling and presentation applied to kable tables.
  #' @param data A data.frame to be displayed in kable.
  #' @return A kable formatted data.frame for display in html documents 
  #'     with custom styling.
  #' @examples
  #' custom_kable(data)
  #' data %>% custom_kable(.)
  
  if(add_footer == FALSE) {
    data %>% 
      kableExtra::kable(digits = 3, escape = FALSE) %>%
      kableExtra::kable_styling(
        bootstrap_options = c("striped", "hover"), 
        full_width = TRUE
      )
  } else {
    data %>% 
      kableExtra::kable(digits = 3, escape = FALSE) %>%
      kableExtra::kable_styling(
        bootstrap_options = c("striped", "hover"), 
        full_width = TRUE
      ) %>% 
      kableExtra::footnote(
        general = make_rope_footer(...)
      )
  }
}