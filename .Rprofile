# comment comment comment
local({
  r <- getOption("repos")
  r <- r[!names(r) %in% c("RSPM", "CRAN")]
  on_mac <- Sys.info()[["sysname"]] == "Darwin"
  r <- c(
    if (!on_mac) RSPM = "https://packagemanager.posit.co/all/__linux__/noble/latest",
    CRAN = "https://cran.rstudio.com/",
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

})
