# Data management
library(readr)
library(tidyverse)
library(lubridate)
library(here)
library("meltt")
library(knitr)
library(dplyr)
library(janitor)

#### HUD data  ####
library(readxl)
hudPicture2023_414982 <- read_csv("hudPicture2023_414982.csv")
hud <- hudPicture2023_414982
rm(hudPicture2023_414982)

##cleans the names of the variables in the dataset 
hud<- clean_names(hud)

##view all variable names
variable_names <- names(hud)
print(variable_names)

##drop all but needed variables 
hud <- select(hud, average_months_on_waiting_list, average_months_since_moved_in, name, percent_62_or_more_head_or_spouse, 
              percent_85_or_more_head_or_spouse, percent_minority, percent_occupied, state)

#New var for total wait time 
hud$total_wait <- hud$average_months_on_waiting_list + hud$average_months_since_moved_in

#Rename county var
hud <- rename(hud, county = name)

#Arrange the dataset by total_wait in ascending order
hud_sorted <- arrange(hud, total_wait)

#Get the top 10 counties with the highest total_wait
top_10_highest <- head(hud_sorted, 10)
print(top_10_highest)

#Get the bottom 10 counties with the lowest total_wait
bottom_10_lowest <- tail(hud_sorted, 10)
print(bottom_10_lowest)

# Replace missing values with NA


# Replace specific values with NA for all variables
for (col in names(hud)) {
  hud[[col]][hud[[col]] %in% c(-1, -4, -5)] <- NA
}


print(hud)




