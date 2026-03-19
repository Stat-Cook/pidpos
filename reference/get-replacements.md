# Access the cache of replacements Tools for accessing the replacements inside a [`make_replacement_function()`](https://stat-cook.github.io/pidpos/reference/make_replacement_function.md) function.

Access the cache of replacements

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
