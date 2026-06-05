library(pidpos)
library(tidyverse)
devtools::load_all()

combine_and_compare <- function(entities, candidates) {
  dplyr::full_join(entities, candidates, by = join_by(
    `Doc ID` == ID,
    overlaps(start_position, end_position, StartIndex, EndIndex)
  )) |> select(-Sentence)
}


pid_presido_tags <- filter(
  presidio_tags,
  str_detect(
    entity_type,
    "PERSON|GPE|STREET_ADDRESS|PHONE_NUMBER|EMAIL_ADDRESS|CREDIT_CARD"
  )
) |>
  mutate(`Doc ID` = as.character(`Doc ID`))

nrow(pid_presido_tags) / nrow(presidio_tags)

lg_tagger <- spacy_factory("en_core_web_lg")
trf_tagger <- spacy_factory("en_core_web_trf")

ewt_model <- udpipe::udpipe_load_model(
  "C:/Users/rzc1/AppData/Local/R/cache/R/pidpos/english-ewt-ud-2.5-191206.udpipe"
)
ewt_tagger <- udpipe_factory(ewt_model)
gum_model <- udpipe::udpipe_load_model(
  "C:/Users/rzc1/AppData/Local/R/cache/R/pidpos/english-gum-ud-2.5-191206.udpipe"
)
gum_tagger <- udpipe_factory(gum_model)
lines_model <- udpipe::udpipe_load_model(
  "C:/Users/rzc1/AppData/Local/R/cache/R/pidpos/english-lines-ud-2.5-191206.udpipe"
)
lines_tagger <- udpipe_factory(lines_model)

regex_tagger <- regex_factory()

taggers <- list(
  LG = lg_tagger,
  TRF = trf_tagger,
  EWT = ewt_tagger,
  GUM = gum_tagger,
  LINES = lines_tagger,
  Regex = regex_tagger
)

filters <- list(
  LG = \(.x) .x,
  TRF = \(.x) .x,
  EWT = \(.x) filter(.x, POS == "PROPN"),
  GUM = \(.x) filter(.x, POS == "PROPN"),
  LINES = \(.x) filter(.x, POS == "PROPN"),
  Regex = \(.x) filter(.x, str_detect(POS, "email|phone|postcode|card"))
)


merge_candidates <- function(existing, additional) {
  suggestions <- additional |>
    dplyr::select(ID, Sentence, POS, Token, StartIndex, EndIndex) |>
    rename_with(
      function(x) paste0("New", x),
      all_of(c("Token", "POS", "StartIndex", "EndIndex"))
    )

  joined <- full_join(
    existing,
    suggestions,
    by = join_by(ID, Sentence, overlaps(StartIndex, EndIndex, NewStartIndex, NewEndIndex))
  )

  new <- joined |>
    filter(is.na(Token), !is.na(NewToken)) |>
    select(-all_of(c("Token", "POS", "StartIndex", "EndIndex"))) |>
    rename_with(
      \(x) str_remove(x, "New"),
      all_of(c("NewToken", "NewPOS", "NewStartIndex", "NewEndIndex"))
    )


  list(existing, new) |>
    bind_rows()
}

ensemble_combine <- function(filtered, models) {
  reduce(filtered[models], merge_candidates)
}

#
baseline_tagged <- map(taggers,
  \(tagger) tagger(presidio_text$Document, presidio_text$`Doc ID`),
  .progress = T
)

baseline_filtered <- map2(baseline_tagged, filters, function(data, .f) .f(data))

baseline_filtered$Ensemble <- ensemble_combine(baseline_filtered, c("LG", "EWT", "Regex"))

baseline_comparison <- map(baseline_filtered, ~ combine_and_compare(pid_presido_tags, .x))

usethis::use_data(baseline_comparison, overwrite = T)


# preproccessed_docs <- gsub("[^a-zA-Z0-9 .,!?']", " ", presidio_text$Document)
preproccessed_docs <- gsub("[^\\p{L}\\p{N} .,!?'@]", " ", presidio_text$Document, perl = TRUE)

preproc_tagged <- map(taggers,
  \(tagger) tagger(preproccessed_docs, presidio_text$`Doc ID`),
  .progress = T
)

preproc_filtered <- map2(preproc_tagged, filters, function(data, .f) .f(data))

preproc_filtered$Ensemble <- ensemble_combine(preproc_filtered, c("LG", "EWT", "Regex"))

preprocessed_comparison <- map(preproc_filtered, ~ combine_and_compare(pid_presido_tags, .x))

usethis::use_data(preprocessed_comparison, overwrite = T)

lower_docs <- tolower(presidio_text$Document)

lower_tagged <- map(taggers,
  \(tagger) tagger(lower_docs, presidio_text$`Doc ID`),
  .progress = T
)

lower_filtered <- map2(lower_tagged, filters, function(data, .f) .f(data))

lower_filtered$Ensemble <- ensemble_combine(lower_filtered, c("LG", "EWT", "Regex"))

lower_comparison <- map(lower_filtered, ~ combine_and_compare(pid_presido_tags, .x))

usethis::use_data(lower_comparison, overwrite = T)

titlecase_docs <- tools::toTitleCase(lower_docs)

titlecase_tagged <- map(taggers,
  \(tagger) tagger(titlecase_docs, presidio_text$`Doc ID`),
  .progress = T
)

titlecase_filtered <- map2(titlecase_tagged, filters, function(data, .f) .f(data))

titlecase_filtered$Ensemble <- ensemble_combine(titlecase_filtered, c("LG", "EWT", "Regex"))

titlecase_comparison <- map(titlecase_filtered, ~ combine_and_compare(pid_presido_tags, .x))

usethis::use_data(titlecase_comparison, overwrite = T)


# ensemble_candidates <- list(
#   Baseline = baseline_tagged,
#   Preprocessed = preproc_tagged,
#   Lowered = lower_tagged,
#   Titlecase = titlecase_tagged
# ) |>
#   map(
#     function(tagged) tagged$LG |>
#       merge_candidates(filters$EWT(tagged$EWT)) |>
#       merge_candidates(filters$Regex(tagged$Regex))
#   )
#
# ensemble_comparison <- ensemble_candidates |>
#   map(~ combine_and_compare(pid_presido_tags, .x))
#
# ensemble_comparison |>
#   map(model_metrics)
#
# ensemble_comparison
#
# map(ensemble_comparison, model_metrics)
#
# usethis::use_data(ensemble_comparison, overwrite = T)
