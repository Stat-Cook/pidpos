# presidio_text

A benchmarking data set to check the reliability of pidpos, built from
the data at
https://raw.githubusercontent.com/microsoft/presidio-research/master/data/synth_dataset_v2.json

## Usage

``` r
presidio_text
```

## Format

A dataframe with three columns::

- Document:

  The free text

- Doc ID:

  Primary key to allign with presidio_tags

- Template:

  The document template used by presidio in generating synthetic text

See `presidio_tags` for the accompanying entity locations.
