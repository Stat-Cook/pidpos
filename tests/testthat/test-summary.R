test_that("summary works", withr::with_options(list(pidpos_download_approved = TRUE), {
  report <- pidpos(the_one_in_massapequa)
  .summary <- summary(report)

  expect_equal(nrow(.summary), 2)
  expect_equal(ncol(.summary), 4)
}))
