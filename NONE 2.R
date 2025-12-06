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

# Create complete year grid (fills missing years with 0)
yearly_full <- yearly %>%
  complete(School, Start = full_seq(2011:2025, 1), fill = list(Players = 0))

# Compute safe % change:
yearly_pct <- yearly_full %>%
  arrange(School, Start) %>%
  group_by(School) %>%
  mutate(
    pct_change = ifelse(
      lag(Players) > 0 & Players > 0,
      round(((Players - lag(Players)) / lag(Players)) * 100, 2),
      NA  # avoid divide-by-zero or meaningless jumps
    ),
    Label = paste0(lag(Start), "→", Start)
  ) %>%
  filter(!is.na(pct_change))

# Convert to wide percent-change table
pct_change_wide <- yearly_pct %>%
  pivot_wider(
    names_from = Label,
    values_from = pct_change
  ) %>%
  arrange(School)

# Select only the columns needed for a clean wide pivot (one row per school)
pct_change_wide <- yearly_pct %>%
  select(School, Label, pct_change) %>%
  pivot_wider(
    names_from = Label,
    values_from = pct_change
  ) %>%
  arrange(School)


