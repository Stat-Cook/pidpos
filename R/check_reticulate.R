#' Internal utility for checking reticulate
#'
#' @keywords internal
check_reticulate <- function() {
  rlang::check_installed(
    "reticulate",
    reason = "to use this function"
  )
}
