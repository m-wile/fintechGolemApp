#' module_pull UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import plotly
mod_module_pull_ui <- function(id){
  ns <- NS(id)
  tagList(
    shiny::br(),
    shiny::textOutput(ns("textR")),
    shiny::br(),
    shiny::br(),
    plotly::plotlyOutput(ns("metal_plot")),
    shiny::br(),
    tags$li("The goal of metal's producers is to sell at beneficial prices"),
    shiny::br(),
    tags$li("Prices are not consistent through time and without risk management, so are revenues!"),
    tags$li("To do so, metal producers give up the potential gain of an increasing price to avoid the potential loss of a decreasing price by hedging"),
    tags$li("The role of traders is to manage price risk by trading financial derivatives"),
    shiny::br(),
    tags$li("ORDER OF PRIORITY : "),
    tags$ul(
      tags$li("1. Know more about your commodity than anybody"),
      tags$li("2. Manage price risk created by production"),
      tags$li("3. Profit off of trading portfolio")
    ),
    shiny::br(),
    shiny::br()
  )
}

#' module_pull Server Functions
#'
#' @noRd
mod_module_pull_server <- function(id, r){
  moduleServer(id,
                function(input, output, session){
                    output$textR <- renderText({
                      paste("Your chosen commodity is ", r$commodity)
                    })
                    output$metal_plot <- renderPlotly({
                      data_metals <- r$df_comms
                        plotly::plot_ly(
                          data = data_metals,
                          x = ~date,
                          y = ~value,
                          color = "blue",
                          type = "scatter",
                          mode = "lines"
                      ) %>%
                        plotly::layout(
                          title = list(text = "Front-Contract Flat Price Movement of Selection"),
                          xaxis = list(text = "Time"),
                          yaxis = list(text = "Price")
                        )
                    })
                })
}


## To be copied in the UI
# mod_module_pull_ui("module_pull_1")

## To be copied in the server
# mod_module_pull_server("module_pull_1")
