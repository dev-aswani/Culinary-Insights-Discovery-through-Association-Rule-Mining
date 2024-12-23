# Title:  Association Analysis with Apriori
# File:   Apriori.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)

install.packages("pacman")

library(pacman)

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  arules,        # Association rules mining
  arulesViz,     # Visualize association rules
  arulesCBA,
  magrittr,      # Pipes
  rio,           # Import/export data
  tidyverse,      # So many reasons
  jsonlite
)

install.packages("arules")
install.packages("arulesViz")
install.packages("arulesCBA")
install.packages("magrittr")
install.packages("rio")
install.packages("tidyverse")
install.packages("jsonlite")

library(jsonlite)
library("arules")
library("arulesViz")
library("arulesCBA")
library("tidyverse")
library("magrittr")
library("rio")

# SET RANDOM SEED ##########################################

# Set random seed for reproducibility in processes like
# sampling and splitting the data
set.seed(1)  # You can use any number here

# LOAD DATA ################################################

rating <- read.csv("Ratings.csv", sep=",", dec=".", header=TRUE)

book <- read.csv("Books.csv", sep=",", dec=".", header=TRUE)
install.packages("jsonlite")
library(jsonlite)

# Specify the path to the JSON file
json_file_path <- "train.json"

# Read the JSON file
ingredients_data <- fromJSON(json_file_path)
dataset<- as.data.frame(ingredients_data)
View(dataset)
df_unnested <- unnest(dataset, ingredients)
View(df_unnested)
df_unnested <- df_unnested %>%
  filter(ingredients!='salt')

View(df_unnested)

write.csv(df_unnested,file="ingredients.csv")

trans<-read.transactions("ingredients.csv", format="single",
                         sep=",", cols=c("id","ingredients"), header=TRUE)

#plotting item frequency----
itemFrequencyPlot(trans, topN=15, type="relative", main="Ingredients Frequency") 
View(trans)
#checking out data ----
summary(trans)


#creating rules----

#iteration 1

rules_1<-apriori(trans, parameter=list(supp=0.003, conf=0.7)) 
inspect(rules_1)
#sort by rating
inspect(sort(rules_1[1:10], by = "support"))
#sort by confidence
inspect(sort(rules_1[1:10], by = "confidence"))
#sort by lift
inspect(sort(rules_1[1:10], by = "lift"))


#iteration 2

rules_2<-apriori(trans, parameter=list(supp=0.0008, conf=0.87)) 
rules_2
inspect(rules_2)
#sort by rating
inspect(sort(rules_2[1:10], by = "support"))
#sort by confidence
inspect(sort(rules_2[1:10], by = "confidence"))
#sort by lift
inspect(sort(rules_2[1:10], by = "lift"))


#iteration 3

rules_3<-apriori(trans, parameter=list(supp=0.002, conf=0.8)) 
inspect(rules_3)
#sort by rating
inspect(sort(rules_3[1:10], by = "support"))
#sort by confidence
inspect(sort(rules_3[1:10], by = "confidence"))
#sort by lift
inspect(sort(rules_3[1:10], by = "lift"))

library("RColorBrewer")



#filter based on lhs----

rules_lhs<-apriori(trans, parameter=list(supp=0.0021, conf=0.7)) 
rules_lhs

#Iteration 1
rules_lhs_1_filtered <- subset(rules_lhs, subset = lhs %in% "garlic" & size(lhs) >= 1)
inspect(rules_lhs_1_filtered,linebreak = FALSE)
rules_lhs_2_filtered
#Iteration 2
rules_lhs_2_filtered <- subset(rules_lhs, subset = lhs %in% "garam masala" & size(lhs) >= 1)
inspect(rules_lhs_2_filtered,linebreak = FALSE)

#Iteration 3
rules_lhs_3_filtered <- subset(rules_lhs, subset = lhs %in% "sesame oil" & size(lhs) >= 1)
inspect(rules_lhs_3_filtered,linebreak = FALSE)

