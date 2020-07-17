library(here)
library(purrr)

# render all markdown files
r_file_list <- list.files(
  path = here("R", "04_reports"), 
  pattern = "Rmd$",
  full.names = TRUE
)
purrr::walk(
  r_file_list, 
  rmarkdown::render, 
  output_dir = here("05_reports", "02_html")
)