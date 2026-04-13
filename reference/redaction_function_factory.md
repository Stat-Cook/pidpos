# Replacement rules to redaction function

Convert a `data.frame` of redaction rules into a function that can be
applied to a character vector.

## Usage

``` r
redaction_function_factory(rules.frm)
```

## Arguments

- rules.frm:

  A data.frame with columns `If`, `From` and `To`.

## Examples

``` r
# \donttest{
data(the_one_in_massapequa)
example.data <- head(the_one_in_massapequa)

raw_rules <- pidpos(example.data) |>
  report_to_redaction_rules()
#> Error in map2(chunks, id_chunks, tagger, .progress = TRUE): ℹ In index: 1.
#> ℹ With name: 1.
#> Caused by error:
#> ! Model download required but session is non-interactive. Set options(pidpos_download_approved = TRUE) or env var PIDPOS_DOWNLOAD_APPROVED=true.

redaction_rules <- auto_replace(raw_rules,
  replacement_func = make_random_replacement()
)
#> Error: object 'raw_rules' not found

redaction_func <- redaction_function_factory(redaction_rules)
#> Error: object 'redaction_rules' not found

redaction_func(example.data)
#> Error in redaction_func(example.data): could not find function "redaction_func"
# }
```
