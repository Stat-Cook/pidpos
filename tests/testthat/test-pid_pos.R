test_that("pidpos returns pid_report", {
  mockery::stub(pidpos, "tag_data_frame", fake_tag_data_frame)

  df <- data.frame(text = c("John went home.", "London is big."))

  result <- pidpos(df)

  expect_s3_class(result, "pidpos")
  expect_s3_class(result, "tbl_df")
})

test_that("errors on invalid frm", {
  expect_error(
    pidpos(123),
    "`frm` must be a data frame"
  )
})

test_that("errors if filter_func not function", {
  expect_error(
    pidpos(data.frame(text = "x"), filter_func = 123),
    "`filter_func` must be a function"
  )
})

test_that("warns if to_ignore missing and warn_if_missing TRUE", {
  mockery::stub(pidpos, "tag_data_frame", fake_tag_data_frame)

  df <- data.frame(text = "John")

  expect_warning(
    pidpos(df, to_ignore = "not_a_column", warn_if_missing = TRUE),
    "were not found"
  )
})

fake_empty_tag_data_frame <- function(...) {
  list(AllTags = NULL, Documents = NULL)
}

test_that("returns empty pid_report if no tags", {
  mockery::stub(pidpos, "tag_data_frame", fake_empty_tag_data_frame)

  df <- data.frame(text = "Nothing")

  result <- pidpos(df)

  expect_s3_class(result, "pid_report")
  expect_equal(nrow(result), 0)
})
