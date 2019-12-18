# create summary of results ----

model_summaries <- list()

# exposure: variety, word type by variety; testing: word type by task & variety
for(i in seq_along(draws)) {
  model_summaries[[i]] <- draws[[i]] %>% 
    median_qi(.value, .width = summary_options$summary_intervals) %>% 
    mutate_if(is.numeric, round, summary_options$rounding)
}
names(model_summaries) <- names(draws)

# testing cov (median split): for novel words
model_summaries$testing_cov_median_etv_n <- 
  draws$testing_cov_median_etv %>% 
  filter(word_familiarity == "Novel") %>% 
  median_qi(.value, .width = summary_options$summary_intervals) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)
  
# do for others...
model_summaries$testing_cov_median_etvw <- 
  draws$testing_cov_median_etv %>% 
  filter(word_familiarity != "Novel") %>% 
  median_qi(.value, .width = summary_options$summary_intervals) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)