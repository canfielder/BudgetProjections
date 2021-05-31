#' Generate table of future monthly budgets
#'
#' Creates a table of future monthly budgets, starting at the most recent month
#'  where budget information is not provided. A default budget is used as the
#'  monthly budget value.
#'
#' @param end_date  Defaults to one year past the current date.
#'  (character string, formatted as YYYY-MM-DD)
#' @noRd

future_budgets_table <- function(end_date = NA) {

  # For quieting visible binding errors in RMD check
  amount <- category <- category_clean  <-  NULL


  # Convert end date to date type object
  if (is.na(end_date)) {
    end_date = Sys.Date() + lubridate::years(1)
  } else {
    end_date = as.Date(end_date)
  }
#
#   # Check to ensure end date is later than current date
#   ## Determine the first day of the next month
#   current_date <- Sys.Date()
#   date_cutoff <- end_date_cutoff()
#
#   if (end_date < date_cutoff) {
#     stop("The End Date is not acceptable. The End Date must be the first of
#          the next month or later.")
#   }

  # Determine most recent known date
  most_recent_date <- budget_monthly_wide %>%
    dplyr::pull(date) %>%
    max() %>%
    as.Date()

  # Create monthly sequence vector between most recent known date and end date
  proj_dates <- seq(
    most_recent_date + months(1),
    end_date,
    by = "month"
  )

  # Extract vector of categories
  categories_vec <- category_key %>%
    dplyr::pull(category)
  categories_clean_vec <- category_key %>%
    dplyr::pull(category_clean)

  # Define list of columns for output dataframe
  list_labels <- c('date', categories_clean_vec)

  # Initialize list for future budget values. To be converted to dataframe
  list_future_budgets <- vector(
    mode = "list",
    length = length(list_labels)
  )

  # Assign names to list
  names(list_future_budgets) <- list_labels

  # Add date sequence to list
  list_future_budgets[['date']] <- proj_dates

  # Add default budget levels to list
  for (budget_category in categories_vec) {

    # Determine budget value
    default_budget <- budget_defaults %>%
      dplyr::filter(
        category == budget_category
      ) %>%
      dplyr::pull(amount)

    # Generate repeating vector of budget values
    future_budgets <- rep(
      x     = default_budget,
      times = length(proj_dates)
    )

    # Determine category label (Janitor format)
    list_label <- category_key %>%
      dplyr::filter(category == budget_category) %>%
      dplyr::pull(category_clean)

    # Add default budget levels to list
    list_future_budgets[[list_label]] <- future_budgets

  }

  # Convert list to long form dataframe
  future_budgets_long <- as.data.frame(list_future_budgets) %>%
    tidyr::pivot_longer(
      !date,
      names_to = "category_clean",
      values_to = "amount"
    ) %>%
    dplyr::left_join(
      y = category_key,
      by = "category_clean"
    ) %>%
    dplyr::select(date, amount, category)

  future_budgets_long

}
