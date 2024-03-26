#### Preamble ####
# Purpose: Simulates a dataset about Pokemon level and weaknesses
# Author: Yuchao Niu
# Date: 26 March 2024
# Contact: yc.niu@mail.utoronto.ca
# License: MIT
# Pre-requisites: N.A.

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
data <-
  tibble(
    level = rnorm(n = 1000, mean = 100, sd = 10) |> floor(),
    weakness = sample(x = c("fire", "not fire"), size = 1000, replace = FALSE)
  )
