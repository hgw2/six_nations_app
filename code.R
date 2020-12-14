library(shiny)
library(tidyverse)
library(shinydashboard)
library(here)
library(shinyWidgets)

teams <- read_csv(here("clean_data/teams.csv"))
trophies <- read_csv(here("clean_data/trophies.csv"))  %>% 
  mutate(trophy = factor(trophy, levels = c("Wooden Spoon", "Doddie Weir Trophy","Auld Alliance Trophy","Guseppe Garibaldi Trophy", "Centanary Quaich", "Millenium Trophy", "Calcutta Cup", "Triple Crown", "Grand Slam", "Champions")))
players <- read_csv(here("clean_data/players.csv"))
trophies_full <- read_csv(here("clean_data/mens_full_trophies.csv"))  %>%  
  mutate(trophy = factor(trophy, levels = c("Wooden Spoon", "Doddie Weir Trophy","Auld Alliance Trophy","Giuseppe Garibaldi Trophy", "Centenary Quaich", 	
                                                                                                            "Millennium Trophy", "Calcutta Cup", "Triple Crown", "Grandlam", "Champions")))

player_info <- read_csv(here("clean_data/players_info.csv"))

distinct_teams <- teams %>% 
  distinct(variable) %>% 
  pull()

player_stat <- players %>% 
  distinct(stat) %>% 
  pull()

all_countries <- players%>% 
  distinct(country) %>% 
  arrange(country) %>% 
  pull()

all_clubs <- players %>% 
  distinct(club) %>% 
  arrange(club) %>% 
  pull()

all_positions <- players %>% 
  distinct(forward_or_back) %>% 
  pull()


club_colours <- c("Toulouse" = "#c70023",   
                  "Brive" = "#353638",
                  "Racing 92" = "#b6e0f2",     
                  "Touloun"  =     "#a6032b",  
                  "Montpellier"   ="#51ade7" ,
                  "Bordeaux" ="#893240",     
                  "Grenoble"  ="#3565bd",     
                  "La Rochelle" = "#33272f",   
                  "Lyon" = "#d20f38",          
                  "Castres" = "#0461cd",        
                  "Stade Francais" ="#ff70af", 
                  "Agen" = "#f7fcfe",        
                  "Clermont" ="#f4d201",      
                  "Leinster" ="#007dba",      
                  "Connacht" ="#058d55",      
                  "Ulster" ="#d9d9d9",       
                  "Munster" ="#fe2a4e",       
                  "Edinburgh" =   "#282841",  
                  "Glasgow" ="#605458",      
                  "Worcester" ="#203565",     
                  "Gloucester" ="#941b24" ,   
                  "Northampton" ="#35706c",  
                  "Saracens" ="#3a3c47",      
                  "Sale" = "#2b406c",         
                  "Cardiff Blues" = "#30365a",
                  "Scarlets" ="#cd3437" ,      
                  "Gwent Dragons" ="#1c1c21",  
                  "Ospreys" ="#17131a",        
                  "Bath"= "#0f57e2" ,          
                  "Leicester" ="#24594c",    
                  "Exeter Chiefs" ="#a59eb5",
                  "Wasps" = "#ef863e",        
                  "Harlequins" ="#9fd6e8" ,  
                  "Zebre"  = "#2d2425",       
                  "Benetton" = "#03905f",
                  "England Under 20's" = "#F5F5F5" )

country_colours <- c("England" =  "#F5F5F5" ,
                     "Scotland" = "#003157",
                     "Wales" = "#f90000",
                     "Ireland" = "#00ae12",
                     "Italy" = "#65d0f7" ,
                     "France" = "#1601ff", 
                     "Not Completed" = "Black",
                     "World War I" = "Black",
                     "World War II" = "Black")



