# Set options for Rscript -e calls
if (requireNamespace("lumisc", quietly = TRUE)) {
    # Call here if needed
    lumisc::set_startup_options()
}

grDevices::X11.options(family = "Iosevka", type = "cairo")

options(
    repos = c(
        CRAN = "https://cran.rstudio.org"
    ),
    bitmapType = "cairo",
    usethis.full_name = "Luke Hannan"
    # remember that this option is active it changes the default contrast option
    # contrasts = c("contr.sum", "contr.poly")
)


if (interactive()) {
    # Code that will only run in interactive sessions goes here
    # This replaces the default quit with the quit without save from my package
    q = lumisc::q
    # adds view as an alias for View
    view = lumisc::view
    # fancy r prompt
    # prompt::set_prompt(prompt::prompt_fancy)
    options(width = 120)
    rownames = row.names
}
