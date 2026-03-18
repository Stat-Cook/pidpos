#' @importFrom R6 R6Class
#' @importFrom purrr simplify
#' @importFrom glue glue
ConsistentMapper <- R6::R6Class(
  "ConsistentMapper",
  list(
    cache = list(),
    used = character(0),
    
    encoder = NA,
    max_values = NA,
    
    initialize = function(encoder, max_values) {
      self$encoder <- encoder
      self$max_values <- max_values
    },
    
    learn = function(x) {
      x.str <- as.character(x)

      to_learn <- setdiff(x, names(self$cache))
      if (length(to_learn) + length(self$cache) > self$max_values) {
        exceeded_max_error("`learn` step has exceeded `max_values`")
      }
      
      if (length(to_learn) + length(self$cache) > 0.5*self$max_values) {
        exceeded_half_max_warn("`learn` step has exceeded half of `max_values` - performance may suffer")
      }
      
      iter <- 1
      while (length(to_learn) > 0) {
        candidates <- replicate(length(to_learn), self$encoder())
        candidates <- setdiff(candidates, self$used)
        
        .names <- head(to_learn, length(candidates))
        candidates <- setNames(candidates, .names)
        
        self$cache <- append(self$cache, candidates)
        self$used <- append(self$used, unname(candidates))
        
        to_learn <- setdiff(to_learn, names(self$cache))
        iter <- iter + 1
        if (iter == 1000) iteration_warn(sprintf(
          "Random encoder is struggling to find unique candidates after %d iterations. %d/%d values mapped. Consider a larger encoding space.",
          iter, length(self$cache), self$max_values
        ))
      }
      invisible(self)
    },
    
    transform = function(x){
      x.str <- as.character(x)
      simplify(self$cache[x.str]) |> 
        unname()
    }
  )
)

#' @exportS3Method 
print.ConsistentMapper <- function(x, ...){
  used_cache <- length(x$cache)
  max_cache <- x$max_values
  cat(sprintf("ConsistentMapper<%s of %s values used>\n", used_cache, max_cache))
  invisible(x)
}


#' Wrapper for custom replacement functions
#' 
#' Convert a function for producing a random replacement into a `memoized` version.
#' The functionality automates reacalling of the function to avoid collision with existing
#' replacements, and can toggle between ...
#' 
#' @param encoder The function to wrap with signature `function()`
#' @param max_values The maximum number of replacements your encoder can produce
#' @param all Boolean flag.  If `TRUE` every key replaced gets its own value.  NB: 
#' at present this results in the key stored  having a number appended e.g. 
#' "bob" stored as "bob.1"  
#' @param elevate_warnings If true, cause warnings to raise as errors.
#' 
make_replacement_function <- function(encoder, max_values, 
                                      all=F, 
                                      elevate_warnings=FALSE){
  mapper <- ConsistentMapper$new(encoder, max_values)
  
  f <- function(x){
    x.str <- as.character(x)

    if (all) {
      .seq <- seq_along(x.str) + length(mapper$cache)
      x.str <- paste(x.str, .seq, sep=".")
    } 
    
    tryCatch(
      mapper$learn(x.str),
      exceed_half_max_warning = \(w) escalate(w, elevate_warnings),
      iteration_warning = \(w) escalate(w, elevate_warnings)
    )
    mapper$transform(x.str)
  }
  
  structure(
    f, 
    mapper = mapper,
    all=all,
    class = c("replacement_function", "function")
  )
}

#' @exportS3Method 
print.replacement_function <- function(x, ...) {
  cat(sprintf("replacement_function wrapping<All: %s>:\n  ", attr(x, "all")))
  print.ConsistentMapper(attr(x, "mapper"))
  invisible(x)
}





