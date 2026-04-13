# Create a UDPipe tagging function

Returns a function that tags text documents using a specified UDPipe
model. The returned function accepts a character vector of documents and
returns a tibble with tokens, sentences, and token metadata.

## Usage

``` r
udpipe_factory(
  model = "english-ewt",
  model_dir = pidpos_env$model_folder,
  udpipe_repo = pidpos_env$udpipe_repo
)
```

## Arguments

- model:

  Character. The name of the UDPipe model to use. Defaults to
  `english-ewt`.

- model_dir:

  Character. Directory where UDPipe models are stored.

- udpipe_repo:

  Character. URL or path of the UDPipe model repository.

## Value

A function that takes a character vector of documents and returns a
[tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)

with columns:

- ID:

  Document identifier

- Token:

  Individual token text

- Sentence:

  Sentence containing the token

- upos:

  The universal parts of speech tag of the token. See
  https://universaldependencies.org/format.html

and all columns returned by the
\<[udpipe()\`](https://rdrr.io/pkg/udpipe/man/udpipe.html)\> function
for each token.

## See also

[`pidpos_setup()`](https://stat-cook.github.io/pidpos/reference/pidpos_setup.md)
and
[`set_udpipe_version()`](https://stat-cook.github.io/pidpos/reference/set_udpipe_version.md)
for control of the configuration environment.

## Examples

``` r
# \donttest{
# Create a tagger for the English EWT model
ewt_tagger <- udpipe_factory("english-ewt")
docs <- c("This is a test.", "Another sentence.")
ewt_tagger(docs)
#> Error: Model download required but session is non-interactive. Set options(pidpos_download_approved = TRUE) or env var PIDPOS_DOWNLOAD_APPROVED=true.

# Create a tagger for the English GUM model
gum_tagger <- udpipe_factory("english-gum")
gum_tagger(docs)
#> Error: Model download required but session is non-interactive. Set options(pidpos_download_approved = TRUE) or env var PIDPOS_DOWNLOAD_APPROVED=true.

# Create a tagger for the English LINES model
lines_tagger <- udpipe_factory("english-lines")
lines_tagger(docs)
#> Error: Model download required but session is non-interactive. Set options(pidpos_download_approved = TRUE) or env var PIDPOS_DOWNLOAD_APPROVED=true.
# }
```
