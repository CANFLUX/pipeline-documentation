## Create your INI Files for Data Cleaning 

The INI files for a given site dictate how data is transferred from its raw format into a standardized, cleaned, and gap-filled format that can be used for scientific analysis. They provide instructions to a set of MATLAB and R scripts used to process data. The INI files are unique to each site because not every site is set up in exactly the same way (different sensors, loggers, record lengths, etc.). The files are separated into three stages according to each data cleaning stage.

Before starting to create your own INI files, you **must** have completed sections [XXX add section numbers once finalized, or link all sections - though there are a lot of bitesize steps before this one now]. Additionally, here are some programming rules that you must follow for the INI files to be successfully read by the pipeline scripts:

#### Programming Rules for First and Second stage INI files:
```
[XXX not sure if this belongs here or elsewhere]
1. We enforce using uppercase for site IDs to avoid problems between running data cleaning on Mac vs. Windows.
2. All traces must be enclosed in [Trace] and [End] blocks.
3. All assignments can be on multiple lines, but should be enclosed in single quotes.
4. Comments must begin with a percentage sign (%).
5. All fields must be in Matlab format.
6. All parameter assignments must be to strings in single quotes, or numeric expressions, e.g., threshold_const = 6, threshold_const = [6], variableName = 'Some Name'.
7. For the first stage, the partial path must be included with the inputFileName when you locate the raw data trace in the database. (Using biomet_path function only returns the path: year/site/measType/)
8. First stage necessary fields are: variableName, inputFileName, measurementType, units, title, and minMax.
9. Second stage necessary fields are: variableName, title, units.
```

To help you create and edit your own site-specific INI files, we present a working example for cleaning data from the Delta Salt Marsh (DSM) flux site in British Columbia [XXX revisit once sample site is decided upon]. You should already have obtained all the sample files for this site and put them in the appropriate locations [XXX link to Obtain_Sample_Config_Standardization_Files.md].

### Working example for Delta Salt Marsh (siteID: DSM)

