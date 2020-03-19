# make performance plot

for (i in seq_along(tasks)) {
  sub_data <- test_data %>% 
    filter(task == tasks[i], !is.na(lenient_nLED))
  
  # calculate number of pages to print
  pagination <- tibble(
    n_cols = 4,
    n_rows = 5,
    n_pages = ceiling(
      length(unique(sub_data$participant_number))/(n_cols * n_rows)
    )
  )
  
  # get min, max, and midpoints for plotting vlines/annotations
  plotting_details <- sub_data %>%
    group_by(block) %>%
    summarise(
      minimum = min(participant_trial_id),
      maximum = max(participant_trial_id),
      text_loc = mean(c(minimum, maximum))
    ) %>%
    mutate(text = unique(block))
  
  # get participants to highlight for poor performance
  high_nLED_highlight <- 
    sub_data %>% 
    group_by(participant_number) %>% 
    filter(high_nLED == TRUE) %>% 
    slice(1)
  
  # plot all pages
  pdf(here(
    "02_data",
    "04_summaries", 
    paste0(tasks[i], "_participant_performance.pdf")
    ))
  for (j in seq_len(pagination$n_pages)) {
    print(
      ggplot(
        sub_data, 
        aes(x = task_trial_id, y = lenient_nLED)
      ) +
        geom_line() +
        geom_point() +
        facet_wrap_paginate(
          ~participant_number,
          ncol = pagination$n_cols,
          nrow = pagination$n_rows,
          page = j
        ) +
        labs(
          x = "Trial Number",
          y = "Lenient normalised Levenshtein Edit Distance (nLED)"
        ) +
        ggtitle(
          paste(
            "Lenient normalised Levenshtein Edit Distance (nLED) on",
            "for each participant \n for the",
            tasks[i], 
            "task during testing.\nRed",
            "highlights show participants with high mean nLEDs."
          )
        ) +
        geom_rect(
          data = high_nLED_highlight,
          xmin = -Inf,
          xmax = Inf,
          ymin = -Inf,
          ymax = Inf,
          fill = "red",
          alpha = 0.5
        )
    )
  }
  dev.off()
}