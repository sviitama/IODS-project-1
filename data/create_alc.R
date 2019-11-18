# Sirja Viitamaki
# 18.11.2019
# This script creates a joined and modified of two dataframes 
# from UCI Machine Learning Repository, Student Performance Data (incl. Alcohol consumption) page:
# https://archive.ics.uci.edu/ml/datasets/Student+Performance
# You can find the zip folder containing two csv files from "Download: Data Folder".


# Set working directory
setwd("Z:/Jatko-opinnot/IODS/IODS-project-1")

# access libraries
library("tidyverse")

# read both student-mat.csv and student-por.csv into R (from the data folder) 
math <- read.csv("data/student-mat.csv", sep=";", header = TRUE)
por <- read.csv("data/student-por.csv", sep=";", header = TRUE)

# explore the structure and dimensions of the data
str(math)
str(por)
dim(math)
dim(por)


# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

# explore the structure and dimensions of the data
str(math_por)
dim(math_por)

# glimpse at the data
glimpse(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use, fill = sex))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# initialize a plot of 'high_use'
g2 <- ggplot(data = alc, aes(x = alc_use, fill = sex))

# draw a bar plot of high_use by sex
g2 + geom_bar()+facet_wrap("sex")

# take a look of the data
glimpse(alc) # should be 382 observations and 35 variables

# write as a csv to "data" folder
write.csv(alc, "data/joined_data.csv", row.names=FALSE)
