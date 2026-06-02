#' Verify python
#'
#' Utility to check python environment is available and has neccesary functionality.
#'
#' @param envname The python environment you wish to use.
#' 
#' @return A list of python package version
#' @seealso check_python
#' @export
check_python <- function(envname = get_pidpos_conda()) {
  check_reticulate()

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

  rm(numpy, spacy, torch)

  versions
}
