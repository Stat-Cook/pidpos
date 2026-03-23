#' Redact PID across folder structure
#'
#' For use as part of the folder level API - this function is the equivalent of
#' [redact()].  The redacted files are saved in the specified `output_path`.
#'
#' @inheritParams find_supported_files
#' @inheritParams redact_supported_files
#'
#' @export
redact_at_folder <- function(data_path,
                             redacter,
                             output_path = "Redacted Data",
                             extensions = get_implemented_extensions(),
                             export_function = NULL,
                             verbose = FALSE) {
  if (!is.character(output_path) | length(output_path) != 1) {
    stop("`output_path` must be a single character string")
  }

  redacter <- parse_redacter(redacter)

  files_to_redact <- find_supported_files(data_path, extensions, verbose)
  redact_supported_files(files_to_redact, output_path, redacter, export_function)
}
