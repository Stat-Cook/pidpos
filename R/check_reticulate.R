check_reticulate <- function() {
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    rlang::abort(
      "reticulate is not installed.\n",
      "Install with: install.packages('reticulate')"
    )
  }
}
