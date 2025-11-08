To reproduce the results:
1. Install R and RStudio if not installed
2. Clone this repository to your local machine using Desktop GitHub
3. Open RStudio and set the working directory to the repository folder
4. Run source("00_requirements.R") to install and load required packages
5. Run source("01_funct_DataCleaning.R") to load the cleaning function and process the data (loads from College_Dataset.xlsx and saves to cleaned_data.RDS)
6. Run source("02_funct_Plots.R") to load plotting functions
7. Run source("03_numeric_Table.R") to load table functions
8. Open and knit Final_Project.rmd to PDF, which will execute all steps: load data, clean it, generate plots and tables, and produce the report
