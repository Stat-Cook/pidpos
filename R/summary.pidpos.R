most_common <- function(cnt, names) {
  names(cnt) <- names
  names(which.max(cnt))
}


#' Summarize a  `pidpos` report.
#'
#' @param object An object of class `pidpos`.
#' @param ... further arguments passed to or from other methods.
#'
#' @return A data frame describing any column determined to contain PID.
#' \itemize{
#'   \item Column
#'   \item Cases of Proper Nouns - the number of sentences with proper nouns in the column
#'   \item Unique Cases of Proper Nouns - the number of unique sentences with proper nouns in the column
#'   \item Most Common Proper Noun Sentence - the most commonly occurring sentence containing proper nouns.
#' }
#' 
#' @examples
#' data(presidio_text)
#' example.data <- presidio_text[32:35, ]
#'
#' # Using regex_factory for illustration; for real PID detection
#' # the udpipe or spaCy taggers are recommended.
#' regex_tagger <- regex_factory()
#'
#' report <- pidpos(example.data, tagger = regex_tagger, filter_func = function(x) x)
#' summary(report)
#'
#' @importFrom dplyr distinct bind_rows summarise
#' @importFrom dplyr n
#' @importFrom purrr map
#' @importFrom stringr str_detect str_extract_all
#' @exportS3Method
#' 
#'
#' @seealso [pidpos]
summary.pidpos <- function(object, ...) {
  object <- as_tibble(object)

  .uni <- unique(object$`Affected Columns`)
  affected.cols <- unique(simplify(str_extract_all(.uni, "`.*?`")))

  map(
    affected.cols,
    ~ object |>
      dplyr::filter(str_detect(`Affected Columns`, .x)) |>
      distinct(Sentence, Repeats) |>
      summarise(
        `Column` = .x,
        `Cases of Proper Nouns` = sum(Repeats),
        `Unique Cases of Proper Nouns` = n(),
        `Most Common Proper Noun Sentence` = most_common(Repeats, Sentence)
      )
  ) |>
    bind_rows()
}
