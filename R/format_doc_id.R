#' Consistent handling of doc ids
#'
#' @param docs A character vector
#' @param doc_id (Optional) vector of suggested ids.
#'
#' @return The new doc ids
#' @keywords internal
format_doc_id <- function(docs, doc_id = NULL) {
  if (is.null(doc_id)) {
    doc_id <- seq_along(docs)
  }

  if (is.numeric(doc_id)) {
    doc_id <- as.character(doc_id)
  }

  doc_id
}
