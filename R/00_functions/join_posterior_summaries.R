join_posterior_summaries <- function(.summary, .rope, l1 = .lower, u1 = .upper, l2 = HDI_low, u2 = HDI_high) {
  point_summary_name <- unique(.summary$.point)
  
  .summary <- merge_CI_limits(
    .summary, {{l1}}, {{u1}}
  ) %>% 
    rename(
      !!point_summary_name := .value,
      ci_interval = interval
    )
  
  .rope <- merge_CI_limits(
    .rope, {{l2}}, {{u2}} 
  ) %>% 
    select(-pd, everything()) %>% 
    rename(rope_interval = interval)
  
  left_join(.summary, .rope) 
  
}