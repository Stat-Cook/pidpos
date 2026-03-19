# Package errors and warnings

To assist with ... the package has implemented several custom errors and
warnings which are embedded as safeguards in the function factories. The
intention is to allow users to catch specific error types raised in the
package structure separately to any raised from custom code.

## Usage

``` r
type_error(message, ..., call = caller_env())

exceeded_max_error(message, ..., call = caller_env())

exceeded_half_max_warn(message, ..., call = caller_env())

iteration_warn(message, ..., call = caller_env())
```

## Arguments

- message:

  The error message to display

- ...:

  Additional arguments to pass to `abort()`

- call:

  The call environment to use for the error (defaults to the caller's
  environment)

## Value

An error object with the specified message and classes
