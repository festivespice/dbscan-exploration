#The global R file is used to import all packages before we start our app.

#1) set the workinig directory of the console to the directory with this file.
#2) do 'source("global.R")'
#3) finally, 'runApp()'

#Packages
library(shiny) #used for quickly creating a web app for showing our information
library(shinydashboard) #used for the dashboard layout of the app
library(shinyWidgets) #used for setting the background color with gradient... seems to have a memory leak maybe though...
library(htmltools) #used to fix the includeHTML issue: replace with tags$iframe

library(ggplot2) #used for plotting
library(ggrepel) #used for plotting with separated labels

set.seed(36)
library(dbscan) #used for dbscan clustering outputs
library(factoextra) #used for visualizing clustering outputs
library(OpenML) #used for obtaining data from the openML database

library(tidyverse) #used for the pipe function
library(dplyr) #i forgot what this was used for


