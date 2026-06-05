# Combine multiple PID reports into a single rule set

For use as part of the folder level API - this function is the
equivalent of
[`report_to_redaction_rules()`](https://stat-cook.github.io/pidpos/reference/report_to_redaction_rules.md).

## Usage

``` r
get_distinct_redaction_rules(object, include_context = FALSE)
```

## Arguments

- object:

  The object to extract distinct redaction rules from. Can be a path to
  a folder of `pid` reports, a list of `pid` reports, or a single data
  frame.

- include_context:

  A boolean flag indicating whether to include context information in
  the output. Default is FALSE.

## Value

A data frame

## Examples

``` r
# From a list of pidpos reports (the typical folder API use case):
report1 <- raw_redaction_rules
report2 <- raw_redaction_rules
get_distinct_redaction_rules(list(report1, report2))
#> Error in map(object, report_to_redaction_rules, include_context = include_context): ℹ In index: 1.
#> Caused by error in `.f()`:
#> ! report is missing columns: Document, Token

# From a single data frame:
get_distinct_redaction_rules(raw_redaction_rules)
#> Error in report_to_redaction_rules(object, include_context = include_context): report is missing columns: Document, Token
```
