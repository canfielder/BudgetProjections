# # Load and process future transactions data
#
# # Import ----------------------------------------------------------------------
# ## Transactions
# file_path <- here::here("data-raw", "transactions_future.csv")
# future_transactions_raw <- readr::read_csv(file_path)
#
# # Processing ------------------------------------------------------------------
# future_transactions <- future_transactions_raw %>%
#   janitor::clean_names() %>%
#   dplyr::mutate(
#     amount = dplyr::if_else(
#       condition = transaction_type == "debit",
#       true      = as.double(amount * -1),
#       false     = as.double(amount)
#     ),
#     date = as.Date(date, "%m/%d/%Y"),
#     year = lubridate::year(date),
#     month = lubridate::month(
#       x = date,
#       label = TRUE,
#       abbr = FALSE
#     )
#   ) %>%
#   dplyr::select(date, amount, category)
#
# # Export-----------------------------------------------------------------------
# usethis::use_data(future_transactions, overwrite = TRUE)
# usethis::use_data(future_transactions, internal = TRUE, overwrite = TRUE)
