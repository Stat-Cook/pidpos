#' 
check_python <- function(envname = "spacy-env") {
  reticulate::use_condaenv(envname)

  numpy <- reticulate::import("numpy")
  spacy <- reticulate::import("spacy")
  torch <- tryCatch(
    reticulate::import("torch"),
    error = function(e) {
      message("Module `torch` not available - `trf` model unavailable.")
      NULL
    }
  )

  versions <- list(
    numpy = numpy$`__version__`,
    spacy = spacy$`__version__`,
    torch = if (!is.null(torch)) torch$`__version__` else "not available"
  )

  # Explicit removal of local bindings:
  rm(numpy, spacy, torch)

  versions
}
