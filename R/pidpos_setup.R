#' Configure model storage for pidpos
#'
#' Sets how \pkg{pidpos} stores and retrieves language models used by
#' \code{\link[udpipe]{udpipe}} for part-of-speech tagging. Call this once at
#' the start of a session or in your project's \file{.Rprofile}.
#'
#' @param model_storage Where models are stored between sessions. One of:
#'   \describe{
#'     \item{\code{"package"}}{Cached inside the \pkg{pidpos} package directory.
#'       Persists across sessions; shared across all projects.}
#'     \item{\code{"project"}}{Cached in the current project directory.
#'       Persists across sessions; isolated per project.}
#'     \item{\code{"temporary"}}{Written to a \code{tempdir()} each session.
#'       Not persisted; re-downloaded on every new session.}
#'     \item{\code{"env"}}{Model object held in memory only. No files are
#'       written; caching is disabled (\code{pidpos_caching = FALSE}).}
#'   }
#'
#' @return Called for its side effects. Sets \code{getOption("pidpos_caching")}
#'   and \code{getOption("pidpos_model_storage")} invisibly.
#'
#' @seealso \code{\link[udpipe]{udpipe}}
#'
#' @export
pidpos_setup <- function(model_storage = c("package", "project", "temporary", "env")) {
  model_storage <- match.arg(model_storage)

  caching <- switch(model_storage,
    package = TRUE,
    project = TRUE,
    temporary = TRUE,
    env = FALSE
  )

  if (model_storage == "package") {
    enable_package_models()
  }

  if (model_storage == "project") {
    enable_local_models()
  }

  if (model_storage == "temporary") {
    enable_temp_models()
  }

  options(pidpos_caching = caching)
  options(pidpos_model_storage = model_storage)
}
