# Encode non utf8 text

Encode non utf8 text

## Usage

``` r
clean_encoding(text)
```

## Arguments

- text:

  A character vector to be encoded

## Value

A character vector

## Examples

``` r
clean_encoding(c("Hello", "caf\xe9"))
#> Warning: Non-UTF-8 text detected - attempting conversion. Check results carefully.
#> [1] "Hello" "caf�" 
```
