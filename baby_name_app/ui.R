
library(shiny)
library(bslib)
library(shinyalert)

# shinyUI(fluidPage(
# 
#     titlePanel("Baby Name Suggestion App"),
# 
#     sidebarLayout(
#         sidebarPanel(
#             checkboxGroupInput("gender",
#                         h3("Gender"),
#                         choices = list("Female" = "F",
#                                        "Male" = "M")),
#             actionButton("suggest", "Suggest a Name!"),
#             actionButton("save", "Save this Name")
#             
#         ),
# 
#         mainPanel(
#             align="center",
#             h1(textOutput("nameSuggestion")),
#             textOutput("nameRank")
#         )
#     )
# ))

shinyUI(fluidPage(
    
    #useShinyalert(),
    
    theme = bs_theme(version = 4, bootswatch = "minty"),
    
    titlePanel(
        h1("Baby Name Helper", align = "center")
        ),
    
    br(),
    
    fluidRow(
        
        column(3, h4("Gender", align = "right")),
        column(3, 
                radioButtons("gender", "",
                             choices = list("Female" = "F",
                                            "Male" = "M"))
               ),
        column(3, h4("Repeat names?", align = "right")),
        column(3,
               radioButtons("rpt", "",
                            choices = list("Yes" = "yes",
                                           "No" = "no")))

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
        
        
        #h6(textOutput("observedPct"), align = "center")
    ),
    
    fluidRow(
        column(4, offset = 4, align = "center", h4(textOutput("likedHeader"))),
    ),
    
    fluidRow(
        column(8, offset = 2, textOutput("liked")),

    ),
    
    # br(), 
    # 
    # fluidRow(
    #     column(4, offset=4, align = "center",
    #            actionButton("email", "Email Me My Saved Names!"))
    # )

    
))
