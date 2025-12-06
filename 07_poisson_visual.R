
models_by_school <- models_by_school %>%
  mutate(
    augmented = map(model, augment, type.predict = "response")
  )


plots <- models_by_school %>%
  mutate(
    plot = map2(
      School,
      augmented,
      ~ ggplot(.y, aes(x = Start, y = count)) +
        geom_point(size = 2) +
        geom_line(aes(y = .fitted), linewidth = 1) +
        labs(
          title = paste(.x),
          x = "Start Year",
          y = "Player Count"
        ) +
        theme_minimal()
    )
  )

# Print all plots one by one
walk(plots$plot, print)
