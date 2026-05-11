#' Initialize a minimum spacy environment
#'
#' NB: the following assumes you have installed the optional `reticulate` dependency.  If you have
#' not please run `install.packages("reticualte")` before continuing.
#'
#' This function  ensures a python environment is available for using the spacy language
#' models.
#'
#' @seealso
#' * To control the environment name or inherit an existing python env: [spacy-conda-env]
#'
#' @export
create_spacy_env <- function() {
  check_reticulate()

  callr::r(function() {
    tryCatch(
      reticulate::conda_binary(),
      error = function(e) {
        stop(
          "No conda installation found.",
          "Install miniconda with reticulate::install_miniconda() or ",
          "Anaconda at `https://www.anaconda.com/docs/getting-started/anaconda/install/overview`"
        )
      }
    )
  })

  envname <- get_pidpos_conda()

  envs <- callr::r(function() {
    reticulate::conda_list()
  })
  if (envname %in% envs$name) {
    message(paste("Env", envname, "already exists - skipping creation"))
    return(invisible(NULL))
  }
  message("Creating conda env - this may take a few minutes...")

  yml_path <- system.file(
    "python", "conda_environment.yml",
    package = "pidpos"
  )

  if (yml_path == "") {
    stop(
      "conda_environment.yml not found in package.\n",
      "If developing locally, run devtools::load_all() first.\n",
      "If installed, try reinstalling the package."
    )
  }

  callr::r(function(envname, yml_path) {
    reticulate::conda_create(
      environment = yml_path,
      additional_create_args = c("-n", envname)
    )
  }, args = list(envname = envname, yml_path = yml_path))
}
