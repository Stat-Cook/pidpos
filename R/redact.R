#' Redact PID
#'
#' @param object The object to be redacted - either a vector or data frame
#' @param redacter A `data.frame` of redaction rules or a function created by `redaction_function_factory()`.
#' @param in_batches Logical. If `TRUE` the supplied data will be processed in chunks.
#' @param ... Other arguments to control batching.
#'
#' @return A copy of `object` with redactions applied.
#'
#' @examples
#' # Using the bundled redaction rules and source data:
#' replace_by <- make_random_replacement()
#' prepared <- auto_replace(raw_redaction_rules, replacement_func = replace_by)
#'
#' example_data <- head(the_one_in_massapequa, 20)
#' redact(example_data, prepared)
#'
#' # Passing a plain data.frame of rules directly (no auto_replace step):
#' rules <- data.frame(
#'   If = "Ross and Rachel got married.",
#'   From = "Ross",
#'   To = "PERSON_A"
#' )
#' redact(data.frame(text = "Ross and Rachel got married."), rules)
#'
#' @export
redact <- function(object, redacter, in_batches = TRUE, ...) {
  redacter <- parse_redacter(redacter)

  if (in_batches) {
    batched_redact(object, redacter, ...)
  } else {
    redact_internal(object, redacter)
  }
}
