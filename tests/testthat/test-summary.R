test_that("summary works", withr::with_options(list(pidpos_download_approved = TRUE), {
  report <- tibble::tibble(
    ID = 1,
    `Token` = "Bob",
    `Sentence` = "Bob came to visit.",
    `Document` = "Bob came to visit.",
    `Repeats` = 1,
    `Affected Columns`  = c("`Text`")
  )
  class(report) <- c("pidpos", class(report))
  
  .summary <- summary(report)

  expect_equal(nrow(.summary), 1)
  expect_equal(ncol(.summary), 4)
}))


