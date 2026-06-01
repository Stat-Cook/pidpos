#' Create a UDPipe tagging function
#'
#' Returns a function that tags text documents using a specified UDPipe model.
#' The returned function accepts a character vector of documents and returns
#' a tibble with tokens, sentences, and token metadata.
#'
#' @param model Character. The name of the UDPipe model to use. Defaults to `english-ewt`.
#' @param model_dir Character. Directory where UDPipe models are stored.
#' @param udpipe_repo Character. URL or path of the UDPipe model repository.
#'
#' @seealso [pidpos_setup()] and
#'   [set_udpipe_version()] for control of the configuration environment.
#' @return A function that takes a character vector of documents and returns a [tibble]
#'
#' with columns:
#' \describe{
#'   \item{ID}{Document identifier}
#'   \item{Token}{Individual token text}
#'   \item{Sentence}{Sentence containing the token}
#'   \item{POS}{The universal parts of speech tag of the token. See https://universaldependencies.org/format.html}
#'   \item{StartIndex}{The character index `Token` starts at}
#'   \item{EndIndex}{The character index `Token` ends at}
#' }
#' and all columns returned by the <[udpipe()`][udpipe::udpipe]>
#'   function for each token.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Create a tagger for the English EWT model
#' ewt_tagger <- udpipe_factory("english-ewt")
#' docs <- c("This is a test.", "Another sentence.")
#' ewt_tagger(docs)
#'
#' # Create a tagger for the English GUM model
#' gum_tagger <- udpipe_factory("english-gum")
#' gum_tagger(docs)
#'
#' # Create a tagger for the English LINES model
#' lines_tagger <- udpipe_factory("english-lines")
#' lines_tagger(docs)
#' }
udpipe_factory <- function(model = "english-ewt",
                           model_dir = pidpos_env$model_folder,
                           udpipe_repo = pidpos_env$udpipe_repo) {
  if (!getOption("pidpos_caching") && is.character(model)) {
    stop(
      "pidpos is configured not to cache models - either select a ",
      "caching option in `pidpos_setup()` or load a pretrained udpipe model."
    )
  }

  function(docs, doc_ids = NULL) {
    if (!is.character(docs) || length(docs) == 0) {
      type_error("`docs` must be a non-empty character vector.")
    }

    names(docs) <- format_doc_id(docs, doc_ids)

    # encoded_docs <- clean_encoding(docs)
    # names(utf8_docs) <- doc_ids

    if (!inherits(model, "udpipe_model")) check_model_download_consent(model)

    tagged <- tryCatch(
      udpipe::udpipe(
        docs,
        model,
        model_dir = model_dir,
        udpipe_model_repo = udpipe_repo
      ),
      error = function(e) {
        msg <- conditionMessage(e)
        if (grepl("File.*does not exist", msg)) {
          file_not_found_error(
            paste0(
              "UDPipe model could not be loaded.\n",
              "Original error: ",
              e$message,
              "\n",
              "Please run `browse_model_location()` to see if models are downloaded.\n",
              "If not present download via `browse_udpipe_repo()."
            )
          )
        }
        stop(e)
      }
    )

    result <- tagged |>
      dplyr::mutate(`TokenNo` = as.numeric(.data$token_id)) |>
      dplyr::rename_with(~ c("ID", "Token", "Sentence", "POS", "StartIndex", "EndIndex"),
        .cols = c("doc_id", "token", "sentence", "upos", "start", "end")
      ) |>
      tibble::as_tibble()

    dplyr::select(
      result,
      all_of(c("ID", "Token", "Sentence", "POS", "StartIndex", "EndIndex")),
      all_of(colnames(result))
    )
  }
}
