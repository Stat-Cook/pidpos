# Map redaction function onto object

Allows for the redaction of a data frame or vector

## Usage

``` r
redact_internal(object, redaction_func)
```

## Arguments

- object:

  The data structure to be redacted

- redaction_func:

  A closure/ function to be applied.

## Value

A redacted equivalent of object - either a vector or data frame with all
character columns converted,
