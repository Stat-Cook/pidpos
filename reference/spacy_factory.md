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
