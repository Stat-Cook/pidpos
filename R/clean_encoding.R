#' Encode non utf8 text
#' 
#' @param text A character vector to be encoded
#' 
#' @return A character vector
#' 
#' @importFrom stringi stri_enc_isutf8
clean_encoding <- function(text) {
  if (!all(stringi::stri_enc_isutf8(text), na.rm = TRUE)) {
    warning("Non-UTF-8 text detected - attempting conversion. Check results carefully.")
    text <- stringi::stri_enc_toutf8(text, is_unknown_8bit = TRUE)
  }
  text
}
