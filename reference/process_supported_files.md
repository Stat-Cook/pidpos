# Folder API utility function

Reads data files within a given folder and produces pidpos reports.

## Usage

``` r
process_supported_files(
  file_list,
  report_path,
  tagger = "english-ewt",
  filter_func = filter_to_proper_nouns,
  chunk_size = 100,
  to_ignore = c(),
  export_function = NULL
)
```
