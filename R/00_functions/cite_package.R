cite_package <- function(package, cite_authors = TRUE, prefix = "R-"){
  #' Return the name and installed version of a package as a character. Optionally also returns the in-text and full citation.
  #' @param package A character for an installed package.
  #' @param cite_authors Logical. Determines whether (TRUE) or not (FALSE) to include a citation to the package authors. Defaults to TRUE.
  #' @param prefix Prefix for citations to software in the bibtex tag. Defaults to "R-".
  #' @return A character defining the \code{package} name with version number in brackets.
  #' @examples
  #' cite_package("tidyverse")
  #' cite_package("lme4")
  if (cite_authors == TRUE) {
    paste0(package, " ([Version ", packageVersion(package), "]; @", prefix, package)
  } else{
    paste0(package, " (Version ", packageVersion(package), ")")
  }
}