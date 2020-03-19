# exploring divergences

library(bayesplot)
library(brms)

models <- list()
models$exposure_agg <- readRDS("C:/Users/Glenn Williams/Dropbox/GitHub/levenik_intervention/04_analysis/01_models/exposure_model_agg.rds")

# determine parameter names (you can't plot all)
parnames(models$exposure_agg)[1:42]

lp_mod <- log_posterior(models$exposure_agg)

np_mod <- nuts_params(models$exposure_agg)
draws <- as.array(models$exposure_agg)

# look for where divergent transitions occur
mcmc_parcoord(draws, np = np_mod)

# look for collinearity between variablkes (shown as narrow bivariate plots)
# or multiplicative non-identifiabilities (banana-like shapes)


# check the condition argument here...
mcmc_pairs(
  models$exposure_agg, 
  np = np_mod, 
  pars = c("^b_variety_exposure"), 
  off_diag_args = list(size = 0.75)
)

# look for tight regions of divergences
# funnel where it struggles to explore the tip = good hint.