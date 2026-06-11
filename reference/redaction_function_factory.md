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

## Value

A function with signature `function(vec)` which applies the rules in
`rules.frm` to each element of `vec`.

## Examples

``` r
data(presidio_text)
example.data <- presidio_text[32:35, ]

# Using regex_factory for illustration; for real PID detection
# the udpipe or spaCy taggers are recommended.
regex_tagger <- regex_factory()
report <- pidpos(example.data, tagger = regex_tagger, filter_func = function(x) x) #'

raw_rules <- report_to_redaction_rules(report)

redaction_rules <- auto_replace(raw_rules,
  replacement_func = make_random_replacement()
)

redaction_func <- redaction_function_factory(redaction_rules)

redaction_func(example.data$Document)
#> [1] "My card 4131UVZWSHWBQQ9939 is expiring this month. Please let me know process to it's extend validity."
#> [2] "Could you please send me the last billed amount for cc IJCKNJTXHE on my e-mail TESAAOSYTC?"            
#> [3] "The Avalara office is at PSC 0413, Box 8144\nAPO AA QAXTVMNZBA"                                        
#> [4] "You said your email is GTWLCQWSNG. Is that correct?"                                                   
```
