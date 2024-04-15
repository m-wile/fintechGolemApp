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
    shiny::textOutput(ns("textR")),
    plotly::plotlyOutput(ns("metal_plot")),
    plotly::plotlyOutput(ns("price_plot"))
  )
}

#' module_pull Server Functions
#'
#' @noRd
mod_module_pull_server <- function(id, r){
  moduleServer(id,
                function(input, output, session){
                  ns <- session$ns
                  reactive({
                  date <- value <- cmdty <- NULL
                    output$textR <- renderText({
                      paste("Your chosen commodity is ", r$commodity)
                    })
                    output$metal_plot <- renderPlotly({
                      data_metals <- r$df_comms
                        plotly::plot_ly(
                          data = data_metals,
                          x = ~date,
                          y = ~value,
                          color = ~"blue",
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
            })
}


## To be copied in the UI
# mod_module_pull_ui("module_pull_1")

## To be copied in the server
# mod_module_pull_server("module_pull_1")
