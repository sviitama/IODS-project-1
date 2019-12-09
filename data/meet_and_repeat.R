# Sirja Viitamäki
# This script creates a modified version of dataset
# 9.12.2019

# Set working directory
setwd("C:/Users/sirja/Documents/IODS-project-1")
#setwd("Z:/Jatko-opinnot/IODS/IODS-project-1")

# Access needed libraries
library(tidyverse)

# Read in datasets
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header=TRUE, sep=" ")
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header=TRUE, sep="\t")

names(BPRS)
names(RATS)
str(BPRS)
str(RATS)
dim(BPRS)
dim(RATS)

# Convert the categorical variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert the data sets to long form and add a week variable to BPRS and a Time variable to RATS
BPRSL <- BPRS %>% gather(key=weeks, value=bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5, 5)))
RATSL <- RATS %>% gather(key=WD, value=Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD, 3,4))) 

# Compare wide and long datasets
names(BPRS)
names(BPRSL)
str(BPRS)
str(BPRSL)
summary(BPRS)  
summary(BPRSL)

names(RATS)
names(RATSL)
str(RATS)
str(RATSL)
summary(RATS)
summary(RATSL)

# In wide data the observations made in each time point are as separate variables. 
# In lognitudinal data the data in different time points is gathered under one variable.
# Transforming wide data to longitudinal is a requirement for certain analyses.

# Save the data
write.csv(BPRSL, "data/BPRSL.txt")
write.csv(RATSL, "data/RATSL.txt")
