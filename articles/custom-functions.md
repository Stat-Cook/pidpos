# Using custom functions in \`pidpos\`

Out of the box,
[`pidpos()`](https://stat-cook.github.io/pidpos/reference/pidpos.md)
relies on the `udpipe` package to perform part-of-speech (POS)
tagging.  
However, the `pidpos` API is intentionally flexible and allows users to:

- Supply their own custom POS tagging functions
- Implement custom filtering logic
- Integrate alternative tagging engines (e.g., Python libraries)

This vignette demonstrates each of these extensions.

A custom tagger must:

- Accept a single character string (a sentence)
- Return a data frame with one row per token

A custom filter must:

- Accept the tagger’s returned data frame
- Return a filtered version of that data frame

We begin by loading the package:

``` r

library(pidpos)
```

We will use the example dataset:

``` r

example.data <- head(the_one_in_massapequa, 20)
example.data
#> # A tibble: 20 × 4
#>    scene utterance speaker          text                                        
#>    <int>     <int> <chr>            <chr>                                       
#>  1     1         1 Scene Directions "[Scene: Central Perk, everyone is there.]" 
#>  2     1         2 Phoebe Buffay    "Oh, Ross, Mon, is it okay if I bring someo…
#>  3     1         3 Monica Geller    "Yeah."                                     
#>  4     1         4 Ross Geller      "Sure. Yeah."                               
#>  5     1         5 Joey Tribbiani   "So, who's the guy?"                        
#>  6     1         6 Phoebe Buffay    "Well, his name is Parker and I met him at …
#>  7     1         7 Chandler Bing    "Oooh, did he put a little starch in your b…
#>  8     1         8 Phoebe Buffay    "Yeah, he's really great though. He has thi…
#>  9     1         9 Monica Geller    "Oh, by the way. Would it be okay if I gave…
#> 10     1        10 Ross Geller      "Uh, yeah, you sure you want to after what …
#> 11     1        11 Monica Geller    "Yeah, I'd really like to."                 
#> 12     1        12 Ross Geller      "Okay, hopefully this time mom won't boo yo…
#> 13     1        13 Monica Geller    "Yes! Every year Ross makes the toast, and …
#> 14     1        14 Chandler Bing    "And you wonder why Ross is their favorite?"
#> 15     1        15 Monica Geller    "No! Really! Any time Ross makes a toast ev…
#> 16     1        16 Joey Tribbiani   "Well I can promise you, at least one perso…
#> 17     1        17 Monica Geller    "Really you can do that?"                   
#> 18     1        18 Joey Tribbiani   "Are you kidding me? Watch! Well I can't do…
#> 19     2         1 Scene Directions "[Scene: Chandler and Monica's, they're get…
#> 20     2         2 Chandler Bing    "What are you doing?"
```

------------------------------------------------------------------------

## Custom POS Tagging Functions

As a minimal example, suppose we want to tag only the main characters
from *Friends* as proper nouns.

``` r

friends <- c("Joey", "Phoebe", "Ross", "Chandler", "Monica", "Rachel")
```

We define a sentence-level tagging function:

``` r

sentence_tagger <- function(sentence) {
  clean_text <- gsub("[[:punct:]]", "", sentence)
  tokens <- strsplit(clean_text, "\\s+")[[1]]
  tokens <- tokens[tokens != ""]

  tibble::tibble(
    Token = tokens,
    POS = ifelse(tokens %in% friends, "PROPN", "XXX")
  )
}

sentence_tagger("Joey sat in Central Perk")
#> # A tibble: 5 × 2
#>   Token   POS  
#>   <chr>   <chr>
#> 1 Joey    PROPN
#> 2 sat     XXX  
#> 3 in      XXX  
#> 4 Central XXX  
#> 5 Perk    XXX
```

To use this with
[`pidpos()`](https://stat-cook.github.io/pidpos/reference/pidpos.md), we
wrap it with
[`custom_tagger()`](https://stat-cook.github.io/pidpos/reference/custom_tagger.md):

``` r

friends_tagger <- custom_tagger(sentence_tagger)

friends_tagger(example.data$text)
#> # A tibble: 263 × 4
#>    Token    POS      ID Sentence                                                
#>    <chr>    <chr> <int> <chr>                                                   
#>  1 Scene    XXX       1 [Scene: Central Perk, everyone is there.]               
#>  2 Central  XXX       1 [Scene: Central Perk, everyone is there.]               
#>  3 Perk     XXX       1 [Scene: Central Perk, everyone is there.]               
#>  4 everyone XXX       1 [Scene: Central Perk, everyone is there.]               
#>  5 is       XXX       1 [Scene: Central Perk, everyone is there.]               
#>  6 there    XXX       1 [Scene: Central Perk, everyone is there.]               
#>  7 Oh       XXX       2 Oh, Ross, Mon, is it okay if I bring someone to your pa…
#>  8 Ross     PROPN     2 Oh, Ross, Mon, is it okay if I bring someone to your pa…
#>  9 Mon      XXX       2 Oh, Ross, Mon, is it okay if I bring someone to your pa…
#> 10 is       XXX       2 Oh, Ross, Mon, is it okay if I bring someone to your pa…
#> # ℹ 253 more rows
```

We can now supply it to
[`pidpos()`](https://stat-cook.github.io/pidpos/reference/pidpos.md):

``` r

result <- pidpos(example.data, tagger = friends_tagger)
result
#> # A tibble: 10 × 6
#>    ID                Token    Sentence       Document Repeats `Affected Columns`
#>  * <glue>            <chr>    <chr>          <chr>      <int> <chr>             
#>  1 Col:speaker Row:2 Phoebe   "Phoebe Buffa… "Phoebe…       3 `speaker`         
#>  2 Col:text Row:2    Ross     "Oh, Ross, Mo… "Oh, Ro…       1 `text`            
#>  3 Col:speaker Row:3 Monica   "Monica Gelle… "Monica…       6 `speaker`         
#>  4 Col:speaker Row:4 Ross     "Ross Geller"  "Ross G…       3 `speaker`         
#>  5 Col:speaker Row:5 Joey     "Joey Tribbia… "Joey T…       3 `speaker`         
#>  6 Col:speaker Row:7 Chandler "Chandler Bin… "Chandl…       3 `speaker`         
#>  7 Col:text Row:13   Ross     "Yes! Every y… "Yes! E…       1 `text`            
#>  8 Col:text Row:14   Ross     "And you wond… "And yo…       1 `text`            
#>  9 Col:text Row:15   Ross     "No! Really! … "No! Re…       1 `text`            
#> 10 Col:text Row:19   Chandler "[Scene: Chan… "[Scene…       1 `text`
```

------------------------------------------------------------------------

## Custom Filtering Functions

The default `filter_to_proper_noun()` assumes:

1.  Proper nouns are labeled `"PROPN"`
2.  The POS column is named `"upos"`

If your tagger uses different conventions, you must supply a custom
filter.

For example, suppose:

- Proper nouns are labeled `"NNP"`
- The POS column is named `"POS"`

We define:

``` r

custom_filter <- function(tag_frm) {
  dplyr::filter(tag_frm, POS == "NNP")
}
```

And a compatible tagger:

``` r

friends_tagger2 <- custom_tagger(function(sentence) {
  if (is.na(sentence)) {
    return(tibble::tibble(Token = character(), POS = character()))
  }

  clean_text <- gsub("[[:punct:]]", "", sentence)
  tokens <- strsplit(clean_text, "\\s+")[[1]]
  tokens <- tokens[tokens != ""]

  tibble::tibble(
    Token = tokens,
    POS = ifelse(tokens %in% friends, "NNP", "XXX")
  )
})
```

Now use both:

``` r

pidpos(
  example.data,
  tagger = friends_tagger2,
  filter_func = custom_filter
)
#> # A tibble: 10 × 7
#>    Token    POS   ID                Sentence Document Repeats `Affected Columns`
#>  * <chr>    <chr> <glue>            <chr>    <chr>      <int> <chr>             
#>  1 Phoebe   NNP   Col:speaker Row:2 "Phoebe… "Phoebe…       3 `speaker`         
#>  2 Ross     NNP   Col:text Row:2    "Oh, Ro… "Oh, Ro…       1 `text`            
#>  3 Monica   NNP   Col:speaker Row:3 "Monica… "Monica…       6 `speaker`         
#>  4 Ross     NNP   Col:speaker Row:4 "Ross G… "Ross G…       3 `speaker`         
#>  5 Joey     NNP   Col:speaker Row:5 "Joey T… "Joey T…       3 `speaker`         
#>  6 Chandler NNP   Col:speaker Row:7 "Chandl… "Chandl…       3 `speaker`         
#>  7 Ross     NNP   Col:text Row:13   "Yes! E… "Yes! E…       1 `text`            
#>  8 Ross     NNP   Col:text Row:14   "And yo… "And yo…       1 `text`            
#>  9 Ross     NNP   Col:text Row:15   "No! Re… "No! Re…       1 `text`            
#> 10 Chandler NNP   Col:text Row:19   "[Scene… "[Scene…       1 `text`
```

------------------------------------------------------------------------

## Using Other Tagging Frameworks (Python Example)

The tagging engine can also be replaced entirely. For example, Python’s
`nltk` library provides POS tagging functionality.

The following Python function (included in the package as
`nltk_function.py`) defines a simple wrapper:

``` python
from nltk.tokenize import word_tokenize
from nltk.tag import pos_tag

def nltk_pos_tagger(sentence):
    tokens = word_tokenize(sentence)
    return pos_tag(tokens)
```

We can bridge this into R using `reticulate` (see [this
vignette](https://cran.r-project.org/web/packages/reticulate/vignettes/calling_python.html)
for an intro to using `reticulate`).

> **Note:** This section requires a working Python installation and the
> `nltk` module.  
> If these are not available, the code below will be skipped.

``` r

reticulate::use_virtualenv("YOUR ENVIRONMENT", required = TRUE)

if (!reticulate::py_module_available("nltk")) {
  reticulate::py_install("nltk", pip = TRUE)
}
```

``` r

nltk_tagger <- custom_tagger(function(sentence) {
  tagged <- nltk_pos_tagger(sentence)

  tagged_frm <- tibble::as_tibble(
    do.call(rbind, tagged),
    .name_repair = "minimal"
  )

  colnames(tagged_frm) <- c("Token", "POS")

  dplyr::mutate(
    tagged_frm,
    dplyr::across(dplyr::everything(), as.character)
  )
})

nltk_filter <- function(frm) {
  dplyr::filter(frm, POS %in% c("NNP", "NNPS"))
}

pidpos(
  example.data,
  tagger = nltk_tagger,
  filter_function = nltk_filter
)
```

------------------------------------------------------------------------

## Custom replacement functions

The preceding examples demonstrate custom taggers and filters. Once PID
detection is complete, users may also wish to supply a custom
replacement function for the redaction step.

Replacements are applied via
[`auto_replace()`](https://stat-cook.github.io/pidpos/reference/auto_replace.md),
which accepts a user-defined function through the `replacement_func`
argument:

``` r

simple_replace <- function(x) {
  "XXX"
}

auto_replace(raw_redaction_rules, replacement_func = simple_replace)
#> # A tibble: 10 × 3
#>    If                                                                From  To   
#>    <chr>                                                             <chr> <chr>
#>  1 "[Scene: Central Perk, everyone is there.]"                       Cent… XXX  
#>  2 "[Scene: Central Perk, everyone is there.]"                       Perk  XXX  
#>  3 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Ross  XXX  
#>  4 "Oh, Ross, Mon, is it okay if I bring someone to your parent's a… Mon   XXX  
#>  5 "Well, his name is Parker and I met him at the drycleaners."      Park… XXX  
#>  6 "Every year Ross makes the toast, and it's always really moving,… Ross  XXX  
#>  7 "And you wonder why Ross is their favorite?"                      Ross  XXX  
#>  8 "Any time Ross makes a toast everyone cries, and hugs him, and p… Ross  XXX  
#>  9 "[Scene: Chandler and Monica's, they're getting ready to leave f… Chan… XXX  
#> 10 "[Scene: Chandler and Monica's, they're getting ready to leave f… Moni… XXX
```

Users requiring more control can leverage the memoization framework
built into `pidpos`. This requires first defining a zero-argument
function that generates a candidate replacement string:

``` r

custom_replace_candidate <- function() {
  sample(letters, 1)
}
```

*Note*: letters contains 26 elements, so this encoder can produce at
most 26 distinct replacements.

This function can then be passed to
[`make_replacement_function()`](https://stat-cook.github.io/pidpos/reference/make_replacement_function.md),
which returns a stateful replacement function — the same pattern used
internally by
[`make_random_replacement()`](https://stat-cook.github.io/pidpos/reference/make_random_replacement.md):

``` r

custom_replacer <- make_replacement_function(custom_replace_candidate, 26)

auto_replace(head(raw_redaction_rules), replacement_func = custom_replacer)
#> # A tibble: 6 × 3
#>   If                                                                 From  To   
#>   <chr>                                                              <chr> <chr>
#> 1 [Scene: Central Perk, everyone is there.]                          Cent… m    
#> 2 [Scene: Central Perk, everyone is there.]                          Perk  m    
#> 3 Oh, Ross, Mon, is it okay if I bring someone to your parent's ann… Ross  m    
#> 4 Oh, Ross, Mon, is it okay if I bring someone to your parent's ann… Mon   m    
#> 5 Well, his name is Parker and I met him at the drycleaners.         Park… m    
#> 6 Every year Ross makes the toast, and it's always really moving, a… Ross  m
```

------------------------------------------------------------------------

## Summary

The [`pidpos()`](https://stat-cook.github.io/pidpos/reference/pidpos.md)
API separates:

- **Tagging logic**
- **Filtering logic**

This design allows users to:

- Implement lightweight dictionary-based taggers
- Swap in alternative POS frameworks
- Integrate external engines such as Python libraries
- Customize filtering criteria without modifying tagging code

By adhering to the simple contract:

- Taggers return a token-level data frame
- Filters return a subset of that data frame

[`pidpos()`](https://stat-cook.github.io/pidpos/reference/pidpos.md) can
operate with virtually any POS tagging system.
