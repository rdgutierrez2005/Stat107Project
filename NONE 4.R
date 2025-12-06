start <- fixed_data$start_year

counts_by_school <- fixed_data %>%
  group_by(School, Start) %>%
  summarise(count = n(), .groups = "drop")

models_by_school <- counts_by_school %>%
  group_by(School) %>%
  nest() %>%
  mutate(
    model = map(data, ~ glm(count ~ Start,
                            family = "poisson",
                            data = .x)),
    results = map(model, tidy)   # model coefficients
  )

walk2(
  models_by_school$School,
  models_by_school$model,
  ~ {
    cat("\n=====================================\n")
    cat("Poisson Model for School:", .x, "\n")
    cat("=====================================\n")
    print(summary(.y))
  }
)