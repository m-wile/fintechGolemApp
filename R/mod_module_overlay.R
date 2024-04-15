#' module_overlay UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_module_overlay_ui <- function(id){
  ns <- NS(id)
  tagList(
    shiny::br(),
    shiny::textOutput(ns("textR")),
    shiny::br(),
    shiny::br(),
    plotly::plotlyOutput(ns("combined_plot")),
    shiny::br(),
    tags$li("If these two returns matched, then there would be no reason for traders!"),
    tags$li("Equity prices of companies involved in commodity production would match the price of that commodity"),
    tags$li("The fact they do not match is partially down to traders who hedge against price risk!"),
    shiny::br(),
    tags$li("More goes into the stock price than the trading portfolio"),
    tags$ul(
      tags$li("Corporate strategy and leadership"),
      tags$li("Public perception and psychology"),
      tags$li("This is NOT the trader's responsibility!")
    ),
    shiny::br(),
    shiny::br(),
    plotly::plotlyOutput(ns("example_plot")),
    shiny::br(),
    tags$li("This is what is possible if the portfolio was perfectly hedged all the time"),
    tags$li("While impossible, the idea is that the stock price is unrelated to the commodity price"),
    tags$li("Production company stock price != Production trading portfolio"),
    shiny::br()
  )
}

#' module_overlay Server Functions
#'
#' @noRd
mod_module_overlay_server <- function(id, r){
  moduleServer(id,
                function(input, output, session){
                  output$textR <- renderText({
                    paste("Your chosen commodity is ", r$commodity)
                  })
                  output$combined_plot <- renderPlotly({
                    data1 <- r$df_stocks %>%
                      dplyr::filter(date >= "2024-01-01") %>%
                      dplyr::mutate(return = (value - dplyr::lag(value)) / dplyr::lag(value),
                                    type = "Equity")
                    data2 <- r$df_comms %>%
                      dplyr::filter(date >= "2024-01-01") %>%
                      dplyr::mutate(return = (value - dplyr::lag(value)) / dplyr::lag(value),
                                    type = "Commodity")
                    data_cmb <- rbind(data1, data2)
                    plotly::plot_ly(
                      data = data_cmb,
                      x = ~date,
                      y = ~return,
                      color = ~type,
                      type = "scatter",
                      mode = "lines"
                    ) %>%
                    plotly::layout(
                      title = list(text = "Comparing Commodity Price and Producer Equity Price"),
                      xaxis = list(text = "Time"),
                      yaxis = list(text = "Price")
                    )
                  })
                  output$example_plot <- renderPlotly({
                    data1 <- r$df_stocks %>%
                      dplyr::filter(date >= "2024-01-01") %>%
                      dplyr::mutate(return = (value - dplyr::lag(value)) / dplyr::lag(value),
                                    type = "Equity")
                    data2 <- r$df_comms %>%
                      dplyr::filter(date >= "2024-01-01") %>%
                      dplyr::mutate(return = (value - dplyr::lag(value)) / dplyr::lag(value),
                                    type = "Commodity")
                    data_cmb <- rbind(data1, data2)
                    data_ex <- data_cmb %>%
                      dplyr::mutate(ex = 0) %>%
                      dplyr::filter(type == "Equity")
                    plotly::plot_ly(
                      data = data_ex,
                      x = ~date,
                      y = ~return,
                      name = "Equity Return",
                      type = "scatter",
                      mode = "lines"
                    ) %>%
                    plotly::add_trace(y = ~ex, name = "Perfectly Hedged Return", mode = "lines") %>%
                    plotly::layout(
                      title = list(text = "Example with Perfect Hedging for Physical Delivery"),
                      xaxis = list(text = "Time"),
                      yaxis = list(text = "Price")
                    )
                  })
                })
}

## To be copied in the UI
# mod_module_overlay_ui("module_overlay_1")

## To be copied in the server
# mod_module_overlay_server("module_overlay_1")