# Graph of top 20 rules
set.seed(123)
plot(rules_lhs_3_filtered[1:10], method="paracoord", control=list(reorder=TRUE))
plot(
  rules_lhs_1_filtered[1:10], 
  method = "graph", 
  control = list(type = "items")
)
set.seed(123)
plot(rules_lhs_1_filtered[1:10], shading="order", control=list(main="Two-key plot"))



#filter based on rhs ----

#iteration 1
rules_rhs_1<-apriori(data=trans, parameter=list(supp=0.0005, conf=0.8, minlen=2), 
                     appearance=list(default="lhs",rhs="ground cumin"), 
                     control=list(verbose=F)) 
rules_rhs_1

inspect(rules_rhs_1)

#iteration 2
rules_rhs_2<-apriori(data=trans, parameter=list(supp=0.00055, conf=0.7, minlen=2), 
                     appearance=list(default="lhs",rhs="vanilla extract"), 
                     control=list(verbose=F)) 
rules_rhs_2

inspect(rules_rhs_2)
#iteration 3
rules_rhs_3<-apriori(data=trans, parameter=list(supp=0.00084, conf=0.73, minlen=2), 
                     appearance=list(default="lhs",rhs="ground turmeric"), 
                     control=list(verbose=F)) 
rules_rhs_3

inspect(rules_rhs_3)


set.seed(2121)
plot(rules_rhs_1, method="paracoord", control=list(reorder=TRUE))
plot(rules_rhs_1, shading="order", control=list(main="Two-key plot"))
plot(rules_rhs_3, method="graph", measure="support", shading="lift", main="Grocery rules")


#minumum no. ingredients is 3 ----

#iteration 1

rules_1<-apriori(trans, parameter=list(supp=0.0023, conf=0.75, minlen=3)) 
rules_1
inspect(rules_1)
#sort by rating
inspect(sort(rules_1[1:10], by = "support"))
#sort by confidence
inspect(sort(rules_1[1:10], by = "confidence"))
#sort by lift
inspect(sort(rules_1[1:10], by = "lift"))


#iteration 2

rules_2<-apriori(trans, parameter=list(supp=0.0033, conf=0.67, minlen=3)) 
rules_2
inspect(rules_2)
#sort by rating
inspect(sort(rules_2[1:10], by = "support"))
#sort by confidence
inspect(sort(rules_2[1:10], by = "confidence"))
#sort by lift
inspect(sort(rules_2[1:10], by = "lift"))


#iteration 3

rules_3<-apriori(trans, parameter=list(supp=0.0011, conf=0.85, minlen=3)) 
rules_3
inspect(rules_3)
#sort by rating
inspect(sort(rules_3[1:10], by = "support"))
#sort by confidence
inspect(sort(rules_3[1:10], by = "confidence"))
#sort by lift
inspect(sort(rules_3[1:10], by = "lift"))


# filter based on rhs for minlen = 3
#iteration 1
rules_rhs_1<-apriori(data=trans, parameter=list(supp=0.0005, conf=0.8, minlen=3), 
                     appearance=list(default="lhs",rhs="ground cumin"), 
                     control=list(verbose=F)) 
rules_rhs_1

inspect(rules_rhs_1)

#iteration 2
rules_rhs_2<-apriori(data=trans, parameter=list(supp=0.00065, conf=0.7, minlen=3), 
                     appearance=list(default="lhs",rhs="eggs"), 
                     control=list(verbose=F)) 
rules_rhs_2

inspect(rules_rhs_2)
#iteration 3
rules_rhs_3<-apriori(data=trans, parameter=list(supp=0.00071, conf=0.68, minlen=3), 
                     appearance=list(default="lhs",rhs="tomatoes"), 
                     control=list(verbose=F)) 
rules_rhs_3

inspect(rules_rhs_3)


set.seed(32234)
plot(rules_rhs_3, method="paracoord", control=list(reorder=TRUE))
plot(rules_rhs_3, shading="order", control=list(main="Two-key plot"))
plot(rules_rhs_3, method="graph", measure="support", shading="lift", main="Grocery rules")

