message("Writing aggregate data to file.")

# Write data to .rds files for easy loading with data types.
write_rds(
  learning_data_agg, 
  here("02_data", "02_cleaned", "learning_data_agg.rds")
)

# Write data to .csv for ease of access across systems/programs.
write_csv(
  learning_data_agg, 
  here("02_data", "02_cleaned", "learning_data_agg.csv")
)