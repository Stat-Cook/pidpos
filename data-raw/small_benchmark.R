library(tidyverse)
library(httr2)
library(jsonlite)

url <- "https://raw.githubusercontent.com/microsoft/presidio-research/master/data/synth_dataset_v2.json"

response <- request(url) |>
  req_perform()

data <- response |>
  resp_body_string() |>
  fromJSON()

presidio_text <- tibble::tibble(
  Document = data$full_text,
  `Doc ID` = seq_along(data$full_text),
  Template = data$template_id
)

usethis::use_data(presidio_text, overwrite = TRUE)

presidio_tags <- data$spans %>%
  setNames(., seq_along(.)) |>
  purrr::imap(
    ~ mutate(.x, `Doc ID` = .y)
  )|>
  bind_rows()

usethis::use_data(presidio_tags, overwrite = TRUE)


