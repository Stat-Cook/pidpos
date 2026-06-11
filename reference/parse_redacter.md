# Parse a data frame into a redaction function with optional caching.

Parse a data frame into a redaction function with optional caching.

## Usage

``` r
parse_redacter(redacter, with_cache = TRUE)
```

## Arguments

- redacter:

  A data.frame containing `From`, `To` and `If` or a file path to

- with_cache:

  A binary flag to control if memoization is required.

## Value

A function with the signature `function(x)` that takes a character
vector and returns the redacted (as defined by `redacter`) equivalent.
