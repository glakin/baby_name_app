
library(shiny)
library(bslib)
library(shinyalert)

shinyUI(fluidPage(
    
    useShinyalert(),
    
    theme = bs_theme(version = 4, bootswatch = "minty"),
    
    titlePanel(
        h1("Baby Name Helper", align = "center")
        ),
    
    br(),
    
    fluidRow(
        
        #column(3, h4("Gender", align = "right")),
        column(2, offset = 2, align = "right",
                radioButtons("gender", "Gender",
                             choices = list("Female" = "F",
                                            "Male" = "M"))
               ),
        #column(3, h4("Repeat Names?", align = "right")),
        column(2, align = "center",
               radioButtons("rpt", "Repeat Names?",
                            choices = list("Yes" = "yes",
                                           "No" = "no"))
               ),
        column(4, align = "left",
               uiOutput("rankSlider")
               )

    ),
    
    fluidRow(
        column(4),
        column(2, align = "center",
            actionButton("suggest", "Suggest a Name!")
            ),
        column(2, align = "center",
            actionButton("save", "Save this Name!")
        ),
        column(4)
    ),
    
    br(),
        
    verticalLayout(
        h1(textOutput("nameSuggestion"), align = "center"),
        h6(textOutput("nameRank"), align = "center"),
        h6(htmlOutput("observedNames"), align = "center")

    ),
    
    fluidRow(
        column(4, offset = 4, align = "center", h4(textOutput("likedHeader")))
    ),
    
    fluidRow(
        column(8, offset = 2, textOutput("liked"))

    ),
    
    fluidRow(
        column(4, offset = 4, align = "center",
               actionButton("email", "Send Me My Saved Names"))
    ),
    
    hr(),
    
    h6("Made by Jerry Lakin, GerardLakin@gmail.com", align = "right")
    

    
))
