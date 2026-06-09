# Redact PID across folder structure

For use as part of the folder level API - this function is the
equivalent of
[`redact()`](https://stat-cook.github.io/pidpos/reference/redact.md).
The redacted files are saved in the specified `output_path`.

## Usage

``` r
redact_at_folder(
  data_path,
  redacter,
  output_path = "Redacted Data",
  extensions = get_implemented_extensions(),
  export_function = NULL,
  verbose = FALSE
)
```

## Arguments

- data_path:

  The file path at which data is stored

- redacter:

  A redaction rules data frame or redaction function

- output_path:

  File path to write redacted data to

- extensions:

  Optional. The set of file extensions to scanned for.

- export_function:

  A function to define export

- verbose:

  boolean flag; if `TRUE`, skipped files will be printed to the console.

## Examples

``` r
if (FALSE) { # \dontrun{
input_dir <- withr::local_tempdir()
output_dir <- withr::local_tempdir()

utils::write.csv(
  data.frame(text = "Joey went to London", stringsAsFactors = FALSE),
  file.path(input_dir, "example.csv"),
  row.names = FALSE
)

replace_by <- make_random_replacement()
prepared <- auto_replace(raw_redaction_rules, replacement_func = replace_by)

redact_at_folder(input_dir, redacter = prepared, output_path = output_dir)
} # }
```
