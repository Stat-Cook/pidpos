---
title: 'pidpos: An R package for the detection of personally identifiable data'
tags:
  - R
authors:
  - name: Robert M. Cook
    orcid: 0000-0003-3343-8271
    equal-contrib: false
    affiliation: 1
  - name: Md Asaduzzaman
    orcid: 0000-0002-8885-6721
    equal-contrib: false # (This is how you can denote equal contributions between multiple authors)
    affiliation: 1
  - name: Sarahjane Jones
    orcid: 0000-0003-4729-4029
    equal-contrib: false # (This is how you can denote equal contributions between multiple authors)
    affiliation: 1
affiliations:
 - name: University of Staffordshire, Centre for Health Innovation, Blackheath Lane, Stafford,  England
   index: 1
bibliography:  JOSS_utilities/paper.bib
---
# Summary

The `pidpos` package aids in identifying personal identifiability risks
in datasets. Using part-of-speech (POS) tagging, it extracts proper
nouns from text fields, reducing the complexity of the review process
and enabling faster human oversight. The package also provides tools for
designing and implementing a redaction workflow.

# Statement of need

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
tagging ( by default the **UDPipe** framework (Straka et al. 2016;
Wijffels 2023), but featuring bindings to **spaCy** (Honnibal et al.
2020) and the ability to use a custom tagging engine) it extracts PID
candidates from a dataset, deliberately accepting a higher false
positive rate, and implementing tools to aid human review rather than
attempting full automation. This makes it robust to the edge cases that
pattern-matching approaches can miss, while remaining auditable and
governable.

# In practice

To install the current version of `pidpos` package, use the following
code:

``` r
# install.packages("pak")
pak::pkg_install("Stat-Cook/pidpos")
```

The intended workflow breaks down into three stages:

1.  Detection of PID risks via `pidpos()`
2.  Preparation of redaction rules via `report_to_redaction_rules()` and
    `auto_replace()`
3.  Redaction of the original data via `redact()`

To illustrate this, we include a subset of the `friends` package data
set:

``` r
library(pidpos)
example_data <- head(the_one_in_massapequa, 20)
example_data
```

| scene | utterance | speaker | text |
|----:|------:|:----------|:------------------------------------------------|
| 1 | 1 | Scene Directions | [Scene: Central Perk, everyone is there.] |
| 1 | 2 | Phoebe Buffay | Oh, Ross, Mon, is it okay if I bring someone to your parent’s anniversary party? |
| 1 | 3 | Monica Geller | Yeah. |
| 1 | 4 | Ross Geller | Sure. Yeah. |
| 1 | 5 | Joey Tribbiani | So, who’s the guy? |

First, generate a PID report:

``` r
report <- pidpos(example_data)
head(report)
```

| ID | Token | Sentence | Document | Repeats | Affected Columns |
|:------|:---|:-------------------------|:-------------------------|---:|:------|
| Col:text Row:1 | Central | [Scene: Central Perk, everyone is there.] | [Scene: Central Perk, everyone is there.] | 1 | `text` |
| Col:text Row:1 | Perk | [Scene: Central Perk, everyone is there.] | [Scene: Central Perk, everyone is there.] | 1 | `text` |
| Col:speaker Row:2 | Phoebe | Phoebe Buffay | Phoebe Buffay | 3 | `speaker` |
| Col:speaker Row:2 | Buffay | Phoebe Buffay | Phoebe Buffay | 3 | `speaker` |
| Col:text Row:2 | Ross | Oh, Ross, Mon, is it okay if I bring someone to your parent’s anniversary party? | Oh, Ross, Mon, is it okay if I bring someone to your parent’s anniversary party? | 1 | `text` |

