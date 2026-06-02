test_that(
  "make and merge replacements workflow",
  withr::with_options(list(pidpos_download_approved = TRUE), {
    test_data <- select(the_one_in_massapequa, speaker) |>
      head()

    .rules <- data.frame(
      If = test_data$speaker,
      From = test_data$speaker,
      To = test_data$speaker
    )

    .replacer <- make_random_replacement()

    .rules.replaced <- auto_replace(.rules, .replacer)

    redactions <- parse_redacter(.rules.replaced)

    .new <- test_data |>
      mutate(across(where(is.character), ~ redactions(.x)))

    expect_true(any(.new$speaker != test_data$speaker))
  })
)
