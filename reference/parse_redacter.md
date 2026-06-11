# Parse a data frame into a redaction function with optional caching.

Parse a data frame into a redaction function with optional caching.

## Usage

``` r
parse_redacter(redacter, with_cache = TRUE)
```

## Arguments

- redacter:

  A data.frame containing `From`, `To` and `If` or a file path to
  equivalent.

- with_cache:

  Logical. If `TRUE`, the resulting function will utilize memoization.

## Value

A function with the signature `function(x)` that takes a character
vector and returns the redacted (as defined by `redacter`) equivalent.
