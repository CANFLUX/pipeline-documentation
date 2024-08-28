## Obtain the Necessary Sample, Configuration and Standardization Files

#### Sample INI files

As mentioned previously, INI files are site-specific. Even if you have measurement sites that are similar in terms of sensors and how they are set up, you should still focus on one site to begin with. Once you have INI files created for your first site, you can duplicate the files and edit as necessary for your remaining sites.

Next steps:

* Obtain sample INI files for first, second, and third stage cleaning, and put them in each siteID directory (see tree structure below). You can use these as guidance to edit your own INI files to perform the data cleaning for your own site(s).
 
    <img src="images/directory_trees/DirectoryTree6.jpg" alt="DirectoryTree:INI_FileLocation" width="450"/>

* Duplicate the files (to keep the original samples untouched), and rename them according to your own site ID.

* Stage one and two INI files are essentially text files written with the same specific format, whereas stage three is an R-script, hence the different suffix. 

#### Configuration and Standardization Files

There are numerous other configuration and standardization files needed to run the data cleaning: 

[XXX maybe just list the files here and explain them later when describing the data cleaning process in the INI file section??]
* Obtain the following configuration and standardization files listed and described here:
    1. *global_config.yml*: global default configuration file for third stage cleaning.
    2. *siteID_config.yml*: site-specific configuration file for third stage cleaning.
    3. *EddyPro_Common_FirstStage_include.ini*: If your site uses EddyPro to process the data, you should utilize this file which standardizes EddyPro output for you. You must include this file as the last line at the end of your first stage INI file, as follows: `#include EddyPro_Common_FirstStage_include.ini` [XXX link to DSM full example/INI file section].
    4. *EddyPro_LI7200_FirstStage_include.ini / EddyPro_LI7200_FirstStage_include.ini / EddyPro_LI7200_FirstStage_include.ini*: Depending on which LiCor instrument(s) you have at your site, you can also use these instrument-specific EddyPro files that standardize the output. Note that you can always override these settings by using the global variables functionality, described in section [XXX link to INI file section].
    5. *RAD_FirstStage_include.ini*
    6. *_StandardTags.yml*: [XXX actually not sure where/how this is used, the first stage tags feature calls on the Matlab function tags_Standard.m...? Is this for a later stage?]
    7. *siteID_CustomTags.m*: Optional; custom tags (located in Derived_Variables)

* Put these files in the locations shown in the following directory tree:

    <img src="images/directory_trees/DirectoryTree7b.jpg" alt="DirectoryTree:ConfigFileLocations" width="550"/>

* For the site-specific files, i.e., filenames that contain "siteID", duplicate them and rename them with your own siteID. 

* *siteID_CustomTags.m* is an optional file. You may have to create the directory `Derived_Variables` within `TraceAnalysis_ini`. [XX revisit this once everything else is covered, might tell them to create this elsewhere] 