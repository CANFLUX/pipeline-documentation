## 8. &nbsp; Data Visualization Apps

<link rel="stylesheet" href="css/style.css">

Previously, we briefly mentioned some ways to visualize your data (section 5.1). This current section gives details on our recommended methods for viewing and analyzing your data, both during cleaning, and once you have real-time data flowing. 

#### Matlab

There are several Matlab functions for visualizing data:

* `plotApp`: a Matlab graphical user interface (GUI) which we recommend using during database set up and cleaning of your data (see section 7.1 for details).\
* `gui_Browse_Folder`: given a filepath, this function will open a new figure window and provide a dropdown containing all traces located at that filepath location. You can pick one or scroll through using the arrow buttons. A working example is provided in section 5.1.\
* `guiPlotTraces`: this is an older function with less utility than the `plotApp` GUI, but it still displays your data for quick viewing.

#### RShiny

There is also an R Shiny App which is useful for viewing your flux data in real-time (see section 7.2 for details). You can host this on an RShiny server to make your data publicly viewable.



