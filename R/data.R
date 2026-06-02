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
#' \describe{
#'  \item{If}{The text to be redacted (character)}
#'  \item{From}{The text to be replaced (character)}
#'  \item{To}{The text to replace it with (character)}
#' }
#'
"raw_redaction_rules"


#' baseline_comparison
#'
#' Entity identification tests on the `presidio_text` data set, consisting of a
#' list of 6 taggers  and a basic ensemble method. The 'baseline'
#' version is the data as-is with no preprocessing.
#'
"baseline_comparison"

#' lower_comparison
#'
#' Entity identification tests on the `presidio_text` data set, consisting of a
#' list of 6 taggers  and a basic ensemble method. The 'lower'
#' version is the data converted to lower case to demonstrate the limitations of udpipe.
#'
"lower_comparison"

#' preprocessed_comparison
#'
#' Entity identification tests on the `presidio_text` data set, consisting of a
#' list of 6 taggers  and a basic ensemble method. The 'preprocessed'
#' version is the data with non XXX character removed.
#'
"preprocessed_comparison"

#' titlecase_comparison
#'
#' Entity identification tests on the `presidio_text` data set, consisting of a
#' list of 6 taggers  and a basic ensemble method. The 'titlecase'
#' version is the data mapped to titlecase to improve udpipe catch rate.
#'
"titlecase_comparison"

#' presidio_text
#'
#' A benchmarking data set to check the reliability of pidpos,  built from the
#' data at https://raw.githubusercontent.com/microsoft/presidio-research/master/data/synth_dataset_v2.json
#'
#' Consists of a dataframe with  three columns:
#' * `Document` - the free text
#' * `Doc ID`
#' * `Template` - the document template used by presidio in generating synthetic text
#'
#' See `presidio_tags` for the accompanying entity locations.
#'
"presidio_text"

#' presidio_tags
#'
#' The location and type of named entities in `presidio_text`.
#'
#' Consists of a dataframe with  five columns:
#' * `entity_type` - the type of named entity
#' * `entity_value`
#' * `start_position`/ `end_position` - the string span the entity occurs at
#' * `Doc ID` - the relative document in `presidio_text`
#'
"presidio_tags"
