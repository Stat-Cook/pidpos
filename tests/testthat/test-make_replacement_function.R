test_that("ConsistentMapper  print method", {
  
  cm <- ConsistentMapper$new(function() sample(letters, 1), 26)
  
  expect_output(
    print(cm),
    "^ConsistentMapper<0 of 26 values used>$"
  )
  
  cm$learn("A")
  
  expect_output(
    print(cm),
    "^ConsistentMapper<1 of 26 values used>$"
  )
})

test_that("replacement_function  print method", {
  
  cm <- make_replacement_function(function() sample(letters, 1), 26)

  expect_output(
    print(cm),
    "^replacement_function wrapping.*<0 of 26 values used>$"
  )
  
  cm("A")
  expect_output(
    print(cm),
    "^replacement_function wrapping.*<1 of 26 values used>$"
  )
})
