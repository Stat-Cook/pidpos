# Wrapper for custom replacement functions

Convert a function for producing a random replacement into a memoized
version. The functionality automates recalling of the function to avoid
collision with existing replacements, and can toggle between sharing
encodings between repeated keys or giving each key a unique value (via
the `all` parameter).

## Usage

``` r
make_replacement_function(
  encoder,
  max_values,
  all = FALSE,
  elevate_warnings = FALSE
)
```

## Arguments

- encoder:

  A zero-argument function with signature `function()` that returns a
  single random replacement string each call.

- max_values:

  The maximum number of unique replacements your encoder can produce.

- all:

  Logical. If `TRUE` every key gets its own unique replacement. If
  `FALSE` repeated keys receive the same replacement.

- elevate_warnings:

  Logical. If `TRUE`, warnings are raised as errors.

## Value

A function with the signature `function(x)` that takes a vector and
returns a character vector of replacements the same length as `x`.

## Examples

``` r
numeric_encoder <- function() paste0(sample(0:9, 10, replace = TRUE), collapse = "")
mapper <- make_replacement_function(numeric_encoder, 1000)
```
