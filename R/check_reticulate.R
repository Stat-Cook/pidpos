#' Internal utility for checking reticulate
#'
#' @keywords internal
check_reticulate <- function() {
  rlang::check_installed(
    "reticulate",
    reason = "to use this function"
  )

  if (!reticulate::py_available(initialize = TRUE)) {
    stop("Python is not available. Check your reticulate/Python setup.", call. = FALSE)
  }
}
