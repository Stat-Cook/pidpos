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
data(presidio_text)
example_data_head <- head(presidio_text, 50)
example_data_tail <- tail(presidio_text, 50)

# Using regex_factory for illustration; for real PID detection
# the udpipe or spaCy taggers are recommended.

regex_tagger <- regex_factory()
report1 <- pidpos(example_data_head,
  tagger = regex_tagger,
  filter_func = function(x) x
)
report2 <- pidpos(example_data_tail,
  tagger = regex_tagger,
  filter_func = function(x) x
)

combined <- list(report1, report2)
get_distinct_redaction_rules(combined)
#> # A tibble: 36 × 4
#>    If                                                          From  To    POS  
#>    <chr>                                                       <chr> <chr> <chr>
#>  1 "The address of Persint is 6750 Koskikatu 25 Apt. 864\nArt… 64677 64677 post…
#>  2 "What is the limit for card 4454794511390933?"              4454… 4454… card 
#>  3 "Billing address: Sara Schwarz\n    28245 Puruntie 82 Apt.… 28245 28245 post…
#>  4 "Billing address: Sara Schwarz\n    28245 Puruntie 82 Apt.… 53650 53650 post…
#>  5 "William Hughes\n\n20789 Allika 46\n Suite 501\n Riisa\n\n… 62488 62488 post…
#>  6 "Tomomi Nishiyama lives at 86036 Rua do Arenque 1634, Goiâ… 86036 86036 post…
#>  7 "My card 4131034282458809939 is expiring this month. Pleas… 0342… 0342… phone
#>  8 "Could you please send me the last billed amount for cc 40… 4007… 4007… card 
#>  9 "Could you please send me the last billed amount for cc 40… 0707… 0707… phone
#> 10 "Could you please send me the last billed amount for cc 40… UtaK… UtaK… email
#> # ℹ 26 more rows
```
