# Calculate fixed effect parameter estimates ----

fixed_eff <- list()

# exposure ----

fixed_eff$exposure <- summary(models$exposure)$fixed %>%
  as.data.frame() %>% 
  rownames_to_column(., var = "Parameter") %>% 
  merge_CI_limits(., `l-95% CI`, `u-95% CI`, decimals = 2) %>%
  select(Parameter:Est.Error, interval, everything()) %>% 
  split_dists() %>% 
  mutate(distribution = factor(distribution, levels = c("mu", "phi", "zoi", "coi"))) %>% 
  arrange(distribution) %>%
  mutate(
    Estimate = round_pad(Estimate, 2),
    Est.Error = round_pad(Est.Error, 2),
    Rhat = round_pad(Rhat, 2),
    Bulk_ESS = round(Bulk_ESS, 0),
    Tail_ESS = round(Tail_ESS, 0)
  )

# testing ----

fixed_eff$testing <- summary(models$testing)$fixed %>%
  as.data.frame() %>% 
  rownames_to_column(., var = "Parameter") %>% 
  merge_CI_limits(., `l-95% CI`, `u-95% CI`, decimals = 2) %>%
  select(Parameter:Est.Error, interval, everything()) %>% 
  split_dists() %>% 
  mutate(distribution = factor(distribution, levels = c("mu", "phi", "zoi", "coi"))) %>% 
  arrange(distribution) %>%
  mutate(
    Estimate = round_pad(Estimate, 2),
    Est.Error = round_pad(Est.Error, 2),
    Rhat = round_pad(Rhat, 2),
    Bulk_ESS = round(Bulk_ESS, 0),
    Tail_ESS = round(Tail_ESS, 0)
  )

# exposure ----

fixed_eff$testing_cov <- summary(models$testing_cov)$fixed %>%
  as.data.frame() %>% 
  rownames_to_column(., var = "Parameter") %>% 
  merge_CI_limits(., `l-95% CI`, `u-95% CI`, decimals = 2) %>%
  select(Parameter:Est.Error, interval, everything()) %>% 
  split_dists() %>% 
  mutate(distribution = factor(distribution, levels = c("mu", "phi", "zoi", "coi"))) %>% 
  arrange(distribution) %>%
  mutate(
    Estimate = round_pad(Estimate, 2),
    Est.Error = round_pad(Est.Error, 2),
    Rhat = round_pad(Rhat, 2),
    Bulk_ESS = round(Bulk_ESS, 0),
    Tail_ESS = round(Tail_ESS, 0)
  )
