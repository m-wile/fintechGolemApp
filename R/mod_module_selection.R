#' module_selection UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import dplyr
#' @import mwile
mod_module_selection_ui <- function(id){
  ns <- NS(id)
  opts <- c("Copper", "Gold", "Silver", "Platinum")
  tagList(
    shiny::selectInput(ns("cmd"), "Choose A Commodity", choices = opts, selected = "Copper"),
    shiny::textOutput(ns("tR"))
  )
}

#' module_selection Server Functions
#'
#' @noRd
mod_module_selection_server <- function(id, r){
  moduleServer(id,
                function(input, output, session){
                    shiny::observeEvent(input$cmd, {
                      r$commodity <- input$cmd
                      dfc <- mwile::comms %>%
                        dplyr::filter(cmdty == r$commodity)
                      dfs <- mwile::stocks %>%
                        dplyr::filter(cmdty == r$commodity)
                      df_comms <- dfc
                      df_stocks <- dfs
                    })
                  })
}


## To be copied in the UI
# mod_module_selection_ui("module_selection_1")

## To be copied in the server
# mod_module_selection_server("module_selection_1")
