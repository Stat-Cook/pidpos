#' A custom abort function
#'
#' @param subclass a vector of inherited error class
#' @param message The error message to display
#' @param ... Additional arguments to pass to `abort()`
#' @param call The call environment to use for the error (defaults to the caller's environment)
#'
#' @return An error object with the specified message and classes
#'
#' @importFrom rlang abort caller_env
#' @keywords internal
#' @noRd
base_error <- function(subclass,
                       message,
                       ...,
                       call) {
  cls <- c(subclass, "pidpos_error")

  abort(
    message = message,
    class = cls,
    call = call,
    !!!list(...)
  )
}

#' @importFrom rlang warn
#' @noRd
base_warn <- function(subclass,
                      message,
                      ...,
                      call) {
  cls <- c(subclass, "pidpos_warning")

  warn(
    message = message,
    class = cls,
    call = call,
    !!!list(...)
  )
}

#' Error function factory
#'
#' Create new error types to allow better handling/ extension on tryCatch.
#'
#' @param name Error type.  Will take the form 'pidpos_<name>'
#' @param parent An optional character vector of parent classes to include.
#'
#' @return A new error closure with signature `f(message)`
#' @keywords internal
#' @noRd
new_error_type <- function(name, parent = NULL) {
  function(message, ..., call = caller_env()) {
    subclass <- c(
      paste0("pidpos_", name),
      name,
      parent
    )

    base_error(
      subclass = subclass,
      message = message,
      ...,
      call = call
    )
  }
}

#' Warning function factory
#'
#' Create new warning types to allow better handling/ extension on tryCatch.
#'
#' @param name Warning type.  Will take the form 'pidpos_<name>'
#' @param parent An optional character vector of parent classes to include.
#'
#' @return A new warning closure with signature `f(message)`
#' @keywords internal
#' @noRd
new_warn_type <- function(name, parent = NULL) {
  function(message, ..., call = caller_env()) {
    subclass <- c(
      paste0("pidpos_", name),
      name,
      parent
    )

    base_warn(
      subclass = subclass,
      message = message,
      ...,
      call = call
    )
  }
}
