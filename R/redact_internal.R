#' Map redaction function onto object
#' 
#' Allows for the redaction of a data frame or vector
#' 
#' @param object The data structure to be redacted
#' @param redaction_func A closure/ function to be applied.
#'
#' 
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
