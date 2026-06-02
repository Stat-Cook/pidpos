test_that("pidpos_setup `package` option values", {
  withr::local_options()
  
  pidpos_setup("package")
  expect_equal(getOption("pidpos_model_storage"), "package")
  expect_true(getOption("pidpos_caching"))
  
})

test_that("pidpos_setup `project` option values", {
  withr::local_options()
  
  pidpos_setup("project")
  expect_equal(getOption("pidpos_model_storage"), "project")
  expect_true(getOption("pidpos_caching"))
  
})

test_that("pidpos_setup `temporary` option values", {
  withr::local_options()
  
  pidpos_setup("temporary")
  expect_equal(getOption("pidpos_model_storage"), "temporary")
  expect_true(getOption("pidpos_caching"))
  
})

test_that("pidpos_setup `env` option values", {
  withr::local_options()
  
  pidpos_setup("env")
  expect_equal(getOption("pidpos_model_storage"), "env")
  expect_false(getOption("pidpos_caching"))
  
})
