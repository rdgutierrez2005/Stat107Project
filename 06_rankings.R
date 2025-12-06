slopes <- yearly %>%
  group_by(School) %>%
  do(tidy(lm(Players ~ Start, data = .))) %>%
  filter(term == "Start") %>%
  rename(Slope = estimate)

ranks <- ggplot(slopes, aes(x = reorder(School, Slope), y = Slope)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Slope of Regression Lines (Players per Year)",
    x = "School",
    y = "Slope"
  ) +
  theme_minimal()

print(ranks)