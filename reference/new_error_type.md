# Error function factory

Create new error types to allow better handling/ extension on tryCatch.

## Usage

``` r
new_error_type(name, parent = NULL)
```

## Arguments

- name:

  Error type. Will take the form 'pidpos\_'

- parent:

  An optional character vector of parent classes to include.

## Value

A new error closure with signature `f(message)`
