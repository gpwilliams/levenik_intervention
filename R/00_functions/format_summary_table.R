format_summary_table <- function(.data, .oldnames, .newnames, .lower = .lower, .upper = .upper, .drop) {
  .data %>% 
    dplyr::select(-{{.drop}}) %>%
    merge_CI_limits(., {{.lower}}, {{.upper}}, decimals = 3) %>% 
    rename_table_cols(., .oldnames, .newnames) %>%
    table_cols_to_title(.)
}