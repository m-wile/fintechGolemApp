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
    plotly::plotlyOutput(ns("equity_plot"))
  )
}

#' module_compare Server Functions
#'
#' @noRd
mod_module_compare_server <- function(id, r){
  moduleServer(id,
               function(input, output, session){
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
