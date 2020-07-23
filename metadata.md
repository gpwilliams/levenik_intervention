# Metadata

Note that due to excessive file sizes associated with storing Bayesian analyses in lists (and subsequently in .RData files), the outputs of Bayesian data analyses are not hosted on GitHub. Instead these can be found via the [OSF repository](https://osf.io/7ct9x/) in the folder **bayesian_analyses** with each model for each experiment saved under the appropriate subfolder. The Bayesian models will be produced when running the analysis code in R, and summaries of the models (i.e. with a reduced file size) are otherwise saved in in 04_analysis/01_models/ with filenames ending in _summary.rds. Fixed effects parameter estimates are also saved in this folder as .csv files. Models with the following prefixes are described below:

- **exposure_**: The model fitted to the vocabulary testing phase data.
- **testing_**: The model fitted to the testing phase data.
- **testing_cov**: The model fitted to the testing phase data using mean vocabulary test performance as a covariate.

There are 5 folders for this analysis:

## **01_materials**: contains subfolder script/ and the file spelling_and_pronunciations.csv:

1. script: contains .png files for the individual graphemes (numbered sequentially) as used in the study. These numbers are purely arbitrary as graphemes are randomly assigned phonemes in the experiment.

2. spelling_and_pronunciations.csv: contains the spellings and pronunciations of each word for transparent and opaque orthographies. Note that transparent_spelling provides the base word, opaque_spelling contains the opaque spelling (in the standard variety), opaque_dialect_spelling contains the opaque spelling for the dialect literacy condition. non-contrastive_spronunciation and contrastive_pronunciation provide the the pronunciations for the words if they are non-contrastive or contrastive respectively. Note that NAs are entered here e.g. for a non-contrastive word in the contrastive pronunciation column. Here, spellings are provided via the CPSAMPA simplified notation for IPA characters. 

Additionally includes a code for whether a word is a testing word (testing_word: 1 = novel word appearing only during testing; 0 = trained word appearing in training and testing), contrastive, or non-contrastive (contrastive_word: 1 = contrastive, 0 = non-contrastive. This only applies to non-testing words). Finally contains a count of the number of phonemes that change in the contrastive words (phoneme_shift_count).

**The remaining is to be completed**