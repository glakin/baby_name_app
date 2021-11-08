#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Baby Name Suggestion App"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput("gender",
                        h3("Gender"),
                        choices = list("Female" = "F",
                                       "Male" = "M")),
            actionButton("suggest", "Suggest a Name!"),
            actionButton("save", "Save this Name")
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            align="center",
            h1(textOutput("nameSuggestion")),
            textOutput("nameRank")
        )
    )
))
