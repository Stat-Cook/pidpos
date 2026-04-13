pidpos_env <- new.env()

.onLoad <- function(libname, pkgname) {
  op <- options()
  if (is.null(op[["pidpos_context_window"]])) options(pidpos_context_window = 25)

  pidpos_env$model_folder <- pidpos_env$deault_model_folder

  pidpos_env$allowed_repos <- c(
    `2.5` = "jwijffels/udpipe.models.ud.2.5",
    `2.4` = "jwijffels/udpipe.models.ud.2.4",
    `2.3` = "jwijffels/udpipe.models.ud.2.3"
  )
  pidpos_env$repo_dates <- c(
    "jwijffels/udpipe.models.ud.2.5" = "191206",
    "jwijffels/udpipe.models.ud.2.4" = "190531",
    "jwijffels/udpipe.models.ud.2.3" = "181115"
  )
  reinstate_default_reader()

  pidpos_env$udpipe_repo <- pidpos_env$allowed_repos[["2.5"]]
  
  options(pidpos_download_approved = FALSE)
  pidpos_setup()

  invisible()
}
