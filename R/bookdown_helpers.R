
# Custom Functions for Bookdown -------------------------------------------

fn_buildbook <- function(){
  bookdown::serve_book(
    dir = ".",
    output_dir = "docs",
    preview = F,
    in_session = F,
    quiet = T)
}

# fn_buildbook()
