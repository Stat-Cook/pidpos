# Access the cache of replacements

Tools for accessing the replacements inside a
[`make_replacement_function()`](https://stat-cook.github.io/pidpos/reference/make_replacement_function.md)
function.

## Usage

``` r
get_replacement_cache(object)

key_lookup(object, key)

value_lookup(object, value)
```

## Arguments

- object:

  A function built by
  [`make_replacement_function()`](https://stat-cook.github.io/pidpos/reference/make_replacement_function.md)
  having been used in
  [`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md).

- key:

  The string to lookup a replacement for.

- value:

  The string to lookup what it replaced.

## Value

A named list of the form `list(original = replacement, ...)`

The replacement string for `key`, or `NULL` if not found.

The key that was pointed to by `value`

## Examples

``` r

replacement <- make_random_replacement()

redaction_rules <- raw_redaction_rules |>
  auto_replace(replacement)

get_replacement_cache(replacement)
#> $Central
#> [1] "RSLSQJLMPG"
#> 
#> $Perk
#> [1] "UDACGQFLGK"
#> 
#> $Ross
#> [1] "JHVQLTORLV"
#> 
#> $Mon
#> [1] "UZJCDMFNBY"
#> 
#> $Parker
#> [1] "ESREJLDSXT"
#> 
#> $Chandler
#> [1] "YQWTXJXWIY"
#> 
#> $Monica
#> [1] "JISYSOQOWE"
#> 

key_lookup(replacement, "Ross")
#> [1] "JHVQLTORLV"

value_lookup(replacement, redaction_rules$To[1])
#> [1] "Central"
```
