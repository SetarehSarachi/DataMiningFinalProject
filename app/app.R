library(ggplot2)
library(Cairo)   # For nicer ggplot2 output when deployed on Linux
library(shiny)

plots <<- list("Histogram Plot:  Type" = "type",
               "Histogram Plot: Country" = "country",
               "Histogram Plot:  Distribution of Type for each Country" = "typeVsCountry")

ui <- fluidPage(
  fluidRow(
    column(width = 4, class = "well",
           selectInput("selection", "Choose a book:",
                       choices = plots),
           actionButton("update", "Select")
    ),
    
    column(width = 8, class = "well",
           h4("Left plot controls right plot"),
           fluidRow(
             column(width = 6,
                    plotOutput("plot2", height = 300,
                               brush = brushOpts(
                                 id = "plot2_brush",
                                 resetOnNew = TRUE
                               )
                    )
             ),
             column(width = 6,
                    plotOutput("plot3", height = 300)
             )
           )
    )
    
  )
)

server <- function(input, output) {
  
  processed_fake <- read.csv("preprocessed_fake.csv")
  
  # -------------------------------------------------------------------
   # -------------------------------------------------------------------
  # Linked plots (middle and right)
  ranges2 <- reactiveValues(x = NULL, y = NULL)
  
  output$plot2 <- renderPlot({
    #Plot of frequency of "type"
    ggplot(processed_fake , aes(x = processed_fake$type, fill = processed_fake$type))+ 
      geom_bar(alpha = 0.5) +
      ggtitle("Histogram Plot:  Type") + 
      labs(x = "Type", y = "Counts") + 
      guides(fill=guide_legend(title="Type")) +
      theme(plot.title = element_text(hjust = 0.5))
  })
  
  output$plot3 <- renderPlot({
    #Plot of frequency of "type"
    ggplot(processed_fake , aes(x = processed_fake$type, fill = processed_fake$type))+ 
      geom_bar(alpha = 0.5) +
      ggtitle("Histogram Plot:  Type") + 
      labs(x = "Type", y = "Counts") + 
      guides(fill=guide_legend(title="Type")) +
      theme(plot.title = element_text(hjust = 0.5)) +
      coord_cartesian(xlim = ranges2$x, ylim = ranges2$y, expand = FALSE)
  })
  
  # When a double-click happens, check if there's a brush on the plot.
  # If so, zoom to the brush bounds; if not, reset the zoom.
  observe({
    brush <- input$plot2_brush
    if (!is.null(brush)) {
      ranges2$x <- c(brush$xmin, brush$xmax)
      ranges2$y <- c(brush$ymin, brush$ymax)
      
    } else {
      ranges2$x <- NULL
      ranges2$y <- NULL
    }
  })
  
}

shinyApp(ui, server)