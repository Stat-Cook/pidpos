# Parse a data frame into a redaction function with optional caching.

Parse a data frame into a redaction function with optional caching.

## Usage

``` r
parse_redacter(redacter, with_cache = TRUE)
```

## Arguments

- redacter:

  A data.frame containing `From`, `To` and `If` or a file path to
  equivalent.

- with_cache:

  Logical. If `TRUE`, the resulting function will utilize memoization.

## Value

A function with the signature `function(x)` that takes a character
vector and returns the redacted (as defined by `redacter`) equivalent.

## Examples

``` r
replace_by <- make_random_replacement()
redaction_rules <- auto_replace(raw_redaction_rules, replacement_func = replace_by)

redacter <- parse_redacter(redaction_rules)
redact(head(the_one_in_massapequa), redacter)
#> # A tibble: 6 × 4
#>   scene utterance speaker          text                                         
#>   <int>     <int> <chr>            <chr>                                        
#> 1     1         1 Scene Directions [Scene: UIZDKNVZCS AHEYTSIJYA, everyone is t…
#> 2     1         2 Phoebe Buffay    Oh, XPVJFHCEPY, VZQNITVFQK, is it okay if I …
#> 3     1         3 Monica Geller    Yeah.                                        
#> 4     1         4 Ross Geller      Sure. Yeah.                                  
#> 5     1         5 Joey Tribbiani   So, who's the guy?                           
#> 6     1         6 Phoebe Buffay    Well, his name is CKAIQZBMHJ and I met him a…
```
