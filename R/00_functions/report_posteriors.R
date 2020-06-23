report_posteriors <- function(
  .summary, .rope, .width, .drop, .oldnames, .newnames, l1 = .lower, u1 = .upper, l2 = HDI_low, u2 = HDI_high
) {
  join_posterior_summaries(
    .summary %>% filter(.width == {{.width}}), 
    .rope,
    l1 = {{l1}},
    u1 = {{u1}},
    l2 = {{l2}},
    u2 = {{u2}}
  ) %>% 
    format_posterior_summary(., {{.drop}}) %>% 
    rename_table_cols(., {{.oldnames}}, {{.newnames}})
}