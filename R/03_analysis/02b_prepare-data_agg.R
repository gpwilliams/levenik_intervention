# prepare data for analysis ----

# load data
all_data_agg <- read_rds(here(
  "02_data", "02_cleaned", "learning_data_agg.RDS"
))

# set contrasts for shared factors (i.e. that do not differ)
contrasts(all_data_agg$variety_exposure) <- contr.sum(4)

# save subsetted data in a list
all_data_agg <- list(
  exposure_agg = all_data_agg %>% 
    filter(block == "exposure_test") %>% 
    mutate(word_type = factor(word_type)),
  testing_agg = all_data_agg %>% 
    filter(block == "test")
)

# set unique contrasts for word_type (i.e. 2 levels in exposure, 3 in testing)
contrasts(all_data_agg[[1]]$word_type) <- contr.sum(2)
contrasts(all_data_agg[[2]]$task) <- contr.sum(2)
contrasts(all_data_agg[[2]]$word_type) <- contr.helmert(3)