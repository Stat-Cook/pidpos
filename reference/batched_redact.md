# A wrapper for efficient redaction.

An experimental function for the efficient application of the redaction
functions. This function wraps a redaction function in a dynamic
programming class which stores previously redacted values and reuses
them when the same value is encountered again.

## Usage

``` r
batched_redact(frm, redact, n = NULL, .progress = TRUE)
```

## Arguments

- frm:

  The data frame to be redacted

- redact:

  A function which converts free text to redacted text.

- n:

  The number of chunks to split the data frame into for processing.

- .progress:

  Whether to show a progress bar.

## Value

A data frame with the same structure as `frm` but with redacted text.

## Details

This function splits the data frame into chunks and processes each chunk
separately. This is useful for large data frames where the redaction
function may be slow.

## Examples

``` r
data(presidio_text)
example.data <- presidio_text[32:35, ]

# Using regex_factory for illustration; for real PID detection
# the udpipe or spaCy taggers are recommended.
regex_tagger <- regex_factory()

report <- pidpos(example.data, tagger = regex_tagger, filter_func = function(x) x)
report
#> # A tibble: 6 × 9
#>   ID                 Token   POS   StartIndex EndIndex Sentence Document Repeats
#> * <glue>             <chr>   <chr>      <int>    <int> <chr>    <chr>      <int>
#> 1 Col:Document Row:1 034282… phone         13       23 "My car… "My car…       1
#> 2 Col:Document Row:2 400707… card          56       71 "Could … "Could …       1
#> 3 Col:Document Row:2 070707… phone         58       69 "Could … "Could …       1
#> 4 Col:Document Row:2 UtaKor… email         86      109 "Could … "Could …       1
#> 5 Col:Document Row:3 42323   post…         53       57 "The Av… "The Av…       1
#> 6 Col:Document Row:4 Ushurm… email         24       48 "You sa… "You sa…       1
#> # ℹ 1 more variable: `Affected Columns` <chr>
redactions.raw <- report_to_redaction_rules(report)

replace_by <- make_random_replacement()
redactions <- auto_replace(redactions.raw, replacement_func = replace_by)
redaction.f <- parse_redacter(redactions)
batched_redact(example.data, redaction.f)
#> # A tibble: 4 × 3
#>   Document                                                     `Doc ID` Template
#>   <chr>                                                           <int>    <int>
#> 1 "My card 4131FVSYBHAAGL9939 is expiring this month. Please …       32       11
#> 2 "Could you please send me the last billed amount for cc FVS…       33       26
#> 3 "The Avalara office is at PSC 0413, Box 8144\nAPO AA FVSYBH…       34      148
#> 4 "You said your email is FVSYBHAAGL. Is that correct?"              35       62
```
