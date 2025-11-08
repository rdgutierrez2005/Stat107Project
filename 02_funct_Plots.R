# Load cleaned data
fixed_data <- readRDS("cleaned_data.RDS")

# Separate Years_From_To into Start and End 
fixed_data <- fixed_data %>%
  separate(Years_From_To, into = c("Start", "End"), sep = "-", convert = TRUE, fill = "right") %>%
  mutate(
    Start = as.integer(Start),
    End = if_else(is.na(End), Start, as.integer(End))
  )

# Define custom year ranges 
fixed_data <- fixed_data %>%
  mutate(YearRange = case_when(
    Start >= 2011 & Start <= 2015 ~ "2011-2015",
    Start >= 2016 & Start <= 2020 ~ "2016-2020",
    Start >= 2021 & Start <= 2025 ~ "2021-2025",
    TRUE ~ NA_character_
  ))

# Count players per school and year range 
college_summary <- fixed_data %>%
  filter(!is.na(YearRange)) %>%
  group_by(School, YearRange) %>%
  summarise(Players = n(), .groups = "drop")

# Get unique schools and global y-axis limit 
teams <- unique(college_summary$School)
y_max <- max(college_summary$Players, na.rm = TRUE)

# Generate plots for each school 
plots <- list()
for (team in teams) {
  college_data <- college_summary %>% filter(School == team)
  
  p <- ggplot(college_data, aes(x = YearRange, y = Players, fill = YearRange)) +
    geom_bar(stat = "identity", width = 0.6) +
    scale_y_continuous(limits = c(0, y_max)) +
    labs(title = team, x = "Year Range", y = "Number of Players") +
    theme_minimal(base_size = 12) +
    theme(
      legend.position = "none",
      plot.title = element_text(hjust = 0.5, face = "bold")
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