#' Package errors and warnings
#'
#' To assist with ... the package has implemented several custom errors and warnings 
#' which are embedded as safeguards in the function factories.  The intention is to allow 
#' users to catch specific error types raised in the package structure separately to 
#' any raised from custom code.
#' 
#'
#' @param message The error message to display
#' @param ... Additional arguments to pass to `abort()`
#' @param call The call environment to use for the error (defaults to the caller's environment)
#'
#' @return An error object with the specified message and classes
#'
#' @importFrom rlang abort caller_env
#' @keywords internal
#' @name custom-errors-warnings
#'
NULL

#' @rdname custom-errors-warnings
type_error <- new_error_type("type_error")

#' @rdname custom-errors-warnings
exceeded_max_error <- new_error_type("exceeded_max_error")

#' @rdname custom-errors-warnings
exceeded_half_max_warn <- new_warn_type("exceed_half_max_warning")

#' @rdname custom-errors-warnings
iteration_warn <- new_warn_type("iteration_warning")


escalate <- function(w, elevate_warnings) {
  .class <- class(w)
  if (elevate_warnings) {
    .class <- gsub("warning$", "error", .class)
    rlang::abort(w$message, class = .class)
  } else {
    rlang::warn(w$message, class = .class)
    #invokeRestart("muffleWarning") 
  }
}


