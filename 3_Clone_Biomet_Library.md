## 3. Clone the Biomet.net library Git repository to your local computer

The [Biomet.net repository](https://github.com/ubc-micromet/Biomet.net) contains libraries of computer code (in Matlab, R, Python, etc.) related to running the data cleaning pipeline. It contains (a) the scripts to run the first, second, and third cleaning stages, as well as conversion to AmeriFlux format, and also (b) many functions to help analyse and visualise data throughout all the stages of data processing and cleaning.

In principle, users should not need to edit this code library. Instead, as far as possible, you will interface with it using various configuration files unique to your own project(s). This process is described later. First, you need to clone the repository.

#### Instructons to clone the Biomet.net repository from a terminal:

 1. Make sure you are in the directory (folder) where you wish the repository to live, for example, your computer `C:` drive for PCs, or `/Users/<username>/` for Macs, or something similar depending on your preferences.

 2. Next, follow the instructions on [this website](https://www.educative.io/answers/how-to-clone-a-git-repository-using-the-command-line) to clone the repository.

 3. If you have any difficulties or are unsure of `git` procedures in general, see [this online tutorial](https://ecoflux-lab.github.io/Documentation/UsingGit.html).
 
 3. Always keep your local copy of the `Biomet.net` code up to date by periodically using the `git pull` command every few days, or when you know there has been a change to the code. You must be in the repository directory for this to work.

NOTE: It is not good practice to save any of your code into the `Biomet.net` folder! If you wish to contribute your own code to the `Biomet.net` library, see [XXX link to "Install_Git_Create_Account.md"].