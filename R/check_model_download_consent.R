#' CMD line UI for checking consent
#'
#' Check and ask user if they consent to model downloads.
#'
#' @param model The model to be downloaded
#' @keywords internal
check_model_download_consent <- function(model) {
  if (getOption("pidpos_download_approved")) {
    return(invisible(TRUE))
  }

  sys.approval <- as.logical(Sys.getenv("PIDPOS_DOWNLOAD_APPROVED", "false"))
  if (isTRUE(sys.approval)) {
    return(invisible(TRUE))
  }

  if (getOption("pidpos_caching")) {
    if (!interactive()) {
      stop("Model download required but session is non-interactive. ",
        "Set options(pidpos_download_approved = TRUE) or ",
        "env var PIDPOS_DOWNLOAD_APPROVED=true.",
        call. = FALSE
      )
    }

    answer <- readline(paste0(
      "pidpos needs to download '", model,
      "'.  Do you consent to downloads? [yes/no/once]: "
    ))
    if (!tolower(trimws(answer)) %in% c("y", "yes", "once")) {
      stop("Download cancelled. ",
        call. = FALSE
      )
    }
    if (tolower(trimws(answer)) %in% c("y", "yes")) {
      options(pidpos_download_approved = TRUE)
    }
  }

  invisible(TRUE)
}
