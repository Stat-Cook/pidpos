#' Access the cache of replacements
#'
#' Tools for accessing the replacements inside a [make_replacement_function()]
#' function.
#'
#' @param object A function built by [make_replacement_function()] having been used
#' in [auto_replace()].
#' @param key The string to lookup a replacement for.
#' @param value The string to lookup what it replaced.
#'
#' @name get-replacements
NULL

#' @rdname get-replacements
#' @export
get_replacement_cache <- function(object) {
  attr(object, "mapper")$cache
}

#' @rdname get-replacements
#' @export
key_lookup <- function(object, key) {
  cache <- get_replacement_cache(object)
  cache[[key]]
}

#' @rdname get-replacements
#' @export
value_lookup <- function(object, value) {
  cache <- get_replacement_cache(object)
  names(which(cache == value))
}
