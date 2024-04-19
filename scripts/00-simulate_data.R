#### Preamble ####
# Purpose: Cleans the Raw Data
# Author: Yuchao Niu
# Date: 6 April 2023 
# Contact: yc.niu@utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)


#### Simulate data ####
# Load necessary libraries
library(dplyr)

# Set seed for reproducibility
set.seed(123)

# Define the provinces
provinces <- c("Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador",
               "Nova Scotia", "Ontario", "Prince Edward Island", "Quebec", "Saskatchewan")

# Generate random data
n <- 100  # Number of rows

data <- data.frame(
  year = sample(2000:2023, n, replace = TRUE),
  province = sample(provinces, n, replace = TRUE),
  crime_severity_index = runif(n, min = 50, max = 150),  # Uniform distribution between 50 and 150
  police_per_100k = runif(n, min = 100, max = 300),      # Uniform distribution between 100 and 300
  woman_to_man_ratio = runif(n, min = 0.1, max = 1)      # Uniform distribution between 0.1 and 1
)

# View the first few rows of the dataset
head(data)




