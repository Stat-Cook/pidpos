mock_tagger <- function(...) {
  data.frame(
    Token = "Token", Sentence = "Sentence", POS = "POS"
  )
}

mock_spacy_process <- function(.x, tagger) tagger(.x)

test_that("spacy_factory tests", {
  mockery::stub(spacy_factory, "check_reticulate", function(...) TRUE)
  mockery::stub(spacy_factory, "reticulate::use_condaenv", function(...) TRUE)
  mockery::stub(spacy_factory, "check_spacy", function(...) TRUE)

  mockery::stub(spacy_factory, "reticulate::import", function(...) TRUE)
  mockery::stub(spacy_factory, "spacy$load", function(.x) .x)
  mockery::stub(spacy_factory, "spacy_process", mock_spacy_process)

  spacy_tagger <- spacy_factory(mock_tagger)

  expect_true(is.function(spacy_tagger))

  short_test <- spacy_tagger("Bob")
  expect_s3_class(short_test, "data.frame")
  expect_equal(dim(short_test), c(1, 4))

  long_test <- spacy_tagger(letters)
  expect_s3_class(long_test, "data.frame")
  expect_equal(dim(long_test), c(26, 4))

  with_doc_id <- spacy_tagger("Bob", 10)
  expect_s3_class(with_doc_id, "data.frame")
  expect_equal(dim(with_doc_id), c(1, 4))
  expect_equal(with_doc_id$ID, 10)
})

test_that("spacy_process tests", {
  mock_tagger <- function(doc) {
    ents <- stringr::str_split(doc, "\\s+")[[1]]

    list(
      ents = map(ents, \(x) c(text = x, label_ = "PROPN"))
    )
  }

  short_test <- spacy_process("Bob", mock_tagger)
  expect_equal(dim(short_test), c(1, 3))

  long_test <- spacy_process("the first day of the week", mock_tagger)
  expect_equal(dim(long_test), c(6, 3))

  mock_null_tagger <- function(doc) list(ents = c())

  null_test <- spacy_process("Bob", mock_null_tagger)
  expect_equal(dim(null_test), c(1, 3))
  expect_true(is.na(null_test$Token))
})
