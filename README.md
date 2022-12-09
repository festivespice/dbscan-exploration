# dbscan-exploration
A website using the R programming language and Shiny to explain and educate readers about DBSCAN. 

# How to use
1) Install the packages listed in the global.R file. This could be done automatically but I haven't implemented that yet. 
2) Set the working directory of the R console, if using RStudio, to the directory with the server.R and ui.R files, with the global.R file by using the 'setwd()' function.
3) In the console, type "source('global.R')" to import all of the packages that will be used for the application.
4) In the console, type 'runApp()' with no parameters. The function should be able to find the ui and server files in the same directory and use them. 