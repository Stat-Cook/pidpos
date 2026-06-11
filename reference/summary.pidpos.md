# Summarize a `pidpos` report.

Summarize a `pidpos` report.

## Usage

``` r
# S3 method for class 'pidpos'
summary(object, ...)
```

## Arguments

- object:

  An object of class `pidpos`.

- ...:

  further arguments passed to or from other methods.

## Value

A data frame describing any column determined to contain PID.

- Column

- Cases of Proper Nouns - the number of sentences with proper nouns in
  the column

- Unique Cases of Proper Nouns - the number of unique sentences with
  proper nouns in the column

- Most Common Proper Noun Sentence - the most commonly occurring
  sentence containing proper nouns.

## See also

[pidpos](https://stat-cook.github.io/pidpos/reference/pidpos.md)

## Examples

``` r
data(presidio_text)
example.data <- presidio_text[32:35, ]

# Using regex_factory for illustration; for real PID detection
# the udpipe or spaCy taggers are recommended.
regex_tagger <- regex_factory()

report <- pidpos(example.data, tagger = regex_tagger, filter_func = function(x) x)
summary(report)
#> # A tibble: 1 × 4
#>   Column    Cases of Proper Noun…¹ Unique Cases of Prop…² Most Common Proper N…³
#>   <chr>                      <int>                  <int> <chr>                 
#> 1 `Documen…                      4                      4 My card 4131034282458…
#> # ℹ abbreviated names: ¹​`Cases of Proper Nouns`,
#> #   ²​`Unique Cases of Proper Nouns`, ³​`Most Common Proper Noun Sentence`
```
