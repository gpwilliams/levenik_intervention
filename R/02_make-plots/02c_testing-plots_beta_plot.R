# by word type ----

ggplot(
  data = testing_word_type_agg,
  aes(x = variety_exposure, y = mean, fill = word_type)
  ) + 
  geom_split_violin(scale = "count", trim = TRUE) +
  geom_boxplot(width = 0.3, outlier.alpha = 0, coef = 0) +
  geom_pointrange(
    data = testing_word_type_summary, 
    aes(
      x = variety_exposure, 
      y = means, 
      colour = word_type,
      ymin = means - sds * Err, 
      ymax = means + sds * Err
    ),
    size = 1,
    position = position_dodge(width = 0.3),
    colour = "white"
  ) +
  facet_wrap(~task) +
  coord_cartesian(ylim = c(0, 1)) +
  scale_y_continuous(breaks = seq(0, 1, 0.2)) +
  labs(x = "Word Type", y = "Mean Normalised Levenshtein Edit Distance")

# by word familiarity ----

ggplot(
  data = testing_word_familiarity_agg,
  aes(x = variety_exposure, y = mean, fill = word_familiarity)
  ) + 
  geom_split_violin(scale = "count", trim = TRUE) +
  geom_boxplot(width = 0.3, outlier.alpha = 0, coef = 0) +
  geom_pointrange(
    data = testing_word_familiarity_summary, 
    aes(
      x = variety_exposure, 
      y = means, 
      colour = word_familiarity,
      ymin = means - sds * Err, 
      ymax = means + sds * Err
    ),
    size = 1,
    position = position_dodge(width = 0.3),
    colour = "white"
  ) +
  facet_wrap(~task) +
  coord_cartesian(ylim = c(0, 1)) +
  scale_y_continuous(breaks = seq(0, 1, 0.2)) +
  labs(x = "Word Familiarity", y = "Mean Normalised Levenshtein Edit Distance")