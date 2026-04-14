#' @keywords internal
redact_internal <- function(object, redaction_func) {
  UseMethod("redact_internal")
}


#' @exportS3Method
redact_internal.data.frame <- function(object, redaction_func) {
  object |>
    dplyr::mutate(
      dplyr::across(where(is.character), \(i) redaction_func(i))
    )
}

#' @exportS3Method
redact_internal.default <- function(object, redaction_func) {
  redaction_func(object)
}
