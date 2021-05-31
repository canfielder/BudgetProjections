#' Determine yeak breaks
#'
#' Determines dates where to add line breaks on the ggplot visual to
#' indicate a new year.
#'
#' @param df Pre-processed budget dataframe
#' @noRd

year_breaks <- function(df) {
  # For quieting visible binding errors in RMD check
  month <-  NULL

  df %>%
    dplyr::slice(2:(dplyr::n()-1)) %>%              # Remove first and last rows
    dplyr::filter(month == "January") %>%
    dplyr::pull(date) %>%
    as.character()
}


#' ggplot theme
#'
#' Creates the theme settings for the ggplot visual.
#' @noRd

theme_custom <- function(){
  ggplot2::theme_classic() +
    ggplot2::theme(
      axis.ticks = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_text(
        hjust = 0
      ),
      axis.text.y = ggplot2::element_text(
        size = 15
      ),
      axis.title.y = ggplot2::element_text(
        size = 20,
        hjust = 0.95,
        vjust = 2
      ),
      plot.margin = ggplot2::unit(c(0, 0.5, 0, 0.5), "cm")
    )
}

#' Generate ggplot output
#'
#' Creates a budget projection with ggplot.
#'
#' @param df Pre-processed budget dataframe
#' @noRd

plot_budget_projection <- function(df) {
  # Determine year breaks
  year_line_breaks <- year_breaks(df)

  p <- ggplot2::ggplot(
    data = df,
    mapping = ggplot2::aes(
      x = date,
      y = available_funds
    )
  ) +
    ggplot2::geom_line() +
    ggplot2::geom_vline(
      xintercept = as.Date(year_line_breaks),
      linetype="dashed"
    ) +
    ggplot2::scale_x_date(
      date_labels = dplyr::if_else(
        condition = lubridate::month(df$date) == 1,
        true =  "%b\n%Y",
        false = "%b"
      ),
      date_breaks = "1 months",
      # date_minor_breaks = "1 month",
      expand = c(0,0)
      ) +
    ggplot2::scale_y_continuous(labels = scales::dollar_format()) +
    ggplot2::xlab(label = "") +
    ggplot2::ylab(label = "Available Funds") +
    theme_custom()

  }


#' Format budget projections table
#'
#' Formats the budget projections table for output.
#'
#' @param df Pre-processed budget dataframe
#' @noRd

format_budget_projection_table <- function(df) {
  # For quieting visible binding errors in RMD check
  month <-  year <- NULL

  df %>%
    dplyr::select(year, month, available_funds) %>%
    dplyr::rename(
      Year              = year,
      Month             = month,
      # Category          = category,
      'Available Funds' = available_funds
    )
}


#' Convert budget table to DataTable object
#'
#' Converts the budget table to a DataTable object.
#'
#' @param df Pre-processed budget dataframe
#' @noRd

to_DT <- function(df) {
  DT::datatable(
    data = df,
    fillContainer = FALSE,
    rownames= FALSE,
    options = list(
      columnDefs = list(
        list(
          className = 'dt-center',
          targets = "_all"
        )
      ),
      lengthMenu = c(20, 50, 100),
      pageLength = 20
    )
  ) %>%
    DT::formatCurrency(
      columns = 'Available Funds',
      currency = '$',
      mark = ",",
      digits = 0
    ) %>%
    DT::formatRound(
      columns = 'Year',
      digits = 0,
      mark = ""
    )
}



#' Create interactive budget projection plot
#'
#' Creates interactive plot with the highcharter library.
#'
#' @param df Pre-processed budget dataframe
#' @noRd

interactive_plot <- function(df) {

  # Define tool tip
  x <- c(
    "{point.month} {point.year}",
    "Available Funds"
  )
  y <- c(
    "",
    "${point.available_funds:,0f}"
  )

  tltip <- highcharter::tooltip_table(x, y)


  highcharter::hchart(
    df,
    "line",
    highcharter::hcaes(
      x = date,
      y = available_funds
    )
  ) %>%
    highcharter::hc_tooltip(
      crosshairs = TRUE,
      useHTML = TRUE,
      headerFormat = "",
      pointFormat = tltip
    ) %>%
    highcharter::hc_xAxis(
      title = list(
        text = ""
      ),
      labels = list(
        style = list(
          fontSize = "14px"
        )
      )
    ) %>%
    highcharter::hc_yAxis(
      title = list(
        text = "",
        style = list(
          fontSize = "25px"
        )
      ),
      labels = list(
        format = "${value:,0f}",
        style = list(
          fontSize = "14px"
        )
      ),
      plotLines = list(
        list(
          value = 0,
          color = "black",
          width = 3,
          dashStyle = "Solid"
        )
      )
    ) %>%
    highcharter::hc_plotOptions(
      line = list(
        lineWidth = 5,
        marker = list(
          lineWidth = 1,
          radius=7.5
        ),
        threshold = 0,
        color = "#0A9396",
        negativeColor = "#9B2226"
      )
    )

}
