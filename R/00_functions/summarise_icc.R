summarise_icc <- function(icc_model, round = 3) {
  # Produces a string summary of the model returned from
  # irr:icc(), using rounding with left padding on all values
  # Inputs: icc_model = Model produced using irr:icc()
  #         round = 3 (default), numeric indicating by how many decimals 
  #                 to round. This also controls the padding of values.
  # Outputs: String summary of model
  # Depends on papa (and thus papa_engine) and round_pad
  icc_summary <- icc_model[c(
    "df1",
    "df2",
    "Fvalue",
    "p.value",
    "value",
    "conf.level",
    "lbound",
    "ubound"
  )]
  
  # extract p-value and print prettily
  p_value <- papa(icc_model$p.value, asterisk = FALSE)
  
  if(!grepl("<", p_value)) {
    # if p doesn't contain a less than, add an equals
    p_value <- paste("=", p_value, sep = " ")
  }
  
  with(
    lapply(icc_summary, round_pad, round),
    paste0(
      "F(",
      df1,
      ", ",
      df2,
      ") = ",
      Fvalue,
      ", $p$ ",
      p_value,
      ", ICC = ",
      value,
      ", ",
      substr(conf.level, 3, 4), # make into %
      "% CI = [",
      lbound, "; ",
      ubound,
      "]"
    )
  )
}