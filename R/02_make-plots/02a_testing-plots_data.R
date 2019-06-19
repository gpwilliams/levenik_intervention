# read data
testing_data <- 
  read_rds(here("02_data", "02_cleaned", "learning_data.RDS")) %>%
  filter(block == "test") %>%
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
    word_familiarity = case_when(
      word_type %in% c("Contrastive", "Non-Contrastive") ~ "Trained Word",
      word_type == "Novel" ~ "Novel Word"
    ),
    word_familiarity = factor(
      word_familiarity, levels = c("Trained Word", "Novel Word")
    ),
    word_type = factor(
      word_type,
      levels = c(
        "Non-Contrastive",
        "Contrastive",
        "Novel"
      )
    ),
    task = str_to_title(task)
  ) %>% 
  drop_na(lenient_nLED)