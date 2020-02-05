# read data
cleaned_data <- 
  read_rds(here("02_data", "02_cleaned", "learning_data.RDS")) %>%
  mutate(
    variety_exposure = str_to_title(
      str_replace_all(variety_exposure, "_", " ")
    ),
    word_type = str_to_title(
      str_replace_all(word_type, "_", "-")
    ),
    variety_exposure = factor( # reorder variety_exposure factor levels
      variety_exposure,
      levels = c(
        "Variety Match",
        "Variety Mismatch",
        "Variety Mismatch Social",
        "Dialect Literacy"
      )),
    word_familiarity = factor(case_when(
      word_type %in% c("Contrastive", "Non-Contrastive") ~ "Trained",
      word_type == "Novel" ~ "Untrained"
      ), 
    levels = c("Trained", "Untrained")
    ),
    word_type = fct_recode(word_type, Untrained = "Novel"),
    word_type = factor( # reorder word_type
      word_type,
      levels = c(
        "Non-Contrastive", 
        "Contrastive", 
        "Untrained"
      )),
    task = factor(str_to_title(task), levels = c("Reading", "Spelling"))
  ) %>% 
  drop_na(lenient_nLED)

exposure_data <- cleaned_data %>% 
  filter(block == "exposure_test") %>% 
  mutate(word_type = factor(word_type)) %>% 
  select(-word_familiarity)

testing_data <- cleaned_data %>% 
  filter(block == "test")