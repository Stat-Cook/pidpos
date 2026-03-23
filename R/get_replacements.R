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
#' @name get_replacements
NULL

#' @rdname get_replacements
#' @export
get_replacement_cache <- function(object) {
  attr(object, "mapper")$cache
}

#' @rdname get_replacements
#' @export
key_lookup <- function(object, key) {
  cache <- get_replacement_cache(object)
  cache[[key]]
}

#' @rdname get_replacements
#' @export
value_lookup <- function(object, value) {
  cache <- get_replacement_cache(object)
  names(which(cache == value))
}
