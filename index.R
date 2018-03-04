# DEPENDENCIES

# install.packages("shiny")
# install.packages('Hmisc')
# install.packages('httr')
# install.packages('jsonlite')
# install.packages('dplyr')
# install.packages("tidyr")
# install.packages("countrycode")
# install.packages("ggplot2")
# install.packages("maps")
# install.packages("sp")
# install.packages("maptools")


# library("shiny")
library(Hmisc)
library(httr)
library(jsonlite)
library(dplyr)
library(tidyr)
# library("countrycode")
# library("ggplot2")
# library("maps")
# library("sp")
# library("maptools")

# IMPORTS
# relative.path <- '~info201/INFO201-Final-Project'
# setwd(relative.path)

# emissions.data <- read.csv(
#   './data/WDI_emissions_Data.csv',
#   fileEncoding = 'UTF-8-BOM',
#   stringsAsFactors = FALSE
# )

# source('./ui.R')
# source('./server.R')
#
# # START APPLICATION
# shinyApp(ui = the.ui, server = the.server)


# EX: "https://api.propublica.org/congress/v1/115/bills/hr21.json"
# https://uwstf.org/v2/proposal/?query={"year":"<2018"}&populate=["body"]&select=["title","year","number","organization","category","asked","received","body"]
stf.api <- "https://uwstf.org/v2"
model <- 'proposal'
query <- '"year":"<2018"'
populate <- '"body"'

resource <- sprintf('/%s/?query={%s}&populate=[%s]', model, query, populate)
uri <- paste0(stf.api, resource)
print(uri)

response <- GET(uri)
print(response)
body <- fromJSON(content(response, "text"))
print(body)

data <- flatten(body) %>%
  filter(published == TRUE) %>%
  # mutate(body = as.data.frame(body.legacy)) %>%
  filter(length(body) > 0)
# print(data)
