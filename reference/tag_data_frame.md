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
data(presidio_text)
example.data <- presidio_text[32:35, ]

# Using regex_factory for illustration; for real PID detection
# the udpipe or spaCy taggers are recommended.
regex_tagger <- regex_factory()
tag_data_frame(example.data, regex_tagger)
#> $AllTags
#> # A tibble: 6 × 6
#>   ID                 Token                    POS   StartIndex EndIndex Sentence
#>   <glue>             <chr>                    <chr>      <int>    <int> <chr>   
#> 1 Col:Document Row:1 03428245880              phone         13       23 "My car…
#> 2 Col:Document Row:2 4007070753690781         card          56       71 "Could …
#> 3 Col:Document Row:2 070707536907             phone         58       69 "Could …
#> 4 Col:Document Row:2 UtaKortig@jourrapide.com email         86      109 "Could …
#> 5 Col:Document Row:3 42323                    post…         53       57 "The Av…
#> 6 Col:Document Row:4 UshurmaDratchev@rhyta.c… email         24       48 "You sa…
#> 
#> $Documents
#> # A tibble: 4 × 5
#>   Document                                ID    Repeats `Affected Columns`    PK
#>   <chr>                                   <glu>   <int> <chr>              <int>
#> 1 "Could you please send me the last bil… Col:…       1 `Document`             2
#> 2 "My card 4131034282458809939 is expiri… Col:…       1 `Document`             1
#> 3 "The Avalara office is at PSC 0413, Bo… Col:…       1 `Document`             3
#> 4 "You said your email is UshurmaDratche… Col:…       1 `Document`             4
#> 

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
