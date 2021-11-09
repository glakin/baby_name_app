
library(shiny)

df <- read.csv("name_data.csv")

shinyServer(function(input, output) {

    values <- reactiveValues()
    
    observeEvent(input$suggest, {
        
        
        if (input$rpt == "yes" | !file.exists(paste0("observed_names_",input$gender,".csv"))) {
            df_gender <- df[df$gender == input$gender,]
        } else {
            observed_names <- read.csv(paste0("observed_names_",input$gender,".csv"))
            df_gender <- df[df$gender == input$gender & !(df$name %in% observed_names$name),]
        }
        
        values$nameSuggestion <- sample(df_gender$name, size=1, prob=df_gender$frequency )
        values$nameRank <- round(df_gender[df_gender$name == values$nameSuggestion,]$rank)
        values$nameCount <- df_gender[df_gender$name == values$nameSuggestion,]$count
        output$nameSuggestion <- renderText({
            values$nameSuggestion
        })
        output$nameRank <- renderText({
            paste0("Rank: ", values$nameRank)
        })
        
        if(file.exists(paste0("observed_names_",input$gender,".csv"))) {
            observed_names <- read.csv(paste0("observed_names_",input$gender,".csv"))
            if(values$nameSuggestion %in% observed_names$name) {
                
            } else {
                new_name <- data.frame(values$nameSuggestion, values$nameCount, values$nameRank)
                names(new_name) = c("name", "count", "rank")
                observed_names <- rbind(observed_names, new_name)
                
                write.csv(observed_names, paste0("observed_names_",input$gender,".csv"), row.names = FALSE)
            } 
                
        } else {
            observed_names <- data.frame(values$nameSuggestion, values$nameCount, values$nameRank)
            names(observed_names) = c("name", "count", "rank")
            write.csv(observed_names, paste0("observed_names_",input$gender,".csv"), row.names = FALSE)
        }
        
        if (input$gender == 'F') {
            values$observed <- length(observed_names$name)
            
            values$observedCount <- sum(observed_names$count)
            output$observedNames <- renderText({
                paste0("Viewed <b>",values$observed,"</b> names, representing <b>",
                       round(values$observedCount/sum(df[df$gender == input$gender,]$count),digits=2)*100, 
                       "%</b> of female babies born in 2020")
            })

        } else {
            values$observed <- length(observed_names$name)
            values$observedCount <- sum(observed_names$count)
            
            output$observedNames <- renderText({
                paste0("Viewed <b>",values$observed,"</b> names, representing <b>",
                       round(values$observedCount/sum(df[df$gender == input$gender,]$count),digits=2)*100, 
                       "%</b> of male babies born in 2020")
            })

        }
    })
    
    observeEvent(input$save, {
        if(file.exists(paste0("liked_names_",input$gender,".csv"))) {
            liked_names <- read.csv(paste0("liked_names_",input$gender,".csv"))
            if(values$nameSuggestion %in% liked_names$name) {
                
            } else {
                new_name <- data.frame(values$nameSuggestion, values$nameRank)
                names(new_name) = c("name", "rank")
                liked_names <- rbind(liked_names, new_name)
                write.csv(liked_names, paste0("liked_names_",input$gender,".csv"), row.names = FALSE)
                if (input$gender == 'F') {
                    output$likedNames_F <- renderText({
                        length(liked_names$name)
                    })
                } else {
                    output$likedNames_M <- renderText({
                        length(liked_names$name) 
                    })
                }
            }
        } else {
            new_name <- data.frame(values$nameSuggestion, values$nameRank)
            names(new_name) = c("name", "rank")
            write.csv(new_name, paste0("liked_names_",input$gender,".csv"), row.names = FALSE)
        }
    })
    

})
