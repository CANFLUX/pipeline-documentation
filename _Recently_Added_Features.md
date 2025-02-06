## Recently Added Features

<link rel="stylesheet" href="css/style.css">

This page contains significant features recently added to the data cleaning pipeline - most recent at the top. Details can also be found in the full documentation (updated on this website soon).

##### *Updated: 6 February 2025*

**Overwrite feature:**

Sometimes we need to overwrite multiple properties for one or more traces that have already been created e.g. in an include file. The global variables feature allows this, however, once this section becomes long with many property tweaks, it can become very hard to troubleshoot, and in these cases having all the information for one trace together is more desirable. 

Instead of using global variables you can duplicate the full trace (`[Trace] ... [END]`), and in your site-specific first stage INI file, put this duplicate *after* the line of code where the include file with your original trace is called (see figure A). Note the additional `Overwrite` property highlighted in yellow. 

There are three overwrite options:

* `0` = do not overwrite with this trace. This is the default setting. If you do not include the `Overwrite` parameter, the pipeline assumes this option.

* `1` = overwrite traces having the same variableName and also with `Overwrite = 0` setting (all include file traces have this as default XXX). This puts the new data where the old data was, i.e., complete overwrite, first trace gone.  In Figure A, the original CH4_MIXING_RATIO will be erased and the new one will be put into trace_str ("list" of all traces and their properties) just before all the RAD_include traces. 

* `2` = overwrite traces having the same variableName and with `Overwrite = 0` setting. This takes advantage of previous trace and will not completely overwrite. The original is erased and the new one gets put where ever it fits (it becomes the "last" trace in the loaded traces until another trace is loaded after it). [XXX Zoran, I can't think of an example where this would be used.]

Most of the time, if you are overwriting, you will want option `1`.

<img src="images/ini_files/ini_example1a.jpg" alt="INIfiles/OverwriteFeature" width="650"/>

*Figure A: Location within site-specific INI file to put duplicate trace for overwriting a trace previously defined in an include INI file. Yellow highlighting shows the syntax for the "overwrite" property.*

<br>

**New *postEvaluate* property:**

The new `postEvaluate` property can be applied in the first stage. It is executed in the first stage *after* all other cleaning is done, e.g., minMax, calibration, etc.. This is in contrast to the `Evaluate` property which is executed *before* other cleaning properties. The example below shows a good example with appropriate usage of both properties:

[XXX update figure]

<img src="images/ini_files/ini_example1a.jpg" alt="INIfiles/OverwriteFeature" width="650"/>



