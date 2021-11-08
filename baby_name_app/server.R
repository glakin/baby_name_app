#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

df <- read.csv("name_data.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    values <- reactiveValues()
    
    observeEvent(input$suggest, {
        df_gender <- df[df$gender == input$gender,]
        values$nameSuggestion <- sample(df_gender$name, size=1, prob=df_gender$frequency )
        values$nameRank <- round(df_gender[df_gender$name == values$nameSuggestion,]$rank)
        output$nameSuggestion <- renderText({
            values$nameSuggestion
        })
        output$nameRank <- renderText({
            paste0("Rank: ", values$nameRank)
        })
    })
    
    observeEvent(input$save, {
        if(file.exists(paste0("liked_names_",input$gender,".csv"))) {
            liked_names <- read.csv(paste0("liked_names_",input$gender,".csv"))
            if(values$nameSuggestion %in% liked_names$name) {
                next
            } else {
                new_name <- data.frame(values$nameSuggestion, values$nameRank)
                names(new_name) = c("name", "rank")
                liked_names <- rbind(liked_names, new_name)
                write.csv(liked_names, paste0("liked_names_",input$gender,".csv"), row.names = FALSE)
            }
        } else {
            new_name <- data.frame(values$nameSuggestion, values$nameRank)
            names(new_name) = c("name", "rank")
            write.csv(new_name, paste0("liked_names_",input$gender,".csv"), row.names = FALSE)
        }
    })
    

})
