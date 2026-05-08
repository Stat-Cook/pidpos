#' Get and set the conda environment for pidpos
#'
#' `get_pidpos_conda()` returns the current conda environment name.
#' `set_pidpos_conda()` sets the session-level environment.
#' `set_SPACY_CONDA_ENV()` sets the global environment variable.
#'
#' @param env_name The name of the conda environment to use.
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
}

#' @rdname spacy-conda-env
#' @export
set_SPACY_CONDA_ENV <- function(env_name) {
  Sys.setenv(SPACY_CONDA_ENV = env_name)
}


#' List available spacy models
#'
#' @importFrom reticulate use_condaenv import
spacy_models <- function() {
  use_condaenv(get_pidpos_conda())

  util <- reticulate::import("spacy.util")

  util$get_installed_models()
}


#' #' @importFrom reticulate use_condaenv import
#' spacy_download_model <- function(model = c("en_core_web_lg", "en_core_web_trf")) {
#'   use_condaenv(get_pidpos_conda())
#'
#'   spacy <- reticulate::import("spacy")
#'
#'   # Direct download
#'   sapply(model, spacy$cli$download)
#' }
#'
#' #' @keywords internal
#' spacy_ask_consent <- function(what, force = FALSE) {
#'   if (force)
#'     return(invisible(TRUE))
#'
#'   # Can't prompt in non-interactive sessions
#'   if (!interactive()) {
#'     stop(
#'       "Cannot prompt for consent in a non-interactive session.\n",
#'       "Use force = TRUE to proceed explicitly."
#'     )
#'   }
#'
#'   message("\nThe following will be downloaded:")
#'   message("  ", what)
#'   message("")
#'
#'   response <- readline("Do you want to proceed? [y/n]: ")
#'
#'   if (!tolower(trimws(response)) %in% c("y", "yes")) {
#'     message("Download cancelled.")
#'     return(invisible(FALSE))
#'   }
#'
#'   invisible(TRUE)
#' }
#'
#'
#' #'
#' #'
#' #' @export
#' spacy_static_install_model <- function(model = c("en_core_web_lg", "en_core_web_trf")) {
#'   messages <- list("en_core_web_lg" = "en_core_web_lg [560 Mb]", "en_core_web_trf" = "en_core_web_trf [400 Mb]")
#'
#'   messages[model] |>
#'     paste0(collapse = ", ") |>
#'     spacy_ask_consent()
#'
#'   dir <- tempdir()
#'   pattern <- "https://github.com/explosion/spacy-models/releases/download/%s-3.8.0/%s-3.8.0-py3-none-any.whl"
#'
#'   for (m in model) {
#'     url <- sprintf(pattern, m, m)
#'
#'     dest <- file.path(dir, basename(url))
#'
#'     request(url) |>
#'       req_progress() |>
#'       req_error(is_error = \(resp) FALSE) |>  # handle errors gracefully
#'       req_perform() |>
#'       resp_body_raw() |>
#'       writeBin(dest)
#'
#'     reticulate::conda_install(
#'       get_pidpos_conda(),
#'       packages = dest,
#'       pip = TRUE,
#'       pip_options = "--force-reinstall --no-cache-dir"
#'     )
#'   }
#' }
