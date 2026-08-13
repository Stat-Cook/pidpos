# Set the context window size for the `get_context` function.

Set the context window size for the `get_context` function.

## Usage

``` r
set_context_window(x)
```

## Arguments

- x:

  An integer specifying the number of characters to include before and
  after the token in the context.

## Value

TRUE on success

## Examples

``` r
set_context_window(25)
#> [1] TRUE
```
