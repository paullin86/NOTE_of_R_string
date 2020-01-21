# FuzzyMergeR101
# https://www.princeton.edu/~otorres/FuzzyMergeR101.pdf
# Reading the data, two files ‘sp500’ and ‘nyse’
sp500 <- read.csv("http://www.princeton.edu/~otorres/sandp500.csv") 
head(sp500) 
nyse <- read.csv("http://www.princeton.edu/~otorres/nyse.csv")
head(nyse)
# Separating the string variable from each dataset 
sp500.name = data.frame(sp500$Name)
names(sp500.name)[names(sp500.name)=="sp500.Name"] = "name.sp"
sp500.name$name.sp = as.character(sp500.name$name.sp)
sp500.name = unique(sp500.name) # Removing duplicates
head(sp500.name) 
# Separating the string variable from each dataset 
nyse.name = data.frame(nyse$Name)
names(nyse.name)[names(nyse.name)=="nyse.Name"] = "name.nyse"
nyse.name$name.nyse = as.character(nyse.name$name.nyse)
nyse.name = unique(nyse.name) # Removing duplicates
head(nyse.name) 
# Matching string variables from sp500 to nyse data 
sp500.name$name.nyse <- "" # Creating an empty column 
for(i in 1:dim(sp500.name)[1]) {
  x <- agrep(sp500.name$name.sp[i], nyse.name$name.nyse,
             ignore.case=TRUE, value=TRUE,
             max.distance = 0.05, useBytes = TRUE)
  x <- paste0(x,"")
  sp500.name$name.nyse[i] <- x
} 
# For more info/details, type ?agrep 
# -----------------------------------
# First column has the original names in the file sp500; 
# second column has the corresponding matched names from the nyse file. 
# This file is the key file to merge the full datasets (make sure to check it first) 
head(sp500.name, 13)
# Notice line 9 has the wrong match. Further cleaning and data inspection is
# needed when performing fuzzy matching. 

# Merging the key file 
# Merging the key file sp500.name to the original dataset sp500 
sp500 = merge(sp500, sp500.name, by.x=c("Name"), by.y=c("name.sp"), all= TRUE) 
head(sp500) 
# Renaming the original variable for company name in dataset sp500 
# (this is for  better tracking when merging the nyse file). 
names(sp500)[names(sp500)=="Name"] = "name.sp" 
# Merging the two files 
# Merging the two original data files (keeping all data from both) 
companies = merge(sp500, nyse, by.x=c("name.nyse"), by.y=c("Name"), all = TRUE)
companies[sample(nrow(companies), 30), ] 
# Merging the two original data files (keeping only perfect matches) 
companies1 = merge(sp500, nyse, by.x=c("name.nyse"), by.y=c("Name")) 
companies1[sample(nrow(companies1), 30), ] 

# --------- stringdist
# install.packages("stringdist")
library(stringdist)

ClosestMatch = function(string, stringVector){
  
  stringVector[amatch(string, stringVector, maxDist=Inf)]
  
}
