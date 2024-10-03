## 11a. &nbsp; Quick Start: Visualize New Database

Here are some quick tips to inspect the Flux data from SITEID1 in your newly created database:

1. `gui_Browse_folder` function: 
```
pth = biomet_path(yearIn, 'SITEID1', 'Flux')
gui_Browse_Folder(pth)
```
This function opens a Matlab app that looks in the Flux folder for SITEID1 for a specific year (as defined in the `biomet_path` function input parameters) and plots each variable in turn. You can scroll through or use the dropdown in order to check that your data looks reasonable and as expected. 

2. Load one trace, e.g., co2_mixing_ratio and plot it. This example 
```
%% Load one trace and plot it
pth = biomet_path(yearIn,'SITEID','Flux');   
tv = read_bor(fullfile(pth,'clean_tv'),8);      % load the time vector (Matlab's datenum format)
tv_dt = datetime(tv,'convertfrom','datenum');   % convert to Matlab's datetime object
x = read_bor(fullfile(pth,'co2_mixing_ratio')); % load co2_mixing_ratio from SITEID1/Flux folder
plot(tv_dt,x)                                   % plot data
grid on;zoom on
```

3. `plotApp` function:
Simply type `plotApp` on the command line, and it will open an app that can compare traces from the same and different cleaning stages (once you have completed those), databases, and also produce statistical plots and outputs. More details of this and other visualization tools are described at length in section 14 [XXX link]. 
