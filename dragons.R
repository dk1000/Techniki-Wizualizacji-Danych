

library(plotly)

plot_ly(dragons, x=~year_of_birth, y=~life_length, color =~colour)


table(dragons$colour)


plot_ly(dragons, x=~weight, y=~height, color =~colour, colors = c("black", "blue", "green", "red"))


write.csv(dragons, "dragons.csv")
