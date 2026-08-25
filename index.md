# pidpos

A package of tools for the detection and redaction of personally
identifiable data (PID) in datasets via natural language processing. By
default, any text element identified as a proper noun is flagged as a
potential PID risk.

To install from GitHub straight into R, use:

``` r

devtools::install_github("Stat-Cook/pidpos")
```

The main entry points for most users are
[`pidpos()`](https://stat-cook.github.io/pidpos/reference/pidpos.md) for
single datasets and
[`report_on_folder()`](https://stat-cook.github.io/pidpos/reference/report_on_folder.md)
for batch processing across multiple files.

Note that natural language processing is rarely perfect — these tools
are designed to assist with the identification and anonymisation of
personal data, but cannot guarantee complete detection. Baseline tag
identification rates for various language models are summarised in the
[Model Comparison
Vignette](https://stat-cook.github.io/pidpos/articles/model_comparisons.html).

## Troubleshooting

The package is built on the
[UDPipe](https://lindat.mff.cuni.cz/services/udpipe/) tree banks via the
`udpipe` R package.  
Fetching the appropriate UDPipe model is intended to be automatic,
however if there are issues it is worth reading the [Trouble shooting
the UDPipe
Model](https://stat-cook.github.io/pidpos/articles/udpipe-model.html)
vignette, and looking at the functions
[`browse_udpipe_repo()`](https://stat-cook.github.io/pidpos/reference/browse_udpipe_repo.md)/
[`browse_model_location()`](https://stat-cook.github.io/pidpos/reference/browse_model_location.md).

## Getting help

If you encounter a bug, please file a minimal reproducible example on
github. Any feature requests, or requests for guidance on using the
package can also be submitted this way though please read the
documentation first.

Contribution to pidpos is welcome, to do so please open an issue so the
development team can check it is compatible with the design principles
or feel free to fork the repository.
