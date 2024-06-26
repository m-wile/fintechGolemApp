#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      theme = bslib::bs_theme(bootswatch = "vapor"),
      h1("The Metals Industry : Communication & Application"),
      h2("The Purpose of Metals Trading From A Producer's Perspective"),
      mod_module_selection_ui("module_selection_1"),
      shiny::tabsetPanel(
        shiny::tabPanel("Commodity Price", mod_module_pull_ui("module_pull_1")),
        shiny::tabPanel("Stock Price", mod_module_compare_ui("module_compare_1")),
        shiny::tabPanel("Commodity vs Equity Comparison", mod_module_overlay_ui("module_overlay_1"))
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "GolemApp"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
