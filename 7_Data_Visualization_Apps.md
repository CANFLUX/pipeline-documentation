## 7. &nbsp; Data Visualization Apps

[XXX In Progress]

Functions for visualizing data*:
* `gui_Browse_Folder`: given a filepath, this function will open a new figure window and provide a dropdown containing all traces located at that filepath location. You can pick one or scroll through using the arrow buttons.
* `guiPlotTraces`
* `plotApp`


### Plotting data using RShiny app

1. Create an ini file for your site (see example under 'R/data_visualization/ini_files/'). You'll need to include an xlsx file with your site coordinates.

2. In your console, edit and enter the following (note that you can also create an R script with the code below and run the R script):

    a. `source("/Users/<username>/Code/local_data_cleaning/Projects/EcoFlux/Database/Calculation_Procedures/RShiny_flux_plots_ini/EcoFlux_ini.R")` [XXX does it matter where the INI and xlsx files are stored so long as they are sourced properly here?]

    b.
    `source("/Users/<username>/Biomet.net/R/RShiny_flux_plots/load_save_data.R")`
    
    c. Run 'RShiny_flux_plots.R' and include your local path to the file
    `shiny::runApp("/Users/<username>/Biomet.net/R/RShiny_flux_plots/RShiny_flux_plots.R")` 


