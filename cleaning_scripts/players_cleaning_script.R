library(readxl)
library(tidyverse)
library(janitor)
library(here)

players <- read_excel(here("raw_data/six_nations_2019.xlsx"), sheet = "players") %>% 
  clean_names()

players_longer <- players %>% 
  select(-(six_nations_won:rpi_score)) %>% 
  relocate(club, .after = player) %>% 
  pivot_longer(six_nations_matches:x2019_red_cards,
               names_to = "stat",
               values_to ="count") %>% 
  drop_na(count) %>% 
  filter(str_detect(stat, "x2019")) %>% 
  mutate(stat = str_remove(stat, "x2019_")) %>% 
  mutate(stat = str_remove(stat, "six_nations_")) %>% 
  mutate(stat = str_replace_all(stat, "_", " ")) %>% 
  mutate(stat = str_to_title(stat)) 

player_info <- players %>% 
  select(player, club,  position_detailed,born, height_in_metres, weight_in_kg, forward_or_back, country) %>% 
  mutate(weight_in_kg = as.numeric(weight_in_kg)) %>% 
  mutate(weight_in_kg = round(weight_in_kg)) %>% 
  mutate(forward_or_back = factor(forward_or_back, levels = c("Forward", "Back")))

players_longer %>% 
  write_csv("clean_data/players.csv")
player_info %>% 
  write_csv("clean_data/players_info.csv")