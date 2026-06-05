#' The One in Massapequa
#'
#' A subset of the 'Friends' data set containing the scene, utterance, speaker and
#' text of the episode 'The One in Massapequa' (s8e18).
#'
#' @format  A data frame with 257 rows and 4 columns:
#' \describe{
#'   \item{scene}{The scene number (integer)}
#'   \item{utterance}{The utterance-by-scene number (integer)}
#'   \item{speaker}{The speaker of the utterance (character)}
#'   \item{text}{The text of the utterance (character)}
#' }
#'
"the_one_in_massapequa"


# sentence_frm
#' A short data frame of free text including PID.  Used for basic examples
#' and tests.
#'
#' @format  A data frame with 5 rows and 4 columns:
#' \describe{
#'   \item{ID}{The row number (integer)}
#'   \item{Sentence}{The free text to detect PID in.}
#'   \item{Numeric}{Example numeric data (discrete) to be ignored by the algorithm}
#'   \item{Random}{Example numeric data (continuous) to be ignored by the algorithm}
#' }
#'
"sentence_frm"


#' raw_redaction_rules
#' An example of a redaction rules produced by the `pidpos` function.
#' It is made using the first 20 rows of `the_one_in_massapequa` data set.
#' 
#' @format  A data frame with 10 rows and 3 columns:
#' \describe{
#'  \item{If}{The text to be redacted (character)}
#'  \item{From}{The text to be replaced (character)}
#'  \item{To}{The text to replace it with (character)}
#' }
#'
"raw_redaction_rules"

#' Comparison datasets
#'
#' Entity identification tests on the `presidio_text` data set, consisting of
#' 6 taggers and a basic ensemble method, run under different preprocessing
#' conditions.
#'
#' @format  A list of 7 data frames for the `LG`, `TRF`, `EWT`, `GUM`, `LINES`, `Regex`, and `Ensemble` models.  
#' Each consists of:
#' \describe{
#'   \item{entity_type}{The Presidio entity tag.}
#'   \item{entity_value}{The expected entity as it appears in the text}
#'   \item{start_position}{The character index `entity_value` begins at}
#'   \item{end_position}{The character index `entity_value` end at}
#'   \item{Doc ID}{The specific document ID (see `presidio_text` and `presidio_tags`)}
#'   \item{Token}{The proposed entity candidate}
#'   \item{POS}{The candidate type}
#'   \item{StartIndex}{The character index `Token` starts at}
#'   \item{EndIndex}{The character index `Token` ends at}
#' }
#'
#' @details
#' The four variants differ only in how the source text was preprocessed before
#' tagging:
#' \describe{
#'   \item{`baseline_comparison`}{Data as-is, no preprocessing}
#'   \item{`lower_comparison`}{Text converted to lower case — demonstrates udpipe's sensitivity to case}
#'   \item{`preprocessed_comparison`}{Non-ASCII characters removed}
#'   \item{`titlecase_comparison`}{Text mapped to title case to improve udpipe catch rate}
#' }
#'
#' @seealso [presidio_text], [presidio_tags]
#' @name comparison_data
NULL


#' @rdname comparison_data
"baseline_comparison"


#' @rdname comparison_data
"lower_comparison"


#' @rdname comparison_data
"preprocessed_comparison"


#' @rdname comparison_data
"titlecase_comparison"

#' presidio_text
#'
#' A benchmarking data set to check the reliability of pidpos,  built from the
#' data at https://raw.githubusercontent.com/microsoft/presidio-research/master/data/synth_dataset_v2.json
#'
#' @format  A dataframe with  three columns::
#' \describe{
#'   \item{Document}{The free text}
#'   \item{Doc ID}{Primary key to allign with presidio_tags}
#'   \item{Template}{The document template used by presidio in generating synthetic text}
#' }
#'
#' See `presidio_tags` for the accompanying entity locations.
#'
"presidio_text"

#' presidio_tags
#'
#' The location and type of named entities in `presidio_text`.
#'
#' @format  A dataframe with  five columns:
#' \describe{
#'   \item{entity_type}{The type of named entity}
#'   \item{entity_value}{}
#'   \item{start_position/ end_position}{the string span the entity occurs at}
#'   \item{Doc ID}{Foreign key to allign with `presidio_text`}
#' }
#'
"presidio_tags"
