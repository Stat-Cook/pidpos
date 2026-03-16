# Summarize a `pid_pos` report.

Summarize a `pid_pos` report.

## Usage

``` r
# S3 method for class 'pid_pos'
summary(object, ...)
```

## Arguments

- object:

  An object of class `pid_pos`.

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

[pid_pos](https://stat-cook.github.io/pid.pos/reference/pid_pos.md)
