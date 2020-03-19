format_posterior_summary <- function(.data, .drop){
  .data %>% 
    dplyr::select(-{{.drop}}) %>% 
    table_cols_to_title(.)
}