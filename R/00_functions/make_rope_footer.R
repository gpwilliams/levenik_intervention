make_rope_footer <- function(.data, .lower = "ROPE_low", .upper = "ROPE_high", .CI = "CI"){
  paste0(
    "ROPE range = [", 
    .data[[.lower]][[1]],
    ", ",
    .data[[.upper]][[1]],
    "]. ROPE determined at the ",
    .data[[.CI]][[1]],
    "% CI of the HDI."
  )
}