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

    answer <- readline(paste0("pidpos needs to download '", model, "'. Consent? [y/n]: "))
    if (!tolower(trimws(answer)) %in% c("y", "yes")) {
      stop("Download cancelled. Models can be used manually via ",
        "`udpipe::udpipe_download_model()` ",
        "and `udpipe::udpipe_load_model()`",
        call. = FALSE
      )
    }
    options(pidpos_download_approved = TRUE)
  }

  invisible(TRUE)
}
