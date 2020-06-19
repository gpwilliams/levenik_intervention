# nLED zero-one inflation & conditional one inflation ---- 

# word type ----

plots$testing_zoi_word_type <- ggplot(
  testing_word_type_zo_agg_summary, 
  aes(x = parameter, y = means, colour = word_type, fill = word_type)
  ) +
  facet_grid(rows = vars(variety_exposure), cols = vars(task)) +
  geom_bar(stat="identity", position = "dodge") +
  geom_errorbar(
    aes(ymin = means - sds*Err, ymax = means + sds*Err), 
    position = position_dodge(width = 0.90), 
    width = 0.25,
    colour = "white",
    size = 1.25
  ) +
  geom_errorbar(
    aes(ymin = means - sds*Err, ymax = means + sds*Err), 
    position = position_dodge(width = 0.9), 
    width = 0.20
  ) +
  scale_y_continuous(
    breaks = seq(0, 100, by = 20), 
    labels = paste0(seq(0, 100, by = 20), "%")
  ) +
  coord_cartesian(ylim = c(0, 100)) +
  scale_colour_manual(values = c("black", "black")) +
  scale_fill_manual(values = plotting_options$scale_fills) +
  geom_rect(
    aes(
      xmin = 1.5, 
      xmax = 3.6, 
      ymin = -5, 
      ymax = Inf
    ), 
    fill = "grey20", 
    alpha = 0.01
  ) +
  geom_vline(xintercept = 1.5, colour = "grey60") +
  labs(
    x = "Distributional Parameter", 
    y = "Mean Percentage of Occurrence", 
    caption = plotting_options$error_caption
  ) +
  four_panel_theme +
  theme(
    legend.title = element_blank(),
    legend.position = c(0.057, .97),
    legend.text = element_text(size = 10),
    legend.background = element_blank()
  )

# set up annotation info
ann_text <- tibble(
  parameter = 2.5, 
  means = 92, 
  task = "Spelling",
  word_type = c("Contrastive", "Non-Contrastive"),
  variety_exposure = "Dialect",
  lab = "Percentages Conditional on Zero-One Inflation"
)

# apply annotation
plots$testing_zoi_word_type + 
  geom_text(
    data = ann_text, 
    label = ann_text$lab, 
    fontface = "italic", 
    show.legend = FALSE # removes letter from legend box
  )

# word familiarity ----

plots$testing_zoi_word_familiarity <- ggplot(
  testing_word_familiarity_zo_agg_summary, 
  aes(x = parameter, y = means, colour = word_familiarity, fill = word_familiarity)
) +
  facet_grid(rows = vars(variety_exposure), cols = vars(task)) +
  geom_bar(stat="identity", position = "dodge") +
  geom_errorbar(
    aes(ymin = means - sds*Err, ymax = means + sds*Err), 
    position = position_dodge(width = 0.90), 
    width = 0.25,
    colour = "white",
    size = 1.25
  ) +
  geom_errorbar(
    aes(ymin = means - sds*Err, ymax = means + sds*Err), 
    position = position_dodge(width = 0.9), 
    width = 0.20
  ) +
  scale_y_continuous(
    breaks = seq(0, 100, by = 20), 
    labels = paste0(seq(0, 100, by = 20), "%")
  ) +
  coord_cartesian(ylim = c(0, 100)) +
  scale_colour_manual(values = c("black", "black")) +
  scale_fill_manual(values = plotting_options$scale_fills) +
  geom_rect(
    aes(
      xmin = 1.5, 
      xmax = 3.6, 
      ymin = -5, 
      ymax = Inf
    ), 
    fill = "grey20", 
    alpha = 0.01
  ) +
  geom_vline(xintercept = 1.5, colour = "grey60") +
  labs(
    x = "Distributional Parameter", 
    y = "Mean Percentage of Occurrence", 
    caption = plotting_options$error_caption
  ) +
  four_panel_theme +
  theme(
    legend.title = element_blank(),
    legend.position = c(0.040, .97),
    legend.text = element_text(size = 10),
    legend.background = element_blank()
  )

# make annotations
ann_text <- tibble(
  parameter = 2.5, 
  means = 92, 
  task = "Spelling",
  word_familiarity = c("Untrained", "Trained"),
  variety_exposure = "Dialect",
  lab = "Percentages Conditional on Zero-One Inflation"
)

# apply annotation
plots$testing_zoi_word_familiarity + 
  geom_text(
    data = ann_text, 
    label = ann_text$lab, 
    fontface = "italic", 
    show.legend = FALSE # removes letter from legend box
  )