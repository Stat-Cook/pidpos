#' Apply a replacement function to a `rules.frm`.
#'
#' Several function factories have been implemented to create replacement functions
#' ([make_hashing_replacement()], [make_random_replacement()]).
#'
#' @param frm A `data.frame` with columns `If`, `From`, and `To`.
#' @param replacement_func A function for transforming the `To` column.
#' @param include_pos Logical.  If `TRUE` will replacement prefix will be the POS tag.
#' @param filter Logical.  If `TRUE` will only apply to rows where `From` and `To` are different.
#'
#' @return A `data.frame` like `frm` but with the `To` column transformed by `replacement_func`.
#' @importFrom rlang .data
#'
#' @examples
#'
#' replace_by <- make_random_replacement()
#' auto_replace(raw_redaction_rules, replacement_func = replace_by)
#'
#' @export
#' @seealso [report_to_redaction_rules()] [redact()]
auto_replace <- function(frm, replacement_func,
                         include_pos = FALSE, filter = FALSE) {
  if (filter) {
    frm <- dplyr::filter(frm, .data$From != .data$To)
  }

  frm |>
    dplyr::mutate(
      To = replacement_func(.data$To),
      To = ifelse(include_pos, paste(POS, To, sep = "_"), To)
    )
}
