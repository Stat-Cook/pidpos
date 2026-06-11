# Remove PID from a data frame via a merge

Higher-speed alternative to the function-based redaction pipeline for
reapplying existing redaction rules. Not yet benchmarked against the
standard pipeline - kept internal until performance advantage is
confirmed.

## Usage

``` r
merge_redactions(frm, cached_redactions, preprocess = utf8::utf8_encode)
```

## Arguments

- frm:

  The data frame to be redacted

- cached_redactions:

  A data frame with `If` and `Then` columns

- preprocess:

  A function of preprocessing steps to be applied to the text columns.

## Value

A data frame of redacted data
