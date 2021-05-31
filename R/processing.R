#' Past budgets - long format
#'
#' Converts wide format past budgets table into long format. All inputs are
#' data tables documented in this package.
#'
#' @noRd

budget_monthly_long <- function() {
  # For quieting visible binding errors in RMD check
  amount <- category <- NULL


  budget_monthly_wide %>%
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

}

