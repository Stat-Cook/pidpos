test_that(
  "make and merge replacements workflow",
  withr::with_options(list(pidpos_download_approved = TRUE), {
    report <- pidpos(the_one_in_massapequa)

    .rules <- report_to_redaction_rules(report)

    .replacer <- make_random_replacement()

    .rules.replaced <- auto_replace(.rules, .replacer)

    redactions <- parse_redacter(.rules.replaced)

    .new <- the_one_in_massapequa |>
      mutate(across(where(is.character), ~ redactions(.x)))

    expect_true(any(.new$speaker != the_one_in_massapequa$speaker))
  })
)
