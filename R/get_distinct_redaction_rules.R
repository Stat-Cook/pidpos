#' Combine multiple PID reports into a single rule set
#'
#' For use as part of the folder level API - this function is the equivalent of
#' [get_distinct_redaction_rules()].
#'
#' @param object The object to extract distinct redaction rules from.
#'   Can be a path to a folder of `pid` reports, a list of `pid` reports, or a single data frame.
#' @param include_context A boolean flag indicating whether to include context information in the output. Default is FALSE.
#'
#' @export
get_distinct_redaction_rules <- function(object, include_context = FALSE) {
  UseMethod("get_distinct_redaction_rules")
}

#' @exportS3Method
get_distinct_redaction_rules.character <- function(object, include_context = FALSE) {
  .files <- find_supported_files(object, "csv")

  if (length(.files) == 0) {
    stop("No supported files found in the report path.")
  }

  map(.files, readr::read_csv, show_col_types = FALSE) |>
    get_distinct_redaction_rules(include_context)
}

#' @exportS3Method
get_distinct_redaction_rules.list <- function(object, include_context = FALSE) {
  map(object, report_to_redaction_rules, include_context = include_context) |>
    bind_rows() |>
    distinct(.keep_all = TRUE)
}

#' @exportS3Method
get_distinct_redaction_rules.data.frame <- function(object, include_context = FALSE) {
  report_to_redaction_rules(object, include_context = include_context)
}
