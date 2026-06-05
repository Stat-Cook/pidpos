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
if (FALSE) { # \dontrun{
data(the_one_in_massapequa)
example_data_head <- head(the_one_in_massapequa, 50)
example_data_tail <- tail(the_one_in_massapequa, 50)

report1 <- pidpos(example_data_head, to_ignore = c("scene", "utterance"))
report2 <- pidpos(example_data_tail, to_ignore = c("scene", "utterance"))

combined <- list(report1, report2)
get_distinct_redaction_rules(combined)
} # }
```
