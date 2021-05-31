#' Generate table of future monthly budgets
#'
#' Calculates the minimum allowable end date for the budget projections
#'
#' @noRd

end_date_cutoff <- function(){
  # Define current date
  current_date <- Sys.Date()

  # Determine earliest allowable future date
  as.Date(
    paste(
      lubridate::year(current_date),
      lubridate::month(current_date) + 1,
      "01",
      sep = "-"
    )
  )
}
