# Load cleaned data
data_set <- readRDS("cleaned_data.RDS")

# Separate Start/End years
data_set <- data_set %>%
  separate(Years_From_To, into = c("Start", "End"), sep = "-", convert = TRUE, fill = "right") %>%
  mutate(
    Start = as.integer(Start),
    End   = if_else(is.na(End), Start, as.integer(End))
  )

# Count players per school per year
yearly <- data_set %>%
  group_by(School, Start) %>%
  summarise(Players = n(), .groups = "drop")

# Create complete year grid (fills missing years with 0)
yearly_full <- yearly %>%
  complete(School, Start = full_seq(2011:2025, 1), fill = list(Players = 0))

# Compute safe % change:
yearly_pct <- yearly_full %>%
  arrange(School, Start) %>%
  group_by(School) %>%
  mutate(
    pct_change = ifelse(
      lag(Players) > 0 & Players > 0,
      round(((Players - lag(Players)) / lag(Players)) * 100, 2),
      NA  # avoid divide-by-zero or meaningless jumps
    ),
    Label = paste0(lag(Start), "→", Start)
  ) %>%
  filter(!is.na(pct_change))

# Use yearly_pct (must already exist)
heatmap_data <- yearly_pct %>%
  mutate(
    Label = factor(Label, levels = unique(Label))  # Keep proper year order
  )

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

print(heatmap)
