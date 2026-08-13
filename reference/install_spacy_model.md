# Utility function for installation of spaCy models

Attempts to download and install the spaCy model in current environment.
Looks for model .whls in `pidpos_env$model_folder`.

## Usage

``` r
install_spacy_model(
  model = c("en_core_web_lg", "en_core_web_trf"),
  force = FALSE
)
```

## Arguments

- model:

  One of "en_core_web_lg"/ "en_core_web_trf"

- force:

  If true - will overwrite the installed model whl.

## Value

TRUE on success
