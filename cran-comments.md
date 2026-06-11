## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Notes for reviewer

This package can download external data, but downloads are never performed automatically during package checks.

Data downloads occur only when users explicitly call the relevant functions and confirm 
the download via an interactive prompt. In non-interactive sessions (including CRAN checks), 
downloads are not intended to initiated unless the user explicitly sets the appropriate function argument.

Further, some optional functionality depends on the suggested package reticulate. 
Functions requiring reticulate check for its availability at runtime and provide an 
informative error message when it is not installed. Core package functionality does 
not depend on reticulate, and package checks, examples, and tests can be ran without it.
