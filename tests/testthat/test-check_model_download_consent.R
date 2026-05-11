test_that("check_model_download_consent returns TRUE if option set", {
  withr::defer(options(pidpos_download_approved = NULL))
  
  options(pidpos_download_approved = TRUE)
  expect_true(check_model_download_consent("en_core_web_lg"))
})

test_that("check_model_download_consent returns TRUE if env var set", {
  withr::defer({
    Sys.unsetenv("PIDPOS_DOWNLOAD_APPROVED")
    options(pidpos_download_approved = NULL)
  })
  
  options(pidpos_download_approved = FALSE)
  Sys.setenv(PIDPOS_DOWNLOAD_APPROVED = "true")
  expect_true(check_model_download_consent("en_core_web_lg"))
})

test_that("check_model_download_consent option takes priority over env var", {
  withr::defer({
    Sys.unsetenv("PIDPOS_DOWNLOAD_APPROVED")
    options(pidpos_download_approved = NULL)
  })
  
  options(pidpos_download_approved = TRUE)
  Sys.setenv(PIDPOS_DOWNLOAD_APPROVED = "false")
  expect_true(check_model_download_consent("en_core_web_lg"))
})

test_that("check_model_download_consent errors if user declines", {
  withr::defer({
    options(pidpos_download_approved = NULL)
    options(pidpos_caching = NULL)
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
    options(pidpos_download_approved = NULL)
    options(pidpos_caching = NULL)
  })
  
  options(pidpos_download_approved = FALSE)
  options(pidpos_caching = TRUE)
  Sys.unsetenv("PIDPOS_DOWNLOAD_APPROVED")
  
  mockery::stub(check_model_download_consent, "interactive", function() TRUE)
  mockery::stub(check_model_download_consent, "readline", function(...) "y")
  
  check_model_download_consent("en_core_web_lg")
  expect_true(getOption("pidpos_download_approved"))
})

