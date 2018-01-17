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
  shinyUI(navbarPage("Nos lois",
                     tabPanel("Loi Normale",  
                              textInput(inputId = "titre_histo", 
                                        label = "Entrez le titre souhaité pour l'histogramme :",
                                        value = "Histogramme Loi Normale"),    sidebarLayout(
                                          sidebarPanel(
                                            sliderInput("n_obs",
                                                        "Nombre d'échantillons :",
                                                        min = 1,
                                                        max = 500,
                                                        value = 30)
                                          ),  mainPanel(
                                            tabsetPanel(
                                              tabPanel("Graphique", plotOutput("histoNormale"))
                                            )
                                          )
                                        )
                     ),
                     tabPanel("Loi de Poisson",  
                              textInput(inputId = "titre_histo", 
                                        label = "Entrez le titre souhaité pour l'histogramme :",
                                        value = "Histogramme Loi de Poisson"),    sidebarLayout(
                                          sidebarPanel(
                                            numericInput(inputId = "nb",
                                                         label = "Probabilité :",
                                                         value = "0",
                                                         min = 0, max = 100),
                                            numericInput(inputId = "nb_max",
                                                         label = "Probabilité max:",
                                                         value = "0",
                                                         min = 0, max = 100),
                                            numericInput(inputId = "l",
                                                         label = "Lambda :",
                                                         value = "5",
                                                         min = 0, max = 100)
                                          ),  mainPanel(
                                            tabsetPanel(
                                              tabPanel("Graphique", plotOutput("histoPoisson"))
                                            )
                                          )
                                        )
                     )
  )
  )         
)                
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$histoPoisson <- renderPlot({ # on fait appel à la fonction 'renderPlot' cette fois car notre sortie sera un graphique
    set.seed(123) # ce paramètre sert à fixer une graine pour l'aléatoire lors de la génération de x (non indispensable)
    
    x = dpois(input$nb:input$nb_max, input$l) # x suit une loi poisson et est constitué du nombre d'observations 'n_obs' spécifié par l'utilisateur dans la partie 'UI'

    hist(x, xlab = "x", ylab = "Fréquence",
         main = input$titre_histo, # le titre de notre histogramme (paramètre 'main') va être constitué du texte rentré à la main par l'utilisateur dans la partie 'UI' et stocké dans 'titre_histo'
         col = "skyblue", border = "white")
  })
  
  output$histoNormale <- renderPlot({ # on fait appel à la fonction 'renderPlot' cette fois car notre sortie sera un graphique
    set.seed(123) # ce paramètre sert à fixer une graine pour l'aléatoire lors de la génération de x (non indispensable)
    
    x = rnorm(input$n_obs) # x suit une loi normale et est constitué du nombre d'observations 'n_obs' spécifié par l'utilisateur dans la partie 'UI'
    
    hist(x, xlab = "x", ylab = "Fréquence",
         main = input$titre_histo, # le titre de notre histogramme (paramètre 'main') va être constitué du texte rentré à la main par l'utilisateur dans la partie 'UI' et stocké dans 'titre_histo'
         col = "skyblue", border = "white")
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

