# prepare data for analysis ----

# load data
all_data <- read_rds(here(
  "02_data", "02_cleaned", "learning_data.RDS"
))

# set contrasts for shared factors (i.e. that do not differ)
contrasts(all_data$variety_exposure) <- contr.sum(4)

# save subsetted data in a list
all_data <- list(
  exposure = all_data %>% 
    filter(block == "exposure_test") %>% 
    mutate(word_type = factor(word_type)),
  testing = all_data %>% 
    filter(block == "test")
)

# set unique contrasts for word_type (i.e. 2 levels in exposure, 3 in testing)
contrasts(all_data[[1]]$word_type) <- contr.sum(2)
contrasts(all_data[[2]]$task) <- contr.sum(2)
contrasts(all_data[[2]]$word_type) <- contr.helmert(3)