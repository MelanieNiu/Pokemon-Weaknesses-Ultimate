#### Preamble ####
# Purpose: Tests the Cancer Dataset
# Author: yc.niu@utoronto.ca
# Date: April 4th, 2024
# Contact: yc.niu@utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)

#### Test data ####

# 1. Test for Missing Values
if (anyNA(cancer_data)) {
  stop("There are missing values in the dataset.")
}

# 2. Test if the maximum year is 2023
if (max(cancer_data$Year) != 2023) {
  stop("The maximum year in the dataset is not 2023.")
}

# 3. Test if the minimum year is 2004
if (max(cancer_data$Year) != 2023) {
  stop("The minimum year in the dataset is not 2004.")
}

# 4. Test if the type of year is integer
if (!is.integer(cancer_data$Year)) {
stop("The type of 'Year' in the dataset is not integer.")
}

# 5. Test if unique hospital indices are one of the values from 1 to 5
if (!all(unique(cancer_data$Hospital) %in% 1:5)) {
  stop("The unique hospital indices are not one of the values from 1 to 5.")
}

# 6. Test for missing values
if (anyNA(cancer_data)) {
  stop("There are missing values in the dataset.")
}

# 7. Test for any death number that is negative
if (any(cancer_data$Deaths < 0)) {
  stop("There are negative values for deaths.")
}

# 8. Test for any death number that is not integer
if(!is.integer(cancer_data$death)) {
  stop("The type of 'Deaths' in the dataset is not integer.")
}

# 9. Test for distribution of deaths (poisson)
lambda <- 120
if (abs(mean(cancer_data$Deaths) - lambda) > 1) {
  stop("Mean of deaths is not approximately equal to the Poisson parameter.")
}

# 10. Test for any duplications in the data frame
if (any(duplicated(cancer_data[c("Year", "Hospital")]))) {
  stop("There are duplicate combinations of year and hospital in the dataset.")
}
