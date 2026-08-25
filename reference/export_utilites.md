# Export utilities

Utilities for writing `pidpos` reports in a folder structure when using
`report_on_folder`. To mimic the file tree on read use `export_as_tree`,
or for a flat structure use `export_flat`.

## Usage

``` r
export_as_tree(report, name, report_path)

export_flat(report, name, report_path)
```

## Arguments

- report:

  The data frame to be written to disk

- name:

  The file name NB: slashes will act as folder sublevels for
  `export_as_tree` and be replaced with underscores in `export_flat`

- report_path:

  the root location

## Value

The path to the output file

## Examples

``` r
if (FALSE) { # \dontrun{
report_on_folder(
  "path/to/data",
  export_function = export_as_tree
)

report_on_folder(
  "path/to/data",
  export_function = export_flat
)
} # }
NULL
#> NULL
```
