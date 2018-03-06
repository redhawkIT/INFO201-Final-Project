## DEPENDENCIES
### Utilities
# install.packages('Hmisc')
# Web Packages
# install.packages('shiny')
# install.packages('httr')
# install.packages('jsonlite')
### Data Manipulation:
# install.packages('dplyr')
# install.packages('tidyr')
### Text Mining:
# install.packages('tidytext')
# install.packages('tm')
# install.packages('SnowballC')
# install.packages('syuzhet')
### Visualization:
# install.packages('ggplot2')

library(shiny)
library(Hmisc)
library(httr)
library(jsonlite)
library(dplyr)
library(tidyr)
library(tidytext)
library(tm)
library(syuzhet)
library(SnowballC)
library(ggplot2)

## IMPORTS
source('./src/GetProposals.R')
source('./src/AnalyzeProposals.R')

## DATA COLLECTION & ANALYSIS
proposals <- GetProposals()
analysis <- AnalyzeProposals(proposals)

## WEB SERVER
source('./ui.R')
source('./server.R')

## START APPLICATION
# shinyApp(ui = the.ui, server = the.server)
