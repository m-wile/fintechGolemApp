#' module_compare UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import plotly
mod_module_compare_ui <- function(id){
  ns <- NS(id)
  tagList(
    shiny::br(),
    shiny::textOutput(ns("textR")),
    shiny::br(),
    shiny::br(),
    plotly::plotlyOutput(ns("equity_plot")),
    shiny::br(),
    tags$li("The industry is not 100% reflected in the producer's stock price"),
    shiny::br(),
    tags$li("The job of a trader is not to increase stock price, but to provide value from a production perspective"),
    shiny::br(),
    shiny::br()
  )
}

#' module_compare Server Functions
#'
#' @noRd
mod_module_compare_server <- function(id, r){
  moduleServer(id,
               function(input, output, session){
                output$textR <- renderText({
                    paste("Your chosen commodity is ", r$commodity)
                })
                output$equity_plot <- renderPlotly({
                    data_equities <- r$df_stocks
                    plotly::plot_ly(
                      data = data_equities,
                      x = ~date,
                      y = ~value,
                      color = "red",
                      type = "scatter",
                      mode = "lines"
                    ) %>%
                  plotly::layout(
                      title = list(text = "Price Movement of A Producer of Selected Metal"),
                      xaxis = list(text = "Time"),
                      yaxis = list(text = "Price")
                  )
                })
              })
}

## To be copied in the UI
# mod_module_compare_ui("module_compare_1")

## To be copied in the server
# mod_module_compare_server("module_compare_1")
