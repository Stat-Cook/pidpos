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
#' @examples
#'
#' replacement <- make_random_replacement()
#'
#' redaction_rules <- raw_redaction_rules |>
#'   auto_replace(replacement)
#'
#' get_replacement_cache(replacement)
#'
#' key_lookup(replacement, "Ross")
#'
#' value_lookup(replacement, redaction_rules$To[1])
#'
#' @name get_replacements
NULL

#' @rdname get_replacements
#' @return A named list of the form `list(original = replacement, ...)`
#' @export
get_replacement_cache <- function(object) {
  attr(object, "mapper")$cache
}

#' @rdname get_replacements
#' @return The replacement string for `key`, or `NULL` if not found.
#' @export
key_lookup <- function(object, key) {
  cache <- get_replacement_cache(object)
  cache[[key]]
}

#' @rdname get_replacements
#' @return The key that was pointed to by `value`
#' @export
value_lookup <- function(object, value) {
  cache <- get_replacement_cache(object)
  names(which(cache == value))
}
