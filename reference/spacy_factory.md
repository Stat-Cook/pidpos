# pidpos bindings to spacy models

pidpos bindings to spacy models

## Usage

``` r
spacy_factory(model = "en_core_web_lg")
```

## Arguments

- model:

  The spacy language model - currently supports "en_core_web_lg" and
  "en_core_web_trf"

## Value

A tagging function with the signature tagger(doc, doc_id) -\> data.frame

## See also

[redact](https://stat-cook.github.io/pidpos/reference/redact.md),
[udpipe_factory](https://stat-cook.github.io/pidpos/reference/udpipe_factory.md)

## Examples

``` r
if (FALSE) { # \dontrun{
spacy_tagger <- spacy_factory()

pidpos(the_one_in_massapequa, tagger = spacy_tagger, filter_func = spacy_filter)
} # }
```
