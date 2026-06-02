test_that("redact_internal methods", {
  
  expect_output(redact_internal("Test message", print), "Test message")
  
  frm <- data.frame(LETTERS)
  redacted <- redact_internal(frm, tolower)
  
  expect_equal(dim(redacted), c(26, 1))
  expect_true(all(redacted$LETTERS == letters))
})
