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
if (FALSE) { # \dontrun{
data(the_one_in_massapequa)
example.data <- head(the_one_in_massapequa)

raw_rules <- pidpos(example.data) |>
  report_to_redaction_rules()

redaction_rules <- auto_replace(raw_rules,
  replacement_func = make_random_replacement()
)

redaction_func <- redaction_function_factory(redaction_rules)

redaction_func(example.data)
} # }
```
