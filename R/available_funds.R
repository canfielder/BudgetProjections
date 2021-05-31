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

  # Convert end date to date type object if not NA
  if (!is.na(end_date)) {
    end_date = as.Date(end_date)
  }

  # Calculate future budgets - if needed
  ## Minimum date
  minimum_date <- end_date_cutoff()

  ## Future budgets
  if (end_date >= minimum_date){
    future_budgets <- future_budgets_table(end_date)
  }

  # Convert type
  start_date <- as.Date(start_date)

  budgets_long <- budget_monthly_long()

  # Bind all tables
  available_inputs <- transactions %>%
    dplyr::bind_rows(future_transactions) %>%
    dplyr::bind_rows(budgets_long) %>%
    dplyr::bind_rows(future_budgets) %>%
    dplyr::filter(
      date >= start_date
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

