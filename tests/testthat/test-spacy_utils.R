test_that("spacy_models returns a list", {

  reticulate:::skip_if_no_python()
  
  expect_equal(length(spacy_models()), 2)

})

test_that("spacy_models returns a list", {
  mockery::stub(is_ephemeral_reticulate, "check_reticulate", function(...) TRUE)
  mockery::stub(is_ephemeral_reticulate, "reticulate::py_config", function(...) list(ephemeral=TRUE))
  expect_true(is_ephemeral_reticulate())
  
  mockery::stub(is_ephemeral_reticulate, "reticulate::py_config", function(...) list(ephemeral=FALSE))
  
  rlang::reset_warning_verbosity("ephemeral_python_warn")  
  expect_warning(is_ephemeral_reticulate())
  expect_false(is_ephemeral_reticulate())
})
