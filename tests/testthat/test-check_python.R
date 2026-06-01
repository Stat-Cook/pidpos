test_that("check_python works", {
  skip_if_not(reticulate::py_available(), "Python not available")
  skip_if_not(reticulate::condaenv_exists(get_pidpos_conda()), "spacy-env conda env not available")

  versions <- check_python()
  expect_named(versions, c("numpy", "spacy", "torch"))
})
