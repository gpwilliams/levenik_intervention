# Compare differences in performance across levels ----

# currently uses mean and percentile intervals

for(i in seq_along(draws)) {
  
  if(str_detect(names(draws)[[i]], "compare")) {
    model_summaries[[i]] <- draws[[i]] %>% 
      mean_qi(.value, .width = summary_options$summary_intervals) %>% 
      mutate_if(is.numeric, round, summary_options$rounding)
  }
}
names(model_summaries) <- names(draws)