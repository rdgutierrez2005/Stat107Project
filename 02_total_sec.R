# Count players per school per year
yearly <- data_set %>%
  group_by(School, Start) %>%
  summarise(Players = n(), .groups = "drop")

# Sum total players per year across all schools
sec_total <- yearly %>%
  group_by(Start) %>%
  summarise(TotalPlayers = sum(Players))

# Create line plot for total players over years
Sec <- ggplot(sec_total, aes(Start, TotalPlayers)) +
  geom_line(size = 1.3) +
  geom_point(size = 3) +
  labs(
    title = "Total NFL Player Output from SEC (2011–2025)",
    x = "Year",
    y = "Total Players"
  ) +
  theme_minimal(base_size = 13)

# Display the plot
print(Sec)