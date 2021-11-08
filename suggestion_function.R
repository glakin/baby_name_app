df <- read.csv("yob2020.txt", header = FALSE, col.names = c("name", "gender", "count"))

genders <- c('F','M')

df$frequency <- NA
df[df$gender == 'M',]$frequency <- unlist(df[df$gender == 'M',]$count/sum(df[df$gender == 'M',]$count))
df[df$gender == 'F',]$frequency <- unlist(df[df$gender == 'F',]$count/sum(df[df$gender == 'F',]$count))

df$rank <- NA
df[df$gender == 'M',]$rank <- unlist(rank(-df[df$gender == 'M',]$count))
df[df$gender == 'F',]$rank <- unlist(rank(-df[df$gender == 'F',]$count))

suggest_name <- function(df, gnd) {
  df_gender <- df[df$gender == gnd,]
  suggestion <- sample(df_gender$name, size=1, prob=df_gender$frequency )
  return(suggestion)
} 


write.csv(df, "name_data.csv")
