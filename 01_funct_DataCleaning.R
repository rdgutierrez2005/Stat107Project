# Read raw data 
data <- read_excel("College Dataset.xlsx")

# Rename columns for clarity 
colnames(data) <- c("Pos", "Player", "College_Stats", "AP1", "PB", "St",
                    "wAV", "Ht", "Wt", "Yrs_Num", "Years_Range", "School")

# Extract start year from the Years_Range column 
data <- data %>%
  mutate(start_year = as.integer(sub("-.*", "", Years_Range)))

# Keep only players who started in 2011 or later 
filtered_data <- data %>%
  filter(start_year >= 2011)

# Select and rename relevant columns 
fixed_data <- filtered_data %>%
  select(Pos, Player, Yrs_Num, Years_Range, School) %>%
  rename(
    Position = Pos,
    Years_Num = Yrs_Num,
    Years_From_To = Years_Range
  )

# Clean text formatting
fixed_data <- fixed_data %>%
  mutate(Years_From_To = str_replace_all(Years_From_To, "\u2013|\u2014", "-") %>%
           str_squish())

# Save cleaned data set as an RDS file 
saveRDS(fixed_data, "cleaned_data.RDS")