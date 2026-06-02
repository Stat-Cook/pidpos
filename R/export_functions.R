#' Export utilities
#'
#' Utilities for writing `pidpos` reports in a folder structure when using `report_on_folder`.
#' To mimic the file tree on read use `export_as_tree`, or for a  flat structure use  `export_flat`.
#'
#' @param report The data frame to be written to disk
#' @param name The file name NB: slashes will act as folder sublevels for `export_as_tree` and be
#' replaced with underscores in `export_flat`
#' @param report_path the root location
#'
#' @return The path to the output file
#' @name export_utilites
NULL

#' @rdname export_utilites
#' @export
export_as_tree <- function(report, name, report_path) {
  output_file <- file.path(report_path, paste0(name, ".csv"))
  output.dir <- dirname(output_file)

  if (!dir.exists(output.dir)) {
    dir.create(output.dir, recursive = TRUE)
  }

  write.csv(report, output_file, row.names = FALSE)
  output_file
}

#' @rdname export_utilites
#' @importFrom stringr str_replace_all
#' @export
export_flat <- function(report, name, report_path) {
  flat_name <- stringr::str_replace_all(name, "/", "_")
  export_as_tree(report, flat_name, report_path)
}
