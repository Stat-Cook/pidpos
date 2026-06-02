# Initialize a minimum spacy environment

NB: the following assumes you have installed the optional `reticulate`
dependency. If you have not please run `install.packages("reticualte")`
before continuing.

## Usage

``` r
create_spacy_env()
```

## Value

(Invisibly) Your python environment name.

## Details

This function ensures a python environment is available for using the
spacy language models.

## See also

- To control the environment name or inherit an existing python env:
  [spacy-conda-env](https://stat-cook.github.io/pidpos/reference/spacy-conda-env.md)
