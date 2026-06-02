test_that("escalate ", {
  test_warn <- new_warn_type("test_warn")

  expect_warning(test_warn("Warn"), "Warn")

  expect_error(tryCatch(
    test_warn("Escalated Warning"),
    warning = function(e) escalate(e, TRUE)
  ), "Escalated Warning")
})
