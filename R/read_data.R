#' IO utility
#'
#' Maps file extension to the predefined reader.
#'
#' @param file_path Path to file
#' @param ... Optional parameters to pass to the file reader
#'
#' @return The file content
#'
#' @keywords internal
read_data <- function(file_path, ...) {
  ext <- tolower(tools::file_ext(file_path))

  reader <- pidpos_env$file_readers[[ext]]

  if (is.null(reader)) {
    stop("Unsupported file type: ", ext, call. = FALSE)
  }

  reader(file_path, ...)
}
