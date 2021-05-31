#' Calculate all available funds
#'
#' Generates a table of available funds. The table includes all transaction
#' categories in the past transactions table. Available funds are provided
#' for all months from defined from start date to the most distant date
#' in the future budget table.
#'
#' @param start_date Defaults to January 1, 2021. (character string,
#'  formatted as YYYY-MM-DD)
#' @param end_date  Defaults to one year past the current date. (character
#'  string, formatted as YYYY-MM-DD)
#' @noRd

available_funds <- function(
  start_date = "2021-01-01",
  end_date = NA
) {

  # For quieting visible binding errors in RMD check
  amount  <- category <- future_budgets <- month <- net_spending <- year <- NULL

  # Dates ---------------------------------------------------------------------
  # Define baseline date
  baseline_date <- sample(baseline_funds$date, 1)

  # Convert end date to date type object if not NA
  if (!is.na(end_date)) {
    end_date = as.Date(end_date)
  }

  ## Earliest end date
  minimum_end_date <- end_date_cutoff()

  # Convert type and set to first of month
  start_date <- as.Date(
    paste(
      lubridate::year(start_date),
      lubridate::month(start_date),
      "01",
      sep = "-"
    )
  )

  # Table Calculations ---------------------------------------------------------
  ## Future budgets
  if (end_date >= minimum_end_date){
    future_budgets <- future_budgets_table(end_date)
  }

  # Import long form budgets
  budgets_long <- budget_monthly_long()

  # Bind all tables
  available_inputs <- transactions %>%
    dplyr::bind_rows(future_transactions) %>%
    dplyr::bind_rows(budgets_long) %>%
    dplyr::bind_rows(future_budgets) %>%
    dplyr::filter(
      date > baseline_date
    ) %>%
    dplyr::bind_rows(baseline_funds)

  # Calculate available funds by year, month, category
  available_inputs %>%
    dplyr::mutate(
      year = lubridate::year(date),
      month = lubridate::month(
        x     = date,
        label = TRUE,
        abbr  = FALSE
      )
    ) %>%
    dplyr::group_by(category, year, month) %>%
    dplyr::summarise(net_spending = sum(amount)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(date = lubridate::mdy(
      paste0(month, "/01/", year, sep = "")
    )
    ) %>%
    dplyr::arrange(date) %>%
    dplyr::group_by(category) %>%
    dplyr::mutate(
      available_funds = floor(cumsum(net_spending))
    ) %>%
    dplyr::ungroup() %>%
    dplyr::select(!net_spending) %>%
    dplyr::arrange(category, date)

}

