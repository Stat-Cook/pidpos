# Create a PID detection function from a named list of regex patterns

Create a PID detection function from a named list of regex patterns

## Usage

``` r
regex_factory(patterns = pid_patterns)
```

## Arguments

- patterns:

  A data frame requiring two columns (`type` and `pattern`)

## Value

A function with signature `function(doc, doc_id)` that returns a data
frame with columns: doc_id, type, match, start, end, doc.
