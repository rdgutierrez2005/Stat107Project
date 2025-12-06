# Load cleaned data
fixed_data <- readRDS("cleaned_data.RDS")

# Separate Years_From_To into Start and End
fixed_data <- fixed_data %>%
  separate(Years_From_To, into = c("Start", "End"), sep = "-", convert = TRUE, fill = "right") %>%
  mutate(
    Start = as.integer(Start),
    End = if_else(is.na(End), Start, as.integer(End))
  )

# Count players per school PER YEAR
yearly_summary <- fixed_data %>%
  group_by(School, Start) %>%
  summarise(Players = n(), .groups = "drop")

# Get unique schools and global y-axis limit
teams <- unique(yearly_summary$School)
y_max <- max(yearly_summary$Players, na.rm = TRUE)

# Generate plots for each school (YEARLY)
plots <- list()
for (team in teams) {
  school_data <- yearly_summary %>% filter(School == team)
  
  p <- ggplot(school_data, aes(x = factor(Start), y = Players, fill = factor(Start))) +
    geom_bar(stat = "identity", width = 0.5) +
    scale_y_continuous(limits = c(0, y_max)) +
    labs(title = team, x = "Year", y = "Number of Players") +
    theme_minimal(base_size = 10) +
    theme(
      legend.position = "none",
      plot.title = element_text(hjust = 0.5, face = "bold"),
      axis.text.x = element_text(angle = 45, hjust = 1)
    )
  
  plots[[team]] <- p
}
# Display plots (4 per page)
for (i in seq(1, length(plots), by = 4)) {
  grid.arrange(
    grobs = plots[i:min(i + 3, length(plots))],
    ncol = 2, nrow = 2
  )
}
