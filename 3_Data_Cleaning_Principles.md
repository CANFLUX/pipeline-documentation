## 3. &nbsp; Data Cleaning Principles

This section outlines the data cleaning principles and processes that should be followed closely and applied at each of the three stages, as well as other relevant information.

<img src="images/principles/Database_Workflow_Principles_v2.jpg" alt="DataCleaningPrinciplesSummary" width="500"/>

*Figure 3. Chart outlining the data cleaning principles followed in the pipeline.*

### First Stage  
* **Principle: during the first stage of data cleaning we want to keep the best measured data values *from each sensor***, i.e., a user looking for the best measurements from a particular sensor would want to use the first stage data. Missing data points for periods of more than one half-hour will not be gap-filled in any way. <!-- (note that one missing half-hourly data point can be interpolated linearly, see section XXX for details). -->

* At the most basic level, the first stage collects the raw data, applies min/max filtering, assigns consistent variable names in line with <a href="https://ameriflux.lbl.gov/data/aboutdata/data-variables/" target="_blank" rel="noopener noreferrer">Ameriflux guidelines</a> as far as possible, and moves the relevant files to a `Clean` folder in preparation for stage two. This folder will be created automatically if it does not already exist. 

* The data are stored as binary files in "single-precision floating-point format" (aka float 32), which importantly means they are readable in most common computer languages and softwares.

### Second Stage 
* **Principle: the second stage focuses on creating the best measured data values *for each particular property/variable***. For example, if there are two (or more) collocated temperature sensors at the same height e.g., 2 metres above ground level, the second stage is intended to create the "best" trace using both (all) sensors, with the highest precision/accuracy and the fewest missing points. By default, it does this by averaging the traces, and gap-filling by using linear regression. Optionally, data can be gap-filled using a nearby climate station, or one of your own nearby stations if you have one. (Other gap-filling methods, such as using reanalysis data, are currently under development.)

* In practice, the second stage collects the first stage data, generates the "best" observation for each variable and moves the relevant files to a "Clean/SecondStage" folder in preparation for the third stage.

### Third Stage 
* **Principle: USTAR filtering, gap-filling, and CO2 flux partitioning**.
* The third stage collects the second stage data and implements USTAR filtering, gap-filling, and flux partitioning procedures. For this we use the R package <a href="https://bg.copernicus.org/articles/15/5015/2018/bg-15-5015-2018.html" target="_blank" rel="noopener noreferrer">REddyProc</a>. Biomet.net functions allow Matlab to interface with R, so all three stages are run directly from Matlab. For more machine learning approaches to gap-filling, we also implement the [random forest approach](https://github.com/yeonukkim/EC_FCH4_gapfilling) described in the paper by [Kim et al. (2020)](https://onlinelibrary.wiley.com/doi/abs/10.1111/gcb.14845). Additional methane gap-filling processes currently not part of the pipeline are described <a href="https://github.com/stanfordmlgroup/methane-gapfill-ml/tree/FL" target="_blank" rel="noopener noreferrer">here</a>, with instructions <a href="https://github.com/stanfordmlgroup/methane-gapfill-ml/blob/FL/Tutorial_from_data_download_to_gap-filling.docx" target="_blank" rel="noopener noreferrer">here</a>.

We achieve these principles by setting up various configuration files used in each stage. This process is described later (section 6), but there are a few more steps to complete before that. Next, you will set up your project directory structure, then configure it to work with the Biomet.net library.
