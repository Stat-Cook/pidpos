# Automatic Replacement Tools

This package is designed to support the identification and redaction of
personally identifiable data (PID) within textual datasets.

The
[`report_to_redaction_rules()`](https://stat-cook.github.io/pidpos/reference/report_to_redaction_rules.md)
function generates a `replacement_rules` table from the output of
[`pidpos()`](https://stat-cook.github.io/pidpos/reference/pidpos.md).
This table specifies candidate values for redaction and provides a `To`
column in which users can define replacement values.

In many cases, users may wish to manually populate the To column (for
example, replacing names with consistent pseudonyms). However, when a
dataset contains a large volume of PID, manual specification may be
impractical. In such cases, the
[`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md)
utility can be used to automatically generate replacement values.

[`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md)
operates on a `replacement_rules` table and encodes the `To` column
according to a user-defined replacement function. The package provides
three built-in replacement strategies:

- [`make_hashing_replacement()`](https://stat-cook.github.io/pidpos/reference/make_hashing_replacement.md)
  — hashes values using a key and salt, producing deterministic and
  reproducible replacements.
- [`make_random_replacement()`](https://stat-cook.github.io/pidpos/reference/make_random_replacement.md)
  — generates random replacements from a defined character space.
- [`make_replacement_function()`](https://stat-cook.github.io/pidpos/reference/make_replacement_function.md) -
  \[Experimental\] convert a function for generating a random string
  into a compatible function.

------------------------------------------------------------------------

## Basic Workflow

We begin by generating a PID report and converting it into redaction
rules:

``` r

library(pidpos)

report <- pidpos(the_one_in_massapequa)
replacement_rules <- report_to_redaction_rules(report)
replacement_rules
```

    #> # A tibble: 5 × 4
    #>   If                                                           From  To    POS  
    #>   <chr>                                                        <chr> <chr> <chr>
    #> 1 [Scene: Central Perk, everyone is there.]                    Cent… Cent… ""   
    #> 2 [Scene: Central Perk, everyone is there.]                    Perk  Perk  ""   
    #> 3 Phoebe Buffay                                                Phoe… Phoe… ""   
    #> 4 Phoebe Buffay                                                Buff… Buff… ""   
    #> 5 Oh, Ross, Mon, is it okay if I bring someone to your parent… Ross  Ross  ""

To automatically populate the `To` column, we first initialise a
replacement function.  
In this example, we use
[`make_random_replacement()`](https://stat-cook.github.io/pidpos/reference/make_random_replacement.md)
to generate five-character replacements drawn from upper-case letters:

``` r

replacement_func <- make_random_replacement(
  replacement_size = 5,
  replacement_space = LETTERS
)
```

We then apply this function using
[`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md):

``` r

set.seed(101)
updated_replacement_rules <- auto_replace(
  replacement_rules,
  replacement_func
)

updated_replacement_rules
```

    #> # A tibble: 5 × 4
    #>   If                                                           From  To    POS  
    #>   <chr>                                                        <chr> <chr> <chr>
    #> 1 [Scene: Central Perk, everyone is there.]                    Cent… IYNWQ ""   
    #> 2 [Scene: Central Perk, everyone is there.]                    Perk  ZVCCI ""   
    #> 3 Phoebe Buffay                                                Phoe… CCBTU ""   
    #> 4 Phoebe Buffay                                                Buff… QNLAM ""   
    #> 5 Oh, Ross, Mon, is it okay if I bring someone to your parent… Ross  FXZPU ""

The resulting `updated_replacement_rules` can then be used alongside the
original data in the
[`redact()`](https://stat-cook.github.io/pidpos/reference/redact.md)
function to adjust the data:

``` r

redact(
  head(the_one_in_massapequa, 5),
  updated_replacement_rules
)
#> # A tibble: 5 × 4
#>   scene utterance speaker          text                                         
#>   <int>     <int> <chr>            <chr>                                        
#> 1     1         1 Scene Directions [Scene: IYNWQ ZVCCI, everyone is there.]     
#> 2     1         2 CCBTU QNLAM      Oh, FXZPU, JZKUZ, is it okay if I bring some…
#> 3     1         3 UTNHH TFXGJ      Yeah.                                        
#> 4     1         4 FXZPU TFXGJ      Sure. Yeah.                                  
#> 5     1         5 JYZIE QLCZI      So, who's the guy?
```

If the quantity of text being redacted is large, and documents are
regularly repeated, the user may wish to parse the replacement rules
into a caching redaction function:

``` r

cached_redacter <- parse_redacter(updated_replacement_rules, with_cache = T)
cached_redacter
#> [1] "`cached_redact_function` [size=0]"
```

This new function has a `memoization` layer built in, so that if the
same document is presented - replacements are called from memory. This
may speed up data processing if the same passage of text is presented
multiple times, but comes at the cost of memory. The
`cached_redact_function` can be used in
[`redact()`](https://stat-cook.github.io/pidpos/reference/redact.md) in
the same way:

``` r

redacted_docs <- redact(
  the_one_in_massapequa,
  cached_redacter
)
cached_redacter
#> [1] "`cached_redact_function` [size=264]"
```

And its representation tracks the number of unique documents stored.

## User defined functions

Depending on the situation, users may wish to implement their own
replacement functions.  
Where these are purely deterministic a single-argument function can be
passed into
[`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md)
to generate new values:

``` r

simple_replacement <- function(vec) {
  gsub(".*", "XXX", vec)
}

auto_replace(
  head(replacement_rules),
  simple_replacement
)
#> # A tibble: 6 × 4
#>   If                                                           From  To    POS  
#>   <chr>                                                        <chr> <chr> <chr>
#> 1 [Scene: Central Perk, everyone is there.]                    Cent… XXX   ""   
#> 2 [Scene: Central Perk, everyone is there.]                    Perk  XXX   ""   
#> 3 Phoebe Buffay                                                Phoe… XXX   ""   
#> 4 Phoebe Buffay                                                Buff… XXX   ""   
#> 5 Oh, Ross, Mon, is it okay if I bring someone to your parent… Ross  XXX   ""   
#> 6 Oh, Ross, Mon, is it okay if I bring someone to your parent… Mon   XXX   ""
```

In addition, the user may wish to generate their own pseudo-random
replacements.  
This can be done by wrapping the desired behaviour in
[`make_replacement_function()`](https://stat-cook.github.io/pidpos/reference/make_replacement_function.md)
with the added requirement of defining the maximum number of random
states that can be generated (e.g. if we used a toy example of the
number “00” to “99” there would be 100 max random values). We implement
this as:

``` r

numeric_replacement <- function() {
  paste(sample(0:9, 2, T), collapse = "")
}

numeric_replacement <- make_replacement_function(numeric_replacement, 100)

numeric_replacement
#> replacement_function wrapping<All: FALSE>:
#>   ConsistentMapper<0 of 100 values used>
```

This function can then be used in
[`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md)
in the same way as the deterministic function:

``` r

auto_replace(
  head(replacement_rules),
  numeric_replacement
)
#> # A tibble: 6 × 4
#>   If                                                           From  To    POS  
#>   <chr>                                                        <chr> <chr> <chr>
#> 1 [Scene: Central Perk, everyone is there.]                    Cent… 59    ""   
#> 2 [Scene: Central Perk, everyone is there.]                    Perk  94    ""   
#> 3 Phoebe Buffay                                                Phoe… 18    ""   
#> 4 Phoebe Buffay                                                Buff… 42    ""   
#> 5 Oh, Ross, Mon, is it okay if I bring someone to your parent… Ross  40    ""   
#> 6 Oh, Ross, Mon, is it okay if I bring someone to your parent… Mon   93    ""
```

With the added benefit the functional representation tracks how many of
the allowed values have been taken:

``` r

numeric_replacement
#> replacement_function wrapping<All: FALSE>:
#>   ConsistentMapper<6 of 100 values used>
```

With utilities supplied to retrieve the underlying key-value pairs (see
[`get_replacement_cache()`](https://stat-cook.github.io/pidpos/reference/get_replacements.md),
[`key_lookup()`](https://stat-cook.github.io/pidpos/reference/get_replacements.md)
and
[`value_lookup()`](https://stat-cook.github.io/pidpos/reference/get_replacements.md)):

``` r

get_replacement_cache(numeric_replacement)
#> $Central
#> [1] "59"
#> 
#> $Perk
#> [1] "94"
#> 
#> $Phoebe
#> [1] "18"
#> 
#> $Buffay
#> [1] "42"
#> 
#> $Ross
#> [1] "40"
#> 
#> $Mon
#> [1] "93"
```

------------------------------------------------------------------------

## Summary

The automatic replacement tools allow users to:

- Rapidly generate redaction mappings for large datasets
- Choose between deterministic or randomised replacement strategies
- Convert replacement rules into reusable redaction functions

This approach separates PID identification from transformation, enabling
reproducible and auditable redaction workflows.
