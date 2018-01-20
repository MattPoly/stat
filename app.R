#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  
  # NavBar
  shinyUI(
    navbarPage(
      "Nos lois",
      tabPanel(
        "Loi Normale",
        sidebarLayout(
          sidebarPanel(
            numericInput(
              "n_obs",
              "Nombre d'échantillons :",
              30,
              min = 1
            ),
            numericInput(
              "n_means",
              "Centre :",
              0
            ),
            numericInput(
              "n_sd",
              "Ecart Type :",
              1,
              min = 0
            ),
            numericInput(
              "breaks",
              "Précision de l'histogramme :",
              50,
              min = 1
            ),
            downloadButton("downloadNormData", "Télécharger les échantillons")
          ),  
          mainPanel(
            plotOutput("histoNormale"),
            verbatimTextOutput('normList')
          )
        )
      ),
      tabPanel(
        "Loi de Poisson",
        sidebarLayout(
          sidebarPanel(
            numericInput(
              inputId = "nb",
              label = "Nombre d'observations :",
              value = 10,
              min = 1
            ),
            numericInput(
              inputId = "l",
              label = "Intervalle :",
              value = 5,
              min = 0
            ),
            numericInput(
              "poiss_breaks",
              "Précision de l'histogramme :",
              10,
              min = 1
            ),
            downloadButton("downloadPoissData", "Télécharger les observations")
          ),
          mainPanel(
            plotOutput("histoPoisson"),
            verbatimTextOutput('poissonList')
          )
        )
      )
    )
  )         
)                
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$histoPoisson <- renderPlot({
    poissValues <<- rpois(input$nb, input$l)
    
    hist(poissValues, xlab = "Valeurs", ylab = "Fréquence",
         main = "Loi de Poisson",
         col = "skyblue", border = "white",
         breaks = input$poiss_breaks)
    
    output$poissonList<-renderPrint({
      poissValues
    })
  })
  
  # Downloadable csv of selected dataset 
  output$downloadPoissData <- downloadHandler(
    filename = function() {
      paste("dataPoiss-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(poissValues, file)
    },
    contentType = "text/csv"
  )
  
  output$histoNormale <- renderPlot({
    normValues <<- rnorm(input$n_obs,input$n_means,input$n_sd) # x suit une loi normale et est constitué du nombre d'observations 'n_obs' spécifié par l'utilisateur dans la partie 'UI'
    
    hist(normValues, xlab = "Valeurs", ylab = "Fréquence",
         main = "Loi Normale",
         col = "skyblue", border = "white",
         breaks = input$breaks)
    
    output$normList<-renderPrint({
      normValues
    })
  })
  
  # Downloadable csv of selected dataset ----
  output$downloadNormData <- downloadHandler(
    filename = function() {
      paste("dataNorm-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(normValues, file)
    },
    contentType = "text/csv"
  )
  
}

# Run the application 
shinyApp(ui = ui, server = server)

