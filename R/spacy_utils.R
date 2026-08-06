#' List available spacy models
#'
#' @return Boolean of which models are available
#' @examples
#' \dontrun{
#' spacy_models()
#' }
#' @export
spacy_models <- function() {
  spacy_require()

  models <- c("en_core_web_lg", "en_core_web_trf")
  names(models) <- models

  vapply(models, reticulate::py_module_available, TRUE)
}

#' Utility to define spacy requirements.
#' @keywords internal
spacy_require <- function() {
  check_reticulate()

  reticulate::py_require(c("click==8.4.2", "spacy==3.8.14", "spacy-curated-transformers==0.3.1"))
  reticulate::py_require(python_version = ">=3.12")

  TRUE
}

#' Utility to check for ephemeral python.
#' @keywords internal
is_ephemeral_reticulate <- function(verbose = TRUE) {
  check_reticulate()
  ephemeral <- isTRUE(reticulate::py_config()$ephemeral)

  if (!ephemeral && verbose) {
    rlang::warn(
      paste0(
        "You are using a persistent Python environment. You will need to manage ",
        "the spaCy setup manually. See reticulate's Order of Discovery docs for ",
        "details on how to use a managed ephemeral environment instead: ",
        "https://rstudio.github.io/reticulate/articles/versions.html#order-of-discovery"
      ),
      .frequency = "once",
      .frequency_id = "ephemeral_python_warn"
    )
  }

  ephemeral
}
