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

#' Utility to define spacy requirements.
#' @keywords internal
spacy_require <- function(){
  
  check_reticulate()
  
  reticulate::py_require(c("click==8.4.2", "spacy==3.8.14", "spacy-curated-transformers==0.3.1"))
  reticulate::py_require(python_version = ">=3.12")
  
  TRUE
}

#' Utility to check for ephemeral python.
#' @keywords internal
is_ephemeral_reticulate <- function(verbose = TRUE) {
  
  check_reticulate()
  ephemeral <- isTRUE(reticulate::py_config()$ephemeral)
  
  if (!ephemeral && verbose) {
    rlang::warn(
      paste0("You are using a persistent Python environment. You will need to manage ",
      "the spaCy setup manually. See reticulate's Order of Discovery docs for ",
      "details on how to use a managed ephemeral environment instead: ",
      "https://rstudio.github.io/reticulate/articles/versions.html#order-of-discovery"),
      .frequency = "once",
      .frequency_id = "ephemeral_python_warn"
    )
  }
  
  ephemeral
}

#' Utility to install 
install_spacy_model <- function(model = c("en_core_web_lg", "en_core_web_trf"), force=FALSE){
  spacy_require()
  is_ephemeral_reticulate()
  
  model <- match.arg(model)
  
  available <- reticulate::py_module_available(model)
  if (available && !force){
    return(TRUE)
  }
  
  url <- "https://github.com/explosion/spacy-models/releases/download/%s-3.8.0/%s-3.8.0-py3-none-any.whl"
  url <- sprintf(url, model, model)
  
  dest <- file.path(pidpos_env$model_folder, basename(url))  

  if (!file.exists(dest) && check_model_download_consent(model)){
    message("Downloading", model)
    
    httr2::request(url) |>
      httr2::req_perform(path = dest)
  }
  message("Installing `", model, "`")
  withCallingHandlers(
    reticulate::py_install(dest, pip = T, pip_ignore_installed=T),
    warning = function(w) {
    if (grepl("ephemeral virtual environment", conditionMessage(w))) {
      invokeRestart("muffleWarning")
    }
  })
  TRUE
  #reticulate::import("spacy")
  
}
