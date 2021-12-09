library(shiny)
library (shinythemes)
library(tidyverse)

ui <- (fluidPage(
    
    theme = shinytheme("sandstone"),
    
    navbarPage("Red Wine Characteristics",
               
 # Tab 1              
               tabPanel("Summary based on Quality", 
                        
                        sidebarLayout(
                            sidebarPanel(
                                radioButtons(inputId = "type",
                                             label = "Choose a Physicochemical",
                                             c("ABV", "pH", "Density", "Total Sulfur Dioxide", "Free Sulfur Dioxide", "Chlorides", "Residual Sugar", "Citric Acid", "Volatile Acidity", "Fixed Acidity")
                                             
                                )
                            ),
                            
                            mainPanel(
                                htmlOutput("text"),
                                tableOutput("table")
                            )
                        )
               ),
 # Tab 2
               tabPanel("Display Plot of Data",
                        sidebarLayout(
                            sidebarPanel(
                                selectInput(inputId = "dependent",
                                            label = "Choose a Dependent Variable",
                                            c("ABV", "pH","Density", "Total Sulfur Dioxide", "Free Sulfur Dioxide", "Chlorides", "Residual Sugar", "Citric Acid", "Volatile Acidity", "Fixed Acidity")
                                ),
                                selectInput(inputId = "independent",
                                            label = "Choose a Independent Variable",
                                            c("Density", "pH","Total Sulfur Dioxide", "Free Sulfur Dioxide", "Chlorides", "Quality", "Residual Sugar", "Citric Acid", "Volatile Acidity", "Fixed Acidity")
                                ),
                                selectInput(inputId = "third",
                                            label = "Choose a Third Variable",
                                            c("None")
                                )
                            ),
                           
                            mainPanel(
                                plotOutput("plot")
                            ) 
                            
                        )
               ),
 # Tab 3
               tabPanel("Regression Analysis",
                        sidebarLayout(
                            sidebarPanel(
                                selectInput(inputId = "response",
                                            label = "Choose a Response Variable",
                                            c("Quality", "ABV", "pH", "Density", "Total Sulfur Dioxide", "Free Sulfur Dioxide", "Chlorides", "Residual Sugar", "Citric Acid", "Volatile Acidity", "Fixed Acidity")
                                ),
                                checkboxGroupInput(inputId = "regressor",
                                            label = "Choose the Regressors",
                                            choiceNames = c("Quality", "ABV", "pH", "Density", "Total Sulfur Dioxide", "Free Sulfur Dioxide", "Chlorides", "Residual Sugar", "Citric Acid", "Volatile Acidity", "Fixed Acidity"),
                                            choiceValues = c("Quality", "ABV", "pH", "Density", "Total.Sulfur.Dioxide", "Free.Sulfur.Dioxide", "Chlorides", "Residual.Sugar", "Citric.Acid", "Volatile.Acidity", "Fixed.Acidity")
                                ),
                                
                                conditionalPanel(condition = "input.regressor.includes('Quality')", 
                                                 sliderInput("sliderQuality", "Choose the value for Quality", min=0, max=10, value=7, step = 1)
                                ),
                                conditionalPanel(condition = "input.regressor.includes('ABV')", 
                                                   sliderInput("sliderABV", "Choose the value for ABV", min=8, max=14, value=10, step = .1)
                                ),
                                conditionalPanel(condition = "input.regressor.includes('pH')", 
                                                 sliderInput("sliderpH", "Choose the value for pH", min=2.7, max=4, value=3.5, step = .05)
                                ),
                                conditionalPanel(condition = "input.regressor.includes('Density')", 
                                                 sliderInput("sliderDensity", "Choose the value for Density", min=0.99, max=1.004, value=.995, step = .0005)
                                ),
                                conditionalPanel(condition = "input.regressor.includes('Total Sulfur Dioxide')", 
                                                 sliderInput("sliderTotal", "Choose the value for Total Sulfur Dioxide", min=5, max=290, value=45, step = 1)
                                ),
                                conditionalPanel(condition = "input.regressor.includes('Free Sulfur Dioxide')", 
                                                 sliderInput("sliderFree", "Choose the value for Free Sulfur Dioxide", min=0, max=73, value=14, step = 1)
                                ),
                                conditionalPanel(condition = "input.regressor.includes('Chlorides')", 
                                                 sliderInput("sliderChlorides", "Choose the value for Chlorides", min=0.01, max=0.62, value=.08, step = .01)
                                ),
                                conditionalPanel(condition = "input.regressor.includes('Residual Sugar')", 
                                                 sliderInput("sliderSugar", "Choose the value for Residual Sugar", min=0.5, max=16, value=2.5, step = .1)
                                ),
                                conditionalPanel(condition = "input.regressor.includes('Citric Acid')", 
                                                 sliderInput("sliderCitric", "Choose the value for Citric Acid", min=0, max=1, value=.28, step =.01)
                                ),
                                conditionalPanel(condition = "input.regressor.includes('Volatile Acidity')", 
                                                 sliderInput("sliderVolatile", "Choose the value for Volatile Acidity", min=0.1, max=1.6, value=.55, step = .05)
                                ),
                                conditionalPanel(condition = "input.regressor.includes('Fixed Acidity')", 
                                                 sliderInput("sliderFixed", "Choose the value for Fixed Acidity", min=4.5, max=16, value=9, step = .1)
                                ),
                                
                                actionButton(inputId = "click", label = "Fit model or find predicted value")
                                
                            ),
                            
                            mainPanel(
                                textOutput("text2"),
                                verbatimTextOutput("text3"),
                                htmlOutput("text4"),
                                htmlOutput("text5")
                            ) 
                        )
               )
               
    )
)
)



