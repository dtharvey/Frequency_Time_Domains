# ui for fourier transform
library(shiny)
library(shinythemes)
library(shinyBS)

ui = navbarPage("Analytical Chemisty 3.0",
                theme = shinytheme("journal"),
                tags$head(
                  tags$link(rel = "stylesheet",
                            type = "text/css",
                            href = "style.css")
          ),
              tabPanel("Fourier Transforms: The 
                       Frequency Domain and the Time Domain",
                fluidRow(
                  column(width = 6,
                    wellPanel(
                      includeHTML("ft_text.html")
          )     
          ),
                  column(width = 6,
                         align = "center",
                    splitLayout(
                      radioButtons("include2", "Include second peak?",
                                   choices = c("yes", "no"),
                                   selected = "no", width = "150px"),
                      sliderInput("p1","peak 1: position",
                                  min = 10, max = 100, value = 50,
                                  width = "150px", step = 1),
                      sliderInput("w1","Peak 1: fwhm",
                                  min = 1, max = 10, value = 3,
                                  width = "150px", step = 1),
                      sliderInput("a1","Peak 1: area",
                                  min = 1, max = 5, value = 4,
                                  width = "150px", step = 0.1)
          ),
                    splitLayout(
                      radioButtons("showspectra", 
                                   "Show individual spectra?",
                                   choices = c("yes","no"),
                                   selected = "no", width = "150px"),
                      sliderInput("p2","peak 2: position",
                                  min = 10, max = 100, value = 60,
                                  width = "150px", step = 1),
                      sliderInput("w2","Peak 2: fwhm",
                                  min = 1, max = 10, value = 3,
                                  width = "150px", step = 1),
                      sliderInput("a2","Peak 2: area",
                                  min = 1, max = 5, value = 4,
                                  width = "150px", step = 0.1)
          ),
                    plotOutput("domains", height = "550px")
          )
          ) 
          )
          )# close ui
