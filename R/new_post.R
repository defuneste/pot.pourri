#' Create a directory with date_title and index.qmd
#'
#' Assumption run at the root of blog 
#' 
#' @param title a string, space will be converted to "_"
#'
#' @export
#'
#'@examples
#'\dontrun{
#' new_post("Boule et Bill")
#'}

new_post <- function(title, author = "default") {

  t <- tolower(gsub(" ", "_", title, fixed = TRUE))

  dir_path <- paste("posts",
                    paste(Sys.Date(), t, sep = "_"), 
                    sep = "/")
  # lazy
  system(sprintf("mkdir -p %s", dir_path))

  my_index_qmd <- paste(dir_path, "index.qmd", sep = "/")

  if (file.exists(my_index_qmd)) {

    stop(sprintf("%s exist!", my_index_qmd), call. = FALSE)

  } else {

    file.create(paste(dir_path, "index.qmd", sep = "/"))
    con <- file(my_index_qmd)
    writeLines(c("---",
                 sprintf("title: '%s'", title),
                 sprintf("author: '%s'", author),
                 "categories:",
                 "---"), con)
    close(con)

  }
}