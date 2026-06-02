# Warning function factory

Create new warning types to allow better handling/ extension on
tryCatch.

## Usage

``` r
new_warn_type(name, parent = NULL)
```

## Arguments

- name:

  Warning type. Will take the form 'pidpos\_'

- parent:

  An optional character vector of parent classes to include.

## Value

A new warning closure with signature `f(message)`
