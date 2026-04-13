# Tags a data frame with part of speech tags

Tags a data frame with part of speech tags

## Usage

``` r
tag_data_frame(
  frm,
  tagger = "english-ewt",
  chunk_size = 100,
  to_ignore = character()
)
```

## Arguments

- frm:

  A data frame to tag

- tagger:

  Either a string naming a UDPipe model (see `udpipe_factory` for the
  list of models) or a custom tagging function (see `udpipe_factory` for
  details of what is required).

- chunk_size:

  The number of sentences to tag at a time

- to_ignore:

  A character vector of column names to remove from the data frame

## Value

A list with two elements:

- AllTags:

  A tibble of token-level annotations

- Documents:

  A tibble describing the processed documents

## Examples

``` r
if (FALSE) { # \dontrun{
example.data <- head(the_one_in_massapequa, 20)

tag_data_frame(example.data, tagger = "english-ewt")
tag_data_frame(example.data, tagger = "english-gum")
tag_data_frame(example.data, tagger = "english-lines")

ewt_tagger <- udpipe_factory("english-ewt")
tag_data_frame(example.data, tagger = ewt_tagger)

gum_tagger <- udpipe_factory("english-gum")
tag_data_frame(example.data, tagger = gum_tagger)

lines_tagger <- udpipe_factory("english-lines")
tag_data_frame(example.data, tagger = lines_tagger)
} # }
```
