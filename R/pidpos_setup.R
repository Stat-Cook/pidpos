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
#'     \item{\code{"env"}}{No downloads are attempted.
#'       The user must supply a pre-loaded udpipe_model object directly to udpipe_factory().}
#'   }
#'
#' @return Called for its side effects. Sets \code{getOption("pidpos_caching")}
#'   and \code{getOption("pidpos_model_storage")}.
#'
#' @seealso \code{\link[udpipe]{udpipe}}
#'
#' @examples
#' \dontrun{
#' # Persist models in a shared package-level cache
#' pidpos_setup("package")
#' pidpos(the_one_in_massapequa, tagger = "english-ewt")
#'
#' # Use a per-project cache (good for reproducible workflows)
#' pidpos_setup("project")
#' pidpos(the_one_in_massapequa, tagger = "english-ewt")
#'
#' # Block downloads and manually manage models
#' pidpos_setup("env")
#' m <- udpipe::udpipe_load_model("path/to/model")
#' pidpos(the_one_in_massapequa, tagger = m)
#' }
#' @export
pidpos_setup <- function(model_storage = c("package", "project", "temporary", "env")) {
  model_storage <- match.arg(model_storage)

  caching <- switch(model_storage,
    package = TRUE,
    project = TRUE,
    temporary = TRUE,
    env = FALSE
  )
  switch(model_storage,
    package   = enable_package_models(),
    project   = enable_local_models(),
    temporary = enable_temp_models()
  )

  options(pidpos_caching = caching)
  options(pidpos_model_storage = model_storage)
}
