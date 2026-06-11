#' Parse a data frame into a redaction function with optional caching.
#'
#' @param redacter A data.frame containing `From`, `To` and `If` or a file path to
#' @param with_cache A binary flag to control if memoization is required.
#' 
#' @return A function with the signature \code{function(x)} that takes a
#'   character vector and returns the redacted (as defined by `redacter`) equivalent.
#' 
#' @export
parse_redacter <- function(redacter, with_cache = TRUE) {
  UseMethod("parse_redacter")
}

#' @exportS3Method
parse_redacter.default <- function(redacter, with_cache = TRUE) {
  stop(
    paste("`redacter` of type", class(redacter), "is not supported.")
  )
}

#' @exportS3Method
parse_redacter.character <- function(redacter, with_cache = TRUE) {
  read_data(redacter) |>
    parse_redacter(with_cache)
}

#' @exportS3Method
parse_redacter.data.frame <- function(redacter, with_cache = TRUE) {
  redaction_function_factory(redacter) |>
    parse_redacter(with_cache)
}

#' @exportS3Method
parse_redacter.redact_function <- function(redacter, with_cache = TRUE) {
  if (with_cache) {
    cached_redact_factory(redacter)
  } else {
    redacter
  }
}

#' @exportS3Method
parse_redacter.cached_redact_function <- function(redacter, with_cache = TRUE) {
  redacter
}
