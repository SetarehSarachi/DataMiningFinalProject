library(ggplot2)
library(Cairo)   # For nicer ggplot2 output when deployed on Linux
library(shiny)

ui <- fluidPage(
  h4("Left plot controls right plot"),
  
  fluidRow(
    
    column(width = 8, class = "well",
           h4("Left plot controls right plot"),
           fluidRow(
             column(width = 6,
                    plotOutput("plot11", height = 300,
                               brush = brushOpts(
                                 id = "plot1_brush",
                                 resetOnNew = TRUE
                               )
                    )
             ),
             column(width = 6,
                    plotOutput("plot12", height = 300)
             )
           )
    )
    
  ),
  
  fluidRow(
    
    column(width = 8, class = "well",
           h4("Left plot controls right plot"),
           fluidRow(
             column(width = 6,
                    plotOutput("plot21", height = 300,
                               brush = brushOpts(
                                 id = "plot2_brush",
                                 resetOnNew = TRUE
                               )
                    )
             ),
             column(width = 6,
                    plotOutput("plot22", height = 300)
             )
           )
    )
    
  ),
  
  fluidRow(
    
    column(width = 8, class = "well",
           h4("Left plot controls right plot"),
           fluidRow(
             column(width = 6,
                    plotOutput("plot31", height = 300,
                               brush = brushOpts(
                                 id = "plot3_brush",
                                 resetOnNew = TRUE
                               )
                    )
             ),
             column(width = 6,
                    plotOutput("plot32", height = 300)
             )
           )
    )
    
  ),
  
  fluidRow(
    
    column(width = 8, class = "well",
           h4("Left plot controls right plot"),
           fluidRow(
             column(width = 6,
                    plotOutput("plot41", height = 300,
                               brush = brushOpts(
                                 id = "plot4_brush",
                                 resetOnNew = TRUE
                               )
                    )
             ),
             column(width = 6,
                    plotOutput("plot42", height = 300)
             )
           )
    )
    
  )
)

