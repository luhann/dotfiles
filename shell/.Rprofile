# Set options for Rscript -e calls
if (requireNamespace("lumisc", quietly = TRUE)) {
  # Call here if needed
  lumisc::set_startup_options()
}

grDevices::X11.options(family = "Iosevka", type = "cairo")
options(bitmapType = "cairo")

options(usethis.full_name = "Luke Hannan")

if (interactive()) {
        # Code that will only run in interactive sessions goes here
        # This replaces the default quit with the quit without save from my package
        q = lumisc::q
        # adds view as an alias for View
        view = lumisc::view
}
