# pidpos: An R package for the detection of personally identifiable data

## Summary

The `pidpos` package aids in identifying personal identifiability risks
in datasets. Using part-of-speech (POS) tagging, it extracts proper
nouns from text fields, reducing the complexity of the review process
and enabling faster human oversight. The package also provides tools for
designing and implementing a redaction workflow.

## Statement of need

Data collection and analysis has grown enormously in scale and scope,
prompting international legislation to protect individuals’ rights over
their own data (European Parliament and Council of the European Union
2016). This has heightened awareness of the responsibilities of data
controllers (ICO, n.d.-b) and the risks posed by large datasets (Clarke
2016). A central concern is personal identifiability — the ability to
directly or indirectly identify an individual from a dataset (Finck and
Pallas 2020) — with breaches carrying significant reputational and
financial consequences (ICO, n.d.-a).

For small, structured datasets, manual inspection can identify
personally identifiable data (PID) with reasonable effort. In large
datasets, however, PID embedded within free-text fields or appearing
rarely in a variable can easily be missed. Existing R packages such as
PII (Patterson-Stein 2025) address this through pattern matching, which
risks missing edge cases.

`pidpos` takes a different approach. Building on *part-of-speech*
tagging (by default the udpipe framework (Straka et al. 2016; Wijffels
2023), with the ability to use a custom tagging engine) it extracts all
proper nouns from a dataset, deliberately accepting a higher false
positive rate, and implementing tools to aid human review rather than
attempting full automation. This makes it robust to the edge cases that
pattern-matching approaches can miss.

## In practice

To install the current version of `pidpos` package, use the following
code:

``` r

# install.packages("pak")
pak::pkg_install("Stat-Cook/pidpos")
```

The intended workflow breaks down into three stages:

