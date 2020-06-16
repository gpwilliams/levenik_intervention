round_pad <- function(x, digits = 2) {
  #' Rounds digits allowing for trailing zeroes
  #' @return a character vector of rounded digits allowing trailing zeroes.
  #' @param x numeric vector
  #' @param digits integer for number of digits to round to. Defaults to 2.
  #' @examples 
  #' round_pad(0.312, digits = 2)
  formatC(round(x, digits), format = "f", digits = digits)
}