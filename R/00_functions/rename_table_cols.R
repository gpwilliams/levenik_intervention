rename_table_cols <- function(.data, .oldnames, .newnames) {
  names(.oldnames) <- .newnames
  
  .data %>% 
    dplyr::rename(!!!.oldnames)
}