The report lists all detected proper nouns alongside their source
variable and position. By default, `pidpos()` uses the `udpipe`
framework for POS tagging, but the package is designed to support
alternative taggers. A ready-made script for using spaCy is included,
and users may supply a custom tagging function, allowing the package to
be integrated into existing NLP pipelines. Further details are provided
in [Custom
Functions](https://stat-cook.github.io/pidpos/articles/custom-functions.html).

Should the user wish to not only identify, but redact the data, the
report can be converted into redaction rules and apply replacements:

``` r
raw_rules <- report_to_redaction_rules(report)
replacement_func <- make_random_replacement()
prepared_replacements <- auto_replace(raw_rules, replacement_func)
head(prepared_replacements)
```

| If | From | To | POS |
|:-----------------------------------------------------|:------|:--------|:---|
| [Scene: Central Perk, everyone is there.] | Central | MHWHHRYHJZ |  |
| [Scene: Central Perk, everyone is there.] | Perk | CXEMTMJVFB |  |
| Phoebe Buffay | Phoebe | HJNVAGOVVF |  |
| Phoebe Buffay | Buffay | ZLCXCWRAWK |  |
| Oh, Ross, Mon, is it okay if I bring someone to your parent’s anniversary party? | Ross | GKHETDIGUB |  |

Users may define replacement values manually or use the built-in
automatic replacement tools, which include options such as random
replacement and encryption. Full documentation of the available
replacement strategies is provided in [Automatic Replacement
Tools](https://stat-cook.github.io/pidpos/articles/auto-replacement.html).
Finally, apply the rules to produce a redacted dataset:

``` r
redacted_data <- redact(example_data, prepared_replacements)
head(redacted_data)
```

| scene | utterance | speaker | text |
|----:|------:|:------------|:------------------------------------------------|
| 1 | 1 | Scene Directions | [Scene: MHWHHRYHJZ CXEMTMJVFB, everyone is there.] |
| 1 | 2 | HJNVAGOVVF ZLCXCWRAWK | Oh, GKHETDIGUB, CQPBQBIYFD, is it okay if I bring someone to your parent’s anniversary party? |
| 1 | 3 | MHCWPKTBER DFSKKVXDQE | Yeah. |
| 1 | 4 | GKHETDIGUB DFSKKVXDQE | Sure. Yeah. |
| 1 | 5 | VPREXNJNTE WPCIWCDJPW | So, who’s the guy? |

# Multiple file API

When a project involves multiple files, three additional functions
support batch processing:

- `report_on_folder()` to generate PID reports
- `get_distinct_redaction_rules()` to combine the distinct reports into
  a single set of raw redactions.
- `redact_at_folder()` to produce redacted copies of the data.

A worked example of which is documented
[here](https://stat-cook.github.io/pidpos/articles/folder-report.html).

# Current applications

The `pidpos` package was developed for applications in the NuRS and
AmReS research projects which aim to extract and analyse retrospective
operational data from NHS Trusts to understand staff retention and
patient safety.

# Contributions

The package was designed by RC, MA and SJ. Implementation was done by
RC. Quality assurance was done by MA. Documentation was written by RC.
Funding for the work was won by RC and SJ.

# Acknowledgements

The development of `pidpos` was part of the NuRS and AmReS projects
funded by the Health Foundation.

# References

Clarke, Roger. 2016. “Big Data, Big Risks.” *Information Systems
Journal* 26 (1): 77–90. <https://doi.org/10.1111/isj.12088>.

European Parliament, and Council of the European Union. 2016.
“Regulation (EU) 2016/679 of the European Parliament and of the
Council.” April 27. <https://data.europa.eu/eli/reg/2016/679/oj>.

Finck, Michèle, and Frank Pallas. 2020. “They Who Must Not Be
Identified—Distinguishing Personal from Non-Personal Data Under the
GDPR.” *International Data Privacy Law* 10 (1): 11–36.
<https://doi.org/10.1093/idpl/ipz026>.

Honnibal, Matthew, Ines Montani, Sofie Van Landeghem, and Adriane Boyd.
2020. *<span class="nocase">spaCy</span>: Industrial-Strength Natural
Language Processing in Python*.
<https://doi.org/10.5281/zenodo.1212303>.

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
(LREC’16)*, 4290–97. <https://aclanthology.org/L16-1680>.

Wijffels, Jan. 2023. *Udpipe: Tokenization, Parts of Speech Tagging,
Lemmatization and Dependency Parsing with the ’UDPipe’ ’NLP’ Toolkit*.
<https://CRAN.R-project.org/package=udpipe>.
