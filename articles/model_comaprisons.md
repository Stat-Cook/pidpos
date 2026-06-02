# Model Comaprisons

``` r

library(pidpos)
```

The pidpos package is intended to be model agnostic - depending on the
level of technical skill and overhead the user wishes more complex
models can be used for the underlying natural language processing (NLP).
However, for the user to be informed as to the improvement for technical
investment, we supply a broad characterisation of several models.

Here we present out of the box tagging for a synthetic data set drawn
from a openly available `presidio-research` data set
[synth_dataset_v2](https://stat-cook.github.io/pidpos/articles/). The
data set consists of free text with associated tagged entities. The
challenge, how well does each model provided perform on this data and
are there edge cases, common flaws, or preprocessing steps that effect
performance.

## Data set, Models and Metrics

### Data set

The total data set (included in the package as …) consists of 1500
passages of free text and a total of 2,863 named entities. The entity
break down is:

``` r

presidio_tags |>
  group_by(entity_type) |>
  summarise(Frequency = n()) |>
  arrange(desc(Frequency))
#> # A tibble: 17 × 2
#>    entity_type       Frequency
#>    <chr>                 <int>
#>  1 PERSON                  857
#>  2 STREET_ADDRESS          598
#>  3 GPE                     411
#>  4 ORGANIZATION            250
#>  5 CREDIT_CARD             136
#>  6 DATE_TIME               119
#>  7 PHONE_NUMBER             92
#>  8 TITLE                    92
#>  9 AGE                      74
#> 10 NRP                      55
#> 11 EMAIL_ADDRESS            49
#> 12 DOMAIN_NAME              37
#> 13 ZIP_CODE                 37
#> 14 IBAN_CODE                21
#> 15 US_SSN                   16
#> 16 IP_ADDRESS               14
#> 17 US_DRIVER_LICENSE         5
```

To provide a rich testing ground the `synth_dataset_v2` was filtered to
the forty examples with the most tagged entities. On the first pass,
each passage of free text was handed to the taggers as-is with no
specialised pre-processing. The first analysis will focus on how well
the taggers can identify the `PERSON` fields as they represent …

### Models

Six models are being compared:

- `en_core_web_lg` (spacy)
- `en_core_web_trf` (spacy)
- `english-ewt-ud-2.5` (udpipe)
- `english-gum-ud-2.5` (udpipe)
- `english-lines-ud-2.5` (udpipe)
- A `regex` based model

NB: the `regex` tagger is intended to catch structured PID such as
emails, phone numbers, etc. Hence we expect it to have poor sensitivity
outside its domain.

A further seventh model is considered as an ensemble of the spacy,
udpipe and regex models

### Metrics

The `presidio` dataset includes several entities made up of multiple
tokens (e.g. `FirstName FamilyName`) wheras the taggers may return
entities as single tokens. Hence instead of comparing labels to tokens
directly, detection will be based on if the candidates overlap with the
given NER span. If any identified token sits within the same span as the
known value it will be characterised as ‘accurate’, and outside the span
characterized as ‘innacurate’. This is depicted in figure xxx to aid
interpretation. Where a label has at least one accurate token it will be
labelled as ‘detected’.

![An example of model judgment criteria. For \[1\] an example passage of
text there may be \[2\] multiple named entities. A given tagging model
will identify \[3\] possible candidates, where they can be \[4\]
accurate (green) or innacurate (red).](figures/EntityCandidates.png)

An example of model judgment criteria. For \[1\] an example passage of
text there may be \[2\] multiple named entities. A given tagging model
will identify \[3\] possible candidates, where they can be \[4\]
accurate (green) or innacurate (red).

Based on the `accurate` and `detected` labels defined above tagger
performance was expressed as three metrics:

- `Precision`: $`\frac{Candidates_{Accurate}}{Candidates_{Total}}`$
- `Sensitivity`: $`\frac{Labels_{detected}}{Labels_{Total}}`$
- `$F_{\beta}$ score`: $`(1+\beta^2)\frac{P.S}{\beta^2P + S}`$ where
  $`P`$ is precision and $`S`$ is sensitivity.

For reference - a model that flags all word tokens to check would result
in a precision of 22.5% and an F2 of 59%.

The $`\beta`$ factor was set at 2 to weight the scoring in favour of
greater detection at the cost of additional false positives i.e. because
missing PID is a greater utility cost than flagging extra candidates.

``` r

f2 <- function(s, p, b) {
  (1 + b^2) * s * p / (s + b^2 * p)
}

model_metrics <- function(comparison, name = "") {
  sens <- filter(comparison, !is.na(entity_value)) |>
    distinct(entity_value, .keep_all = T) |>
    summarize(Sensitivity = 100 * mean(!is.na(Token)))

  prec <- filter(comparison, !is.na(Token)) |>
    summarize(Precision = 100 * (1 - mean(is.na(entity_value))))

  cbind(sens, prec) |>
    mutate(
      Model = name,
      `F2[B=2]` = (1 + 4) * (Sensitivity * Precision) / (Sensitivity + 4 * Precision)
    )
}
```

## Analysis

### Baseline data

Initial tests were performed using the `spacy` taggers as is, and with
the inclusion of a filter to limit the udpipe model output to only
proper nouns. A script outlining the trials is included in … for the
interested reader.

``` r

summarize_model_metrics <- function(frm) {
  imap(frm, model_metrics) |>
    bind_rows() |>
    select(Model, everything())
}

baseline_comparison |>
  summarize_model_metrics() |>
  mutate(across(where(is.numeric), ~ round(.x, 1)))
#>      Model Sensitivity Precision F2[B=2]
#> 1       LG        85.7      70.7    82.2
#> 2      TRF        68.9      63.9    67.8
#> 3      EWT        70.6      74.4    71.3
#> 4      GUM        71.4      71.4    71.4
#> 5    LINES        60.5      79.2    63.5
#> 6    Regex        17.6      84.4    20.9
#> 7 Ensemble        96.8      72.8    90.8
```

``` r

summarize_by_entity <- function(frm, model) {
  frm |>
    dplyr::filter(!is.na(entity_type)) |>
    group_by(entity_type) |>
    group_modify(~ model_metrics(.x, model))
}

summarize_model_by_entity <- function(comparisons) {
  comparisons |>
    imap(
      summarize_by_entity
    ) |>
    bind_rows() |>
    mutate(
      Model = factor(Model, levels = names(baseline_comparison)),
      Sensitivity = round(Sensitivity, 1)
    ) |>
    select(Model, entity_type, Sensitivity) |>
    arrange(Model, desc(Sensitivity)) |>
    pivot_wider(
      id_cols = Model,
      names_from = entity_type,
      values_from = Sensitivity
    )
}


summarize_model_by_entity(baseline_comparison)
#> # A tibble: 7 × 7
#>   Model    CREDIT_CARD PERSON STREET_ADDRESS PHONE_NUMBER   GPE EMAIL_ADDRESS
#>   <fct>          <dbl>  <dbl>          <dbl>        <dbl> <dbl>         <dbl>
#> 1 LG              98.5   93.3           84.7         83.7  73.7           6.4
#> 2 TRF             19.9   93.6           60           18.5  71             0  
#> 3 EWT              0     87.9           70.3         20.7  81.6          29.8
#> 4 GUM              0     84.8           68.1         48.9  83.5          76.6
#> 5 LINES            0     74.6           61.6          5.4  69            53.2
#> 6 Regex           61.8    0             31           20.7   0           100  
#> 7 Ensemble       100     97.7           96.1         91.3  95.3         100
```

The spacy `LG` model shows the greatest sensitivity, identfying 88% of
named entities, closesly followed by the two udpipe models (`EWT` and
`GUM`). Interestingly, the `EWT` model has the superior F2 score due to
a superior precision.

### Addition of preprocessing stage

Inspection of the raw data identifed cases of punctuation…

``` r

preprocessed_comparison |>
  summarize_model_metrics() |>
  mutate(across(where(is.numeric), ~ round(.x, 1)))
#>      Model Sensitivity Precision F2[B=2]
#> 1       LG        89.5      71.8    85.3
#> 2      TRF        69.6      63.0    68.2
#> 3      EWT        66.4      70.6    67.2
#> 4      GUM        67.1      68.2    67.3
#> 5    LINES        58.8      77.5    61.8
#> 6    Regex        17.5      95.8    20.9
#> 7 Ensemble        96.4      71.5    90.1
```

``` r

summarize_model_by_entity(preprocessed_comparison)
#> # A tibble: 7 × 7
#>   Model    CREDIT_CARD PERSON PHONE_NUMBER STREET_ADDRESS   GPE EMAIL_ADDRESS
#>   <fct>          <dbl>  <dbl>        <dbl>          <dbl> <dbl>         <dbl>
#> 1 LG              98.5   93.8         90.2           87.9  80            61.7
#> 2 TRF             24.3   93.8         10.9           60.5  71.4          19.1
#> 3 EWT              0     88.2          0             58.5  85.5          25.5
#> 4 GUM              0     85.7          3.3           60.7  87.1          48.9
#> 5 LINES            0     74.9          0             54.3  72.5          57.4
#> 6 Regex           61.8    0            5.4           41.1   0             0  
#> 7 Ensemble       100     97.6         92.4           97.8  93.3          74.5
```

### Reduced data quality

While the udpipe models appear to have reasonable performance in this
scenario, the models do have a known systematic issue. The current
udpipe models rely heavily on capitalisation as a method to identify
proper nouns from the space of all nouns.

To mimic this, the raw text was manipualted to remove all casing
(i.e. conversion to lower case) and the taggers re-tested:

``` r

lower_comparison |>
  summarize_model_metrics() |>
  mutate(across(where(is.numeric), ~ round(.x, 1)))
#>      Model Sensitivity Precision F2[B=2]
#> 1       LG        76.2      72.0    75.3
#> 2      TRF        63.4      60.6    62.8
#> 3      EWT         3.4      76.2     4.2
#> 4      GUM         2.2      70.8     2.7
#> 5    LINES         1.3      28.3     1.6
#> 6    Regex        17.6      84.4    20.9
#> 7 Ensemble        80.1      72.8    78.5
```

``` r

summarize_model_by_entity(lower_comparison)
#> # A tibble: 7 × 7
#>   Model    CREDIT_CARD STREET_ADDRESS PHONE_NUMBER PERSON   GPE EMAIL_ADDRESS
#>   <fct>          <dbl>          <dbl>        <dbl>  <dbl> <dbl>         <dbl>
#> 1 LG              98.5           90.6         88     76    41.6             0
#> 2 TRF             19.1           45.9         10.9   91.9  71.4             0
#> 3 EWT              0              3.2          0      4     5.9             0
#> 4 GUM              0              4.2          9.8    0.6   1.2             0
#> 5 LINES            0              0.3          0      2.3   1.6             0
#> 6 Regex           61.8           31           20.7    0     0             100
#> 7 Ensemble       100             92.9         90.2   76.6  42.7           100
```

While this process effects all algorithms, the udpipe models deeply
suffer as a result.

### Re-introduction of casing

The reduction in F2 score associated with removal of casing is
concerning for all models and especially the udpipe. To partially
explore this behaviour a final test was made where the passages were
automatically cased via the
[`tools::toTitleCase`](https://rdrr.io/r/tools/toTitleCase.html)
utility.

``` r

titlecase_comparison |>
  summarize_model_metrics() |>
  mutate(across(where(is.numeric), ~ round(.x, 1)))
#>      Model Sensitivity Precision F2[B=2]
#> 1       LG        77.6      62.4    74.0
#> 2      TRF        69.7      64.7    68.6
#> 3      EWT        75.6      43.8    66.0
#> 4      GUM        76.4      33.4    60.8
#> 5    LINES        63.2      50.5    60.2
#> 6    Regex        17.6      84.4    20.9
#> 7 Ensemble        95.6      51.8    81.8
```

``` r

summarize_model_by_entity(titlecase_comparison)
#> # A tibble: 7 × 7
#>   Model    PERSON STREET_ADDRESS PHONE_NUMBER   GPE CREDIT_CARD EMAIL_ADDRESS
#>   <fct>     <dbl>          <dbl>        <dbl> <dbl>       <dbl>         <dbl>
#> 1 LG         87.3           82.8         79.3  67.8        43.4           0  
#> 2 TRF        92.4           62.2         17.4  68.6        33.8           0  
#> 3 EWT        93.3           75           27.2  88.2         0            34  
#> 4 GUM        92.7           70.2         54.3  87.1         2.9          85.1
#> 5 LINES      77.4           63.2         18.5  69.4         0            66  
#> 6 Regex       0             31           20.7   0          61.8         100  
#> 7 Ensemble   98.6           95.6         89.1  96.1        80.1         100
```
