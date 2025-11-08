# Load cleaned dataset 
data_set <- readRDS("cleaned_data.RDS")

# Split "Years_From_To" into Start and End 
data_set <- data_set %>%
  separate(Years_From_To, into = c("Start", "End"), sep = "-", convert = TRUE, fill = "right") %>%
  mutate(
    Start = as.integer(Start),
    End   = if_else(is.na(End), Start, as.integer(End))
  )

# Define year ranges 
data_set <- data_set %>%
  mutate(YearRange = case_when(
    Start >= 2011 & Start <= 2015 ~ "2011-2015",
    Start >= 2016 & Start <= 2020 ~ "2016-2020",
    Start >= 2021 & Start <= 2025 ~ "2021-2025",
    TRUE ~ NA_character_
  ))

# Count players per school and year range 
college_summary <- data_set %>%
  filter(!is.na(YearRange)) %>%
  group_by(School, YearRange) %>%
  summarise(Players = n(), .groups = "drop")

# Pivot to wide format for a readable numeric table 
college_summary_wide <- college_summary %>%
  pivot_wider(names_from = YearRange,
              values_from = Players,
              values_fill = 0) %>%
  arrange(School)

# Display the summary table 
print(college_summary_wide)