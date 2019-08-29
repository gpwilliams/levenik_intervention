# Write data to .csv for ease of access across systems/programs.
write_csv(
  transcription_by_participant, 
  here("02_data", "03_checks", "transcription_by_participant.csv")
)
write_csv(
  transcription_by_trial, 
  here("02_data", "03_checks", "transcription_by_trial.csv")
)
write_csv(
  list_counts, 
  here("02_data", "03_checks", "list_counts.csv")
)