# define priors for Bayesian analyses using brms::brm() ----

# exposure priors ----

# set informative priors
priors$exposure <- c(
  set_prior("normal(0, 5)", class = "Intercept"),
  set_prior("normal(0, 3)", class = "Intercept", dpar = "phi"),
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
  set_prior("normal(0, 1)", class = "sd", group = "base_word"),
  set_prior("normal(0, 5)", class = "sd", group = "base_word", dpar = "phi"),
  set_prior("normal(0, 10)", class = "sd", group = "base_word", dpar = "zoi"),
  set_prior("normal(0, 10)", class = "sd", group = "base_word", dpar = "coi"),
  set_prior("lkj(2)", class = "cor")
)

priors$testing <- c(
  set_prior("normal(0, 5)", class = "Intercept"),
  set_prior("normal(0, 3)", class = "Intercept", dpar = "phi"),
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
  set_prior("normal(0, 1)", class = "sd", group = "base_word"),
  set_prior("normal(0, 5)", class = "sd", group = "base_word", dpar = "phi"),
  set_prior("normal(0, 10)", class = "sd", group = "base_word", dpar = "zoi"),
  set_prior("normal(0, 10)", class = "sd", group = "base_word", dpar = "coi"),
  set_prior("lkj(2)", class = "cor")
)