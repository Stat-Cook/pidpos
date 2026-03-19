# Function factory for hashing replacement.

Function factory for hashing replacement.

## Usage

``` r
make_hashing_replacement(key, salt = "", hash = sha256)
```

## Arguments

- key:

  The hash key (passed to `hash`)

- salt:

  The hash salt

- hash:

  The desired hash function (default is
  [openssl::sha256](https://jeroen.r-universe.dev/openssl/reference/hash.html)).
  NB: other functions can be used, if they take `key` as a key word
  argument.

## Value

`function`

## See also

[`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md)

## Examples

``` r
replace_by <- make_hashing_replacement(key = "PIDPOS", salt = "SALT")
auto_replace(raw_redaction_rules, replacement.f = replace_by)
#> # A tibble: 10 × 3
#>    If                                                                From  To   
#>    <chr>                                                             <chr> <has>
#>  1 "[Scene: Central Perk, everyone is there.]"                       Cent… 1cc8…
#>  2 "[Scene: Central Perk, everyone is there.]"                       Perk  282d…
#>  3 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Ross  97f0…
#>  4 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Mon   3807…
#>  5 "Well, his name is Parker and I met him at the drycleaners."      Park… 864e…
#>  6 "Every year Ross makes the toast, and it's always really moving,… Ross  97f0…
#>  7 "And you wonder why Ross is their favorite?"                      Ross  97f0…
#>  8 "Any time Ross makes a toast everyone cries, and hugs him, and p… Ross  97f0…
#>  9 "[Scene: Chandler and Monica's, they're getting ready to leave f… Chan… 0d22…
#> 10 "[Scene: Chandler and Monica's, they're getting ready to leave f… Moni… eee5…
```
