message("Writing data to file.")

# Write data to .rds files for easy loading with data types.
write_rds(demographics, here("02_data", "02_cleaned", "demographics.rds"))
write_rds(learning_data, here("02_data", "02_cleaned", "learning_data.rds"))

# Write data to .csv for ease of access across systems/programs.
write_csv(demographics, here("02_data", "02_cleaned", "demographics.csv"))
write_csv(learning_data, here("02_data", "02_cleaned", "learning_data.csv"))


agg_data

item_data