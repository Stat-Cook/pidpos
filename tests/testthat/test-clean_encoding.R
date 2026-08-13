test_that("clean_encoding ", {
  expect_equal(clean_encoding("Test"), "Test")

  bad <- iconv("café", from = "UTF-8", to = "latin1") # force latin1 bytes
  expect_warning(clean_encoding(bad))
})
