# Configure model storage for pidpos

Sets how pidpos stores and retrieves language models used by
[`udpipe`](https://rdrr.io/pkg/udpipe/man/udpipe.html) for
part-of-speech tagging. Call this once at the start of a session or in
your project's `.Rprofile`.

## Usage

``` r
pidpos_setup(model_storage = c("package", "project", "temporary", "env"))
```

## Arguments

- model_storage:

  Where models are stored between sessions. One of:

  `"package"`

  :   Cached inside the pidpos package directory. Persists across
      sessions; shared across all projects.

  `"project"`

  :   Cached in the current project directory. Persists across sessions;
      isolated per project.

  `"temporary"`

  :   Written to a [`tempdir()`](https://rdrr.io/r/base/tempfile.html)
      each session. Not persisted; re-downloaded on every new session.

  `"env"`

  :   Model object held in memory only. No files are written; caching is
      disabled (`pidpos_caching = FALSE`).

## Value

Called for its side effects. Sets `getOption("pidpos_caching")` and
`getOption("pidpos_model_storage")`.

## See also

[`udpipe`](https://rdrr.io/pkg/udpipe/man/udpipe.html)

## Examples

``` r
if (FALSE) { # \dontrun{
# Persist models in a shared package-level cache
pidpos_setup("package")

# Use a per-project cache (good for reproducible workflows)
pidpos_setup("project")
} # }
```
