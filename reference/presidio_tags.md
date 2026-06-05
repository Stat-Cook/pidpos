# presidio_tags

The location and type of named entities in `presidio_text`.

## Usage

``` r
presidio_tags
```

## Format

A dataframe with five columns:

- entity_type:

  The type of named entity

- entity_value:

- start_position/ end_position:

  the string span the entity occurs at

- Doc ID:

  Foreign key to allign with `presidio_text`
