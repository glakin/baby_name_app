
suggest_name <- function(df, gnd) {
  df_gender <- df[df$gender == gnd,]
  suggestion <- sample(df_gender$name, size=1, prob=df_gender$frequency )
  return(suggestion)
} 