server <- function(input, output) {
  
  processed_fake <- read.csv("preprocessed_fake.csv")
  participants.count_type <- aggregate(participants_count~type,processed_fake,sum)
  
  # -------------------------------------------------------------------
   # -------------------------------------------------------------------
  # Linked plots (middle and right)
  ranges1 <- reactiveValues(x = NULL, y = NULL)
  ranges2 <- reactiveValues(x = NULL, y = NULL)
  ranges3 <- reactiveValues(x = NULL, y = NULL)
  ranges4 <- reactiveValues(x = NULL, y = NULL)
  
  output$plot11 <- renderPlot({
    #Plot of frequency of "type"
    ggplot(processed_fake , aes(x = processed_fake$type, fill = processed_fake$type))+ 
      geom_bar(alpha = 0.5) +
      ggtitle("Histogram Plot:  Type") + 
      labs(x = "Type", y = "Counts") + 
      guides(fill=guide_legend(title="Type")) +
      theme(plot.title = element_text(hjust = 0.5))
  })
  
  output$plot12 <- renderPlot({
    #Plot of frequency of "type"
    ggplot(processed_fake , aes(x = processed_fake$type, fill = processed_fake$type))+ 
      geom_bar(alpha = 0.5) +
      ggtitle("Histogram Plot:  Type") + 
      labs(x = "Type", y = "Counts") + 
      guides(fill=guide_legend(title="Type")) +
      theme(plot.title = element_text(hjust = 0.5)) +
      coord_cartesian(xlim = ranges1$x, ylim = ranges1$y, expand = FALSE)
  })
  
  output$plot21 <- renderPlot({
    #Plot of frequency of "countries"
    ggplot(processed_fake , aes(x = processed_fake$country, fill = processed_fake$country))+ 
      geom_bar(alpha = 0.63) +
      ggtitle("Histogram Plot:  Country") + 
      labs(x = "Country", y = "Counts") + 
      guides(fill=guide_legend(title="Country")) +
      theme(plot.title = element_text(hjust = 0.5))
  })
  
  output$plot22 <- renderPlot({
    #Plot of frequency of "countries"
    ggplot(processed_fake , aes(x = processed_fake$country, fill = processed_fake$country))+ 
      geom_bar(alpha = 0.63) +
      ggtitle("Histogram Plot:  Country") + 
      labs(x = "Country", y = "Counts") + 
      guides(fill=guide_legend(title="Country")) +
      theme(plot.title = element_text(hjust = 0.5)) +
      coord_cartesian(xlim = ranges2$x, ylim = ranges2$y, expand = FALSE)
  })
  
  output$plot31 <- renderPlot({
    #Plot of distribution of types for each country
    ggplot(processed_fake , aes(x = processed_fake$country, fill = processed_fake$type))+ 
      geom_bar(alpha = 0.63) +
      ggtitle("Histogram Plot:  Distribution of Type for each Country") + 
      labs(x = "Country", y = "Type Distribution") + 
      guides(fill=guide_legend(title="Type")) +
      theme(plot.title = element_text(hjust = 0.5))
  })
  
  output$plot32 <- renderPlot({
    #Plot of distribution of types for each country
    ggplot(processed_fake , aes(x = processed_fake$country, fill = processed_fake$type))+ 
      geom_bar(alpha = 0.63) +
      ggtitle("Histogram Plot:  Distribution of Type for each Country") + 
      labs(x = "Country", y = "Type Distribution") + 
      guides(fill=guide_legend(title="Type")) +
      theme(plot.title = element_text(hjust = 0.5)) +
      coord_cartesian(xlim = ranges3$x, ylim = ranges3$y, expand = FALSE)
  })
  output$plot41 <- renderPlot({
    #Number of Participants for each Type
    ggplot(participants.count_type , aes(x = type, y = participants_count, fill= participants_count))+ 
      geom_bar(alpha = 0.7,stat = "Identity") +
      ggtitle("Histogram Plot: Number of Participants for each Type") + 
      labs(x = "Type", y = "Counts") + 
      guides(fill=guide_legend(title=" Count")) +
      theme(plot.title = element_text(hjust = 0.5)) +
      scale_fill_continuous(low="red",high="yellow", limits=c(0,9000))
  })
  
  output$plot42 <- renderPlot({
    #Number of Participants for each Type
    ggplot(participants.count_type , aes(x = type, y = participants_count, fill= participants_count))+ 
      geom_bar(alpha = 0.7,stat = "Identity") +
      ggtitle("Histogram Plot: Number of Participants for each Type") + 
      labs(x = "Type", y = "Counts") + 
      guides(fill=guide_legend(title=" Count")) +
      theme(plot.title = element_text(hjust = 0.5)) +
      scale_fill_continuous(low="red",high="yellow", limits=c(0,9000)) +
      coord_cartesian(xlim = ranges4$x, ylim = ranges4$y, expand = FALSE)
  })
  
  # When a double-click happens, check if there's a brush on the plot.
  # If so, zoom to the brush bounds; if not, reset the zoom.
  observe({
    brush1 <- input$plot1_brush
    if (!is.null(brush1)) {
      ranges1$x <- c(brush1$xmin, brush1$xmax)
      ranges1$y <- c(brush1$ymin, brush1$ymax)
      
    } else {
      ranges1$x <- NULL
      ranges1$y <- NULL
    }
    
    brush2 <- input$plot2_brush
    if (!is.null(brush2)) {
      ranges2$x <- c(brush2$xmin, brush2$xmax)
      ranges2$y <- c(brush2$ymin, brush2$ymax)
      
    } else {
      ranges2$x <- NULL
      ranges2$y <- NULL
    }
    
    brush3 <- input$plot3_brush
    if (!is.null(brush3)) {
      ranges3$x <- c(brush3$xmin, brush3$xmax)
      ranges3$y <- c(brush3$ymin, brush3$ymax)
      
    } else {
      ranges3$x <- NULL
      ranges3$y <- NULL
    }
    
    brush4 <- input$plot4_brush
    if (!is.null(brush4)) {
      ranges4$x <- c(brush4$xmin, brush4$xmax)
      ranges4$y <- c(brush4$ymin, brush4$ymax)
      
    } else {
      ranges4$x <- NULL
      ranges4$y <- NULL
    }
  })
  
  
  
}

shinyApp(ui, server)