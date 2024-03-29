cite_packages <- function(package_string, cite_authors = TRUE, prefix = "R-", as_string = TRUE){
  #' Return the name and installed version of one or more installed packages passed as a character vector.
  #' @param package A character vector of one or more installed packages.
  #' @param cite_authors Logical determining whether or not to also include an external citation to a bibtex file using the same label as the package name along with an optional prefix.
  #' @param prefix A string defaulting to "R-" for any prefixes to R-package names in the external bibtex file.
  #' @param as_string Logical determining whether the returned output is formatted as a string in English (TRUE) or as a list (FALSE). Defaults to TRUE.
  #' @return A string or list of packages from \code{package_string} with version number in brackets.
  #' @examples
  #' cite_packages("tidyverse", as_string = TRUE)
  #' cite_packages("tidyverse", as_string = FALSE)
  #' cite_packages(c("tidyverse", "lme4"))
  if(length(package_string) > 1) {
    all_packages <- base::lapply(package_string, cite_package, cite_authors = TRUE, prefix = "R-")
    if(as_string == TRUE) {
      but_last_packages <- toString(all_packages[1:length(all_packages)-1])
      last_package <- base::toString(all_packages[length(all_packages)])
      base::paste0(but_last_packages, ", and ", last_package)
    } else if(as_string == FALSE){
      all_packages
    }
  } else {
    if(as_string == TRUE) {
      base::toString(cite_package(package_string, cite_authors = TRUE, prefix = "R-"))
    } else if(as_string == FALSE) {
      cite_package(package_string, cite_authors = TRUE, prefix = "R-")
    }
  }
}