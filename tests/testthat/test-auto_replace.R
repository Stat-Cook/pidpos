test_that("make_hashing_replacement", {
  basic.hash.f <- make_hashing_replacement("101", "Barry")
  hashed <- basic.hash.f(letters)

  expect_equal(
    length(letters),
    length(hashed)
  )
  expect_true(all(hashed != letters))

  other.hash.f <- make_hashing_replacement("101", "Barry", hash = openssl::sha512)
  hashed.2 <- other.hash.f(letters)

  expect_equal(
    length(letters),
    length(hashed.2)
  )
  expect_true(all(hashed.2 != letters))
})


test_that("make_random_replacement default", {
  basic.replacement_func <- make_random_replacement()
  hashed <- basic.replacement_func(letters)

  expect_equal(
    length(letters),
    length(hashed)
  )
  expect_true(all(hashed != letters))
})

test_that("make_random_replacement with args", {
  other.hash.f <- make_random_replacement(50, c(letters, LETTERS, 0:9))
  hashed.2 <- other.hash.f(letters)

  expect_equal(
    length(letters),
    length(hashed.2)
  )
  expect_true(all(hashed.2 != letters))
})

test_that("make_random_replacement on numerics", {
  other.hash.f <- make_random_replacement(5, c(letters, LETTERS, 0:9))
  .x <- 0:10
  hashed.3 <- other.hash.f(.x)

  expect_equal(
    length(.x),
    length(hashed.3)
  )
  expect_true(all(.x != hashed.3))
})

test_that("make_random_replacement with repeats", {
  .x <- sample(letters[1:3], 50, TRUE)
  replacement_func <- make_random_replacement()

  hashed <- replacement_func(.x)

  expect_equal(length(unique(hashed)), 3)
})

test_that("make_random_replacement default", {
  basic.replacement_func <- make_random_replacement(all = TRUE)
  hashed <- basic.replacement_func(letters)

  expect_equal(
    length(letters),
    length(hashed)
  )
  expect_true(all(hashed != letters))
})


test_that("make_random_replacement - all with args", {
  other.hash.f <- make_random_replacement(50, c(letters, LETTERS, 0:9), all = TRUE)
  hashed.2 <- other.hash.f(letters)

  expect_equal(
    length(letters),
    length(hashed.2)
  )
  expect_true(all(hashed.2 != letters))
})

test_that("make_random_replacement - all on numerics", {
  other.hash.f <- make_random_replacement(5, c(letters, LETTERS, 0:9), all = TRUE)
  .x <- 0:10
  hashed.3 <- other.hash.f(.x)

  expect_equal(
    length(.x),
    length(hashed.3)
  )
  expect_true(all(.x != hashed.3))
})

test_that("make_random_replacement - all with repeats", {
  .x <- sample(letters[1:3], 50, TRUE)
  replacement_func <- make_random_replacement(all = TRUE)

  hashed <- replacement_func(.x)

  expect_equal(length(unique(hashed)), 50)
})


test_that("auto_replace", {
  frm <- data.frame(
    To = sample(LETTERS, 100, TRUE)
  )

  basic.replacement_func <- make_random_replacement()

  frm.replaced <- auto_replace(frm, basic.replacement_func)

  expect_true(all(frm$To != frm.replaced$To))
})

# Helper encoders
sequential_encoder <- function() {
  i <- 0
  function() {
    i <<- i + 1
    paste0("ID", i)
  }
}

random_encoder <- function() paste0("X", sample(1000, 1))
collision_encoder <- function() "SAME" # always returns same value

test_that("initialize sets fields correctly", {
  m <- ConsistentMapper$new(encoder = random_encoder, max_values = 100)
  expect_equal(m$max_values, 100)
  expect_true(is.function(m$encoder))
  expect_equal(length(m$cache), 0)
  expect_equal(length(m$used), 0)
})

test_that("learn maps new values into cache", {
  m <- ConsistentMapper$new(encoder = sequential_encoder(), max_values = 100)
  m$learn(c("a", "b", "c"))
  expect_equal(length(m$cache), 3)
  expect_true(all(c("a", "b", "c") %in% names(m$cache)))
})

test_that("learn is idempotent - re-learning same values doesn't change cache", {
  m <- ConsistentMapper$new(encoder = sequential_encoder(), max_values = 100)
  m$learn(c("a", "b"))
  cache_before <- m$cache
  m$learn(c("a", "b"))
  expect_equal(m$cache, cache_before)
})

test_that("learn accumulates across multiple calls", {
  m <- ConsistentMapper$new(encoder = sequential_encoder(), max_values = 100)
  m$learn("a")
  m$learn("b")
  expect_equal(length(m$cache), 2)
})

test_that("transform returns consistent values", {
  m <- ConsistentMapper$new(encoder = sequential_encoder(), max_values = 100)
  m$learn(c("cat", "dog"))
  first <- m$transform(c("cat", "dog"))
  second <- m$transform(c("cat", "dog"))
  expect_equal(first, second)
})

test_that("transform preserves order", {
  m <- ConsistentMapper$new(encoder = sequential_encoder(), max_values = 100)
  m$learn(c("a", "b", "c"))
  result <- m$transform(c("c", "a", "b"))
  expect_equal(result, unlist(m$cache[c("c", "a", "b")], use.names = FALSE))
})

test_that("encoded values are unique across different keys", {
  m <- ConsistentMapper$new(encoder = sequential_encoder(), max_values = 100)
  m$learn(c("a", "b", "c", "d", "e"))
  vals <- unname(unlist(m$cache))
  expect_equal(length(vals), length(unique(vals)))
})

test_that("learn errors when max_values exceeded", {
  m <- ConsistentMapper$new(encoder = sequential_encoder(), max_values = 3)
  expect_error(m$learn(c("a", "b", "c", "d")), "max_values")
})


test_that("learn warns when cache exceeds 50% of max_values", {
  m <- ConsistentMapper$new(encoder = sequential_encoder(), max_values = 10)
  expect_warning(m$learn(c("a", "b", "c", "d", "e", "f")), "half of `max_values`")
})

test_that("learn warns after many iterations with collision-prone encoder", {
  m <- ConsistentMapper$new(encoder = collision_encoder, max_values = 100)

  expect_warning(
    tryCatch(
      m$learn(c("a", "b")),
      iteration_warning = function(w) rlang::warn(w$message, class = class(w))
    ),
    "struggling"
  )
})
