library(readxl)
library(tidyverse)
library(janitor)
library(here)

trophies_full <- read_excel("raw_data/full_six_nations_results.xlsx", sheet = "Mens Full") %>% 
  clean_names()


trophies_full_long <- trophies_full %>% 
  pivot_longer(cols = champions:wooden_spoon,
               values_to = "won",
               names_to = "trophy") %>% 
  mutate(trophy = str_replace_all(trophy, "_", " ")) %>% 
  mutate(trophy = str_to_title(trophy)) %>% 
  filter(won > 0) %>% 
  select(-won)


trophies_full_long %>% 
  write_csv("clean_data/mens_full_trophies.csv")