#' Prepare a function from redaction rules.
#'
#' Convert the `replacement_rules` (as defined with `report_to_redaction_rules`)
#' to a function that can be applied to a data frame.
#'
#' @param object The `replacement_rules` (can be a path to a csv file
#' or a `data.frame`).
#'
#' @return A function that can be applied to a data frame.
#'
#' @examples
#' \dontrun{
#' example.data <- head(the_one_in_massapequa)
#' report <- pidpos(example.data, to_ignore = "speaker")
#' redactions.raw <- report_to_redaction_rules(report)
#'
#' replace_by <- make_random_replacement()
#' redactions <- auto_replace(redactions.raw, replacement_func = replace_by)
#'
#' f <- pidpos:::prepare_redactions(redactions)
#' f(example.data$text)
#' }
#'
#' @keywords internal
#'
prepare_redactions <- function(object) {
  lifecycle::deprecate_warn("0.1", "prepare_redactions()", "parse_redacter()")
  UseMethod("prepare_redactions")
}

#' @exportS3Method
prepare_redactions.character <- function(object) {
  rules.frm <- read.csv(object)

  prepare_redactions(rules.frm)
}

#' @exportS3Method
prepare_redactions.data.frame <- function(object) {
  redaction_function_factory(object)
}
