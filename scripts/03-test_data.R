#### Preamble ####
# Purpose: Tests the Police Crime Data
# Author: yc.niu@utoronto.ca
# Date: April 4th, 2024
# Contact: yc.niu@utoronto.ca
# License: MIT


#### Workspace setup ####
install.packages("testthat")
library(tidyverse)
library(testthat)
library(dplyr)
library(arrow)

analysis_data <- read_parquet("data/analysis_data/analysis_data.parquet")
data <- analysis_data

#### Tests ####

# Test 1: Data frame should have the correct number of columns
test_that("Data frame has the correct number of columns", {
  expect_equal(ncol(data), 7)
})

# Test 2: Data frame has the correct column names
test_that("Data frame has the correct column names", {
  expect_equal(colnames(data), c("year", "province", "crime_severity_index", "police_officers_per_100_000_population", "police_civilian_ratio", "woman_to_man_ratio", "unfilled_position_per_100_000_population"))
})

# Test 3: No NA values should be present
test_that("Data contains no NA values", {
  expect_true(!any(is.na(data)))
})

# Test 4: Year range should be between 2000 and 2023
test_that("Year column within valid range", {
  expect_true(all(data$year >= 2000 & data$year <= 2023))
})

# Test 5: Province names are valid
test_that("Provinces are valid", {
  valid_provinces <- c("Alberta", "British Columbia", "Manitoba", "Maritime", "Newfoundland and Labrador",
                       "Ontario", "Quebec", "Saskatchewan")
  expect_true(all(data$province %in% valid_provinces))
})

# Test 6: Crime severity index should be within a realistic range
test_that("Crime severity index is within range", {
  expect_true(all(data$crime_severity_index >= 30 & data$crime_severity_index <= 300))
})

# Test 7: Police per 100k should be within a specified range
test_that("Police per 100k is within range", {
  expect_true(all(data$police_officers_per_100_000_population>= 100 & data$police_officers_per_100_000_population <= 300))
})

# Test 8: Woman-to-man ratio should be between 0.1 and 1
test_that("Woman-to-man ratio is within range", {
  expect_true(all(data$woman_to_man_ratio >= 0.1 & data$woman_to_man_ratio <= 1))
})

# Test 9: Data frame should have exactly 100 rows if expected
test_that("Data frame has 230 rows", {
  expect_equal(nrow(data), 230)
})

# Test 10: Check for duplicate rows
test_that("No duplicate rows are present", {
  expect_equal(nrow(data), nrow(distinct(data)))
})

