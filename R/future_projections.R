#' Determine available funds for available budgets
#'
#' Creates a table of the available funds, filtered from all transaction types
#'  to provided budget categories, within a defined date span.
#'
#' @param start_date Defaults to January 1, 2021. (character string,
#'  formatted as YYYY-MM-DD)
#' @param end_date  Defaults to one year past the current date. (character
#'  string, formatted as YYYY-MM-DD)
#' @noRd

fund_projections <- function(
  start_date = "2021-01-01",
  end_date = NA
  ) {

  # For quieting visible binding errors in RMD check
  category <-   NULL

  funds <- available_funds(
    start_date = start_date,
    end_date = end_date
    )

  # Set dates to Date type
  start_date = as.Date(start_date)
  if (is.na(end_date)) {
    end_date = Sys.Date() + lubridate::years(1)
  } else {
    end_date = as.Date(end_date)
  }

  # Extract known categories
  categories_vec <- category_key %>% dplyr::pull(category)

  # Filter Available Funds table
  funds %>%
    dplyr::filter(
      dplyr::between(
        x     = date,
        left  = as.Date(start_date),
        right = as.Date(end_date)
      ),
    category %in% categories_vec
  )

}


