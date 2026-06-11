# Create a PID detection function from a named list of regex patterns

Create a PID detection function from a named list of regex patterns

## Usage

``` r
regex_factory(patterns = pid_patterns)
```

## Arguments

- patterns:

  A data frame with columns `type`, `pattern`, and optionally
  `description`. Defaults to the built-in
  [pid_patterns](https://stat-cook.github.io/pidpos/reference/pid_patterns.md).
  Note that a `pid_patterns` variable in the calling environment will
  not override the default; pass it explicitly if you wish to use a
  modified version.

## Value

A function with signature `function(doc, doc_id)` that returns a data
frame with columns: doc_id, type, match, start, end, doc.

## Examples

``` r

regex_tagger <- regex_factory()

regex_tagger(c("Send a message to DonaldDuck@gmail.com", "Arrange the meeting for 2024-07-01"))
#> # A tibble: 2 × 6
#>   ID    Token                POS   StartIndex EndIndex Sentence                 
#>   <chr> <chr>                <chr>      <int>    <int> <chr>                    
#> 1 1     DonaldDuck@gmail.com email         19       38 Send a message to Donald…
#> 2 2     2024-07-01           date          25       34 Arrange the meeting for …
```
