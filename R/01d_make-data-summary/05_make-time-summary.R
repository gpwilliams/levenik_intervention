# Make time to complete ----

message("Making time summary.")

time_to_complete <- demographics %>% 
  mutate(time_to_complete = end_timestamp - start_timestamp) %>% 
  summarise(
    mean_minutes = mean(time_to_complete),
    sd_minutes = sd(time_to_complete),
    min_minutes = min(time_to_complete),
    max_minutes = max(time_to_complete)
  )

# save output
write_csv(
  time_to_complete, 
  here("02_data", "04_summaries", "time_to_complete.csv")
)
