# Write data to .csv for ease of access across systems/programs.
write_csv(
  summary_nLED_zo_inclusive, 
  here("02_data", "04_summaries", "summary_nLED_zo_inclusive.csv")
)
write_csv(
  summary_nLED_zo_exclusive, 
  here("02_data", "04_summaries", "summary_nLED_zo_exclusive.csv")
)
write_csv(
  summary_nLED_zo_only, 
  here("02_data", "04_summaries", "summary_nLED_zo_only.csv")
)