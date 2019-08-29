# OLD CODE USED TO DIRECTLY LABEL PLOTS

tvw_ms_labels <- testing_tvw_ms_compare_summary_agg %>% 
  filter(task == "Spelling", .width %in% c(0.95, 0.8)) %>% 
  mutate(
    # case_when to set value to lower for one (e.g. .95) and higher for other (e.g. .80)
    labels = paste(.width*100, "%", "credible interval")
  )  

ggrepel::geom_text_repel(
  data = tvw_ms_labels,
  aes(x = .upper, y = 2, label = labels),
  nudge_x = c(0.05, -0.1), 
  nudge_y = .25,
  hjust = 0
)