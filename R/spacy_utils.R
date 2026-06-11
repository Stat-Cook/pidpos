#' Get and set the conda environment for pidpos
#'
#' `get_pidpos_conda()` returns the current conda environment name.
#' `set_pidpos_conda()` sets the session-level environment.
#' `set_SPACY_CONDA_ENV()` sets the global environment variable.
#'
#' @param env_name The name of the conda environment to use.
#' @return The name of the conda environment `pidpos` is using
#' @name spacy-conda-env
#' @export
get_pidpos_conda <- function() {
  pidpos_env$conda_env %||%
    Sys.getenv("SPACY_CONDA_ENV", unset = "pidpos")
}

#' @rdname spacy-conda-env
#' @export
set_pidpos_conda <- function(env_name) {
  pidpos_env$conda_env <- env_name
  pidpos_env$conda_env
}

#' @rdname spacy-conda-env
#' @export
set_SPACY_CONDA_ENV <- function(env_name) {
  Sys.setenv(SPACY_CONDA_ENV = env_name)
  get_pidpos_conda()
}


#' List available spacy models
#'
spacy_models <- function() {
  reticulate::use_condaenv(get_pidpos_conda())

  util <- reticulate::import("spacy.util")

  util$get_installed_models()
}
