report_posteriors <- function(.summary, .rope, .width, .drop, .oldnames, .newnames) {
  join_posterior_summaries(
    .summary %>% filter(.width == {{.width}}), 
    .rope
  ) %>% 
    format_posterior_summary(., {{.drop}}) %>% 
    rename_table_cols(., {{.oldnames}}, {{.newnames}})
}