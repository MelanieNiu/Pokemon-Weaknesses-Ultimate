#### Preamble ####
# Purpose: Cleans the Raw Data
# Author: Yuchao Niu
# Date: 6 April 2023 
# Contact: yc.niu@utoronto.ca
# License: MIT

#### Workspace setup ####
install.packages("janitor")
library(tidyverse)
library(arrow)
library(janitor)
library(ggplot2)
library(dplyr)

#### Clean data ####
clean_data <- read_parquet("data/raw_data/raw_data.parquet")

clean_data <- clean_data |>
  select(REF_DATE, GEO, Statistics, VALUE)

clean_data <- clean_data |>
  pivot_wider(id_cols = c(1,2), names_from = Statistics, values_from = VALUE) |>
  clean_names()

analysis_data <- clean_data |>
  mutate(woman_to_man_ratio = women_police_officers/men_police_officers,unfilled_position_per_100_000_population = authorized_police_officer_strength_per_100_000_population - police_officers_per_100_000_population) |>
  rename(year = ref_date) |>
  mutate(province = case_when(
    geo %in% c("Nova Scotia","New Brunswick", "Prince Edward Island") ~ "Maritime",
    TRUE ~ as.character(geo)
  )
  ) |>
  select(year, province, crime_severity_index, police_civilian_ratio, police_officers_per_100_000_population, woman_to_man_ratio, unfilled_position_per_100_000_population)

#### Save data ####
write_parquet(analysis_data, "data/analysis_data/analysis_data.parquet")


