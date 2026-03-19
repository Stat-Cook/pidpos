# Apply a replacement function to a `rules.frm`.

Several function factories have been implemented to create replacement
functions
([`make_hashing_replacement()`](https://stat-cook.github.io/pidpos/reference/make_hashing_replacement.md),
[`make_random_replacement()`](https://stat-cook.github.io/pidpos/reference/make_random_replacement.md)).

## Usage

``` r
auto_replace(frm, replacement.f, filter = F)
```

## Arguments

- frm:

  A `data.frame` with columns `If`, `From`, and `To`.

- replacement.f:

  A function for transforming the `To` column.

- filter:

  Logical. If `TRUE` will only apply to rows where `From` and `To` are
  different.

## Value

A `data.frame` like `frm` but with the `To` column transformed by
`replacement.f`.

## See also

[`report_to_redaction_rules()`](https://stat-cook.github.io/pidpos/reference/report_to_redaction_rules.md)
[`redact()`](https://stat-cook.github.io/pidpos/reference/redact.md)

## Examples

``` r
replace_by <- make_random_replacement()
auto_replace(raw_redaction_rules, replacement.f = replace_by)
#> # A tibble: 10 × 3
#>    If                                                                From  To   
#>    <chr>                                                             <chr> <chr>
#>  1 "[Scene: Central Perk, everyone is there.]"                       Cent… MWLE…
#>  2 "[Scene: Central Perk, everyone is there.]"                       Perk  EEXO…
#>  3 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Ross  ULBF…
#>  4 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Mon   KGUF…
#>  5 "Well, his name is Parker and I met him at the drycleaners."      Park… TXVA…
#>  6 "Every year Ross makes the toast, and it's always really moving,… Ross  ULBF…
#>  7 "And you wonder why Ross is their favorite?"                      Ross  ULBF…
#>  8 "Any time Ross makes a toast everyone cries, and hugs him, and p… Ross  ULBF…
#>  9 "[Scene: Chandler and Monica's, they're getting ready to leave f… Chan… OREH…
#> 10 "[Scene: Chandler and Monica's, they're getting ready to leave f… Moni… CBWJ…
```
