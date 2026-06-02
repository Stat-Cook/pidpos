# presidio_tags

The location and type of named entities in `presidio_text`.

## Usage

``` r
presidio_tags
```

## Format

An object of class `data.frame` with 2863 rows and 5 columns.

## Details

Consists of a dataframe with five columns:

- `entity_type` - the type of named entity

- `entity_value`

- `start_position`/ `end_position` - the string span the entity occurs
  at

- `Doc ID` - the relative document in `presidio_text`
