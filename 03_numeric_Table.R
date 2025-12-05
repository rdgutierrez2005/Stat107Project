library(dplyr)
library(tidyr)

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

# Create numeric YEARLY table (one column per year)
yearly_numeric_table <- yearly %>%
  complete(School, Start = full_seq(2011:2025, 1), fill = list(Players = 0)) %>%
  pivot_wider(
    names_from = Start,
    values_from = Players,
    values_fill = 0
  ) %>%
  arrange(School)

print(yearly_numeric_table)
