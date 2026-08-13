#' Utility function for installation of spaCy models
#'
#' Attempts to download and install the spaCy model in current environment.  Looks for
#' model .whls in `pidpos_env$model_folder`.
#'
#' @param model One of "en_core_web_lg"/ "en_core_web_trf"
#' @param force If true - will overwrite the installed model whl.
#'
#' @return TRUE on success
#'
#' @keywords internal
install_spacy_model <- function(model = c("en_core_web_lg", "en_core_web_trf"), force = FALSE) {
  spacy_require()
  is_ephemeral_reticulate()

  model <- match.arg(model)

  available <- reticulate::py_module_available(model)
  if (available && !force) {
    return(TRUE)
  }

  url <- "https://github.com/explosion/spacy-models/releases/download/%s-3.8.0/%s-3.8.0-py3-none-any.whl"
  url <- sprintf(url, model, model)

  dest <- file.path(pidpos_env$model_folder, basename(url))

  if (!file.exists(dest)) {
    check_model_download_consent(model)

    rlang::check_installed("httr2", reason = "to download the spaCy model")

    message("Downloading ", model)

    httr2::request(url) |>
      httr2::req_perform(path = dest)
  }

  message("Installing `", model, "`")
  withCallingHandlers(
    reticulate::py_install(dest, pip = TRUE, pip_ignore_installed = TRUE),
    warning = function(w) {
      if (grepl("ephemeral virtual environment", conditionMessage(w))) {
        invokeRestart("muffleWarning")
      } else {
        warning(w)
      }
    }
  )

  TRUE
}
