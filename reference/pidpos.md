# Proper Noun Detection

For a given data set, the function reports each detected instance of a
proper noun and reports the location in the data set, the `Document`
containing the proper noun, and how often the `Document` occurs.

## Usage

``` r
pidpos(
  frm,
  tagger = "english-ewt",
  filter_func = filter_to_proper_nouns,
  chunk_size = 100,
  to_ignore = c(),
  warn_if_missing = FALSE
)
```

## Arguments

- frm:

  A data frame to check for proper nouns

- tagger:

  Either a string naming a UDPipe model (see
  [udpipe::udpipe_download_model](https://rdrr.io/pkg/udpipe/man/udpipe_download_model.html)
  for the list of models) or a custom tagging function (see
  [`vignette("custom-functions")`](https://stat-cook.github.io/pidpos/articles/custom-functions.md)
  for details of what is required).

- filter_func:

  A function to filter the tagged instances. See the 'Custom Filtering
  Functions' section of
  [`vignette("custom-functions")`](https://stat-cook.github.io/pidpos/articles/custom-functions.md)
  for more details.

- chunk_size:

  The number of sentences to tag at a time. The optimal value has yet to
  be determined.

- to_ignore:

  A vector of column names to be ignored by the algorithm. Intended to
  be used for variables that are giving strong false positives, such as
  IDs or ICD-10 codes.

- warn_if_missing:

  Raise a warning if the `to_ignore` columns are not in the data frame.

## Value

A `pidpos` (inheriting from tibble) containing:

- `ID`: The location of the sentence in the data frame in the form
  `Col:<colname> Row:<rownumber>`.

- `Token`: The detected proper noun.

- `Sentence`: The sentence in which the proper noun occurs.

- `Document`: The source string (data frame cell) containing the
  sentence.

- `Repeats`: The number of times the `Document` occurs in the data
  frame.

- `Affected Columns`: The columns in the data frame where the `Document`
  occurs.

If no proper nouns are detected, an empty data frame is returned.

## Note

By default `pidpos()` caches the `udpipe` models in a package cache
directory. This behaviour can be altered via
[`pidpos_setup()`](https://stat-cook.github.io/pidpos/reference/pidpos_setup.md)
to redirect `udpipe` models or force environemnt only models.

## See also

- To summarize the results:
  [`summary.pidpos()`](https://stat-cook.github.io/pidpos/reference/summary.pidpos.md)

- To help with redaction of PID:
  [`report_to_redaction_rules()`](https://stat-cook.github.io/pidpos/reference/report_to_redaction_rules.md)

- To report on a data repository:
  [`report_on_folder()`](https://stat-cook.github.io/pidpos/reference/report_on_folder.md)

- for help constructing a custom tagger:
  [`custom_tagger()`](https://stat-cook.github.io/pidpos/reference/custom_tagger.md)

## Examples

``` r
if (FALSE) { # \dontrun{
data(the_one_in_massapequa)
example.data <- head(the_one_in_massapequa, 50)
try(
  pidpos(example.data, to_ignore = c("scene", "utterance"))
)

pidpos(example.data, to_ignore = c("scene", "utterance"), tagger = "english-gum")

tag_ewt <- udpipe_factory("english-ewt")
pidpos(example.data, to_ignore = c("scene", "utterance"), tagger = tag_ewt)


filter_to_long_proper_nouns <- function(frm) {
  frm |>
    dplyr::filter(nchar(Token) > 1)
  filter_to_proper_nouns(frm)
}

pidpos(example.data,
  to_ignore = c("scene", "utterance"),
  tagger = tag_ewt, filter = filter_to_long_proper_nouns
)
} # }
```
