#### Preamble ####
# Purpose: Models
# Author: yc.niu@utoronto.ca
# Date: 11 April, 2024 
# Contact: yc.niu@utoronto.ca
# License: MIT
# Pre-requisites: N.A.
# Any other information needed? N.A.

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(rstanarm)

#### Read data ####
analysis_data <- read_parquet("../Police_crime_analysis/data/analysis_data/analysis_data.parquet")
dim(analysis_data)

#### Model data ####
first_model <-
  stan_glm(
    formula = crime_severity_index ~ province + police_officers_per_100_000_population + woman_to_man_ratio,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )

second_model <-
  stan_glm(
    formula = log(crime_severity_index) ~ province + woman_to_man_ratio + 
      police_officers_per_100_000_population + police_civilian_ratio,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )

third_model <- 
  stan_glm(
    formula = log(crime_severity_index) ~ province + woman_to_man_ratio,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )

fourth_model <-
  stan_glm(
    formula = crime_severity_index ~ province + woman_to_man_ratio + 
      province * woman_to_man_ratio,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )

#### Save model ####
saveRDS(
  first_model,
  file = "../Police_crime_analysis/models/first_model.rds"
)

saveRDS(second_model, 
        file = "../Police_crime_analysis/models/second_model.rds"
)

saveRDS(third_model, 
        file = "../Police_crime_analysis/models/third_model.rds"
)

saveRDS(fourth_model, 
        file = "../Police_crime_analysis/models/fourth_model.rds"
)
