# Default PID regex patterns

A data frame of regular expressions used by
[`regex_factory()`](https://stat-cook.github.io/pidpos/reference/regex_factory.md)
to detect common patterns of personally identifiable data.

## Usage

``` r
pid_patterns
```

## Format

A data frame with 3 columns:

- type:

  The category of PID (e.g. `"email"`, `"phone"`, `"date"`).

- pattern:

  A Perl-compatible regular expression.

- description:

  A human-readable description of what the pattern matches.

## See also

[`regex_factory()`](https://stat-cook.github.io/pidpos/reference/regex_factory.md)
