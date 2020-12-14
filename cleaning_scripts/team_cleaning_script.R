library(readxl)
library(tidyverse)
library(janitor)
library(here)

teams<- read_excel("raw_data/six_nations_2019.xlsx", sheet = "teams") %>% 
  clean_names()

teams_longer <- teams %>% 
  pivot_longer(cols = points:metres_per_carry,
               values_to = "total", 
               names_to = "variable") %>% 
  mutate(variable = str_replace_all(variable, "_", " ")) %>% 
  mutate(variable = str_to_title(variable))

teams_longer %>% 
write_csv("clean_data/teams.csv")