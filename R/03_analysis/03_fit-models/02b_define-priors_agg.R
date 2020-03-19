# define priors for Bayesian analyses using brms::brm() ----

# exposure priors ----

# set informative priors

# Previous model used for fitting with zoib, 
# but very little zo inflation was found.
# Also required an adapt delta of 0.99, which took a long time to fit.
priors$exposure_agg_zoib <- c(
  set_prior("normal(0.5, 1)", class = "Intercept"), # previously (0, 5)
  set_prior("normal(3, 1)", class = "Intercept", dpar = "phi"), # previously (0, 3)
  set_prior("logistic(0, 1)", class = "Intercept", dpar = "zoi"),
  set_prior("logistic(0, 1)", class = "Intercept", dpar = "coi"),
  set_prior("normal(0, 0.2)", class = "b"), # previously (0, 0.5)
  set_prior("normal(0, 0.5)", class = "b", dpar = "phi"), # previously (0, 1)
  set_prior("normal(0, 4)", class = "b", dpar = "zoi"), # previously (0, 5)
  set_prior("normal(0, 0.2)", class = "b", dpar = "coi"), # previously (0, 0.5) - wider coi prior causes divergences
  set_prior("normal(0, 1)", class = "sd"),
  set_prior("normal(0, 1)", class = "sd", dpar = "phi"), # previously (0, 5)
  set_prior("normal(0, 4)", class = "sd", dpar = "zoi"), # previously (0, 5)
  set_prior("normal(0, 5)", class = "sd", dpar = "coi"),
  set_prior("normal(0, 1)", class = "sd", group = "participant_number"),
  set_prior("normal(0, 3)", class = "sd", group = "participant_number", dpar = "phi"), # previously (0, 5)
  set_prior("normal(0, 10)", class = "sd", group = "participant_number", dpar = "zoi"),
  set_prior("normal(0, 10)", class = "sd", group = "participant_number", dpar = "coi"),
  set_prior("lkj(2)", class = "cor")
)

# thus using this beta model on the adjusted means:
priors$exposure_agg <- c(
  set_prior("normal(0.5, 1)", class = "Intercept"), # previously (0, 5)
  set_prior("normal(0, 0.2)", class = "b"), # previously (0, 0.5)
  set_prior("gamma(0.01, 0.01)", class = "phi"),
  set_prior("normal(0, 1)", class = "sd"),
  set_prior("normal(0, 1)", class = "sd", group = "participant_number")
)

priors$testing_agg <- c(
  set_prior("normal(0, 5)", class = "Intercept"),
  set_prior("normal(3, 3)", class = "Intercept", dpar = "phi"), # previously (0, 3)
  set_prior("logistic(0, 1)", class = "Intercept", dpar = "zoi"),
  set_prior("logistic(0, 1)", class = "Intercept", dpar = "coi"),
  set_prior("normal(0, 0.5)", class = "b"),
  set_prior("normal(0, 1)", class = "b", dpar = "phi"),
  set_prior("normal(0, 5)", class = "b", dpar = "zoi"),
  set_prior("normal(0, 0.5)", class = "b", dpar = "coi"),
  set_prior("normal(0, 1)", class = "sd"),
  set_prior("normal(0, 1)", class = "sd", dpar = "phi"),
  set_prior("normal(0, 5)", class = "sd", dpar = "zoi"),
  set_prior("normal(0, 5)", class = "sd", dpar = "coi"),
  set_prior("normal(0, 1)", class = "sd", group = "participant_number"),
  set_prior("normal(0, 5)", class = "sd", group = "participant_number", dpar = "phi"),
  set_prior("normal(0, 10)", class = "sd", group = "participant_number", dpar = "zoi"),
  set_prior("normal(0, 10)", class = "sd", group = "participant_number", dpar = "coi"),
  set_prior("lkj(2)", class = "cor")
)