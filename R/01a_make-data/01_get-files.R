# Read Data ----

message("Making data.")

# store .csv file names in a list
file_list <- list.files(
  path = here("02_data", "01_raw"), 
  pattern = "csv$",
  full.names = TRUE
)
csv_list <- map( # read all csvs
  file_list, 
  read_csv,
  col_types = cols(),
  na = c("0000-00-00 00:00:00", "") # set any 0 datetimes or missing values to NA
) 

# get names for files and assign to data list
file_names <- list.files(
  path = here("02_data", "01_raw"), 
  pattern = "csv$",
  full.names = FALSE
) %>%
  stringr::str_sub(., start = 1, end = - 5)
names(csv_list) <- file_names