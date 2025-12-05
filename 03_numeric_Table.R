# Load cleaned data set
data_set <- readRDS("cleaned_data.RDS")

# Split "Years_From_To" into Start and End
data_set <- data_set %>%
  separate(Years_From_To, into = c("Start", "End"), sep = "-", convert = TRUE, fill = "right") %>%
  mutate(
    Start = as.integer(Start),
    End   = if_else(is.na(End), Start, as.integer(End))
  )

# Count players per school per YEAR
yearly_counts <- data_set %>%
  group_by(School, Start) %>%
  summarise(Players = n(), .groups = "drop") %>%
  arrange(School, Start)

print(yearly_counts)


# Pivot to wide format for a readable numeric table
yearly_wide <- yearly_counts %>%
  pivot_wider(
    names_from = Start,
    values_from = Players,
    values_fill = 0
  ) %>%
  arrange(School)

print(yearly_wide)

