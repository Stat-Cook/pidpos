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
#>  1 "[Scene: Central Perk, everyone is there.]"                       Cent… FVSY…
#>  2 "[Scene: Central Perk, everyone is there.]"                       Perk  FVSY…
#>  3 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Ross  FVSY…
#>  4 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Mon   FVSY…
#>  5 "Well, his name is Parker and I met him at the drycleaners."      Park… FVSY…
#>  6 "Every year Ross makes the toast, and it's always really moving,… Ross  FVSY…
#>  7 "And you wonder why Ross is their favorite?"                      Ross  FVSY…
#>  8 "Any time Ross makes a toast everyone cries, and hugs him, and p… Ross  FVSY…
#>  9 "[Scene: Chandler and Monica's, they're getting ready to leave f… Chan… FVSY…
#> 10 "[Scene: Chandler and Monica's, they're getting ready to leave f… Moni… FVSY…

replace_by <- make_random_replacement(replacement_space = LETTERS[1:10], replacement_size = 20)
auto_replace(raw_redaction_rules, replacement_func = replace_by)
#> # A tibble: 10 × 3
#>    If                                                                From  To   
#>    <chr>                                                             <chr> <chr>
#>  1 "[Scene: Central Perk, everyone is there.]"                       Cent… EDAC…
#>  2 "[Scene: Central Perk, everyone is there.]"                       Perk  EDAC…
#>  3 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Ross  EDAC…
#>  4 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Mon   EDAC…
#>  5 "Well, his name is Parker and I met him at the drycleaners."      Park… EDAC…
#>  6 "Every year Ross makes the toast, and it's always really moving,… Ross  EDAC…
#>  7 "And you wonder why Ross is their favorite?"                      Ross  EDAC…
#>  8 "Any time Ross makes a toast everyone cries, and hugs him, and p… Ross  EDAC…
#>  9 "[Scene: Chandler and Monica's, they're getting ready to leave f… Chan… EDAC…
#> 10 "[Scene: Chandler and Monica's, they're getting ready to leave f… Moni… EDAC…
```
