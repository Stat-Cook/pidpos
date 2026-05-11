# Get and set the conda environment for pidpos

`get_pidpos_conda()` returns the current conda environment name.
`set_pidpos_conda()` sets the session-level environment.
`set_SPACY_CONDA_ENV()` sets the global environment variable.

## Usage

``` r
get_pidpos_conda()

set_pidpos_conda(env_name)

set_SPACY_CONDA_ENV(env_name)
```

## Arguments

- env_name:

  The name of the conda environment to use.
