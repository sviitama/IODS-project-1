# Set working directory
#setwd("C:/Users/sirja/Documents/IODS-project-1")
setwd("Z:/Jatko-opinnot/IODS/IODS-project-1")

# Access needed libraries
library(tidyverse)

# read in datasets
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# explore data
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

# change variable names
colnames(hd)
colnames(hd) <- c("HDIRank", "Country", "HDI", "LifeExp", "ExpEdu", "EduYs", "GNI", "GNI-HDI")

colnames(gii)
colnames(gii) <- c("GIIRank", "Country", "GII", "MatMort", "AdolBirth", "ParlRep", "SecEduF", "SecEduM", "LabourF", "LabourM")


# the ratio of Female and Male populations with secondary education in each country. 
gii$EduRatio <- gii$SecEduF / gii$SecEduM

# the ratio of labour force participation of females and males in each country
gii$LabourRatio <- gii$LabourF / gii$LabourM

#Join together the two datasets using the variable Country as the identifier.
hd_gii <- inner_join(hd, gii, by = "Country")
str(hd_gii) #The joined data should have 195 observations and 19 variables. 

#Call the new joined data "human" and save it in your data folder
write.csv(hd_gii, "data/human.csv", row.names=FALSE)
