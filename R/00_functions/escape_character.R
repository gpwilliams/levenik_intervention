escape_character <- function(data, col, pattern = "-", after = FALSE) {
  # Inserts a new line before or after a character in a column
  #   of strings or in level labels in a column of factors. 
  #   Used for plotting long labels on new lines.
  #   When using factors, level orders are maintained.
  #
  # Args:
  #   data: input dataframe.
  #
  #   col: bare column name of the column containing strings by which
  #         to apply the function.
  #
  #   pattern: string of characters determining where to insert the new line.
  #             Defaults to "-".
  #
  #   after: logical determining whether to insert the new line before or
  #           after the string provided in pattern. Defaults to FALSE,
  #           placing the new line after the character supplied in pattern.
  #
  # Returns: data.frame with a column of characters with a new line inserted
  #           according to the arguments in pattern and col.
  col_quo <- enquo(col)
  
  if(after == TRUE) {
    replacement <- paste0(pattern, "\n")
  } else {
    replacement <- paste0("\n", pattern)
  }
  
  if(is.factor(data %>% pull(!!col_quo))) {
    data %>% 
      ungroup() %>% 
      mutate(
        !!col_quo := fct_relabel(
          !!col_quo, 
          str_replace, 
          pattern, 
          replacement
        )
      )
  } else if(is.character(data %>% pull(!!col_quo))) {
    data %>% 
      ungroup() %>% 
      mutate(
        !!col_quo := str_replace_all(
          !!col_quo, 
          pattern, 
          replacement
        )
      )
    } else{
      stop(paste(
        "Cannot insert break in non-factor or non-character column.",
        "Consider converting column type first."
        ))
    }
}