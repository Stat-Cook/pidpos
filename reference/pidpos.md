# Proper Noun Detection

For a given data set, the function reports each detected instance of a
proper noun and reports the location in the data set, the `Document`
containing the proper noun, and how often the `Document` occurs.

## Usage

``` r
pidpos(
  frm,
  tagger = "english-ewt",
  filter_func = filter_to_proper_nouns,
  chunk_size = 100,
  to_ignore = c(),
  warn_if_missing = FALSE
)
```

## Arguments

- frm:

  A data frame to check for proper nouns

- tagger:

  Either a string naming a UDPipe model (see
  [udpipe::udpipe_download_model](https://rdrr.io/pkg/udpipe/man/udpipe_download_model.html)
  for the list of models) or a custom tagging function (see
  [`vignette("custom-functions")`](https://stat-cook.github.io/pidpos/articles/custom-functions.md)
  for details of what is required).

- filter_func:

  A function to filter the tagged instances. See the 'Custom Filtering
  Functions' section of
  [`vignette("custom-functions")`](https://stat-cook.github.io/pidpos/articles/custom-functions.md)
  for more details.

- chunk_size:

  The number of sentences to tag at a time. The optimal value has yet to
  be determined.

- to_ignore:

  A vector of column names to be ignored by the algorithm. Intended to
  be used for variables that are giving strong false positives, such as
  IDs or ICD-10 codes.

- warn_if_missing:

  Raise a warning if the `to_ignore` columns are not in the data frame.

## Value

A `pidpos` (inheriting from tibble) containing:

- `ID`: The location of the sentence in the data frame in the form
  `Col:<colname> Row:<rownumber>`.

- `Token`: The detected proper noun.

- `Sentence`: The sentence in which the proper noun occurs.

- `Document`: The source string (data frame cell) containing the
  sentence.

- `Repeats`: The number of times the `Document` occurs in the data
  frame.

- `Affected Columns`: The columns in the data frame where the `Document`
  occurs.

If no proper nouns are detected, an empty data frame is returned.

## Note

By default `pidpos()` caches the `udpipe` models in a package cache
directory. This behaviour can be altered via
[`pidpos_setup()`](https://stat-cook.github.io/pidpos/reference/pidpos_setup.md)
to redirect `udpipe` models or force environment only models.

## See also

- To summarize the results:
  [`summary.pidpos()`](https://stat-cook.github.io/pidpos/reference/summary.pidpos.md)

- To help with redaction of PID:
  [`report_to_redaction_rules()`](https://stat-cook.github.io/pidpos/reference/report_to_redaction_rules.md)

- To report on a data repository:
  [`report_on_folder()`](https://stat-cook.github.io/pidpos/reference/report_on_folder.md)

- for help constructing a custom tagger:
  [`custom_tagger()`](https://stat-cook.github.io/pidpos/reference/custom_tagger.md)

## Examples

``` r
data(presidio_text)
example.data <- head(presidio_text, 50)

# Using regex_factory for illustration; for real PID detection
# the udpipe or spaCy taggers are recommended.

regex_tagger <- regex_factory()
pidpos(example.data,
  tagger = regex_tagger,
  filter_func = function(x) x
)
#> # A tibble: 18 × 9
#>    ID                  Token POS   StartIndex EndIndex Sentence Document Repeats
#>  * <glue>              <chr> <chr>      <int>    <int> <chr>    <chr>      <int>
#>  1 Col:Document Row:1  "646… post…         82       86 "The ad… "The ad…       1
#>  2 Col:Document Row:6  "445… card          28       43 "What i… "What i…       1
#>  3 Col:Document Row:15 "282… post…         36       40 "Billin… "Billin…       1
#>  4 Col:Document Row:15 "536… post…         93       97 "Billin… "Billin…       1
#>  5 Col:Document Row:23 "624… post…         67       71 "Willia… "Willia…       1
#>  6 Col:Document Row:25 "860… post…         27       31 "Tomomi… "Tomomi…       1
#>  7 Col:Document Row:32 "034… phone         13       23 "My car… "My car…       1
#>  8 Col:Document Row:33 "400… card          56       71 "Could … "Could …       1
#>  9 Col:Document Row:33 "070… phone         58       69 "Could … "Could …       1
#> 10 Col:Document Row:33 "Uta… email         86      109 "Could … "Could …       1
#> 11 Col:Document Row:34 "423… post…         53       57 "The Av… "The Av…       1
#> 12 Col:Document Row:35 "Ush… email         24       48 "You sa… "You sa…       1
#> 13 Col:Document Row:38 "369… post…        122      126 "card n… "card n…       1
#> 14 Col:Document Row:39 "200… date           7       16 "When: … "When: …       1
#> 15 Col:Document Row:46 "658… card          16       32 "My cre… "My cre…       1
#> 16 Col:Document Row:46 "089… phone         21       31 "My cre… "My cre…       1
#> 17 Col:Document Row:50 "nSz… email        112      131 "Janka … "Janka …       1
#> 18 Col:Document Row:50 "251… post…        253      257 "Janka … "Janka …       1
#> # ℹ 1 more variable: `Affected Columns` <chr>
```
