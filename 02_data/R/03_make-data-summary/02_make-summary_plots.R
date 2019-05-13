library(here)
library(tidyverse)

learning_data <- readRDS(here("02_data", "02_cleaned", "learning_data.RDS"))

# define custom plotting elements for this set of plots
add_custom_plot_elements <- function(ggplot_object, y_heading, y_subheading) {
  ggplot_object +
    # highlight poor performers
    geom_rect(
      data = subset(participant_performance, high_nLED == TRUE),
      xmin = -Inf,
      xmax = Inf,
      ymin = -Inf,
      ymax = Inf,
      fill = "red",
      alpha = 0.01
    ) +
    geom_vline(
      xintercept = c(
        plotting_details$minimum - 0.5,
        max(plotting_details$maximum) + 0.5
      ),
      alpha = 0.3,
      linetype = 2
    ) +
    geom_text(
      data = text_headings,
      aes(x = text_loc, y = y_heading, label = text),
      fontface = 3,
      size = 3,
      colour = "black"
    ) +
    geom_text(
      data = text_subheadings,
      aes(x = text_loc, y = y_subheading, label = text),
      fontface = 3,
      size = 2,
      colour = "black"
    ) +
    scale_x_continuous(
      limits = c(
        min(plotting_details$minimum) - 0.5,
        max(plotting_details$maximum) + 0.5
      ),
      breaks = c(
        plotting_details$minimum,
        max(plotting_details$maximum)
      )
    ) +
    labs(x = "Trial Number") +
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank()
    )
}


# change this; just make your own theme


# Make data summaries ----

# find subjects with missing trials; create summary
missing_trials <- learning_data %>%
  group_by(participant_number) %>%
  summarise(total_trials = max(participant_trial_id)) %>%
  filter(total_trials != max(total_trials))

# find participants with poor performance
participant_performance <- learning_data %>%
  filter(block == "test" & task == "spelling") %>%
  group_by(participant_number, variety_exposure) %>%
  summarise(
    mean_nLED = mean(lenient_nLED, na.rm = TRUE),
    sd_nLED = sd(lenient_nLED, na.rm = TRUE),
    median_submission_time = median(submission_time, na.rm = TRUE)
  ) %>%
  mutate_if(is.numeric, round, 2) %>% 
  mutate(high_nLED = case_when(
    mean_nLED > .8 ~ TRUE,
    TRUE ~ FALSE
  )) ## NEED SIMULATION FOR "BAD" PERFORMANCE

# determine a lagging strategy in responses; 
# i.e. giving the previous answer on the current trial
lag_strategy_summary <- learning_data %>% 
  filter(block != "test") %>%
  select(
    participant_number,
    participant_trial_id,
    target,
    primary_coder_transcription,
    secondary_coder_transcription
  ) %>%
  mutate(target_lag = lag(target)) %>%
  select(
    participant_number: target,
    target_lag,
    everything()) %>%
  na.omit() %>%
  filter(
    target_lag == primary_coder_transcription |
      target_lag == secondary_coder_transcription
  ) %>%
  filter(target != target_lag)

# make summary of distance from target for participant input
learning_data <- learning_data %>%
  mutate(
    target_distance = 
      nchar(as.character(target)) - 
      nchar(as.character(primary_coder_transcription)),
    target_distance = replace_na(target_distance, 0)
  )

# Plot ----

# calculate number of pages to print
n_cols <- 4
n_rows <- 6
n_pages <- ceiling(
  length(unique(learning_data$participant_number))/(n_cols * n_rows)
)

# make target distance plot



learning_data %>%
  group_by(participant_number, task) %>%
  summarise(td = mean(target_distance)) %>%
  ggplot(., aes(x = participant_number, y = td)) + 
  geom_bar(stat = "identity") + 
  facet_wrap(~task)

### THIS SEEMS TO TAKE AGES...
# DO WE EVEN NEED THESE PLOTS?

tasks <- unique(learning_data$task)

for (i in seq_along(tasks)) {
  data_sub <- learning_data %>% 
    filter(task == tasks[i], !is.na(target_distance))
  pdf(here(
    "02_data", 
    "03_checks", 
    paste0(tasks[i], "_input_target_distance.pdf")
  ))
  for (j in seq_len(n_pages)) {
    print(
      ggplot(
        data_sub, 
        aes(x = participant_trial_id, y = target_distance)
      ) +
        geom_bar(stat = "identity", position = "dodge") +
        facet_wrap_paginate(
          ~participant_number,
          ncol = n_cols,
          nrow = n_rows,
          page = j
        ) +
        labs(y = "Absolute Target Distance (Number of Letters)") +
        ggtitle(
          paste0(
            "Number of letters from the target to the",
            "\n participant's input on each ",
            tasks[i],
            " spelling trial by participant."
          )
        )
    )
  }
  dev.off()
}




# make performance plot





# get min, max, and midpoints for plotting vlines/annotations
plotting_details <- learning_data %>%
  # filter(participant_number %!in% missing_trials$participant_number) %>%
  group_by(block) %>%
  summarise(
    minimum = min(participant_trial_id),
    maximum = max(participant_trial_id),
    text_loc = mean(c(minimum, maximum))
  ) %>%
  mutate(text = unique(block))



pdf(here("02_data", "04_summaries", "participant_performance.pdf"))

for (i in seq_len(n_pages)) {
  print(
      ggplot(
        learning_data %>% filter(!is.na(lenient_nLED)), 
        aes(x = participant_trial_id, y = lenient_nLED)
      ) +
        geom_line() +
        geom_point() +
        facet_wrap_paginate(
          ~participant_number,
          ncol = n_cols,
          nrow = n_rows,
          page = i
        ) +
        labs(y = "Lenient normalised Levenshtein Edit Distance (nLED)") +
        ggtitle(
          paste(
            "\nLenient normalised Levenshtein Edit Distance (nLED)",
            "\n on each trial split by participant."
          )
        ),
      0.9,
      0.8
    )
}
dev.off()
