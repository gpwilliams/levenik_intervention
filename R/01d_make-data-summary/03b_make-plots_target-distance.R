# Target Distance Plot ----

for (i in seq_along(tasks)) {
  # make means, keeping only people who deviate from word lengths
  target_distance_means <- test_data %>% 
    filter(task == tasks[i], !is.na(lenient_nLED)) %>%
    group_by(participant_number, variety_exposure, high_nLED, mean_nLED) %>%
    summarise(mtd = mean(target_distance)) %>%
    filter(mtd != 0) %>%
    ungroup()
  
  target_distance_labels <- target_distance_means %>%
    arrange(mtd) %>%
    filter(high_nLED == TRUE) %>%
    slice(1) # slice needed as alpha is additive per trial
    
  # plot mean scores
  target_distance_plot <- ggplot(
    target_distance_means, 
    aes(x = reorder(participant_number, -mtd), y = mtd, fill = high_nLED)
  ) +
  geom_bar(stat = "identity", colour = "white") +
  facet_wrap(
    ~variety_exposure, 
    scales = "free",
    labeller = as_labeller(variety_exposure_names)
  ) +
  coord_flip(ylim = c(0, 2.5)) +
  labs(
    x = "Participant Number", 
    y = "Mean Target Distance"
  ) +
  ggtitle(
    paste0(
      "Mean number of letters from the target to the ",
      "participant's input for the ",
      tasks[i],
      " task during testing.\nOnly ",
      "participants with deviant scores are shown.\nRed",
      " bars show participants with high mean nLEDs."
    )
  ) + 
  theme_bw() +
  theme(
    axis.text.y = element_text(size = 6),
    legend.position = "none",
    panel.grid.minor = element_blank()
  ) + 
  scale_fill_manual(values = c("#999999", "#ff0000")) +
  geom_label_repel(
    data = target_distance_labels, 
    aes(
      reorder(participant_number, -mtd), 
      y = mtd, 
      label = "High nLED"
    ),
    nudge_y = 0.5,
    colour = "black",
    fill = "white",
    label.size = NA
  )
  
  # save plots
  ggsave(
    filename = here(
      "02_data", 
      "03_checks", 
      paste0(tasks[i], "_mean_input_target_distance.pdf")
    ),
    plot = target_distance_plot,
    height = 14, width = 12
  )
}