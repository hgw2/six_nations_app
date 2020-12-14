library(readxl)
library(tidyverse)
library(janitor)
library(here)

trophies<- read_excel("raw_data/six_nations_2019.xlsx", sheet = "trophies") %>% 
  clean_names()

trophies_long <- trophies %>% 
  pivot_longer(cols = champions:wooden_spoon,
               values_to = "country",
               names_to = "trophy") %>% 
  mutate(country = str_squish(country)) %>% 
  mutate(trophy = str_replace_all(trophy, "_", " ")) %>% 
  mutate(trophy = str_to_title(trophy))  


individual_tophies <- trophies_long %>% 
  distinct(trophy) %>% 
  pull()

trophies_order <- trophies_long %>% 
  mutate(trophy = factor(trophy, levels = individual_tophies)) %>% 
  distinct(trophy) %>% 
  arrange(desc(trophy)) %>% 
  pull()

trophies_long <- trophies_long %>% 
  mutate(trophy = factor(trophy, levels = individual_tophies))
trophies_long %>% 
  write_csv("clean_data/trophies.csv")