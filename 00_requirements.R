packages <- c(
  "tidyverse",   # data wrangling, plotting
  "readxl",      # read Excel files
  "gridExtra",   # arrange multiple ggplots
  "knitr",       # knitting tables
  "dplyr",       # tidy data manipulation
  "tidyr",       # data tidying
  "tinytex",     # LaTeX distribution for rendering PDFs from RMarkdown
  "ggplot2",      # grammar of graphics for creating plots
  "broom",
  "purrr"
)

# Install any missing packages automatically
installed <- rownames(installed.packages())
for (p in packages) {
  if (!(p %in% installed)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}
