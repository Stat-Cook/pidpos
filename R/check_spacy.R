#' Verify spacy install
#'
#' Utility to check spacy is configured with the neccesary models.
#'
#' @return (Invisibly) TRUE if no error is raised.
#'
#' @seealso check_python
#' @export
#' @importFrom stats setNames
#'
check_spacy <- function() {
  check_reticulate()

  py_packages <- c(
    spacy = "spacy",
    en_core_web_lg = "en_core_web_lg",
    en_core_web_trf = "en_core_web_trf"
  )

  missing <- !sapply(py_packages, reticulate::py_module_available)

  if (sum(missing) > 0) {
    msg <- paste0("`", names(which(missing)), "`", collapse = ", ")
    stop(
      "The python packages ",
      msg,
      " are missing. ",
      "To check your active python env run `reticulate::py_config()`."
    )
  }

  invisible(TRUE)
}
