# Sirja Viitamäki
# This script creates a modified version of dataset originates from the United Nations Development Programme.
# data origin: http://hdr.undp.org/en/content/human-development-index-hdi
# and http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
# Set working directory

setwd("C:/Users/sirja/Documents/IODS-project-1")
#setwd("Z:/Jatko-opinnot/IODS/IODS-project-1")

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
human <- inner_join(hd, gii, by = "Country")
str(human) #The joined data should have 195 observations and 19 variables. 

#Call the new joined data "human" and save it in your data folder
write.csv(human, "data/human.csv", row.names=FALSE)

#  1.12.2019

# access needed packages
library(stringr)

# see structure of the data
str(human)
# dataset "human" has 195 observations and 19 variables.
# Variables are: 
# "HDIRank"    = Human Development Index rank
# "Country"    = Country name
# "HDI"        = Human Development Index
# "LifeExp"    = Life expectancy at birth
# "ExpEdu"     = Expected years of schooling
# "EduYs"      = Mean Years of Education
# "GNI"        = Gross National Income per capita
# "GNI-HDI"    = GNI per Capita rank minus HDI Rank
# "GIIRank"    = Gender Inequality Index rank
# "GII"        = Gender Inequality Index 
# "MatMort"    = Maternal mortality ratio
# "AdolBirth"  = Adolescent birth rate
# "ParlRep"    = Percetange of female representatives in parliament
# "SecEduF"    = Proportion of females with at least secondary education 
# "SecEduM"    = Proportion of males with at least secondary education 
# "LabourF"    = Proportion of females in the labour force
# "LabourM"    = Proportion of males in the labour force
# "EduRatio"   = SecEduF / SecEduM
# "LabourRatio = LabourF / LabourM

# change "GNI" from character to numeric
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()

# keep selected data
keep_columns <- c("Country", "EduRatio", "LabourRatio", "ExpEdu", "LifeExp", "GNI", "MatMort", "AdolBirth", "ParlRep")
human <- dplyr::select(human, one_of(keep_columns))

# remove rows with missing values
human <- filter(human, complete.cases(human)==TRUE)

# remove the observations which relate to regions instead of countries
human$Country # seven last observations are regions
human <- head(human, -7)

# set country names as rownames and remove column "Country"
rownames(human) <- human$Country
human <- dplyr::select(human, -Country)

# save as csv
write.csv(human, "data/human.csv")