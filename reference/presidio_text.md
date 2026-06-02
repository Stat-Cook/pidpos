# presidio_text

A benchmarking data set to check the reliability of pidpos, built from
the data at
https://raw.githubusercontent.com/microsoft/presidio-research/master/data/synth_dataset_v2.json

## Usage

``` r
presidio_text
```

## Format

An object of class `tbl_df` (inherits from `tbl`, `data.frame`) with
1500 rows and 3 columns.

## Details

Consists of a dataframe with three columns:

- `Document` - the free text

- `Doc ID`

- `Template` - the document template used by presidio in generating
  synthetic text

See `presidio_tags` for the accompanying entity locations.
