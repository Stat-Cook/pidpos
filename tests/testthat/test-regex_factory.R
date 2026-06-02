test_that("regex_factory requires a data frame with type and pattern columns", {
  expect_error(
    regex_factory(list()),
    "`patterns` must be a data frame with columns `type` and `pattern`"
  )
  
  expect_error(
    regex_factory(data.frame(foo = "x", bar = "y")),
    "`patterns` must be a data frame with columns `type` and `pattern`"
  )
})

test_that("regex_factory requires character type and pattern columns", {
  patterns <- tibble::tibble(
    type = 1,
    pattern = "abc"
  )
  
  expect_error(
    regex_factory(patterns),
    "Columns `type` and `pattern` must both be character vectors"
  )
})

test_that("regex_factory rejects missing or empty types", {
  expect_error(
    regex_factory(
      tibble::tibble(
        type = c("email", ""),
        pattern = c("a", "b")
      )
    ),
    "All values in `type` must be non-empty strings"
  )
  
  expect_error(
    regex_factory(
      tibble::tibble(
        type = c("email", NA_character_),
        pattern = c("a", "b")
      )
    ),
    "All values in `type` must be non-empty strings"
  )
})

test_that("regex_factory rejects invalid regex patterns", {
  patterns <- tibble::tibble(
    type = "bad",
    pattern = "("
  )
  
  expect_error(
    suppressWarnings(regex_factory(patterns)),
    "failed to compile"
  )
})

test_that("detector requires non-empty character docs", {
  detector <- regex_factory(
    tibble::tibble(
      type = "email",
      pattern = "@"
    )
  )
  
  expect_error(
    detector(1),
    "`docs` must be a non-empty character vector"
  )
  
  expect_error(
    detector(character()),
    "`docs` must be a non-empty character vector"
  )
})

test_that("detector finds matches and returns expected columns", {
  detector <- regex_factory(
    tibble::tibble(
      type = "email",
      pattern = "[[:alnum:]._%+-]+@[[:alnum:].-]+"
    )
  )
  
  result <- detector(
    "Contact me at test@example.com",
    doc_ids = "doc1"
  )
  
  expect_s3_class(result, "data.frame")
  
  expect_named(
    result,
    c(
      "ID",
      "Token",
      "POS",
      "StartIndex",
      "EndIndex",
      "Sentence"
    )
  )
  
  expect_equal(result$ID, "doc1")
  expect_equal(result$Token, "test@example.com")
  expect_equal(result$POS, "email")
  expect_equal(result$Sentence, "Contact me at test@example.com")
})

test_that("detector returns multiple matches in a document", {
  detector <- regex_factory(
    tibble::tibble(
      type = "number",
      pattern = "\\d+"
    )
  )
  
  result <- detector(
    "123 abc 456",
    doc_ids = "doc1"
  )
  
  expect_equal(result$Token, c("123", "456"))
  expect_equal(nrow(result), 2)
})

test_that("detector processes multiple documents", {
  detector <- regex_factory(
    tibble::tibble(
      type = "number",
      pattern = "\\d+"
    )
  )
  
  result <- detector(
    c("abc 123", "def 456"),
    doc_ids = c("d1", "d2")
  )
  
  expect_equal(result$ID, c("d1", "d2"))
  expect_equal(result$Token, c("123", "456"))
})

test_that("detector returns empty typed tibble when no matches found", {
  detector <- regex_factory(
    tibble::tibble(
      type = "number",
      pattern = "\\d+"
    )
  )
  
  result <- detector(
    "no numbers here",
    doc_ids = "doc1"
  )
  
  expect_equal(nrow(result), 0)
  
  expect_named(
    result,
    c(
      "ID",
      "Token",
      "POS",
      "StartIndex",
      "EndIndex",
      "Sentence"
    )
  )
  
  expect_type(result$ID, "character")
  expect_type(result$StartIndex, "integer")
})

test_that("results are ordered by ID and StartIndex", {
  detector <- regex_factory(
    tibble::tibble(
      type = "number",
      pattern = "\\d+"
    )
  )
  
  result <- detector(
    c("999 aaa 111", "222"),
    doc_ids = c("b", "a")
  )
  
  expect_equal(result$ID, c("a", "b", "b"))
  expect_equal(result$Token, c("222", "999", "111"))
})


test_that("regex_factory catches email addresses", {
  detector <- regex_factory(pid_patterns)
  
  result <- detector(
    "Contact john.smith+test@example.co.uk",
    "doc1"
  )
  
  expect_true(any(result$POS == "email"))
  expect_true(any(result$Token == "john.smith+test@example.co.uk"))
})

test_that("regex_factory catches UK phone numbers", {
  detector <- regex_factory(pid_patterns)
  
  result <- detector(
    "Call me on +44 7700 900123",
    "doc1"
  )
  
  expect_true(any(result$POS == "phone"))
})

test_that("regex_factory catches IPv4 addresses", {
  detector <- regex_factory(pid_patterns)
  
  result <- detector(
    "Server IP is 192.168.1.1",
    "doc1"
  )
  
  expect_true(any(result$POS == "ip"))
  expect_true(any(result$Token == "192.168.1.1"))
})

test_that("regex_factory catches credit card numbers", {
  detector <- regex_factory(pid_patterns)
  
  result <- detector(
    "4111 1111 1111 1111",
    "doc1"
  )
  
  expect_true(any(result$POS == "card"))
})
