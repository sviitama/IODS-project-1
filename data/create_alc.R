# Sirja Viitamaki
# 18.11.2019
# This script ...


# Set working directory
setwd("Z:/Jatko-opinnot/IODS/IODS-project-1")

# read both student-mat.csv and student-por.csv into R (from the data folder) 
mat <- read.table("data/student-mat.csv", sep="\t", header = TRUE)
por <- read.table("data/student-por.csv", sep="\t", header = TRUE)

# explore the structure and dimensions of the data
str(mat)
str(por)
dim(mat)
dim(por)


#Join the two data sets using the variables "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" as (student) identifiers. Keep only the students present in both data sets. Explore the structure and dimensions of the joined data. (1 point)

#Either 
# a) copy the solution from the DataCamp exercise The if-else structure to combine the 'duplicated' answers in the joined data
# b) write your own solution to achieve this task. (1 point)


#Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data. 

#Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise). (1 point)


#Glimpse at the joined and modified data to make sure everything is in order. The joined data should now have 382 observations of 35 variables. 

#Save the joined and modified data set to the ‘data’ folder, using for example write.csv() or write.table() functions. (1 point)
