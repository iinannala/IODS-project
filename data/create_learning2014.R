#Iina Annala
#14.11.2021
#This file is for data wrangling in week 2 IODS course

#read the table, and check it. his data has 60 variables with 183 columns, with data types being numerical, except for gender (character)
week2data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(week2data)

str(week2data)

#another name for the table
learning2014 <- week2data

#get dplyr package for next things
install.packages("dplyr")
library(dplyr)

#creating analysis variables gender, age, attitude, deep, stra, surf and points
#gender and age will not be combined or scaled

#making new columns to the dataframe from the calculated means of the questions of deep, surface and strategic categories, respectively
deep_quest <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_columns <- select(learning2014, one_of(deep_quest))
learning2014$deep <- rowMeans(deep_columns)

surface_quest <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
surface_columns <- select(learning2014, one_of(surface_quest))
learning2014$surf <- rowMeans(surface_columns)

strategic_quest <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
strategic_columns <- select(learning2014, one_of(strategic_quest))
learning2014$stra <- rowMeans(strategic_columns)

# created a column 'attitude' by scaling the column "Attitude", which is already a sum of 10 questions (Da-Dj) in the questionnaire
learning2014$attitude <- learning2014$Attitude/10

#renaming Age and Points columns
colnames(learning2014)[57] <- "age"
colnames(learning2014)[59] <- "points"

#headers I want for the new dataframe
header_subset <- c("gender", "age", "attitude", "deep", "stra", "surf", "points")
learning2014_subset <- select(learning2014, one_of(header_subset))

#the rows with 0 points excluded
learning2014_subset <- filter(learning2014_subset, points > 0)

#checked that 166 obs. of 7 variables left, as said in instructions
dim(learning2014_subset)

#save the table in data folder in IODS (working directory)
write.csv(learning2014_subset, file = "data/learning2014_subset.csv", row.names = FALSE)

#reload the csv file and checking that the structure is OK
learning2014_subset <- read.csv("data/learning2014_subset.csv")
learning2014_subset
str(learning2014_subset)
head(learning2014_subset)
