gmap_rope <- function(data, draws, ..., ci = .90, bounds = c(-0.1, 0.1)) {
  # Applies the ROPE function to groups of draws, usually from 
  # tidybayes::compare_levels()
  #
  # Inputs:
  #   data = a data.frame of draws from a posterior distribution
  #   draws = bare column name of column containing values related to the draws
  #   bounds = vector of numbers outlining the boundaries for 
  #     the ROPE (i.e. lowest and highest values equivalent to 0). 
  #     Defaults to the default range of 
  #       bayestestR::equivalence_test(); -0.1 and 0.1.
  #   ci = credible interval probability related to the proportion of the 
  #     HDI to use in the ROPE.
  #   ... = any bare columns named by which to group the data
  #     prior to performing the ROPE procedure.
  # Outputs:
  #   data.frame containing grouped factors, CI for ROPE, 
  #     ROPE bounds, percentage of distribution from CI in the ROPE,
  #     a decision criterion for accepting equivlence, and the lower and higher
  #     bounds of the HDI.
  data %>% 
    group_by(!!!enquos(...)) %>% 
    summarise(values = list({{draws}})) %>% 
    dplyr::mutate(
      equivalence = purrr::map(
        values, 
        ~bayestestR::equivalence_test(
          x = .,
          ci = ci,
          range = bounds
        )
      )
    ) %>% 
    dplyr::select(-values) %>% 
    tidyr::unnest(equivalence)
}