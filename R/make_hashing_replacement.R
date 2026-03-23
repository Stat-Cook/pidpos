#' Function factory for hashing replacement.
#'
#' @param key The hash key (passed to `hash`)
#' @param salt The hash salt
#' @param hash The desired hash function (default is [openssl::sha256]).
#'    NB: other functions can be used, if they take `key` as a key word argument.
#'
#' @return `function`
#'
#' @examples
#' replace_by <- make_hashing_replacement(key = "PIDPOS", salt = "SALT")
#' auto_replace(raw_redaction_rules, replacement_func = replace_by)
#'
#' @importFrom openssl sha256
#' @export
#' @seealso [auto_replace()]
make_hashing_replacement <- function(key, salt = "", hash = sha256) {
  key <- as.character(key)

  hash_function <- function(x) {
    paste(x, salt, sep = "_") |>
      hash(key = key)
  }

  hash_function
}
