#### Preamble ####
# Purpose: Downloads and saves the data from Statistics Canada
# Author: Yuchao Niu
# Date: 17 April, 2024
# Contact: yc.niu@utoronto.ca
# License: MIT
# Pre-requisites: N.A.
# Any other information needed? N.A.


#### Workspace setup ####

library(tidyverse)
library(arrow)
library(dplyr)


#### Download data ####


# URLs of CSV files to download
csv_urls <- c(
  "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=3510007601&latestN=0&startDate=20000101&endDate=20230101&csvLocale=en&selectedMembers=%5B%5B2%5D%2C%5B1%2C2%2C3%2C4%2C6%2C7%2C10%2C11%2C12%2C13%2C14%2C15%5D%5D&checkedLevels=",
  "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=3510007601&latestN=0&startDate=20000101&endDate=20230101&csvLocale=en&selectedMembers=%5B%5B3%5D%2C%5B1%2C2%2C3%2C4%2C6%2C7%2C10%2C11%2C12%2C13%2C14%2C15%5D%5D&checkedLevels=",
  "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=3510007601&latestN=0&startDate=20000101&endDate=20230101&csvLocale=en&selectedMembers=%5B%5B4%5D%2C%5B1%2C2%2C3%2C4%2C6%2C7%2C10%2C11%2C12%2C13%2C14%2C15%5D%5D&checkedLevels=",
  "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=3510007601&latestN=0&startDate=20000101&endDate=20230101&csvLocale=en&selectedMembers=%5B%5B5%5D%2C%5B1%2C2%2C3%2C4%2C6%2C7%2C10%2C11%2C12%2C13%2C14%2C15%5D%5D&checkedLevels=",
  "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=3510007601&latestN=0&startDate=20000101&endDate=20230101&csvLocale=en&selectedMembers=%5B%5B6%5D%2C%5B1%2C2%2C3%2C4%2C6%2C7%2C10%2C11%2C12%2C13%2C14%2C15%5D%5D&checkedLevels=",
  "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=3510007601&latestN=0&startDate=20000101&endDate=20230101&csvLocale=en&selectedMembers=%5B%5B7%5D%2C%5B1%2C2%2C3%2C4%2C6%2C7%2C10%2C11%2C12%2C13%2C14%2C15%5D%5D&checkedLevels=",
  "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=3510007601&latestN=0&startDate=20000101&endDate=20230101&csvLocale=en&selectedMembers=%5B%5B8%5D%2C%5B1%2C2%2C3%2C4%2C6%2C7%2C10%2C11%2C12%2C13%2C14%2C15%5D%5D&checkedLevels=",
  "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=3510007601&latestN=0&startDate=20000101&endDate=20230101&csvLocale=en&selectedMembers=%5B%5B9%5D%2C%5B1%2C2%2C3%2C4%2C6%2C7%2C10%2C11%2C12%2C13%2C14%2C15%5D%5D&checkedLevels=",
  "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=3510007601&latestN=0&startDate=20000101&endDate=20230101&csvLocale=en&selectedMembers=%5B%5B10%5D%2C%5B1%2C2%2C3%2C4%2C6%2C7%2C10%2C11%2C12%2C13%2C14%2C15%5D%5D&checkedLevels=",
  "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=3510007601&latestN=0&startDate=20000101&endDate=20230101&csvLocale=en&selectedMembers=%5B%5B11%5D%2C%5B1%2C2%2C3%2C4%2C6%2C7%2C10%2C11%2C12%2C13%2C14%2C15%5D%5D&checkedLevels=")
# Initialize an empty vector to store downloaded file names
downloaded_files <- c()

# Loop through each URL in csv_urls
for (url in csv_urls) {
  # Extract the file name from the URL
  file_name <- basename(url)
  
  # Download the file
  download.file(url, file_name)
  
  # Append the file name to the vector of downloaded files
  downloaded_files <- c(downloaded_files, file_name)
}

# Read and combine CSV files
merged_data <- lapply(downloaded_files, read.csv)
raw_data <- bind_rows(merged_data)

#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_parquet(raw_data, "../Police_crime_analysis/data/raw_data/raw_data.parquet") 
write_csv(raw_data, "../Police_crime_analysis/data/raw_data/raw_data.csv")


