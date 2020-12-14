library(here)
source(here("code.R"))

ui <- fluidPage(
  dashboardPage(
    skin = "black",
    dashboardHeader(title = "2019 Six Nations "),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Overall", tabName = "overall", icon = icon("trophy")),
        menuItem("Top 5", tabName = "top_5", icon = icon("football-ball")),
        menuItem("Teams", tabName = "teams", icon = icon("users"))
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(
          tabName = "overall",
          fluidRow(
            box(
              width = 12,
              status = "primary",
              tags$style(".irs-bar {",
                         "  border-color: transparent;",
                         "  background-color: transparent;",
                         "}",
                         ".irs-bar-edge {",
                         "  border-color: transparent;",
                         "  background-color: transparent;",
                         "}"),
              sliderInput("year",
                "Select year",
                value = 2019,
                max = 2020, min = 1883,
                sep = "", 
                ticks = TRUE
              )
            ),
            box(
              title = textOutput("title"),
              width = 12,
              plotOutput("trophy")
            )
          )
        ),
        tabItem(
          tabName = "top_5",
          fluidRow(
            box(
              width = 12,
              status = "primary",
              fluidRow(
                column(
                  4,
                  pickerInput("country",
                    "Country",
                    choices = all_countries,
                    selected = all_countries,
                    options = list(`actions-box` = TRUE),
                    multiple = T
                  )
                ),
                column(
                  4,
                  pickerInput("position",
                    "Forward or Back",
                    choices = all_positions,
                    selected = all_positions,
                    options = list(`actions-box` = TRUE),
                    multiple = T
                  )
                ),
                column(4, pickerInput("club",
                  "Club",
                  choices = all_clubs,
                  selected = all_clubs,
                  options = list(`actions-box` = TRUE),
                  multiple = T
                ))
              )
            )
          ),
          fluidRow(
            box(
              title = selectInput("input1",
                "Select Top 5",
                choices = player_stat,
                selected = "Tries"
              ),
              width = 6,
              plotOutput("tries")
            ),
            box(
              title = selectInput("input2",
                "Select Top 5",
                choices = player_stat,
                selected = "Points"
              ),
              width = 6,
              plotOutput("points")
            )
          ),
          fluidRow(
            box(
              title = selectInput("input3",
                "Select Top 5",
                choices = player_stat,
                selected = "Try Assists"
              ),
              width = 6,
              plotOutput("assists")
            ),
            box(
              title = selectInput("input4",
                "Select Top 5",
                choices = player_stat,
                selected = "Carries"
              ),
              width = 6,
              plotOutput("carries")
            )
          )
        ),
        tabItem(
          tabName = "teams",
          fluidRow(
            box(
              width = 12,
              prettyRadioButtons("select_country",
                "Select Country",
                choices = all_countries,
                inline = TRUE
              )
            )
          ),
          fluidRow(
            column(
              6,
              box(
                title = "Squad",
                width = 12,
                dataTableOutput("player_info"),
                options = list(`scrollX` = TRUE)
              )
            ),
            column(
              6,
              box(
                title = "Total Scored",
                width = 12,
                plotOutput("scores")
              ),
              box(
                title = "Squad Weight",
                width = 12,
                plotOutput("weight")
              ),
              box(
                title = "Clubs",
                width = 12,
                plotOutput("club")
              )
            )
          )
        )
      )
    )
  )
)
