# Package index

## pidpos

- [`pidpos()`](https://stat-cook.github.io/pidpos/reference/pidpos.md) :
  Proper Noun Detection

- [`summary(`*`<pidpos>`*`)`](https://stat-cook.github.io/pidpos/reference/summary.pidpos.md)
  :

  Summarize a `pidpos` report.

- [`tag_data_frame()`](https://stat-cook.github.io/pidpos/reference/tag_data_frame.md)
  : Tags a data frame with part of speech tags

- [`udpipe_factory()`](https://stat-cook.github.io/pidpos/reference/udpipe_factory.md)
  : Create a UDPipe tagging function

- [`custom_tagger()`](https://stat-cook.github.io/pidpos/reference/custom_tagger.md)
  : Convert a POS tagging function to a tagger for the pidpos package

- [`filter_to_proper_nouns()`](https://stat-cook.github.io/pidpos/reference/filter_to_proper_nouns.md)
  : Filter a tagged data frame to proper nouns

## Redaction tools

- [`report_to_redaction_rules()`](https://stat-cook.github.io/pidpos/reference/report_to_redaction_rules.md)
  : Initialize redaction rules
- [`redact()`](https://stat-cook.github.io/pidpos/reference/redact.md) :
  Redact PID
- [`parse_redacter()`](https://stat-cook.github.io/pidpos/reference/parse_redacter.md)
  : Parse a data frame into a redaction function with optional caching.
- [`redaction_function_factory()`](https://stat-cook.github.io/pidpos/reference/redaction_function_factory.md)
  : Replacement rules to redaction function
- [`batched_redact()`](https://stat-cook.github.io/pidpos/reference/batched_redact.md)
  : A wrapper for efficient redaction.

## Replacement Utilities

- [`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md)
  :

  Apply a replacement function to a `rules.frm`.

- [`make_hashing_replacement()`](https://stat-cook.github.io/pidpos/reference/make_hashing_replacement.md)
  : Function factory for hashing replacement.

- [`make_random_replacement()`](https://stat-cook.github.io/pidpos/reference/make_random_replacement.md)
  : Function factory for random replacement.

- [`make_replacement_function()`](https://stat-cook.github.io/pidpos/reference/make_replacement_function.md)
  : Wrapper for custom replacement functions

- [`get_replacement_cache()`](https://stat-cook.github.io/pidpos/reference/get_replacements.md)
  [`key_lookup()`](https://stat-cook.github.io/pidpos/reference/get_replacements.md)
  [`value_lookup()`](https://stat-cook.github.io/pidpos/reference/get_replacements.md)
  : Access the cache of replacements

## Folder level API

- [`report_on_folder()`](https://stat-cook.github.io/pidpos/reference/report_on_folder.md)
  : Generate PID reports across folder structure
- [`get_distinct_redaction_rules()`](https://stat-cook.github.io/pidpos/reference/get_distinct_redaction_rules.md)
  : Combine multiple PID reports into a single rule set
- [`redact_at_folder()`](https://stat-cook.github.io/pidpos/reference/redact_at_folder.md)
  : Redact PID across folder structure

## Package Utilities

- [`pidpos_setup()`](https://stat-cook.github.io/pidpos/reference/pidpos_setup.md)
  : Configure model storage for pidpos
- [`browse_model_location()`](https://stat-cook.github.io/pidpos/reference/browse_model_location.md)
  : Browse user to folder for UDPipe models.
- [`browse_udpipe_repo()`](https://stat-cook.github.io/pidpos/reference/browse_udpipe_repo.md)
  : Open github link to the 'english-ewt-2.5' UD model.
- [`register_reader()`](https://stat-cook.github.io/pidpos/reference/register_reader.md)
  : Add a reader function for a specific file extension.
- [`set_udpipe_version()`](https://stat-cook.github.io/pidpos/reference/set_udpipe_version.md)
  : Set the udpipe model repository version.
- [`reinstate_default_reader()`](https://stat-cook.github.io/pidpos/reference/reinstate_default_reader.md)
  : Reinstate the default read functionality for csv, tsv, xls, and xlsx
  files.
- [`merge_redactions()`](https://stat-cook.github.io/pidpos/reference/merge_redactions.md)
  : Remove PID from a data frame via a merge

## Experimental: spacy bindings

- [`spacy_factory()`](https://stat-cook.github.io/pidpos/reference/spacy_factory.md)
  : pidpos bindings to spacy models
- [`create_spacy_env()`](https://stat-cook.github.io/pidpos/reference/create_spacy_env.md)
  : Initialize a minimum spacy environment
- [`get_pidpos_conda()`](https://stat-cook.github.io/pidpos/reference/spacy-conda-env.md)
  [`set_pidpos_conda()`](https://stat-cook.github.io/pidpos/reference/spacy-conda-env.md)
  [`set_SPACY_CONDA_ENV()`](https://stat-cook.github.io/pidpos/reference/spacy-conda-env.md)
  : Get and set the conda environment for pidpos
- [`spacy_models()`](https://stat-cook.github.io/pidpos/reference/spacy_models.md)
  : List available spacy models

## Datasets

- [`the_one_in_massapequa`](https://stat-cook.github.io/pidpos/reference/the_one_in_massapequa.md)
  : The One in Massapequa

- [`sentence_frm`](https://stat-cook.github.io/pidpos/reference/sentence_frm.md)
  : A short data frame of free text including PID. Used for basic
  examples and tests.

- [`raw_redaction_rules`](https://stat-cook.github.io/pidpos/reference/raw_redaction_rules.md)
  :

  raw_redaction_rules An example of a redaction rules produced by the
  `pidpos` function. It is made using the first 20 rows of
  `the_one_in_massapequa` data set.
