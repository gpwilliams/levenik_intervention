cite_package <- function(package){
  #' Return the name and installed version of a package as a character.
  #' @param package A character for an installed package.
  #' @return A character defining the \code{package} name with version number in brackets.
  #' @examples
  #' cite_package("tidyverse")
  #' cite_package("lme4")
  paste0(package, " [Version ", packageVersion(package), "]")
}