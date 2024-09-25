## Troubleshooting, Special Cases, and FAQ


#### Special Cases

This section outlines some recurring special cases and how to deal with them:

1. *There is a variable defined in an include INI file that there is no raw input data for.* 

    In this case, you can add the following code to the global variables section of your first stage INI file (see XXX [link section describing global variables]).

    ```
    %-->Avoiding errors due to missing input files 
    dateRangeNoData = [datenum(1900,1,1) datenum(1900,12,31)]
    globalVars.Trace.dummyVariable.inputFileName_dates = dateRangeNoData
    ```
    E.g., if you are running data cleaning for the year 2023, this code essentially tells the pipeline that for this "dummyVariable", no data exists for 2023 (and only exists for the year 1900), and the program will continue smoothly with no errors.

* add info from troubleshooting new Macbook
* add UBC-specific cases?
* add INI file specific cases, e.g., flags, etc.

XXX not complete