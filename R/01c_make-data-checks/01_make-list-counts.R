# get a summary of the number of participants in each list

message("Performing data checks.")

# define groups that are involved in assigning lists
list_groups <- c(
  "order_condition", 
  "speaker_gender", 
  "language_condition", 
  "social_cue_condition", 
  "dialect_training_condition", 
  "dialect_location_condition"
)

# count numbers in each valid and invalid combination
list_summary <- demographics %>%
  mutate(
    dialect_location_condition = 
      fct_explicit_na(dialect_location_condition, na_level = "NA")) %>% 
  group_by_at(list_groups) %>%
  summarise(n = length(unique(participant_number))) %>%
  ungroup()

# join counts with list IDs
list_counts <- full_join(
  csv_list[["lists"]] %>% mutate_all(as.factor), 
  list_summary, 
  by = list_groups
)