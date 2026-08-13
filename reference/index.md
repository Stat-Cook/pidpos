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

- [`regex_factory()`](https://stat-cook.github.io/pidpos/reference/regex_factory.md)
  : Create a PID detection function from a named list of regex patterns

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
- [`export_as_tree()`](https://stat-cook.github.io/pidpos/reference/export_utilites.md)
  [`export_flat()`](https://stat-cook.github.io/pidpos/reference/export_utilites.md)
  : Export utilities

## Package Utilities

- [`pidpos_setup()`](https://stat-cook.github.io/pidpos/reference/pidpos_setup.md)
  : Configure model storage for pidpos

- [`browse_model_location()`](https://stat-cook.github.io/pidpos/reference/browse_model_location.md)
  : Browse user to folder for UDPipe models.

- [`browse_udpipe_repo()`](https://stat-cook.github.io/pidpos/reference/browse_udpipe_repo.md)
  : Open github link to the 'english-ewt-2.5' UD model.

- [`clean_encoding()`](https://stat-cook.github.io/pidpos/reference/clean_encoding.md)
  : Encode non utf8 text

- [`register_reader()`](https://stat-cook.github.io/pidpos/reference/register_reader.md)
  : Add a reader function for a specific file extension.

- [`set_udpipe_version()`](https://stat-cook.github.io/pidpos/reference/set_udpipe_version.md)
  : Set the udpipe model repository version.

- [`set_context_window()`](https://stat-cook.github.io/pidpos/reference/set_context_window.md)
  :

  Set the context window size for the `get_context` function.

- [`reinstate_default_reader()`](https://stat-cook.github.io/pidpos/reference/reinstate_default_reader.md)
  : Reinstate the default read functionality for csv, tsv, xls, and xlsx
  files.

## Experimental: spacy bindings

- [`spacy_factory()`](https://stat-cook.github.io/pidpos/reference/spacy_factory.md)
  : pidpos bindings to spacy models
- [`spacy_filter()`](https://stat-cook.github.io/pidpos/reference/spacy_filter.md)
  : A default filter for the spaCy language models
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

- [`presidio_text`](https://stat-cook.github.io/pidpos/reference/presidio_text.md)
  : presidio_text

- [`presidio_tags`](https://stat-cook.github.io/pidpos/reference/presidio_tags.md)
  : presidio_tags

- [`baseline_comparison`](https://stat-cook.github.io/pidpos/reference/comparison_data.md)
  [`lower_comparison`](https://stat-cook.github.io/pidpos/reference/comparison_data.md)
  [`preprocessed_comparison`](https://stat-cook.github.io/pidpos/reference/comparison_data.md)
  [`titlecase_comparison`](https://stat-cook.github.io/pidpos/reference/comparison_data.md)
  : Comparison datasets

- [`pid_patterns`](https://stat-cook.github.io/pidpos/reference/pid_patterns.md)
  : Default PID regex patterns
