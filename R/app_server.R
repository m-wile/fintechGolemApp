#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import plotly
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  r <- reactiveValues()
  mod_module_selection_server("module_selection_1", r=r)
  mod_module_pull_server("module_pull_1", r=r)
  mod_module_compare_server("module_compare_1", r=r)
  mod_module_overlay_server("module_overlay_1", r=r)
}
