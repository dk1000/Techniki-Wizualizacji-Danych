library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)

dane <- read.csv("dane_new.csv", stringsAsFactors = FALSE, sep = ";")


ui <- fluidPage( theme = shinythemes::shinytheme("cerulean"),
  
      titlePanel("Praca domowa 6 R Shiny"),
      
      sidebarLayout(sidebarPanel(
      
            sliderInput(inputId = "chosen_price",
                        label = "Wybierz zakres cen",
                        min = min(dane[["cena"]]),
                        max = max(dane[["cena"]]),
                        value = c(5000, 7000)),
            
            checkboxGroupInput( inputId = "chosen_rynek",
                                label = "Wybierz rynek",
                                choices = unique(dane[["rynek"]]),
                                selected = unique(dane[["rynek"]]))),
            
      mainPanel(plotlyOutput("city_plot")))
)

server <- function(input, output) {
 

     output[["city_plot"]] <- renderPlotly({

         dane1 <- dane %>% filter(cena >= min(input[["chosen_price"]]), cena <= max(input[["chosen_price"]]), rynek %in% input[["chosen_rynek"]])
         p <-  ggplot(dane1, aes(x=miasto, y=cena)) +
                      geom_bar(aes(fill = rynek), position = "dodge", stat="identity", width = 0.7) +
                      theme(axis.text.x = element_text(angle=60, hjust=1)) +
                      scale_fill_brewer(palette = "Paired") +
                      labs(title="Ceny mieszkań w największych miastach Polski na rynku wtórnym i pierwotnym", x="Miasto", y = "Średnia cena za mkw. (w zl)")
         p
      })

}

shinyApp(ui = ui, server = server)





#rsconnect::setAccountInfo(name='kowalczykd',
#                          token='A66E36243ABBE43687B1E0EF990A79B1',
#                          secret='ZS69pi/zGGHL+orhM0jvWlEgy9XYLyfy2AYzRAO+')
#rsconnect::deployApp('C:\Users\Dawid Kowalczyk\Google Drive\Studia MiNI PW\III semestr\Techniki wizualizacji danych\PD6')
