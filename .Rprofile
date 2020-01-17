local({
  r         <- getOption("repos")
  r["CRAN"] <- "https://cran.rstudio.com/"
  auth      <- paste('person("Zhian N.", "Kamvar",', 
                     'email = "zkamvar@gmail.com",', 
                     'role = c("aut", "cre"),',
                     'comment = c(ORCID = "0000-0003-1458-7108"))'
                     )
  me       <- eval(parse(text = paste0('utils::', auth)))
  my_name  <- format(me, c('given', 'family'))
  my_email <- format(me, c('email'), braces = list(email = ''))
  desc     <- list(`Authors@R` = auth,
                   License     = "MIT + file LICENSE",
                   Version     = "0.0.0.9000"
                   )
  # Setting options ------------------------------------------------------------
  options(repos                   = r)
  options(editor                  = "vim")

  options(usethis.full_name       = my_name)
  options(usethis.description     = desc)
  options(usethis.protocol        = "ssh")

  options(blogdown.author         = my_name)
  options(blogdown.subdir         = "post")
  options(blogdown.new_bundle     = TRUE)

  # https://github.com/randy3k/radian
  options(radian.editing_mode     = "vi")
  options(radian.auto_indentation = TRUE)
  options(radian.insert_new_line  = FALSE)
  options(radian.color_scheme     = "bw")
  options(radian.tab_size         = 2)
  # Blue arrow for R prompt
  options(radian.prompt           = "\033[0;34m>\033[0m ")
  # Blood money for shell prompt
  options(radian.shell_prompt     = "\033[0;31m$\033[0m ")

  # Checking CRAN package status -----------------------------------------------
  if (interactive()) {
    # based off of BrodieG's tinyverse version, but the notification has gotten
    # a bit noisy and cchecks seems to be fairly stable
    # 
    # I've also made some modifications to cache based on email, not just
    # assuming that it's one person.
    #
    # For posterity, here's the original function:
    # https://gist.github.com/brodieG/e60c94d4036f45018530ea504258bcf3
    .check_cran <- function(email      = my_email,
                            cache      = '~/.%s-R-cran-status.RDS',
                            cache.life = 24 * 3600
                           ) {

      cache_pat   <- cache
      cache       <- sprintf(cache, email)
      renew.cache <- TRUE

      display_check <- function(x, extra=NULL) {
        pkgs    <- format(c('package', x$data$table$package))
        package <- pkgs[1]
        pkgs    <- pkgs[-1]
        oops    <- x$data$table$any

        err <- x$data$table$error
        wrn <- x$data$table$warn
        nte <- x$data$table$note
        iss <- x$data$table$issues

        fe <- function(i) format(i, width = nchar("errors"))
        fw <- function(i) format(i, width = nchar("warnings"))
        fn <- function(i) format(i, width = nchar("notes"))
        fi <- function(i) paste("    ", i)

        # Display the time of the update
        tim <- as.character(parsedate::parse_iso_8601(x$data$date_updated))
        cat(crayon::silver(sprintf("CRAN status updated: %s\n", tim)))

        cat(crayon::silver$bold$underline(package), 
            crayon::cyan$bold$underline$blurred("notes"),  
            crayon::yellow$bold$underline$blurred("warnings"),
            crayon::red$bold$underline$blurred("errors"),
            crayon::silver$bold$underline$blurred("issues"),
            "\n",
            sep = crayon::silver$underline(" ")
           )
        # This needs to be a for loop because we can't print the decorated
        # output as a data frame or it will show all the escape values.
        for (i in seq_along(pkgs)) {
          ii <- iss[i]
          e <- err[i]
          w <- wrn[i]
          n <- nte[i]
          p <- pkgs[i]

          # tallying errors
          ee <- e > 0
          we <- w > 0
          ne <- n > 0

          # formatting
          n <- fn(n)
          w <- fw(w)
          e <- fe(e)
          if (ii) {
            ip <- crayon::red(fi("⚠"))
          } else {
            ip <- crayon::silver(fi("✔"))
          }
          if (oops[i]) {
            e <- if (ee > 0) crayon::red$bold(e)    else e
            w <- if (we > 0) crayon::yellow(w)      else w
            n <- if (ne > 0) crayon::cyan(n)        else n
            p <- if (ee || ii) crayon::bold$italic$red(p) else if (we) crayon::bold(p) else crayon::bold$silver(p)
          } else {
            p <- if (ii) crayon::bold$italic$red(p) else crayon::silver(p)
            e <- crayon::silver(e)
            w <- crayon::silver(w)
            n <- crayon::silver(n)
          }
          writeLines(paste(p, n, w, e, ip))
        }
        err.cols <- err > 0 | wrn > 0
        if (sum(as.numeric(err.cols), na.rm=TRUE)) {
          writeLines(c(crayon::bgRed("Issues/Errors/Warnings Present"), x$data$url))
        }
        writeLines(c(crayon::silver(extra, "")))
      }


      if (file.exists(cache)) {
        cache.dat <- readRDS(cache)
        cache.age <- Sys.time() - cache.dat[[1]]
        if (as.double(cache.age, 'secs') < cache.life) {
          renew.cache <- FALSE
          aged_cache  <- format(round(cache.age))
          res         <- cache.dat[[2]]
          display_check(res,
                        sprintf("\ncached CRAN status (%s old).", aged_cache) 
                       ) 
        } 
      }

      if (renew.cache) {
        cat("connecting to CRAN...\n")
        res <- cchecks::cch_maintainers(sub("@", "_at_", email))
        pkgs <- res$data$packages$package
        full <- cchecks::cch_pkgs(pkgs, limit = length(pkgs))
        names(full) <- pkgs
        iss <- lapply(full, "[[", c("data", "check_details", "additional_issues"))
        iss <- vapply(iss, function(.x) length(.x) > 0, logical(1))
        res$data$table$issues <- iss
        saveRDS(list(time = Sys.time(), summary = res, full = full), cache)
        display_check(res)
      }
      return(invisible(res))
    }

    # Display the header at startup --------------------------------------------
    cat("Default R library:", crayon::green(.libPaths()[1]), "\n")
    .check_cran(my_email)
    assign('.check_cran', .check_cran, env = .GlobalEnv)

    # Unload all the packages that were needed to display the header -----------
    #
    # This is necessary to provide a clean as possible environment
    to_unload <- c("crayon", 
                   "cchecks", 
                   "parsedate", 
                   "jsonlite",
                   "crul", 
                   "httpcode", 
                   "curl", 
                   "rematch2",
                   "tibble", 
                   "pkgconfig", 
                   "pillar", 
                   "rlang", 
                   "R6",
                   "urltools",
                   "triebeard",
                   "Rcpp",
                   NULL)
    for (package in to_unload) {
      unloadNamespace(asNamespace(package))
    }
    
  }
})
