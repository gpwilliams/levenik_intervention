# clean up names
additional_languages <- demographics %>% 
  filter(additional_languages != "english") %>% 
  mutate(additional_languages = str_to_title(additional_languages)) %>%
  mutate(additional_languages = case_when(
    additional_languages == "Bsl" ~ "British Sign Language",
    additional_languages == "Urdu/ Hindi" ~ "Urdu/Hindi",
    additional_languages == "French (Canadian)" ~ "French",
    TRUE ~ additional_languages 
  ))

# count each language and get ratings
languages_plot_data <- additional_languages %>% 
  group_by(variety_exposure, additional_languages) %>% 
  summarise(
    n = length(unique(participant_number)),
    mean_rating = mean(language_proficiency),
    sd = sd(language_proficiency)
    ) %>% 
  arrange(desc(n))

# make tidier names for plotting
levels(languages_plot_data$variety_exposure) <- c(
  "No Dialect",
  "Dialect",
  "Dialect & Social",
  "Dialect Literacy"
)

# plot count of languages known
languages_plot <- ggplot(
  languages_plot_data, 
  aes(
    x = n, 
    y = reorder_within(
      additional_languages, 
      -n, 
      variety_exposure)
    )
  ) +
  geom_bar(stat = "identity") +
  facet_wrap(.~variety_exposure, scales = "free_y") +
  scale_y_reordered() +
  theme_bw() +
  theme(
    axis.text.y = element_text(size = 6),
    legend.position = "none",
    panel.grid.minor = element_blank()
  ) +
  scale_x_continuous(breaks = seq(0, 24, 4)) +
  labs(y = NULL, x = "Count of Languages Known")

# save plot
ggsave(
  filename = here("02_data", "04_summaries", "additional_languages_plot.pdf"),
  plot = languages_plot, 
  height = 8, 
  width = 12
)
