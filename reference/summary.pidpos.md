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
