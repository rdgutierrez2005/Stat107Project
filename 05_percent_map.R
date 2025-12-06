# Use yearly_pct (must already exist)

heatmap_data <- yearly_pct %>%
  mutate(
    Label = factor(Label, levels = unique(Label))  # Keep proper year order
  )

heatmap <- ggplot(heatmap_data, aes(x = Label, y = School, fill = pct_change)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(
    low = "black",
    mid = "cyan",
    high = "purple",
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
