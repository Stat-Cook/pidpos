#' Create a PID detection function from a named list of regex patterns
#'
#' @param patterns A data frame with columns `type`, `pattern`, and optionally
#'   `description`. Defaults to the built-in [pid_patterns]. Note that a
#'   `pid_patterns` variable in the calling environment will not override the
#'   default; pass it explicitly if you wish to use a modified version.
#'
#' @return A function with signature \code{function(doc, doc_id)} that returns
#'   a data frame with columns: doc_id, type, match, start, end, doc.
#' 
#' @examples 
#' 
#' regex_tagger <- regex_factory()
#' 
#' regex_tagger(c('Send a message to DonaldDuck@gmail.com', 'Arrange the meeting for 2024-07-01'))
#' 
#' @export
regex_factory <- function(patterns = pid_patterns) {
  #  Validate patterns at construction time
  if (!inherits(patterns, "data.frame") ||
    !all(c("type", "pattern") %in% colnames(patterns))) {
    type_error("`patterns` must be a data frame with columns `type` and `pattern`.")
  }

  if (!is.character(patterns$type) || !is.character(patterns$pattern)) {
    type_error("Columns `type` and `pattern` must both be character vectors.")
  }

  if (any(is.na(patterns$type) | !nzchar(patterns$type))) {
    value_error("All values in `type` must be non-empty strings.")
  }

  invalid_patterns <- purrr::map_lgl(patterns$pattern, function(p) {
    inherits(tryCatch(grepl(p, "", perl = TRUE), error = function(e) e), "error")
  })

  if (any(invalid_patterns)) {
    value_error(
      paste0(
        "The following patterns failed to compile:\n",
        paste0(
          "  [", patterns$type[invalid_patterns], "] ",
          patterns$pattern[invalid_patterns],
          collapse = "\n"
        )
      )
    )
  }

  #  Closure
  function(docs, doc_ids = NULL) {
    if (!is.character(docs) || length(docs) == 0) {
      type_error("`docs` must be a non-empty character vector.")
    }

    doc_ids <- format_doc_id(docs, doc_ids)
    utf8_docs <- utf8::utf8_encode(docs)

    results <- purrr::map2(utf8_docs, doc_ids, function(text, id) {
      purrr::pmap(patterns, function(type, pattern, ...) {
        m <- gregexpr(pattern, text, perl = TRUE, ignore.case = TRUE)[[1]]

        if (m[[1]] == -1L) {
          return(NULL)
        }

        tibble::tibble(
          ID = id,
          Token = regmatches(text, list(m))[[1]],
          POS = type,
          StartIndex = as.integer(m),
          EndIndex = as.integer(m) + attr(m, "match.length") - 1L,
          Sentence = text
        )
      }) |>
        purrr::compact() |>
        dplyr::bind_rows()
    }) |>
      purrr::compact() |>
      dplyr::bind_rows()

    if (nrow(results) == 0) {
      return(tibble::tibble(
        ID = character(),
        Token = character(),
        POS = character(),
        StartIndex = integer(),
        EndIndex = integer(),
        Sentence = character()
      ))
    }

    dplyr::arrange(results, .data$ID, .data$StartIndex)
  }
}
