server <- function(input, output) {
  tournament_name <- reactive({
    trophies_full %>%
      filter(year == input$year) %>%
      distinct(tournament_name) %>% 
      pull(tournament_name)
  })
  
  tournament_year <- reactive({
    trophies_full %>%
      filter(year == input$year) %>%
      distinct(year) %>% 
      pull(year)
  })
  
  output$title<- renderText({
    paste(tournament_year(), tournament_name(), "Trophies", sep = " ")
  })
  output$trophy <- renderPlot({
    trophies_full %>%
      filter(year == input$year) %>%
      drop_na() %>%
      ggplot() +
      aes(x = trophy, fill = nation) +
      geom_bar(colour = "black", position = "fill") +
      coord_flip() +
      labs(x = "Trophy \n ", fill = "Nation") +
      scale_fill_manual(values = country_colours) +
      theme(
        axis.line = element_blank(), axis.text.x = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank(), 
        text = element_text(size = 20) 
      )
  })
  
  filtered_data <- reactive({
    filtered_data <- players %>%
      filter(country %in% input$country ) %>% 
      filter(forward_or_back %in% input$position ) %>% 
      filter(club %in% input$club ) %>% 
      mutate(count = na_if(count, 0)) %>% 
      drop_na()
    
  })

  output$club <- renderPlot({
    filtered_data() %>%
      distinct(country, club, player, forward_or_back) %>%
      group_by(club) %>%
      summarise(total_number = n()) %>%
      ggplot() +
      aes(x = reorder(club, -total_number), y = total_number, fill = club) +
      geom_col(colour = "black") +
      scale_fill_manual(values = club_colours, guide = FALSE) +
      labs(x = "Club", y = "Number of PLayers") +
      geom_text(aes(label = total_number), vjust = -0.3) +
      theme(
        axis.line = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank()
      )
  })


  
  output$tries <- renderPlot({
   filtered_data() %>% 
      filter(stat == input$input1) %>%
      slice_max(count, n = 5, with_ties = FALSE) %>%
      ggplot() +
      aes(x = reorder(player, -count), y = count, fill = country) +
      geom_col(colour = "black") +
      geom_text(aes(label = count), vjust = -0.3) +
      labs(x = "\n Player", y = "Tries")+
      scale_fill_manual(values = country_colours, guide = FALSE) +
      theme(
        axis.line = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank(),
        text = element_text(size = 15) 
      )
  })


  output$points <- renderPlot({
    filtered_data() %>%
      filter(stat == input$input2) %>%
      slice_max(count, n = 5, with_ties = FALSE) %>%
      ggplot() +
      aes(x = reorder(player, -count), y = count, fill = country) +
      geom_col(colour = "black") +
      scale_fill_manual(values = country_colours, guide = FALSE) +
      labs(x = "\n Player", y = "Number of Points")+
      geom_text(aes(label = count), vjust = -0.3) +
      theme(
        axis.line = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank(),
        text = element_text(size = 15) 
      )
  })

  output$assists <- renderPlot({
    filtered_data() %>%
      filter(stat == input$input3) %>%
      slice_max(count, n = 5, with_ties = FALSE) %>%
      ggplot() +
      aes(x = reorder(player, -count), y = count, fill = country) +
      geom_col(colour = "black") +
      scale_fill_manual(values = country_colours, guide = FALSE) +
      labs(x = "\n Player", y = "Try Assists")+
      geom_text(aes(label = count), vjust = -0.3) +
      theme(
        axis.line = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank(),
        text = element_text(size = 15) 
      )
  })
  output$carries <- renderPlot({
    filtered_data() %>% 
      filter(stat == input$input4) %>%
      slice_max(count, n = 5, with_ties = FALSE) %>%
      ggplot() +
      aes(x = reorder(player, -count), y = count, fill = country) +
      geom_col(colour = "black") +
      geom_text(aes(label = count), vjust = -0.3) +
      labs(x = "\n Player", y = "Tries")+
      scale_fill_manual(values = country_colours, guide = FALSE) +
      theme(
        axis.line = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank(),
        text = element_text(size = 15) 
      )
  })
  
player_filter <- reactive({
  player_info %>% 
    filter(country == input$select_country) 
})
  
output$player_info <- renderDataTable({
player_filter() %>% 
    select(player:weight_in_kg) %>% 
    rename(position = position_detailed) %>%
    rename("height_(m)" = height_in_metres) %>% 
    rename("weight_(Kg)"= weight_in_kg) %>% 
    rename_all(~ str_replace_all(., "_", " ")) %>% 
    rename_all(~ str_to_title(.)) 
   })


output$club <- renderPlot({
player_filter( ) %>% 
    group_by(club) %>%
    summarise(total_number = n()) %>%
    ggplot() +
    aes(x = reorder(club, total_number), y = total_number, fill = club) +
    geom_col(colour = "black") +
    scale_fill_manual(values = club_colours, guide = FALSE) +
    labs(x = "Club", y = "Number of PLayers") +
    geom_text(aes(label = total_number), vjust = 0.3, hjust = -1) +
    coord_flip() +
    theme(
      axis.line = element_blank(),
      axis.text.x = element_blank(),
      axis.ticks = element_blank(),
      axis.title.y = element_blank(),
      axis.title.x = element_blank(),
      panel.background = element_blank(),
      panel.border = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      plot.background = element_blank())
})

output$weight <- renderPlot({
 player_filter() %>% 
    ggplot() +
    aes(x = weight_in_kg, fill = forward_or_back) +
    geom_density(alpha = 0.5) + 
    theme_minimal() +
    theme(axis.text.y=element_blank(),
          axis.ticks=element_blank())+
    labs(x = "Weight (kg)", fill = "", y = "")
})

output$scores <- renderPlot({
  teams %>% 
    filter(country == input$select_country) %>% 
    filter(variable %in% c("Tries", "Conversions", "Penalty Goals", "Drop Goals")) %>% 
    mutate(variable = factor(variable, levels = c("Tries", "Conversions", "Penalty Goals", "Drop Goals"))) %>% 
    mutate(total = na_if(total, 0)) %>% 
    drop_na() %>% 
    ggplot()+
    aes(x = variable ,y = total, fill = variable, ) +
    geom_col(show.legend = FALSE, colour = "black")+
    geom_text(aes(label= total ), vjust=-0.3)+
    scale_fill_manual(values = c("Tries" = "#013875", 
                                 "Conversions" = "#ec182d", 
                                 "Penalty Goals" = "#2f7b32", 
                                 "Drop Goals"= "#9fd3f2"))+
    theme(
      axis.line = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.title.y = element_blank(),
      axis.title.x = element_blank(),
      panel.background = element_blank(),
      panel.border = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      plot.background = element_blank()
    )
})

}
