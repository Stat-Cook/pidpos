# Changelog

## pidpos 0.1.0

Initial release.

### Core functionality

- [`pidpos()`](https://stat-cook.github.io/pidpos/reference/pidpos.md)
  for detecting personally identifiable data in a data frame via POS
  tagging
- [`report_to_redaction_rules()`](https://stat-cook.github.io/pidpos/reference/report_to_redaction_rules.md)
  to convert a PID report into an editable redaction rule set
- [`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md)
  to automatically populate replacement values
- [`redact()`](https://stat-cook.github.io/pidpos/reference/redact.md)
  to apply redaction rules to a data frame

### Taggers

- Default UDPipe tagger via
  [`udpipe_factory()`](https://stat-cook.github.io/pidpos/reference/udpipe_factory.md)
- Experimental spaCy support via
  [`spacy_factory()`](https://stat-cook.github.io/pidpos/reference/spacy_factory.md)
- User-extensible interface via
  [`custom_tagger()`](https://stat-cook.github.io/pidpos/reference/custom_tagger.md)
- Regex-based tagger via
  [`regex_factory()`](https://stat-cook.github.io/pidpos/reference/regex_factory.md)
  with built-in `pid_patterns`

### Batch processing

- [`report_on_folder()`](https://stat-cook.github.io/pidpos/reference/report_on_folder.md),
  [`get_distinct_redaction_rules()`](https://stat-cook.github.io/pidpos/reference/get_distinct_redaction_rules.md),
  and
  [`redact_at_folder()`](https://stat-cook.github.io/pidpos/reference/redact_at_folder.md)
  for processing collections of files

### Replacement strategies

- [`make_random_replacement()`](https://stat-cook.github.io/pidpos/reference/make_random_replacement.md)
  for random string replacements
- [`make_hashing_replacement()`](https://stat-cook.github.io/pidpos/reference/make_hashing_replacement.md)
  for deterministic encrypted replacements
- [`make_replacement_function()`](https://stat-cook.github.io/pidpos/reference/make_replacement_function.md)
  for custom encoder wrapping
