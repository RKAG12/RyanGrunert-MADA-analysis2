###############################
# Processing script for Botulism Data


#load needed packages. make sure they are installed.
library(dplyr) #for data processing
library(here) #to set paths
library(tidyverse) #all required data manipulation packages

# #This dataset shows the frequency count of confirmed botulism cases in a 
# specific state and year, while also showing the type of botulism detected
# and the specific toxin the confirmed cases contained. 

#path to data
#note the use of the here() package and not absolute paths
data_location <- here::here("data","raw_data","Botulism.csv")

#load data. 
rawdata <- read.csv(data_location)

#take a look at the data
dplyr::glimpse(rawdata)

#This prints the rawdata so you can see the structure
print(rawdata)

######Exploring the Data
summary(rawdata)
# State                Year        BotType           ToxinType        
# Length:2280        Min.   :1899   Length:2280        Length:2280       
# Class :character   1st Qu.:1976   Class :character   Class :character  
# Mode  :character   Median :1993   Mode  :character   Mode  :character  
# Mean   :1986                                        
# 3rd Qu.:2006                                        
# Max.   :2017                                        
# Count       
# Min.   : 1.000  
# 1st Qu.: 1.000  
# Median : 1.000  
# Mean   : 3.199  
# 3rd Qu.: 3.000  
# Max.   :59.000  

unique(rawdata$BotType)
# [1] "Foodborne" "Infant"    "Wound"     "Other"   
#These are the different botulism types

unique(rawdata$ToxinType)
# [1] "Unknown" "E"       "B"       "A"       "F"       "A&B"     "AB"     
# [8] "Ba"      "Bf"      "E,F"     "ABE"     "Ab"      "B/F"     "A/B/E"  
#These are the different toxin types detected

#Raw data is formatted correctly, just need to abbreviate some aspects to make analysis easier

rawdata$BotType <- strtrim(rawdata$BotType, 1) 
#This abbreviates the BotType column to just the first letter for easier manipulation

rawdata[rawdata == "Unknown"] <- NA
#This replaces all the "Unknown" values in the ToxinType column with an NA value
#Going to leave the NA values in the dataset, those observations are still
#helpful in analyzing the dataset even though the Toxin type isn't known.


processeddata <- rawdata
#this includes the processed data for part two

# location to save file
save_data_location <- here::here("data","processed_data","processeddataBot.rds")

#Saves the processeddata as an rds file for analysis
saveRDS(processeddata, file = save_data_location)











