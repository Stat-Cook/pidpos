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

## See also

[`pidpos()`](https://stat-cook.github.io/pidpos/reference/pidpos.md)

## Examples

``` r
tagged <- data.frame(
  upos = c("PROPN", "VERB", "PROPN"),
  ID = c("doc1", "doc1", "doc2"),
  Token = c("London", "visited", "Paris"),
  Sentence = c("London was visited.", "London was visited.", "Paris is nice.")
)
filter_to_proper_nouns(tagged)
#>     ID  Token            Sentence
#> 1 doc1 London London was visited.
#> 2 doc2  Paris      Paris is nice.
```
