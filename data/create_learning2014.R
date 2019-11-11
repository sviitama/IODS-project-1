# Sirja Viitamaki
# 11.11.2019
# This scripts creates a modified version of the original dataset: questions related to a certain type of learning (deep, surface and strategic) are summed.

# access needed libraries
library(dplyr)

# Download data from a website
lrn14 <- read.table('https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt', sep="\t", header = TRUE)

# Check how the data looks like
str(lrn14)
dim(lrn14)

# Create an analysis dataset
# Gather the names of questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06", "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# Select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# Remove observations with zero points
learning2014 <- filter(learning2014, Points > 0)

# See the stucture of the new dataset
str(learning2014)

# Modify column names to uniform style
colnames(learning2014) <- c("gender","age","attitude", "deep", "stra", "surf", "points")

# Set working directory
setwd("Z:/Jatko-opinnot/IODS/IODS-project-1")

# Save the analysis dataset
write.csv(learning2014, "learning2014.csv")

# See if you can read the data again
learn2014again <- read.csv("learning2014.csv")

# Check that the data was exported and imported again correctly
str(learn2014again)
head(learn2014again)
=======
# Sirja Viitamaki
# 11.11.2019
# This scripts creates a modified version of the original dataset: questions related to a certain type of learning (deep, surface and strategic) are summed.

# access needed libraries
library(dplyr)

# Download data from a website
lrn14 <- read.table('https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt', sep="\t", header = TRUE)

# Check how the data looks like
str(lrn14) # shows the structure: column names (codes for the for the questions), variable class (all integers) and head of the values. 
dim(lrn14) # shows the dimensions of the dataframa: 183 observations of  60 variables


# Create an analysis dataset
# Gather the names of questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06", "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns of questions related to each learning type
deep_columns <- select(lrn14, one_of(deep_questions))
surface_columns <- select(lrn14, one_of(surface_questions))
strategic_columns <- select(lrn14, one_of(strategic_questions))

#create column for each type as average of the questions
lrn14$deep <- rowMeans(deep_columns)
lrn14$surf <- rowMeans(surface_columns)
lrn14$stra <- rowMeans(strategic_columns)

# choose which columns to keep in the new dataset
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))

# Remove observations with zero points
learning2014 <- filter(learning2014, Points > 0)

# See the stucture of the new dataset
str(learning2014)

# Modify column names to uniform style
colnames(learning2014) <- c("gender","age","attitude", "deep", "stra", "surf", "points")

# Set working directory
setwd("Z:/Jatko-opinnot/IODS/IODS-project-1")

# Save the analysis dataset
write.csv(learning2014, "learning2014.csv")

# See if you can read the data again
learn2014again <- read.csv("learning2014.csv")

# Check that the data was exported and imported again correctly
str(learn2014again)
head(learn2014again)
