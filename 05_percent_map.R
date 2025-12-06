# Load data from RDS file
data_set <- readRDS("cleaned_data.RDS")

# Split Years_From_To into Start and End years, convert to integers, fill NA End with Start
data_set <- data_set %>%
  separate(Years_From_To, into = c("Start", "End"), sep = "-", convert = TRUE, fill = "right") %>%
  mutate(
    Start = as.integer(Start),
    End = if_else(is.na(End), Start, as.integer(End))
  )

# Count players by school and start year
yearly <- data_set %>%
  group_by(School, Start) %>%
  summarise(Players = n(), .groups = "drop")

# Fill missing years from 2011-2025 with 0 players
yearly_full <- yearly %>%
  complete(School, Start = full_seq(2011:2025, 1), fill = list(Players = 0))

# Calculate percent change safely, avoiding zero divisions
yearly_pct <- yearly_full %>%
  arrange(School, Start) %>%
  group_by(School) %>%
  mutate(
    pct_change = ifelse(
      lag(Players) > 0 & Players > 0,
      round(((Players - lag(Players)) / lag(Players)) * 100, 2),
      NA
    ),
    Label = paste0(lag(Start), "→", Start)
  ) %>%
  filter(!is.na(pct_change))

# Prepare data for heatmap, factorize labels for order
heatmap_data <- yearly_pct %>%
  mutate(
    Label = factor(Label, levels = unique(Label))
  )

# Create heatmap plot with gradient fill for percent change
heatmap <- ggplot(heatmap_data, aes(x = Label, y = School, fill = pct_change)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(
    low = "red",
    mid = "white",
    high = "blue",
    midpoint = 0,
    name = "% Change"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(hjust = 0.5, face = "bold")
  ) +
  labs(
    title = "Year-to-Year Percent Change in Player Draft Counts (2011–2025)",
    x = "Year Transition",
    y = "School"
  )

# Display the plot
print(heatmap)