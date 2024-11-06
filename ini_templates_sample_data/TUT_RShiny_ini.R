# variables/paths to edit to run 'flux_shiny_app.R'

# Specify the path to your database
main_dir <- "/Users/saraknox/Code/local_data_cleaning/Projects/My_Micromet/Database"

# Path for met/flux variables to display
basepath <- main_dir
level <- c("Clean/ThirdStage") # Can load data from one or multiple folders/sub-folders. Here is an example for load data from two folders
tv_input <- "clean_tv" # MAKE SURE tv is in folder - this can sometimes generate an error.

# Specify the path to csv file with units
UnitCSVFilePath <- '/Users/saraknox/Code/Biomet.net/R/RShiny_flux_plots/flux_variables.csv'

# Specify the path to shiny app
arg <- '/Users/saraknox/Code/Biomet.net/R/RShiny_flux_plots/'

# provide names for incoming shortwave radiation and incoming PPDF
var_rad <- c('SW_IN_1_1_1') 

# path and file name of site coordinates - you will need to DOWNLOAD and EDIT this file the first time. 
# This file will be under your ./Calculation_Procedures/RShiny_flux_plots_ini folder that you created
# Note that the standard meridian is = to your UTC offet (without daylight savings) x 15 (e.g., Montreal is UTC-5 so the standard meridian is -75)
# Also note that latitude and longitude are in decimal degrees and negative for West and South coordinates
coordinatesXLSXFilePath <- '/Users/saraknox/Code/local_data_cleaning/Projects/My_Micromet/Database/Calculation_Procedures/TraceAnalysis_ini/TUT/site_coordinates_TUT.xlsx'
