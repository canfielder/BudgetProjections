# # Load and process budget balances
# # Import ----------------------------------------------------------------------
# file_path <- here::here("data-raw", "budgets.xlsx")
# budget_balance_raw <- readxl::read_xlsx(
#   path  = file_path,
#   sheet = "balance"
# )
#
# # Processing ------------------------------------------------------------------
# budget_balance <- budget_balance_raw %>%
#   janitor::clean_names() %>%
#   dplyr::mutate(
#     year = lubridate::year(date),
#     month = lubridate::month(
#       x = date,
#       label = TRUE,
#       abbr = FALSE
#     )
#   ) %>%
#   dplyr::select(category, balance)
#
#
# # Export-----------------------------------------------------------------------
# usethis::use_data(budget_balance, overwrite = TRUE)
# usethis::use_data(budget_balance, internal= TRUE, overwrite = TRUE)
