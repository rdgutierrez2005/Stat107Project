df <- readRDS("cleaned_data.RDS")

# Make sure Start exists (if not already separated)
df <- df %>%
  separate(Years_From_To, into = c("Start", "End"),
           sep = "-", convert = TRUE, fill = "right") %>%
  mutate(
    Start = as.integer(Start),
    End = if_else(is.na(End), Start, as.integer(End))
  )

# Count players per school per year
counts_by_school <- df %>%
  group_by(School, Start) %>%
  summarise(count = n(), .groups = "drop")

# Fit Poisson regression for each school
models_by_school <- counts_by_school %>%
  group_by(School) %>%
  nest() %>%
  mutate(
    model = map(data, ~ glm(count ~ Start,
                            family = "poisson",
                            data = .x)),
    results = map(model, tidy)
  )

