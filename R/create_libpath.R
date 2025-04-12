#' Create a specific directory and set libpath here
#'
#' Assumption run at the root of the project and ask the user.
#' Inspired from awong234
#'
#' @param my_lib name of the dir were we want to store pkgs
#'
#' @importFrom utils menu
#' @importFrom usethis use_git_ignore
#' @export
#'

set_proj_libpath <- function(my_lib) {
  aws <- utils::menu(c("Yes", "No"),
                     title = "Setting .libPaths, should be at project root:")

  if (aws != 1) {
    message("exit!")
  } else {
    if (dir.exists(my_lib)) {
      # I could take the CLI dep. since usethis have it
      message(sprintf("%s already exist.", my_lib))
    } else {
      dir.create(my_lib)
      message(sprintf("Creating %s.", my_lib))
    }

    if (! file.exists(".gitignore")) {
      message("You should use git!")
    } else {
      is_my_lib_gitignored <- any(grepl(my_lib,
                                        readLines(".gitignore")))
      if (is_my_lib_gitignored) {
        message(sprintf("%s already in .gitignore.", my_lib))
      } else {
        usethis::use_git_ignore(my_lib)
      }
    }
    .libPaths(my_lib)
    message(sprintf(".libPaths is set to %s", my_lib))
  }
}
