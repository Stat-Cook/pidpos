# A default filter for the spaCy language models

Filters to 'PERSON' and 'DATE' entities.

## Usage

``` r
spacy_filter(frm)
```

## Arguments

- frm:

  A data frame containing at least the column `POS`

## Value

Filtered data frame

## Examples

``` r
if (FALSE) { # \dontrun{
spacy_tagger <- spacy_factory()

pidpos(the_one_in_massapequa, tagger = spacy_tagger, filter_func = spacy_filter)
} # }
```
