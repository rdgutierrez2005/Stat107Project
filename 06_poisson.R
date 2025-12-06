counts_by_school <- data_set %>%
  group_by(School, start_year) %>%
  summarise(count = n(), .groups = "drop")

models_by_school <- counts_by_school %>%
  group_by(School) %>%
  nest() %>%
  mutate(
    model = map(data, ~ glm(count ~ start_year,
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