1.  Detection of PID risks via
    [`pidpos()`](https://stat-cook.github.io/pidpos/reference/pidpos.md)
2.  Preparation of redaction rules via
    [`report_to_redaction_rules()`](https://stat-cook.github.io/pidpos/reference/report_to_redaction_rules.md)
    and
    [`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md)
3.  Redaction of the original data via
    [`redact()`](https://stat-cook.github.io/pidpos/reference/redact.md)

To illustrate this, we include a subset of the `friends` package data
set:

``` r

library(pidpos)
example_data <- head(the_one_in_massapequa, 20)
example_data
```

    #> # A tibble: 20 × 4
    #>   scene utterance speaker          text                                         
    #>   <int>     <int> <chr>            <chr>                                        
    #> 1     1         1 Scene Directions [Scene: Central Perk, everyone is there.]    
    #> 2     1         2 Phoebe Buffay    Oh, Ross, Mon, is it okay if I bring someone…
    #> 3     1         3 Monica Geller    Yeah.                                        
    #> 4     1         4 Ross Geller      Sure. Yeah.                                  
    #> # ℹ 16 more rows

First, generate a PID report:

``` r

report <- pidpos(example_data)
#> Downloading udpipe model from https://raw.githubusercontent.com/jwijffels/udpipe.models.ud.2.5/master/inst/udpipe-ud-2.5-191206/english-ewt-ud-2.5-191206.udpipe to /home/runner/.cache/R/pidpos/english-ewt-ud-2.5-191206.udpipe
#>  - This model has been trained on version 2.5 of data from https://universaldependencies.org
#>  - The model is distributed under the CC-BY-SA-NC license: https://creativecommons.org/licenses/by-nc-sa/4.0
#>  - Visit https://github.com/jwijffels/udpipe.models.ud.2.5 for model license details.
#>  - For a list of all models and their licenses (most models you can download with this package have either a CC-BY-SA or a CC-BY-SA-NC license) read the documentation at ?udpipe_download_model. For building your own models: visit the documentation by typing vignette('udpipe-train', package = 'udpipe')
#> Downloading finished, model stored at '/home/runner/.cache/R/pidpos/english-ewt-ud-2.5-191206.udpipe'
head(report)
#> # A tibble: 6 × 6
#>   ID                Token   Sentence         Document Repeats `Affected Columns`
#>   <glue>            <chr>   <chr>            <chr>      <int> <chr>             
#> 1 Col:text Row:1    Central [Scene: Central… [Scene:…       1 `text`            
#> 2 Col:text Row:1    Perk    [Scene: Central… [Scene:…       1 `text`            
#> 3 Col:speaker Row:2 Phoebe  Phoebe Buffay    Phoebe …       3 `speaker`         
#> 4 Col:speaker Row:2 Buffay  Phoebe Buffay    Phoebe …       3 `speaker`         
#> # ℹ 2 more rows
```

The report lists all detected proper nouns alongside their source
variable and position. By default,
[`pidpos()`](https://stat-cook.github.io/pidpos/reference/pidpos.md)
uses the `udpipe` framework for POS tagging, but the package is designed
to support alternative taggers. A ready-made script for using spaCy is
included, and users may supply a custom tagging function, allowing the
package to be integrated into existing NLP pipelines. Further details
are provided in [Custom
Functions](https://stat-cook.github.io/pidpos/articles/custom-functions.html).

Should the user wish to not only identify, but redact the data, the
report can be converted into redaction rules and apply replacements:

``` r

raw_rules <- report_to_redaction_rules(report)
replacement_func <- make_random_replacement()
prepared_replacements <- auto_replace(raw_rules, replacement_func)
head(prepared_replacements)
#> # A tibble: 6 × 4
#>   If                                        From    To         POS  
#>   <chr>                                     <chr>   <chr>      <chr>
#> 1 [Scene: Central Perk, everyone is there.] Central MWLEFOODFI ""   
#> 2 [Scene: Central Perk, everyone is there.] Perk    MWLEFOODFI ""   
#> 3 Phoebe Buffay                             Phoebe  MWLEFOODFI ""   
#> 4 Phoebe Buffay                             Buffay  MWLEFOODFI ""   
#> # ℹ 2 more rows
```

Users may define replacement values manually or use the built-in
automatic replacement tools, which include options such as random
replacement and encryption. Full documentation of the available
replacement strategies is provided in [Automatic Replacement
Tools](https://stat-cook.github.io/pidpos/articles/auto-replacement.html).
Finally, apply the rules to produce a redacted dataset:

``` r

redacted_data <- redact(example_data, prepared_replacements)
head(redacted_data)
#> # A tibble: 6 × 4
#>   scene utterance speaker               text                                    
#>   <int>     <int> <chr>                 <chr>                                   
#> 1     1         1 Scene Directions      [Scene: MWLEFOODFI MWLEFOODFI, everyone…
#> 2     1         2 MWLEFOODFI MWLEFOODFI Oh, MWLEFOODFI, MWLEFOODFI, is it okay …
#> 3     1         3 MWLEFOODFI MWLEFOODFI Yeah.                                   
#> 4     1         4 MWLEFOODFI MWLEFOODFI Sure. Yeah.                             
#> # ℹ 2 more rows
```

## Multiple file API

When a project involves multiple files, three additional functions
support batch processing:

- [`report_on_folder()`](https://stat-cook.github.io/pidpos/reference/report_on_folder.md)
  to generate PID reports
- [`get_distinct_redaction_rules()`](https://stat-cook.github.io/pidpos/reference/get_distinct_redaction_rules.md)
  to combine the distinct reports into a single set of raw redactions.
- [`redact_at_folder()`](https://stat-cook.github.io/pidpos/reference/redact_at_folder.md)
  to produce redacted copies of the data.

## Current applications

The `pidpos` package was developed for applications in the NuRS and
AmReS research projects which aim to extract and analyse retrospective
operational data from NHS Trusts to understand staff retention and
patient safety.

## Contributions

The package was designed by RC, MA and SJ. Implementation was done by
RC. Quality assurance was done by MA. Documentation was written by RC.
Funding for the work was won by RC and SJ.

## Acknowledgements

The development of `pidpos` was part of the NuRS and AmReS projects
funded by the Health Foundation.

## References

Clarke, Roger. 2016. “Big Data, Big Risks.” *Information Systems
Journal* 26 (1): 77–90.

European Parliament, and Council of the European Union. 2016.
“Regulation (EU) 2016/679 of the European Parliament and of the
Council.” April 27. <https://data.europa.eu/eli/reg/2016/679/oj>.

Finck, Michèle, and Frank Pallas. 2020. “They Who Must Not Be
Identified—Distinguishing Personal from Non-Personal Data Under the
GDPR.” *International Data Privacy Law* 10 (1): 11–36.

ICO. n.d.-a. “Personal Data Breaches: What Happens If We Fail to Notify
the ICO of All Notifiable Breaches?”
<https://ico.org.uk/for-organisations/report-a-breach/personal-data-breach/personal-data-breaches-a-guide/#whathappensi>.

ICO. n.d.-b. “What Does It Mean If You Are a Controller?”
<https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/controllers-and-processors/controllers-and-processors/what-does-it-mean-if-you-are-a-controller/>.

Patterson-Stein, Jacob. 2025. *Pii: Search Data Frames for Personally
Identifiable Information*. <https://CRAN.R-project.org/package=pii>.

Straka, Milan, Jan Hajic, and Jana Straková. 2016. “UDPipe: Trainable
Pipeline for Processing CoNLL-u Files Performing Tokenization,
Morphological Analysis, Pos Tagging and Parsing.” *Proceedings of the
Tenth International Conference on Language Resources and Evaluation
(LREC’16)*, 4290–97.

Wijffels, Jan. 2023. *Udpipe: Tokenization, Parts of Speech Tagging,
Lemmatization and Dependency Parsing with the ’UDPipe’ ’NLP’ Toolkit*.
<https://CRAN.R-project.org/package=udpipe>.
