## Data Cleaning Principles

This section outlines the data cleaning principles and processes that should be followed closely and applied at each of the three stages, as well as other relevant information.

XXX include figure/outline (edited) from Calculation_Procedures

### Stage 1 
* **Principle: during the first stage of data cleaning we want to keep the best measured data values *from each sensor***, i.e., a user looking for the best measurements from a particular sensor would want to use the first stage data. Missing data points for periods of more than one half-hour will not be gap-filled in any way (one missing half-hourly data point can be interpolated linearly, see section XXX for details). 
* In summary, the first stage collects the raw data, applies min/max filtering, assigns consistent variable names in line with [Ameriflux guidelines](https://ameriflux.lbl.gov/data/aboutdata/data-variables/) as far as possible, and moves the relevant files to a `Clean` folder in preparation for stage two. This folder will be created automatically if it does not already exist. 
* The data are stored as binary files in "single-precision floating-point format" (aka float 32), which importantly means they are readable in most common computer languages and softwares.

### Stage 2 
* **Principle: the second stage focuses on creating the best measured data values *for each particular property/variable***. For example, if there are two (or more) collocated temperature sensors at the same height e.g., 2 metres above ground level, the second stage is intended to create the "best" trace using both (all) sensors, with the highest precision/accuracy and the fewest missing points. It does this by averaging the traces, and also gap-filling either by using linear regression, or using data from a nearby ECCC climate station (other gap filling methods are currently under evaluation).
* In practice, the second stage collects the stage one data, generates the "best" observation for each variable and moves the relevant files to a "Clean/SecondStage" folder in preparation for stage three.

### Stage 3 
* **Principle: filtering [XXX check with Sara if 3rd stage includes filtering], partitioning, and gap filling for flux variables**.
* The third stage collects the stage two data and applies filtering and gap filling procedures to the flux data. For this we use the [REddyProc](https://bg.copernicus.org/articles/15/5015/2018/bg-15-5015-2018.html), R package which has been adapted to interface with Matlab, so that all three stages can be run together (per DSM site example in section XXX).

We achieve these principles by setting up various configuration files used in each stage (see section [XXX add link]).
