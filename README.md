# pidpos <a href="https://stat-cook.github.io/pidpos/"><img src="man/figures/logo.png" align="right" height="136" /></a>

<!-- badges: start -->
[![codecov: master](https://codecov.io/gh/Stat-Cook/pidpos/graph/badge.svg?token=MU68U4JMP3)](https://codecov.io/gh/Stat-Cook/pidpos)
[![R-CMD-check](https://github.com/Stat-Cook/pidpos/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Stat-Cook/pidpos/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

A package of tools for the detection and redaction of personally identifiable data (PID) in datasets via 
natural language processing. By default, any text element identified as a proper noun is flagged as a potential PID risk.

To install from GitHub straight into R, use:

```r
devtools::install_github("Stat-Cook/pidpos")

```

The main entry points for most users are `pidpos()` for single datasets and `report_on_folder()` for batch processing across multiple files.  

Note that natural language processing is rarely perfect — these tools are designed to assist with the identification and anonymisation of personal data, 
but cannot guarantee complete detection. Baseline tag identification rates for various language models are summarised
 in the  [Model Comparison Vignette](articles/model_comparisons.html).

## Troubleshooting 

The package is built on the [UDPipe](https://lindat.mff.cuni.cz/services/udpipe/) tree banks via the `udpipe` R package.  
Fetching the appropriate UDPipe model is intended to be automatic, however if there are issues it is worth reading 
the [Trouble shooting the UDPipe Model](articles/udpipe-model.html) vignette, and looking at the functions `browse_udpipe_repo()`/ `browse_model_location()`.

## Getting help

If you encounter a bug, please file a minimal reproducible example on github. Any feature requests, or requests for guidance on using the package can also be submitted this way though please read the documentation first.

Contribution to pidpos is welcome, to do so please open an issue so the development team can check it is compatible with the design principles or feel free to fork the repository.

