test_that("create_spacy_env skips if env already exists", {
  withr::defer(pidpos_env$conda_env <- NULL)

  skip_if_not(
    reticulate::condaenv_exists(get_pidpos_conda()),
    "conda env not available"
  )

  expect_message(create_spacy_env(), "already exists - skipping creation")
})

test_that("create_spacy_env errors if yml not found", {
  withr::defer(pidpos_env$conda_env <- NULL)

  # Point to a non-existent env so it doesn't skip
  set_pidpos_conda("pidpos-nonexistent-env-12345")

  # Mock system.file to return empty string
  mockery::stub(create_spacy_env, "system.file", "")

  expect_error(create_spacy_env(), "conda_environment.yml not found")
})

test_that("create_spacy_env errors if reticulate not available", {
  mockery::stub(
    create_spacy_env, "check_reticulate",
    function() stop("reticulate is not installed")
  )

  expect_error(create_spacy_env(), "reticulate is not installed")
})

test_that("create_spacy_env errors if no conda found", {
  withr::defer(pidpos_env$conda_env <- NULL)

  set_pidpos_conda("pidpos-nonexistent-env-12345")

  mockery::stub(
    create_spacy_env, "callr::r",
    function(...) stop("No conda installation found")
  )

  expect_error(create_spacy_env(), "No conda installation found")
})
