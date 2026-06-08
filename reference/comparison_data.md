# Comparison datasets

Entity identification tests on the `presidio_text` data set, consisting
of 6 taggers and a basic ensemble method, run under different
preprocessing conditions.

## Usage

``` r
baseline_comparison

lower_comparison

preprocessed_comparison

titlecase_comparison
```

## Format

A list of 7 data frames for the `LG`, `TRF`, `EWT`, `GUM`, `LINES`,
`Regex`, and `Ensemble` models. Each consists of:

- entity_type:

  The Presidio entity tag.

- entity_value:

  The expected entity as it appears in the text

- start_position:

  The character index `entity_value` begins at

- end_position:

  The character index `entity_value` end at

- Doc ID:

  The specific document ID (see `presidio_text` and `presidio_tags`)

- Token:

  The proposed entity candidate

- POS:

  The candidate type

- StartIndex:

  The character index `Token` starts at

- EndIndex:

  The character index `Token` ends at

An object of class `list` of length 7.

An object of class `list` of length 7.

An object of class `list` of length 7.

An object of class `list` of length 7.

## Details

The four variants differ only in how the source text was preprocessed
before tagging:

- `baseline_comparison`:

  Data as-is, no preprocessing

- `lower_comparison`:

  Text converted to lower case — demonstrates UDPipe's sensitivity to
  case

- `preprocessed_comparison`:

  Non-ASCII characters removed

- `titlecase_comparison`:

  Text mapped to title case to improve UDPipe catch rate

## See also

[presidio_text](https://stat-cook.github.io/pidpos/reference/presidio_text.md),
[presidio_tags](https://stat-cook.github.io/pidpos/reference/presidio_tags.md)
