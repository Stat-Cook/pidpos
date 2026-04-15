#' Function factory for random replacement.
#'
#' Simple APIs for implementing random replacement functions for use in [auto_replace()].
#' The user can select between:
#'
#' @param replacement_size The size of the replacement (number of characters in each replacement).
#' @param replacement_space The space from which to sample replacements (default is `LETTERS`).
#' @param all If `TRUE`, every value in `To` gets a unique repalcement.  If `FALSE`, replacements are reused.
#' @param elevate_warnings If `TRUE`, warnings are boosted to errors.
#'
#' @return `function`
#'
#' @examples
#'
#' replace_by <- make_random_replacement()
#' auto_replace(raw_redaction_rules, replacement_func = replace_by)
#'
#' replace_by <- make_random_replacement(replacement_space = LETTERS[1:10], replacement_size = 20)
#' auto_replace(raw_redaction_rules, replacement_func = replace_by)
#'
#' @seealso [auto_replace()]
#' @export
make_random_replacement <- function(replacement_size = 10,
                                    replacement_space = LETTERS,
                                    all = FALSE,
                                    elevate_warnings = FALSE) {
  if (!is.numeric(replacements_size) || replacements_size < 0 || x != floor(x)){
    stop("`replacement_size` should be a non-zero positive integer")
  }
  
  random_encoder <- function() {
    paste(sample(replacement_space, replacement_size, TRUE), collapse = "")
  }

  make_replacement_function(random_encoder,
    length(replacement_space)^replacement_size,
    all = all,
    elevate_warnings = elevate_warnings
  )
}
