#' Apply a replacement function to a `rules.frm`.
#'
#' Several function factories have been implemented to create replacement functions
#' ([make_hashing_replacement()], [make_random_replacement()]).
#'
#' @param frm A `data.frame` with columns `If`, `From`, and `To`.
#' @param replacement.f A function for transforming the `To` column.
#' @param filter Logical.  If `TRUE` will only apply to rows where `From` and `To` are different.
#'
#' @return A `data.frame` like `frm` but with the `To` column transformed by `replacement.f`.
#' @importFrom rlang .data
#'
#' @examples
#'
#' replace_by <- make_random_replacement()
#' auto_replace(raw_redaction_rules, replacement.f = replace_by)
#'
#' @export
#' @seealso [report_to_redaction_rules()] [redact()]
auto_replace <- function(frm, replacement.f, filter = F) {
  if (filter) {
    frm <- dplyr::filter(frm, .data$From != .data$To)
  }

  frm |>
    dplyr::mutate(To = replacement.f(.data$To))
}

