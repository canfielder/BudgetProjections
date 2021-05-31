#' Shiny Application
#'

#' @noRd

# PROCESSING -------------------------------------------------------------------
## Create list of categories for select input
category_filters <- c(
  "Athletic Apparel", "Bike Maintenance", "Donation",
  "Electronics & Software","Entertainment", "Fashion Apparel", "Flex Spending",
  "Gift", "Home Goods - Large", "Home Goods - Small", "Home Supplies",
  "Personal Care", "Routine Maintenance", "Running Events", "Service & Parts",
  "Sporting Goods", "Travel"
)

## Default Dates
current_date <- Sys.Date()
end_date_default <- current_date + lubridate::years(1)
minimum_date <- as.Date("2020-11-01")

# UI ---------------------------------------------------------------------------
ui <- shiny::fluidPage(
    shiny::titlePanel(
      title = "Budget Balance Projections"
    ),
    shiny::sidebarPanel(
      width = 3,
      shiny::selectInput(
        inputId  = "category",
        label    = 'Budget',
        selected = "Travel",
        choices  = category_filters,
        multiple = FALSE
        ),
      shiny::dateInput(
        inputId = 'start_date',
        label   = 'Start Date',
        value   = Sys.Date(),
        min     = minimum_date
    ),
    shiny::dateInput(
      inputId = 'end_date',
      label   = 'End Date',
      value   = end_date_default,
      min     = minimum_date
      ),
    shiny::actionButton(
      inputId = "reset_input",
      label = "Reset Date Range"
      )
    ),
    shiny::mainPanel(
      width = 9,
      shiny::tabsetPanel(
        shiny::tabPanel(
          title = "Plot",
          highcharter::highchartOutput(
            outputId = "interactive",
            height = "700px"
          )
        ),
        # shiny::tabPanel(
        #   title = "Plot - Static",
        #   shiny::plotOutput(outputId = "static")
        #   ),
        shiny::tabPanel(
          title = "Table",
          DT::DTOutput(outputId = "table")
        )
      )
    )
)

# Server -----------------------------------------------------------------------
server <- function(input, output, session) {
  # For quieting visible binding errors in RMD check
  category <- NULL

  # --- Reactive Values ---------------------------------------------------- #
  # Budget balance projections
  budget_projection_table <- shiny::reactive({

    # Generate projections table
    df <- fund_projections(
      start_date = input$start_date,
      end_date   = input$end_date
    )

    # Round Down for conservatism
    df <- df %>%
      dplyr::mutate(
        available_funds = floor(available_funds)
      )

    # Select for category
    df <- df %>%
      dplyr::filter(category == input$category)

    df
  })

  # Reset Date Range
  shiny::observeEvent(input$reset_input, {
    shiny::updateTextInput(session, "start_date", value = current_date)
    shiny::updateTextInput(session, "end_date", value = end_date_default)
  })

  # --- Outputs to UI ------------------------------------------------------ #
  # Static Plot
  output$static <- shiny::renderPlot({
    df <- budget_projection_table()
    p_static <- plot_budget_projection(df)
    p_static
  })

  # Interactive Plot
  output$interactive <- highcharter::renderHighchart({
    df <- budget_projection_table()
    p_interactive <- interactive_plot(df)
    p_interactive
  })

  # Table
  output$table <- DT::renderDT({
    df <- budget_projection_table()
    df <- format_budget_projection_table(df)
    df <- to_DT(df)

    df

  })
}


#' Launch app
#'
#'@noRd

LaunchApp <- function() {

  # Run the application
  shiny::runApp(
    list(
      ui = ui,
      server = server
      ),
    launch.browser = TRUE
    )
}
