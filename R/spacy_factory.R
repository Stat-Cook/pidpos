#' pidpos bindings to spacy models
#'
#' @param model The spacy language model - currently supports "en_core_web_lg" and "en_core_web_trf"
#'
#' @return A tagging function with the signature tagger(doc, doc_id) -> data.frame
#' @seealso [redact], [udpipe_factory]
#'
#' @examples
#' \dontrun{
#' spacy_tagger <- spacy_factory()
#'
#' spacy_tagger("John, Paul, George and Ringo made the Cavern Club famous")
#' }
#'
#' @export
spacy_factory <- function(model = "en_core_web_lg") {
  
  rlang::inform(
    "This function requires Python via reticulate. Be aware environment setup applies.",
    .frequency = "once",
    .frequency_id = "python_setup_notice"
  )
  
  install_spacy_model(model)

  spacy <- reticulate::import("spacy")
  tagger <- spacy$load(model)

  function(docs, doc_ids = NULL) {
    doc_ids <- format_doc_id(docs, doc_ids)

    map2(
      docs, doc_ids,
      \(.x, .y) spacy_process(.x, tagger) |>
        dplyr::mutate(ID = .y)
    ) |>
      dplyr::bind_rows() |>
      dplyr::select(all_of(c("ID", "Token", "Sentence", "POS", "StartIndex", "EndIndex")))
  }
}


spacy_filter <- function(frm) {
  dplyr::filter(frm, .data$POS %in% c("PERSON", "DATE"))
}


spacy_process <- function(doc, tagger) {
  tagged <- tagger(doc)

  if (length(tagged$ents) == 0) {
    return(tibble::tibble(
      Sentence = doc,
      Token = NA_character_,
      POS = NA_character_
    ))
  }

  tibble::tibble(
    Sentence = doc,
    Token = simplify(map(tagged$ents, "text")),
    POS = simplify(map(tagged$ents, "label_")),
    StartIndex = simplify(map(tagged$ents, "start_char")),
    EndIndex = simplify(map(tagged$ents, "end_char"))
  )
}
