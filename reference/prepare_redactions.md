# Prepare a function from redaction rules.

Convert the `replacement_rules` (as defined with
`report_to_redaction_rules`) to a function that can be applied to a data
frame.

## Usage

``` r
prepare_redactions(object)
```

## Arguments

- object:

  The `replacement_rules` (can be a path to a csv file or a
  `data.frame`).

## Value

A function that can be applied to a data frame.

## Examples

``` r
data(presidio_text)
example.data <- presidio_text[32:35, ]

# Using regex_factory for illustration; for real PID detection
# the udpipe or spaCy taggers are recommended.
regex_tagger <- regex_factory()
report <- pidpos(example.data, tagger = regex_tagger, filter_func = function(x) x)
redactions.raw <- report_to_redaction_rules(report)

replace_by <- make_random_replacement()
redactions <- auto_replace(redactions.raw, replacement_func = replace_by)

f <- pidpos:::prepare_redactions(redactions)
#> Warning: `prepare_redactions()` was deprecated in pidpos 0.1.
#> ℹ Please use `parse_redacter()` instead.
f(example.data$Document)
#> [1] "My card 4131UIZDKNVZCS9939 is expiring this month. Please let me know process to it's extend validity."
#> [2] "Could you please send me the last billed amount for cc AHEYTSIJYA on my e-mail VZQNITVFQK?"            
#> [3] "The Avalara office is at PSC 0413, Box 8144\nAPO AA CKAIQZBMHJ"                                        
#> [4] "You said your email is ZPQDIMABCR. Is that correct?"                                                   
```
