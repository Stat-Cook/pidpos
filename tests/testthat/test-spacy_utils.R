test_that("get_pidpos_conda returns default when nothing set", {
  withr::defer({
    pidpos_env$conda_env <- NULL
    Sys.unsetenv("SPACY_CONDA_ENV")
  })
  
  pidpos_env$conda_env <- NULL
  Sys.unsetenv("SPACY_CONDA_ENV")
  expect_equal(get_pidpos_conda(), "pidpos")
})

test_that("get_pidpos_conda returns session env when set", {
  withr::defer({
    pidpos_env$conda_env <- NULL
    Sys.unsetenv("SPACY_CONDA_ENV")
  })
  
  set_pidpos_conda("my-test-env")
  expect_equal(get_pidpos_conda(), "my-test-env")
})

test_that("get_pidpos_conda returns env var when session env not set", {
  withr::defer({
    pidpos_env$conda_env <- NULL
    Sys.unsetenv("SPACY_CONDA_ENV")
  })
  
  pidpos_env$conda_env <- NULL
  Sys.setenv(SPACY_CONDA_ENV = "global-test-env")
  expect_equal(get_pidpos_conda(), "global-test-env")
})

test_that("session env takes priority over env var", {
  withr::defer({
    pidpos_env$conda_env <- NULL
    Sys.unsetenv("SPACY_CONDA_ENV")
  })
  
  set_pidpos_conda("session-env")
  Sys.setenv(SPACY_CONDA_ENV = "global-env")
  expect_equal(get_pidpos_conda(), "session-env")
})

test_that("set_pidpos_conda sets session env", {
  withr::defer(pidpos_env$conda_env <- NULL)
  
  set_pidpos_conda("test-env")
  expect_equal(pidpos_env$conda_env, "test-env")
})

test_that("set_SPACY_CONDA_ENV sets system env var", {
  withr::defer(Sys.unsetenv("SPACY_CONDA_ENV"))
  
  set_SPACY_CONDA_ENV("global-test-env")
  expect_equal(Sys.getenv("SPACY_CONDA_ENV"), "global-test-env")
})

test_that("spacy_models returns a list", {
  skip_if_not(reticulate::condaenv_exists(get_pidpos_conda()),
              "conda env not available")
  expect_true(is.character(spacy_models()))
})

