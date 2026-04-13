# Filter a tagged data frame to proper nouns

Filter a tagged data frame to proper nouns

## Usage

``` r
filter_to_proper_nouns(tag_frm)
```

## Arguments

- tag_frm:

  A data frame containing at least the columns `upos`, `ID`, `Token`,
  and `Sentence`.

## Value

A tibble containing only rows where `upos == "PROPN"`, with columns
`ID`, `Token`, and `Sentence`.

## Examples

``` r
# \donttest{
example.data <- head(the_one_in_massapequa, 20)
tagged <- tag_data_frame(example.data, tagger = "english-ewt")
#> Error in map2(chunks, id_chunks, tagger, .progress = TRUE): ℹ In index: 1.
#> ℹ With name: 1.
#> Caused by error:
#> ! Model download required but session is non-interactive. Set options(pidpos_download_approved = TRUE) or env var PIDPOS_DOWNLOAD_APPROVED=true.
filter_to_proper_nouns(tagged$`AllTags`)
#> Error: object 'tagged' not found
# }
```
