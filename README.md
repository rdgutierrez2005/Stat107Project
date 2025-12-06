Overview:
This repository contains the files for our STAT 107 final report evaluation on "Trends in NFL Player Representation from SEC Schools (2011–2025)." The project analyzes NFL player data from SEC colleges over the full 2011–2025 period using data cleaning, visualizations, percent-change analysis, Poisson regression modeling, and slope-based rankings to identify long-term trends in player representation. It includes raw and processed data, R code for cleaning and visualization functions, additional scripts for generating regression and ranking outputs, the R Markdown file for the report, and the final knitted PDF.
________________________________________________________________________________________________________________________________________
File Roles: 
Below is a description of each file in the repository, grouped by category (data, code, R Markdown, report, and miscellaneous)
________________________________________________________________________________________________________________________________________
Data Files:

College_Dataset.xlsx: The raw input data file in Excel format, sourced from Pro-Football-Reference.com. It contains information on NFL players, including their names, colleges (focused on SEC schools), career years, positions, and other statistics. This is the starting point for all analysis.

cleaned_data.RDS:
A processed R data file (RDS format) generated during data cleaning. It includes filtered and cleaned player data (e.g., only players starting careers in 2011 or later, with unnecessary columns removed and variables renamed for clarity)

.RData:
An R workspace file that may save session data or objects from previous runs (e.g., loaded datasets or variables). Useful for restoring a session, but not essential for reproduction
________________________________________________________________________________________________________________________________________
Code Files:

00_requirements.R:
This script loads all necessary packages used throughout the project. It must be sourced first because all other scripts depend on these libraries.

01_funct_DataCleaning.R:
An R source file containing code (or functions) for data cleaning. It reads the raw Excel data, renames columns, extracts start years, filters to 2011+, selects relevant variables, cleans text formatting, and saves the cleaned data as an RDS file.

02_total_sec.R
This script creates the conference-wide line graph showing the total number of SEC players drafted each year from 2011 to 2025. It produces Figure 1 used in the final report.

03_funct_Plots.R
This script produces multiple visualizations, including individual school bar charts, the heat map, and Poisson regression plots. It contains the primary plotting functions used throughout the RMD.

04_percent_map.R
This script computes the year-to-year percentage changes used in the heat map. It formats the data so it can be visualized consistently across all SEC schools.

06_poisson_visual.R
This script fits Poisson regression models for each SEC school to analyze long-term trends in NFL player output. It produces the regression plots shown in Figure 4.

07_rankings.R
This script calculates and visualizes slope values from the Poisson regression models. It generates the rankings chart in Figure 5 that summarizes long-term school performance.

________________________________________________________________________________________________________________________________________
R Markdown Files:

FinalReport.rmd: 
This is the main report that sources all required scripts and runs the full analysis pipeline. It compiles the visualizations and written interpretation into a formatted PDF.
________________________________________________________________________________________________________________________________________
Report Files:

FinalReport.pdf:
This file is the final knitted version of the report generated from the RMD. It contains all figures, interpretations, and conclusions for the project.
________________________________________________________________________________________________________________________________________
Miscellaneous Files:

.DS_Store:
A macOS system file for folder metadata (ignore for analysis; not relevant to the project).

.Rhistory:
An R history file logs the commands executed in previous sessions (for reference or debugging, but not required for reproduction).

README.md: 
This file provides an overview of the project, describes file roles, and includes instructions for reproducing the results.
________________________________________________________________________________________________________________________________________
To reproduce the results:
1. Install R and RStudio
Install the latest versions of R and RStudio on your computer. These programs are required to run the scripts and knit the final report.

2. Clone or download the repository
Use GitHub Desktop or git clone to download all project files to your machine. Make sure every script, the RMD file, and the dataset remain in the same folder structure.

3. Open the project folder in RStudio
Launch RStudio and set the working directory to the repository folder. This ensures that all sourced files and relative paths work correctly.

4. Load all required packages
Run source("00_requirements.R") to install and load the packages needed for the analysis. This step must be completed before running any other script.

5. Clean and prepare the data
Execute source("01_funct_DataCleaning.R"), which reads the Excel file, cleans the data, and saves the output as cleaned_data.RDS. This provides the standardized dataset used for every visualization.

6. Generate the total SEC output visualization
Run source("02_total_sec.R") to create the line graph showing total SEC player output per year. This will produce Figure 1 used in the FinalReport.

7. Produce all bar charts, heat map inputs, and regression data
Run source("03_funct_Plots.R") to load the functions that generate school-specific plots, heat map data, and Poisson models. These functions support the visualizations used throughout the RMD.

8. Create the percent-change data for the heat map
Run source("04_percent_map.R") to compute year-to-year percentage changes for each SEC school. This prepares the dataset used for the heat map visualization.

9. Build Poisson regression visualizations
Run source("06_poisson_visual.R"), which fits Poisson regression models for all schools and outputs the regression plots. These plots become Figure 4 in the final PDF.

10. Produce regression slope rankings
Run source("07_rankings.R") to compute slope values and generate the rankings plot. This script produces Figure 5 summarizing long-term program trends.

11. Knit the final report
Open FinalReport.rmd in RStudio and click the “Knit” button to render the PDF. The report will run every script, load all figures, and produce the full analysis in a formatted document.
