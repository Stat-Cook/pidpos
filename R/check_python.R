#' @importFrom reticulate use_condaenv import
check_python <- function(envname = "spacy-env"){
  use_condaenv(envname)
  
  numpy <- import("numpy")
  spacy <- import("spacy")
  torch <- tryCatch(
    import("torch"),
    error = function(e) {
      message("Module `torch` not available - `trf` model unavailable.") 
      NULL
    }
  )
  
  versions <- list(numpy = numpy$`__version__`,
       spacy = spacy$`__version__`,
       torch = if (!is.null(torch)) torch$`__version__` else "not available"
  )
  
  # Explicit removal of local bindings: 
  rm(numpy, spacy, torch)
  
  versions
}


