# pidpos (development)

# pidpos 0.1.0

Initial release.

## Core functionality

* `pidpos()` for detecting personally identifiable data in a data frame via POS tagging
* `report_to_redaction_rules()` to convert a PID report into an editable redaction rule set
* `auto_replace()` to automatically populate replacement values
* `redact()` to apply redaction rules to a data frame

## Taggers

* Default UDPipe tagger via `udpipe_factory()`
* Experimental spaCy support via `spacy_factory()`
* User-extensible interface via `custom_tagger()`
* Regex-based tagger via `regex_factory()` with built-in `pid_patterns`

## Batch processing

* `report_on_folder()`, `get_distinct_redaction_rules()`, and `redact_at_folder()`
  for processing collections of files

## Replacement strategies

* `make_random_replacement()` for random string replacements
* `make_hashing_replacement()` for deterministic encrypted replacements
* `make_replacement_function()` for custom encoder wrapping