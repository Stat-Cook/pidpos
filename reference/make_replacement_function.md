# Wrapper for custom replacement functions

Convert a function for producing a random replacement into a `memoized`
version. The functionality automates reacalling of the function to avoid
collision with existing replacements, and can toggle between ...

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

  The function to wrap with signature `function()`

- max_values:

  The maximum number of replacements your encoder can produce

- all:

  Boolean flag. If `TRUE` every key replaced gets its own value. NB: at
  present this results in the key stored having a number appended e.g.
  "bob" stored as "bob.1"

- elevate_warnings:

  If true, cause warnings to raise as errors.

## Value

A function with the signature `function(x)` that takes a vector and
returns a character vector of replacements the same length as `x`.
