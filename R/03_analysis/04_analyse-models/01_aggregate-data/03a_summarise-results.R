# create summary of results ----

model_summaries <- list()

# exposure: variety, word type by variety; testing: word type by task & variety
for(i in seq_along(draws)) {
  model_summaries[[i]] <- draws[[i]] %>% 
    mean_qi(.value, .width = summary_options$summary_intervals) %>% 
    mutate_if(is.numeric, round, summary_options$rounding)
}
names(model_summaries) <- names(draws)

# testing: for novel words
model_summaries$testing_tv_n_agg <- draws$testing_tvw_agg %>% 
  ungroup() %>% 
  filter(word_familiarity == "Novel") %>% 
  select(-word_type) %>% 
  group_by(task, variety_exposure) %>% 
  mean_qi(.value, .width = summary_options$summary_intervals) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)

# testing cov (median split): for novel words
model_summaries$testing_cov_median_etv_n_agg <- 
  draws$testing_cov_median_etv_agg %>% 
  filter(word_familiarity == "Novel") %>% 
  mean_qi(.value, .width = summary_options$summary_intervals) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)
  
# do for others...
model_summaries$testing_cov_median_etvw_agg <- 
  draws$testing_cov_median_etv_agg %>% 
  filter(word_familiarity != "Novel") %>% 
  mean_qi(.value, .width = summary_options$summary_intervals) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)