#  #' Get the context of a token in a sentence.
#'
#' NB: to set the context window size, use `set_context_window()`.
#'
#' @param sentence A character vector of sentences.
#' @param token A character vector of tokens.
#' @param context_window The width of window around the token to be taken.
#'
#' @importFrom dplyr mutate
#' @importFrom stringr str_locate str_sub
#' @importFrom tibble as_tibble
#'
#' @keywords internal
get_context <- function(sentence, token,
                        context_window = getOption("pidpos_context_window")) {
  loc <- stringr::str_locate(sentence, token)

  # If token not found, return NA
  if (any(is.na(loc))) {
    return(NA_character_)
  }

  start <- loc[1]
  end <- loc[2]
  sent_len <- stringr::str_length(sentence)

  from <- max(start - context_window, 1)
  to <- min(end + context_window, sent_len)

  ctx <- stringr::str_sub(sentence, from, to)
  ctx <- paste0(if (from > 1) "..." else "", ctx, if (to < sent_len) "..." else "")

  ctx
}




set_context_window <- function(x) {
  #' Set the context window size for the `get_context` function.
  #'
  #' @param x  An integer specifying the number of characters to include
  #'   before and after the token in the context.
  #'
  #' @keywords internal
  .opt <- list("pidpos_context_window" = x)

  options(.opt)
}
