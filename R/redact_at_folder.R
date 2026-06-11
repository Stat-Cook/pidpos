#' Redact PID across folder structure
#'
#' For use as part of the folder level API - this function is the equivalent of
#' [redact()].  The redacted files are saved in the specified `output_path`.
#'
#' @inheritParams find_supported_files
#' @inheritParams redact_supported_files
#'
#' @return (Invisibly) the list of files redacted
#'
#' @examples
#' \dontrun{
#' input_dir <- withr::local_tempdir()
#' output_dir <- withr::local_tempdir()
#'
#' utils::write.csv(
#'   data.frame(text = "Joey went to London", stringsAsFactors = FALSE),
#'   file.path(input_dir, "example.csv"),
#'   row.names = FALSE
#' )
#'
#' replace_by <- make_random_replacement()
#' prepared <- auto_replace(raw_redaction_rules, replacement_func = replace_by)
#'
#' redact_at_folder(input_dir, redacter = prepared, output_path = output_dir)
#' }
#'
#' @export
redact_at_folder <- function(data_path,
                             redacter,
                             output_path = "Redacted Data",
                             extensions = get_implemented_extensions(),
                             export_function = NULL,
                             verbose = FALSE) {
  if (!is.character(output_path) || length(output_path) != 1) {
    stop("`output_path` must be a single character string")
  }

  redacter <- parse_redacter(redacter)

  files_to_redact <- find_supported_files(data_path, extensions, verbose)
  file_list <- redact_supported_files(files_to_redact, output_path, redacter, export_function)

  invisible(file_list)
}
