library(dplyr)
library(tidyr)

# Load cleaned dataset
data_set <- readRDS("cleaned_data.RDS")

# Split years
data_set <- data_set %>%
  separate(Years_From_To, into = c("Start", "End"), sep = "-", 
           convert = TRUE, fill = "right") %>%
  mutate(
    Start = as.integer(Start),
    End   = if_else(is.na(End), Start, as.integer(End))
  )

# Yearly counts per school
yearly_summary <- data_set %>%
  group_by(School, Start) %>%
  summarise(Players = n(), .groups = "drop")

# Save output
saveRDS(yearly_summary, "yearly_summary.RDS")

# Wide table
yearly_summary_wide <- yearly_summary %>%
  pivot_wider(
    names_from = Start,
    values_from = Players,
    values_fill = 0
  ) %>%
  arrange(School)

saveRDS(yearly_summary_wide, "yearly_summary_wide.RDS")