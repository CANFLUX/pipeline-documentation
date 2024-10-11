## 7. &nbsp; Data Visualization Apps

In progress...

Functions for visualizing data:
* `gui_Browse_Folder`: given a filepath, this function will open a new figure window and provide a dropdown containing all traces located at that filepath location. You can pick one or scroll through using the arrow buttons.
* `guiPlotTraces`
* `plotApp`


### Plotting data using RShiny app

1. Create a visualization INI file for your site (see examples in the `Biomet.net` library under `Biomet.net/R/data_visualization_EcoFlux/ini_files/`; not to be confused with data-cleaning INI files). 
[XXX Sara: the examples in here vary a bit, and are a bit long and confusing... can I just use RShiny_flux_plots_ini/EcoFlux_ini.R as a template for the instructions?]

2. Make a new directory in your `Calculation_Procedures` directory called `RShiny_flux_plots_ini`, and put this INI file there. Edit the relevant directory paths in this INI file for your own local computer.

3. You will also need to include an XLSX file with your site coordinates (format shown in figure 7.1), in the same directory as the INI file.

2. In your R console, edit and enter the following (note that you can also create an R script with the code below and run the R script):

    a. `source("/Users/<username>/Code/local_data_cleaning/Projects/EcoFlux/Database/Calculation_Procedures/RShiny_flux_plots_ini/EcoFlux_ini.R")` [XXX does it matter where the INI and xlsx files are stored so long as they are sourced properly here?] no just create plotting INI file in their cal_proc directory

    b.
    `source("/Users/<username>/Biomet.net/R/RShiny_flux_plots/load_save_data.R")`
    
    c. Run 'RShiny_flux_plots.R' and include your local path to the file
    `shiny::runApp("/Users/<username>/Biomet.net/R/RShiny_flux_plots/RShiny_flux_plots.R")` 


