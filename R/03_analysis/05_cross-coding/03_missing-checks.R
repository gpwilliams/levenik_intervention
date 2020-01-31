# Missing input checks ----

# Check submissions with no clearly identifiable or missing input
# this is used purely for manual data checks to be sure that each
# item is coded correctly.

# extract all data with x, *, ?, or NA
data_checks <- data_subset %>%
  filter(
    primary_coder_transcription == "?" |
    secondary_coder_transcription == "?" |
    primary_coder_transcription == "x" |
    secondary_coder_transcription == "x" |
    primary_coder_transcription == "*" |
    secondary_coder_transcription == "*" |
    is.na(primary_coder_transcription) |
    is.na(secondary_coder_transcription)
  )

# save outputs
write.csv(
  data_checks,
  file = here(
    "04_analysis", 
    "03_cross-coding", 
    "missing-submissions.csv"
  )
)