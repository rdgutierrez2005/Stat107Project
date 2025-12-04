Overview:
This repository contains the files for our STAT 107 halfway project evaluation on "Trends in NFL Player Representation from SEC Schools (2011–2025)". The project analyzes NFL player data from SEC colleges over three time periods (2011-2015, 2016-2020, 2021-2025) to identify trends in player representation, using data cleaning, visualizations, and planned statistical analysis. It includes raw and processed data, R code for requirements and functions, R Markdown for the report, and the knitted PDF output.
_____________________________________________________________________________________________________________________________________________
File Roles: 
Below is a description of each file in the repository, grouped by category (data, code, R Markdown, report, and miscellaneous)
_____________________________________________________________________________________________________________________________________________
Data Files:

College_Dataset.xlsx: The raw input data file in Excel format, sourced from Pro-Football-Reference.com. It contains information on NFL players, including their names, colleges (focused on SEC schools), career years, positions, and other statistics. This is the starting point for all analysis.

cleaned_data.RDS:
A processed R data file (RDS format) generated during data cleaning. It includes filtered and cleaned player data (e.g., only players starting careers in 2011 or later, with unnecessary columns removed and variables renamed for clarity)

.RData:
An R workspace file that may save session data or objects from previous runs (e.g., loaded datasets or variables). Useful for restoring a session, but not essential for reproduction
_____________________________________________________________________________________________________________________________________________
Code Files:

00_requirements.R:
An R source file that loads all required packages for the project, including tidyverse (for data manipulation and visualization) and gridExtra (for arranging plots). Run this first to set up the environment.

01_funct_DataCleaning.R:
An R source file containing code (or functions) for data cleaning. It reads the raw Excel data, renames columns, extracts start years, filters to 2011+, selects relevant variables, cleans text formatting, and saves the cleaned data as an RDS file.

02_funct_Plots.R:
An R source file with code (or functions) for generating visualizations, such as bar plots showing the number of NFL players per SEC school across the three time periods.

03_numeric_Table.R:
An R source file with code (or functions) for creating numeric summaries, including a tibble table that tabulates player counts by school and time period.
_____________________________________________________________________________________________________________________________________________
R Markdown Files:

FinalReport.rmd: 
The main R Markdown file that compiles the halfway report. It includes sections for the abstract, introduction, data description, visualization, and analysis plans. It sources the requirements and function files, loads and cleans data, generates plots and tables, and knits to PDF.
_____________________________________________________________________________________________________________________________________________
Report Files:
FinalReport.pdf
The knitted PDF output of FinalReport.rmd. This is the formatted halfway report, including the title, abstract, introduction, data section, preliminary visualizations (bar plots and tables), and plans for further analysis.
_____________________________________________________________________________________________________________________________________________
Miscellaneous Files:
.DS_Store:
A macOS system file for folder metadata (ignore for analysis; not relevant to the project).

.Rhistory:
An R history file logs the commands executed in previous sessions (for reference or debugging, but not required for reproduction).

README.md: 
This file provides an overview of the project, describes file roles, and includes instructions for reproducing the results.
_____________________________________________________________________________________________________________________________________________
To reproduce the results:
1. Install R and RStudio if not installed
2. Clone this repository to your local machine using Desktop GitHub
3. Open RStudio and set the working directory to the repository folder
4. Run source("00_requirements.R") to install and load required packages
5. Run source("01_funct_DataCleaning.R") to load the cleaning function and process the data (loads from College_Dataset.xlsx and saves to cleaned_data.RDS)
6. Run source("02_funct_Plots.R") to load plotting functions
7. Run source("03_numeric_Table.R") to load table functions
8. Open and knit Final_Project.rmd to PDF, which will execute all steps: load data, clean it, generate plots and tables, and produce the report
