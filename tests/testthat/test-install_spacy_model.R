test_that("install_spacy_model", {
  mockery::stub(install_spacy_model, "spacy_require", function(...) TRUE)
  mockery::stub(install_spacy_model, "is_ephemeral_reticulate", function(...) TRUE)
  mockery::stub(install_spacy_model, "reticulate::py_module_available", function(...) TRUE)
  expect_true(install_spacy_model())

  mockery::stub(install_spacy_model, "reticulate::py_module_available", function(...) FALSE)
  mockery::stub(install_spacy_model, "file.exists", function(...) TRUE)
  mockery::stub(install_spacy_model, "reticulate::py_install", function(...) warning("An ephemeral virtual environment"))
  expect_message(install_spacy_model())

  mockery::stub(install_spacy_model, "reticulate::py_install", function(...) warning("Mock warning"))
  suppressWarnings(
    expect_warning(expect_message(
      install_spacy_model()
    ))
  )

  mockery::stub(install_spacy_model, "file.exists", function(...) FALSE)
  mockery::stub(install_spacy_model, "check_model_download_consent", function(...) TRUE)
  mockery::stub(install_spacy_model, "httr2::request", function(...) TRUE)
  mockery::stub(install_spacy_model, "httr2::req_perform", function(...) TRUE)
  mockery::stub(install_spacy_model, "reticulate::py_install", function(...) warning("An ephemeral virtual environment"))
  expect_message(install_spacy_model(), "Downloading")
})
