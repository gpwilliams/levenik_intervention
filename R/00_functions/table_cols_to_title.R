table_cols_to_title <- function(.data) {
  .data %>% 
    dplyr::rename_all(
      ~stringr::str_to_title(base::gsub("_", " ", .))
    ) 
}