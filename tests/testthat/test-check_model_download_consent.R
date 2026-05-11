original_download_approved <- getOption("pidpos_download_approved")
original_caching <- getOption("pidpos_caching")


test_that("check_model_download_consent returns TRUE if option set", {

  options(pidpos_download_approved = TRUE)
  expect_true(check_model_download_consent("en_core_web_lg"))
})

test_that("check_model_download_consent returns TRUE if env var set", {
  withr::defer({
    options(pidpos_download_approved = original_download_approved)
  })
  
  options(pidpos_download_approved = FALSE)
  expect_true(check_model_download_consent("en_core_web_lg"))
})

test_that("check_model_download_consent option takes priority over env var", {
  withr::defer({
    options(pidpos_download_approved = original_download_approved)
  })
  
  options(pidpos_download_approved = TRUE)
  expect_true(check_model_download_consent("en_core_web_lg"))
})

test_that("check_model_download_consent errors if user declines", {
  withr::defer({
    options(pidpos_download_approved = original_download_approved)
    options(pidpos_caching = original_caching)
  })

  options(pidpos_download_approved = FALSE)
  options(pidpos_caching = TRUE)
  Sys.unsetenv("PIDPOS_DOWNLOAD_APPROVED")

  mockery::stub(check_model_download_consent, "interactive", function() TRUE)
  mockery::stub(check_model_download_consent, "readline", function(...) "n")

  expect_error(
    check_model_download_consent("en_core_web_lg"),
    "Download cancelled"
  )
})

test_that("check_model_download_consent sets option after consent", {
  
  withr::defer({
    options(pidpos_download_approved = original_download_approved)
    options(pidpos_caching = original_caching)
  })

  options(pidpos_download_approved = FALSE)
  options(pidpos_caching = TRUE)
  Sys.unsetenv("PIDPOS_DOWNLOAD_APPROVED")

  mockery::stub(check_model_download_consent, "interactive", function() TRUE)
  mockery::stub(check_model_download_consent, "readline", function(...) "y")

  check_model_download_consent("en_core_web_lg")
  expect_true(getOption("pidpos_download_approved"))
})
