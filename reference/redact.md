# Redact PID

Redact PID

## Usage

``` r
redact(object, redacter, in_batches = TRUE, ...)
```

## Arguments

- object:

  The object to be redacted - either a vector or data frame

- redacter:

  A `data.frame` of redaction rules or a function created by
  [`redaction_function_factory()`](https://stat-cook.github.io/pidpos/reference/redaction_function_factory.md).

- in_batches:

  Logical. If `TRUE` the supplied data will be processed in chunks.

- ...:

  Other arguments to control batching.

## Value

A copy of `object` with redactions applied.

## Examples

``` r
# Using the bundled redaction rules and source data:
replace_by <- make_random_replacement()
prepared <- auto_replace(raw_redaction_rules, replacement_func = replace_by)

example_data <- head(the_one_in_massapequa, 20)
redact(example_data, prepared)
#> # A tibble: 20 × 4
#>    scene utterance speaker          text                                        
#>    <int>     <int> <chr>            <chr>                                       
#>  1     1         1 Scene Directions "[Scene: QXIMNWERLW ZLGJZRDPZB, everyone is…
#>  2     1         2 Phoebe Buffay    "Oh, XKHTHYRDEH, MULXTLVMDH, is it okay if …
#>  3     1         3 Monica Geller    "Yeah."                                     
#>  4     1         4 Ross Geller      "Sure. Yeah."                               
#>  5     1         5 Joey Tribbiani   "So, who's the guy?"                        
#>  6     1         6 Phoebe Buffay    "Well, his name is OVFKIGGLRT and I met him…
#>  7     1         7 Chandler Bing    "Oooh, did he put a little starch in your b…
#>  8     1         8 Phoebe Buffay    "Yeah, he's really great though. He has thi…
#>  9     1         9 Monica Geller    "Oh, by the way. Would it be okay if I gave…
#> 10     1        10 Ross Geller      "Uh, yeah, you sure you want to after what …
#> 11     1        11 Monica Geller    "Yeah, I'd really like to."                 
#> 12     1        12 Ross Geller      "Okay, hopefully this time mom won't boo yo…
#> 13     1        13 Monica Geller    "Yes! Every year XKHTHYRDEH makes the toast…
#> 14     1        14 Chandler Bing    "And you wonder why XKHTHYRDEH is their fav…
#> 15     1        15 Monica Geller    "No! Really! Any time XKHTHYRDEH makes a to…
#> 16     1        16 Joey Tribbiani   "Well I can promise you, at least one perso…
#> 17     1        17 Monica Geller    "Really you can do that?"                   
#> 18     1        18 Joey Tribbiani   "Are you kidding me? Watch! Well I can't do…
#> 19     2         1 Scene Directions "[Scene: TGNITOUGZR and UBXETCDAWA's, they'…
#> 20     2         2 Chandler Bing    "What are you doing?"                       

# Passing a plain data.frame of rules directly (no auto_replace step):
rules <- data.frame(
  If = "Ross and Rachel got married.",
  From = "Ross",
  To = "PERSON_A"
)
redact(data.frame(text = "Ross and Rachel got married."), rules)
#>                               text
#> 1 PERSON_A and Rachel got married.
```
