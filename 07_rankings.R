# groups by school, runs a linear model for each, extracts slope, renames it
slopes <- yearly %>%
  group_by(School) %>%
  do(tidy(lm(Players ~ Start, data = .))) %>%
  filter(term == "Start") %>%
  rename(Slope = estimate)

# creates bar plot of slopes ranked by school
ranks <- ggplot(slopes, aes(x = reorder(School, Slope), y = Slope)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Slope of Regression Lines (Players per Year)", x = "School", y = "Slope") +
  theme_minimal()

# displays the plot
print(ranks)
