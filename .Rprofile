# comment comment comment
local({
  r <- getOption("repos")
  r <- r[!names(r) %in% c("RSPM", "CRAN")]
  on_mac <- Sys.info()[["sysname"]] == "Darwin"
  r <- c(
    if (!on_mac) RSPM = "https://packagemanager.posit.co/all/__linux__/focal/latest",
    CRAN = "https://cran.rstudio.com/",
    carpentries = "https://carpentries.r-universe.dev",
    r)
  # Set the default HTTP user agent
  HUA = sprintf("R/%s R (%s)", 
    getRversion(), 
    paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])
  )
  auth <- paste(
    'person("Zhian N.", "Kamvar",', 
    'email = "zkamvar@gmail.com",', 
    'role = c("aut", "cre"),',
    'comment = c(ORCID = "0000-0003-1458-7108"))'
  )
  # Github Personal Access Token. Download the token into a plaintext file
  # called ~/.github_pat and set the permissions to read only by your user
  # fs::file_chmod("~/.github_pat", "600")
  if (file.exists("~/.github_pat")) {
    Sys.setenv(GITHUB_PAT = readLines("~/.github_pat")[[1]])
  }
  me       <- eval(parse(text = paste0('utils::', auth)))
  my_name  <- format(me, c('given', 'family'))
  my_email <- format(me, c('email'), braces = list(email = ''))
  desc     <- list(
    `Authors@R` = auth,
    License     = "MIT + file LICENSE",
    Version     = "0.0.0.9000"
  )
  # Setting options ------------------------------------------------------------
  options(repos         = r)
  options(HTTPUserAgent = HUA)
  options(editor        = "nvim")

  options(reprex.html_preview = FALSE)

  options(usethis.full_name   = my_name)
  options(usethis.description = desc)
  options(usethis.protocol    = "https")

  options(testthat.progress.max_fails = Inf)

  options(blogdown.author     = my_name)
  options(blogdown.subdir     = "post")
  options(blogdown.new_bundle = TRUE)

  # Checking CRAN package status -----------------------------------------------
  #if (interactive()) {
  #  # based off of BrodieG's tinyverse version, but the notification has gotten
  #  # a bit noisy and cchecks seems to be fairly stable
  #  # 
  #  # I've also made some modifications to cache based on email, not just
  #  # assuming that it's one person.
  #  #
  #  # For posterity, here's the original function:
  #  # https://gist.github.com/brodieG/e60c94d4036f45018530ea504258bcf3
  #  display_check <- function(x, extra=NULL) {
  #    pkgs    <- format(c('package', x$data$table$package))
  #    package <- pkgs[1]
  #    pkgs    <- pkgs[-1]
  #    oops    <- x$data$table$any

  #    err <- x$data$table$error
  #    wrn <- x$data$table$warn
  #    nte <- x$data$table$note
  #    iss <- x$data$table$issues

  #    fe <- function(i) format(i, width = nchar("errors"))
  #    fw <- function(i) format(i, width = nchar("warnings"))
  #    fn <- function(i) format(i, width = nchar("notes"))
  #    fi <- function(i) paste("    ", i)

  #    # Display the time of the update
  #    tim <- as.character(parsedate::parse_iso_8601(x$data$date_updated))
  #    cat(crayon::silver(sprintf("CRAN status updated: %s\n", tim)))

  #    cat(
  #      crayon::silver$bold$underline(package), 
  #      crayon::cyan$bold$underline$blurred("notes"),  
  #      crayon::yellow$bold$underline$blurred("warnings"),
  #      crayon::red$bold$underline$blurred("errors"),
  #      crayon::silver$bold$underline$blurred("issues"),
  #      "\n",
  #      sep = crayon::silver$underline(" ")
  #    )
  #    # This needs to be a for loop because we can't print the decorated
  #    # output as a data frame or it will show all the escape values.
  #    for (i in seq_along(pkgs)) {
  #      ii <- iss[i]
  #      e <- err[i]
  #      w <- wrn[i]
  #      n <- nte[i]
  #      p <- pkgs[i]

  #      # tallying errors
  #      ee <- e > 0
  #      we <- w > 0
  #      ne <- n > 0

  #      # formatting
  #      n <- fn(n)
  #      w <- fw(w)
  #      e <- fe(e)
  #      if (ii) {
  #        ip <- crayon::red(fi("🔥"))
  #      } else {
  #        ip <- crayon::silver(fi("✔"))
  #      }
  #      if (oops[i]) {
  #        e <- if (ee > 0) crayon::red$bold(e)    else e
  #        w <- if (we > 0) crayon::yellow(w)      else w
  #        n <- if (ne > 0) crayon::cyan(n)        else n
  #        p <- if (ee || ii) crayon::bold$italic$red(p) else if (we) crayon::bold(p) else crayon::bold$silver(p)
  #      } else {
  #        p <- if (ii) crayon::bold$italic$red(p) else crayon::silver(p)
  #        e <- crayon::silver(e)
  #        w <- crayon::silver(w)
  #        n <- crayon::silver(n)
  #      }
  #      writeLines(paste(p, n, w, e, ip))
  #    }
  #    err.cols <- err > 0 | wrn > 0
  #    if (sum(as.numeric(err.cols), na.rm=TRUE)) {
  #      writeLines(c(crayon::bgRed("Issues/Errors/Warnings Present"), x$data$url))
  #    }
  #    writeLines(c(crayon::silver(extra, "")))
  #  }

  #  print.crnchk <- function(x, cache.life = 24 * 3600, ...) {
  #    cache.age <- Sys.time() - x[[1]]
  #    cage      <- as.double(cache.age, 'secs')

  #    if (cage > 1 && cage < cache.life) {
  #      extra <- sprintf(
  #        "\ncached CRAN status (%s old).", 
  #        format(round(cache.age))
  #      )
  #    } else {
  #      extra <- NULL
  #    }

  #    res <- x[[2]]
  #    display_check(res, extra)
  #  }

  #  .check_cran <- function(email      = my_email,
  #                          cache      = '~/.%s-R-cran-status.RDS',
  #                          cache.life = 24 * 3600
  #                         ) {

  #    cache_pat   <- cache
  #    cache       <- sprintf(cache, email)
  #    renew.cache <- TRUE

  #    if (file.exists(cache)) {
  #      cache.dat <- readRDS(cache)
  #      cache.age <- Sys.time() - cache.dat[[1]]
  #      renew.cache <- as.double(cache.age, 'secs') > cache.life
  #    }

  #    if (renew.cache) {
  #      cat("connecting to CRAN...\n")
  #      res <- cchecks::cch_maintainers(sub("@", "_at_", email))
  #      pkgs <- res$data$packages$package
  #      full <- cchecks::cch_pkgs(pkgs, limit = length(pkgs))
  #      names(full) <- pkgs
  #      iss <- lapply(full, "[[", c("data", "check_details", "additional_issues"))
  #      iss <- vapply(iss, function(.x) length(.x) > 0, logical(1))
  #      res$data$table$issues <- iss
  #      cache.dat <- list(time = Sys.time(), summary = res, full = full)
  #      saveRDS(cache.dat, cache)
  #    }
  #    class(cache.dat) <- "crnchk"
  #    return(invisible(cache.dat))
  #  }

  #  # Display the header at startup --------------------------------------------
  #  # cat("Default R library:", crayon::green(.libPaths()[1]), "\n")
  #  # callr::r(.check_cran, args = list(email = my_email)) -> res
  #  # print(res)
  #  assign('.check_cran', .check_cran, env = .GlobalEnv)
  #  assign('print.crnchk', print.crnchk, env = .GlobalEnv)

  #  # Unload all the packages that were needed to display the header -----------
  #  #
  #  # This is necessary to provide a clean as possible environment
  #  # to_unload <- c(
  #  #   "crayon", 
  #  #   "cchecks", 
  #  #   "parsedate", 
  #  #   "jsonlite",
  #  #   "crul", 
  #  #   "httpcode", 
  #  #   "curl", 
  #  #   "rematch2",
  #  #   "tibble", 
  #  #   "pkgconfig", 
  #  #   "pillar", 
  #  #   "callr",
  #  #   "processx",
  #  #   "ps",
  #  #   "rlang", 
  #  #   "R6",
  #  #   NULL
  #  # )
  #  # for (package in to_unload) {
  #  #   unloadNamespace(asNamespace(package))
  #  # }
    
  #}
})
