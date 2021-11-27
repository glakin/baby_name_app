df <- read.csv("yob2020.txt", header = FALSE, col.names = c("name", "gender", "count"))

df$frequency <- NA
df[df$gender == 'M',]$frequency <- unlist(df[df$gender == 'M',]$count/sum(df[df$gender == 'M',]$count))
df[df$gender == 'F',]$frequency <- unlist(df[df$gender == 'F',]$count/sum(df[df$gender == 'F',]$count))

df$rank <- NA
df[df$gender == 'M',]$rank <- unlist(rank(-df[df$gender == 'M',]$count))
df[df$gender == 'F',]$rank <- unlist(rank(-df[df$gender == 'F',]$count))

write.csv(df, "baby_name_app/name_data.csv", row.names = FALSE)
