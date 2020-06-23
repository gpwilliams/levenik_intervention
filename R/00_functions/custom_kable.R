custom_kable <- function(data, caption = NULL, add_footer = FALSE, ...) {
  #' Custom styling and presentation applied to kable tables.
  #' @param data A data.frame to be displayed in kable.
  #' @param caption optional string to include as a caption.
  #' @param add_footer Logical for whether or not to add a footer.
  #' @param ... String for the footer to be added.
  #' @return A kable formatted data.frame for display in html documents 
  #'     with custom styling.
  #' @examples
  #' custom_kable(data)
  #' data %>% custom_kable(.)
  
  if(add_footer == FALSE) {
    data %>% 
      kableExtra::kable(digits = 3, escape = FALSE, caption = caption) %>%
      kableExtra::kable_styling(
        bootstrap_options = c("striped", "hover"), 
        full_width = TRUE
      )
  } else {
    data %>% 
      kableExtra::kable(digits = 3, escape = FALSE, caption = caption) %>%
      kableExtra::kable_styling(
        bootstrap_options = c("striped", "hover"), 
        full_width = TRUE
      ) %>% 
      kableExtra::footnote(
        general = make_rope_footer(...)
      )
  }
}