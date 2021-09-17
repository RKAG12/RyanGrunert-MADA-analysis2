###############################
# analysis script
#
#this script loads the processed, cleaned data, does a simple analysis
#and saves the results to the results folder

#load needed packages. make sure they are installed.
library(ggplot2) #for plotting
library(broom) #for cleaning up output from lm()
library(here) #for data loading/saving
library(dplyr) #for filters and %>%
library(ggplot2)

#path to data
#note the use of the here() package and not absolute paths
data_location <- here::here("data","processed_data","processeddataBot.rds")

#load data. 
df <- readRDS(data_location)

######################################
#Data exploration/description
######################################

#summarize data 
mysummary = summary(df)

#look at summary
print(mysummary)

#do the same, but with a bit of trickery to get things into the 
#shape of a data frame (for easier saving/showing in manuscript)
summary_df = data.frame(do.call(cbind, lapply(mydata, summary)))

#save data frame table to file for later use in manuscript
summarytable_file = here("results", "summarytable.rds")
saveRDS(summary_df, file = summarytable_file)

#######################################
#Data Manipulation and Visualization
#######################################
#1) As part of the data analysis, could be a good idea know the behavior 
# of Botulism cases in Georgia throught the years.

GA <- df %>% filter(State=="Georgia")

#Visualization "Boltulism cases in Georgia (1943 - 2017)"
install.packages("tidyverse")
Plot_GA<-ggplot(GA, aes(x= Year, y= Count))+ geom_point()+
  ggtitle("Boltulism cases in Georgia (1943 - 2017)") +
  ylab("Count") +
  xlab("Year")
Plot_GA
#save figure
Figure1 = here("results","resultfigure.png")
ggsave(filename = Figure1, plot=Plot_GA) 

#2) What is the most common type of Botulism?

BT <- aggregate(Count ~ BotType, data = df, sum) 

Plot_BT <- ggplot(BT, aes(x=BotType , y=Count))+
              geom_bar(stat= "identity") +
              ggtitle("Frequency of Botulism Type") +
              ylab("Count") +
              xlab("BotType")
Plot_BT
#save figure
Figure2 = here("results","resultfigure.png")
ggsave(filename = Figure2, plot=Plot_BT) 

#BotType = I was the most common type of Botulism during the study.

# 3) Top 5 of States with more cases
cs <- aggregate (Count ~ State, data= df, sum) 
B5<- arrange(cs, desc(Count)) 
Btop5<- head(B5, 5)

Plot_Btop5 <- ggplot(Btop5 , aes(x=State , y=Count))+
  geom_bar(stat= "identity") +
  ggtitle("Frequency of Botulism Type") +
  ylab("Count") +
  xlab("BotType")
Plot_Btop5 
#save figure
Figure3 = here("results","resultfigure.png")
ggsave(filename = Figure3, plot=Plot_BT) 


  