#### *First Stage INI file*
These are the steps to create your first stage INI (which generally requires the most work of the three stages):
* Create first stage cleaning INI file from template using createFirstStageIni [XXX discuss this with Zoran, vs. duplicating DSM INI and renaming].
* Name your INI file using the unique measurement site ID, e.g., siteID = ‘DSM’ INI file is named DSM_FirstStage.ini.
* Edit first stage INI file adding *just a few variables at a time*, keeping in mind the following, as well as the data cleaning principles previously outlined [XXX link to Data_Cleaning_Principles section?]:

    1. Select traces that are needed for future data analysis. Not all the measured variables from a site need to be here, only the ones that will be used in future analysis or those needed to improve cleaning, such as diagnostic variables.
    2. Filenames from the database can be renamed here. The trace name does not have to be the same as the file name from the database, and should follow [Ameriflux guidelines](https://ameriflux.lbl.gov/data/aboutdata/data-variables/) including positional qualifiers where relevant.
    3. The original values can be altered; calibrations can be applied, units can be changed.
    4. Apply basic filtering: 
    (a) values can be removed if they exceed minMax thresholds;
    (b) values can be clamped to the thresholds if they exceed clampedMinMax values. 
    5. This stage creates dependencies between different traces. If one trace gets some points removed here, all its dependent traces will have those points removed too. 
    6. More complex user-defined processing can be applied to the trace using the "Evaluate" option (also available, and very useful, in stage two). User-written Matlab functions can be called from this statement. Multiple Matlab statements can be called from within the “Evaluate” string. Some rules for formatting apply here (see the existing SecondStage ini file for details and examples).

[XXX Add DSM_FirstStage.INI file image or link to file for downloading? They may already have this but perhaps worth linking again for reference]

* Once you have a few variables in your INI file, test it by running the `fr_automated_cleaning` function in Matlab:

    Arguments for fr_automated_cleaning function:
    | Field | Description | Type |
    | ----- | ----------- | ---- |
    | yearIn | year to clean data for | integer |
    | siteID | measurement site ID, e.g., DSM | string uppercase |
    | cleaning stage to run | 1 = first stage, 2 = second stage, 7 = third stage, 8 = convert to AmeriFlux CSV file | integer |

* For example, to run first stage cleaning for the DSM site for 2022, you would type: `fr_automated_cleaning(2022,'DSM',1)`.

* With this function, you can clean multiple years of data, e.g., `2020:2023`, and also run multiple stages e.g., `[1 2 7]`, once you have your INI files set up for those. Earlier stages must have been run at least once before running subsequent stages so the appropriate data files exist for the next stage.

##### First stage INI file properties
| Field      | Description |
| ----------- | ----------- |
| Header/Comments      | “%” character indicates the beginning of a comment. Program will not process any characters that follow “%”. Use comments to add information and to better document the site. Each line of the INI file can be followed by a comment. Refer to the sample INI file for DSM site.      |
| Site_name   | Name of the site. Any text can go here.        |
| SiteID      | This is the name attributed to the site in the database (e.g., DSM). Must be uppercase. |
| Difference_GMT_to_local_time | Time difference between GMT time, that database is kept in, and the standard time at the site location. `local_time+Difference_GMT_to_local_time -> GMT time`. |
|[Trace] | Marks the beginning of a new variable. The section has to end with the keyword `[End]`.|
| variableName | Name of variable for first stage, following the Ameriflux naming convention. The variable with this name will show up in the subfolder “Clean” under the same folder where the original database file came from. |
| title | Descriptive title for plots/visualization.|
| originalVariable [XXX remove?]| This is an example of adding an optional field to a trace that can be used by an advanced user. Here it’s set to be the same as the variableName. Currently, this particular field is not used for generic processing. |
|inputFileName |{`inputFileName`} The name of the database file that contains data for this trace. The brackets are mandatory.<br /> The file name can include folder(s), e.g., `'Met/Tair'`, and the paths are relative to the main site path (`./Database/yyyy/siteID`), so the above example translates into this filepath: `'./Database/yyyy/siteID/Met/Tair'`.<br />Over the lifetime of a measurement site, the data logger programs can change and a sensor measurement that was assigned to a variable may change. To allow for different variable names over the site history the inputFileName can be given as: {`'inputFileName1','inputFileName2'`}. In this case, the parameter `inputFileName_dates` must be present and reflect this (see next parameter description).<br /> Advanced: if there is a need to load up a data file from an alternative site, the path can be constructed as follows: `../../siteID2/dataFolder`. This syntax `../../` moves the path pointer up two directory levels to `/Database/yyyy` and from there `siteID2/dataFolder` takes the program to the correct folder.|
|inputFileName_dates |`[datenum_start1 datenum_end1; datenum_start2 datenum_end2]` The start and end dates of data periods for each of the inputFileNames, using the Matlab `datenum` function. <br />If there are multiple inputFileNames per the example in the previous parameter description, e.g., {`'inputFileName1','inputFileName2'`} then the program needs to know the time periods when the data assigned to the variableName should come from `inputFileName1`, and when from `inputFileName2`. In that case, this field is mandatory.<br /> If the inputFileName parameter contains only one file name, this inputFileName_dates parameter is optional, but it is still a good practice to use it anyway for documentation purposes and in case other filenames are added in the future.<br /> The last `datenum_end` is usually set far into the future, e.g., `datenum(2999,1,1)`.| 
|measurementType| Usually `'Met'` or `'Flux'` (must be of Matlab type char). Mandatory parameter that sets the input and output trace folders. The input folder defaults to: `siteID/measurementType/inputFileName`. If relative paths are used [XXX used where?] they "assume" that the current folder is `siteID/measurementType` so the relative path is referenced to that [XXX unsure what this sentence means]. The output folder for the first stage cleaned trace is always `siteID/measurementType/Clean`. <br />Note: the measurementType must *not* be missing (empty), otherwise the data will be saved to `siteID/Clean/variableName` which is incorrect and will cause errors in future cleaning stages.|
|units|Measurement units for this trace, must be data type char. Important!|
|instrument|The name of the sensor that measures this trace, e.g., `'HMP155A'`|
|instrumentSN|Serial number of the sensor, if available.|
|loggedCalibration|Used together with currentCalibration (see next parameter). If you need to change the linear calibration for the trace, these coefficients are used to convert the trace values from engineering units to its original/raw units. Then the correct calibration coefficients (currentCalibration) are used. This can also be used to change the units. The format is `[gain offset startDatenum endDatenum]`, where `startDatenum` and `endDatenum` refer to the time span that this particular set of coefficients should be applied. For example, with no change for data starting on 1 January 2020, the code would read `loggedCalibration = [1 0 datenum(2020,1,1) datenum(2999,1,1)]`. You can apply multiple calibrations to different time periods, separated by semicolons.<br /> Note: all calibration values need to be on the same line of code, i.e., no line-breaks are allowed in the INI file!|
|currentCalibration|Correct(ed) linear calibration coefficients. Used together with loggedCalibrations (see notes for previous parameter for more details). |
|comments|Any useful comments relating to this trace and its handling in the INI file, such as why certain flags are applied.|
|minMax|`[min max]` Minimum and maximum numerical thresholds for filtering. The values *outside* of this range will be set to NaN.|
|clamped_minMax|`[cMin cMax]` Similar to minMax but instead of setting the data points outside the range to NaN, it truncates their value to the cMin or cMax. (e.g., RH: [0 100]).<br />Note: this parameter is not mandatory, however, when used, please make sure that the minMax property boundaries are wider than the boundaries of clamped_minMax because the minMax property is applied first. This parameter is useful for variables such as relative humidity, e.g., `minMax = [-1 110]` used with `clamped_minMax=[0 100]`.|
|zeroPt| Value to indicate missing data. Many programs nowadays use -9999 to indicate bad/missing data points.|
|dependent|Filter-dependent variables based on specified trace. The current trace can have multiple dependents that need to be separated by commas, e.g., `dependent = 'trace1','trace2','trace3'`.<br />For example, when using the LI-7200 pump, all the traces that depend on the LI-7200 are dependent on the pump trace. So, for the LI-7200: `dependent = 'CO2','H2O'`. Then the CO2 trace should have `dependent = 'FC',...` and so on. You can write these out manually where necesssary but we highly recommend using the "tags" feature for common dependencies [XXX link to subsection on tags]. Avoid circular references, i.e.,  CO2: `dependent = 'FC'` together with FC: `dependent = 'CO2'` is bad!|
|[End]|Marks the end of the trace properties section.|

**Note:**
Other properties that a user wants to use later on in their own programs (or in the “Evaluate” statements in the second stage INI) can be added to each of the traces. The function that processes the INI files (read_ini_files.m) will add the property and its assigned value to the trace structure but the rest of the Trace Analysis programs will ignore it. The user can then parse the trace info in their own programs (or within “Evaluate” statements) and take advantage of this feature.<br />



[XXX Move description of tags and global variables (everything beneath this comment) to separate section? This section is getting long...]

##### Tags for Dependent Variables
As mentioned in the "dependent" parameter description, you can use the tags feature to ensure that your INI file "catches" all common dependent variables. This feature utilizes the Biomet library Matlab function `tags_Standard.m`.  You should list the tag in the dependent field for it to work. 

For example, given the standard tags, if you put `'tag_H2O_All'` in the dependent field for a trace, all traces listed under that tag will then be a dependent of that trace. Tags can refer to other tags. You can also create site-specific custom tags by creating a `siteID_CustomTags.m`, making sure to follow the same format as the tags in `tags_Standard.m` (see section XXX for the location where this optional file should live). 

Tags in your site-specific custom file will overwrite tags of the same name in the `tags_Standard.m` file, and Matlab will warn you that this is occurring (by beeping and writing out a message to the screen).


##### Global Variables

 *Global Variables*
At the top of the sample first stage INI file that you obtained (`DSM_FirstStage.ini` XXX check site name once decided), you will notice sections with headers containing "Global Variables". To simplify entering and editing the required parameters into the first stage INI file there is an option to apply the same setting to many traces at once, using this global variables feature. These are always defined at the beginning of the INI file. (Note: only the main body of your INI file, not your "include files", should have global variables.)
 
The main advantage that this provides is an option of having a standard set of variables defined in the template files that can be loaded into each site-specific INI file using the `#include` statement. [XXX FYI to a newer user, I don't think it's clear how this part is an advantage and these are linked at this point]

Another advantage is that you can apply changes to multiple traces all at once if needed, by making only one edit at the top of the file. Then you do not risk missing out a trace needed the same edit, so long as it is referenced correctly. 

There are three types of global variables, as follows:

* Instrument-specific (`globalVars.Instrument`). Example: `globalVars.Instrument.LI7200.instrumentSN  = '72H-1029'`.
* Trace-specific (`globalVars.Trace`). Example: `globalVars.Trace.CH4.currentCalibration = [1000 0 datenum(2021,1,1) datenum(2999,1,1)]`.
* Other (`globalVars.other`).

*How global variables work:*
1. The trace settings (all fields between [TRACE] and [END] in the INI file) are loaded up.
2. The program then cycles through all the traces. For each trace, first it checks if the "instrumentType" field matches one of the `globalVars.Instrument` fields, e.g., for `instrumentType = 'LI7700'` measuring "CH4",  if there is a `global.Instrument.LI7700` field, then all its fields would be applied to the trace CH4, either creating a new field or overwriting the existing fields; i.e., the content of `global.Instrument.LI7700.instrumentSN` would replace the content of the CH4 field `instrumentSN`. Secondly, it checks if the trace name `variableName` matches any of the `globalVars.Trace` fields, e.g. Trace "CH4".
3. The program continues reading the INI file and applies all the settings from the [TRACE]-[END] sections.
4. Cycles through all the `globalVars.Instrument` fields and creates or overwrites the fields.
5. Cycles through all the `globalVars.Trace` fields and creates or overwrites the fields.
 
Example:
* In the INI file, the trace "CH4" has the field `currentCalibration` set to empty: `currentCalibration = []`
* There is a global variable for the same trace with the correct `currentCalibration` field:
`globalVars.Trace.CH4.currentCalibration = [1000 0 datenum(2021,1,1) datenum(2999,1,1)]`
* The final result is that the field `currentCalibration` for the trace "CH4" gets set to: `currentCalibration = [1000 0 datenum(2021,1,1) datenum(2999,1,1)]`.
 

For the instrument-specific global variables, each trace has an `instrumentType` field. Currently we use five default instrument types (six if we consider an empty field `[]` as a type):
* LI7200
* LI7700
* Anemometer
* EC
* otherTraces. 

You can also create your own unique sensor option for instrumentType, if you need to apply a setting to multiple traces. If `otherTraces` is enabled (`otherTraces.Enable = 1`) these settings are applied to all the traces not defined under any other groups, or the ones that have `instrumentType=[]`. Future improvements to global variables include adding a MET type.

For the third type of global variable, e.g., `globalVars.other`, currently you can use this to carry out single-point interpolation, for cases where only one half-hourly data point is missing:
```
globalVars.other.singlePointInterpolation = 'on'  % 'no_interp' - skip interpolation [default], 'on' - do single missing point interpolation for all traces
```

#### *Second Stage INI file*

#### Second Stage
The steps to create your first stage INI are very similar to the first stage:
* Duplicate the `DSM_SecondStage.ini` file you obtained then rename it with you unique measurement site ID, e.g., `mySiteID_SecondStage.ini` (you should have already completed this step [XXX link to Obtain_Sample_Config_Standardization_Files.md]).
* Edit second stage INI file adding *just a few variables at a time* (as with the first stage) and then testing, so it’s easy to diagnose errors/typos. Pay attention to the output in your Matlab command window, it is informative and highlights any issues and where they occur. Recall the data cleaning principles previously outlined [XXX link to Data_Cleaning_Principles section?] and make sure your traces align with the second stage principles.

#### Second stage main features:
1. Combining multiple sensor measurements into one trace. This can be done in different ways using `calc_avg_trace.m`, which combines two or more traces from the first stage (i.e., already deemed “good” sensor measurements; see section XXX on data cleaning principles). You can also combine these three methods:
 * Averaging multiple sensors to remove variability;
 * Using one sensor as the best (most accurate value) and using the other sensor(s) only to fill in the missing values. A relationship can be created between the “best” sensor and its “replacement” and that relationship can be applied to the “replacement” values to improve the accuracy;
 * Using the sensors from another near-by site to fill in the missing values at the current site.

    Arguments for `calc_avg_trace` function:
    | Field | Description | Type |
    | ----- | ----------- | ---- |
    | tv | input the time vector `clean_tv` that has already been created in the first stage cleaning | n/a|
    | data_in | the name of the trace output from stage one, to be filled or "improved" by combining/averaging with another trace or traces | string uppercase |
    | data_fill | the name of the traces used to average/gap-fill "data_in" trace; these "data_fill" traces must have been included in the first stage | integer |
    | avg_period | |



2. As with the first stage, more complex user-defined processing can be applied to the trace using the “Evaluate” option. User written Matlab functions can be called from this statement. Multiple Matlab statements can be called from within the “Evaluate” string. Some rules for formatting apply here (see the DSM SecondStage ini file for details and examples).

[Add DSM_SecondStage.INI file image or link to file for downloading]

#### Second Stage INI file Properties
| Field      | Description |

Once you have added a few variables to the second stage INI, test it using the following Matlab command:
`fr_automated_cleaning(yearIn,siteID,[1 2])`
Alternatively, if you already ran the first stage, you can simply run:
`fr_automated_cleaning(yearIn,siteID,2)`.
