# Function factory for random replacement.

Simple APIs for implementing random replacement functions for use in
[`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md).
The user can select between:

## Usage

``` r
make_random_replacement(
  replacement_size = 10,
  replacement_space = LETTERS,
  all = FALSE,
  elevate_warnings = FALSE
)
```

## Arguments

- replacement_size:

  The size of the replacement (number of characters in each
  replacement).

- replacement_space:

  The space from which to sample replacements (default is `LETTERS`).

- all:

  If `TRUE`, every value in `To` gets a unique repalcement. If `FALSE`,
  replacements are reused.

- elevate_warnings:

  If `TRUE`, warnings are boosted to errors.

## Value

`function`

## See also

[`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md)

## Examples

``` r

replace_by <- make_random_replacement()
auto_replace(raw_redaction_rules, replacement_func = replace_by)
#> # A tibble: 10 × 3
#>    If                                                                From  To   
#>    <chr>                                                             <chr> <chr>
#>  1 "[Scene: Central Perk, everyone is there.]"                       Cent… RSLS…
#>  2 "[Scene: Central Perk, everyone is there.]"                       Perk  UDAC…
#>  3 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Ross  JHVQ…
#>  4 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Mon   UZJC…
#>  5 "Well, his name is Parker and I met him at the drycleaners."      Park… ESRE…
#>  6 "Every year Ross makes the toast, and it's always really moving,… Ross  JHVQ…
#>  7 "And you wonder why Ross is their favorite?"                      Ross  JHVQ…
#>  8 "Any time Ross makes a toast everyone cries, and hugs him, and p… Ross  JHVQ…
#>  9 "[Scene: Chandler and Monica's, they're getting ready to leave f… Chan… YQWT…
#> 10 "[Scene: Chandler and Monica's, they're getting ready to leave f… Moni… JISY…

replace_by <- make_random_replacement(replacement_space = LETTERS[1:10], replacement_size = 20)
auto_replace(raw_redaction_rules, replacement_func = replace_by)
#> # A tibble: 10 × 3
#>    If                                                                From  To   
#>    <chr>                                                             <chr> <chr>
#>  1 "[Scene: Central Perk, everyone is there.]"                       Cent… IDFH…
#>  2 "[Scene: Central Perk, everyone is there.]"                       Perk  AGDA…
#>  3 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Ross  EFCA…
#>  4 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Mon   IBGC…
#>  5 "Well, his name is Parker and I met him at the drycleaners."      Park… DDDC…
#>  6 "Every year Ross makes the toast, and it's always really moving,… Ross  EFCA…
#>  7 "And you wonder why Ross is their favorite?"                      Ross  EFCA…
#>  8 "Any time Ross makes a toast everyone cries, and hugs him, and p… Ross  EFCA…
#>  9 "[Scene: Chandler and Monica's, they're getting ready to leave f… Chan… HBFF…
#> 10 "[Scene: Chandler and Monica's, they're getting ready to leave f… Moni… EJIF…
```
