# # Load and process transactions data
#
# # Import ----------------------------------------------------------------------
# ## Transactions
# file_path <- here::here("data-raw", "transactions.csv")
# transactions_raw <- readr::read_csv(file_path)
#
# ## Parent / Child Budgets
# file_path <- here::here("data-raw", "budgets.xlsx")
# budgets_parent_child_raw <- readxl::read_xlsx(
#   path  = file_path,
#   sheet = "parent_child"
#   ) %>%
#   janitor::clean_names()
#
#
# # Processing ------------------------------------------------------------------
# ## Define override budgets
# override_budgets <- c("Travel", "Entertainment")
#
#
# ## Execute processing
# transactions <- transactions_raw %>%
#   janitor::clean_names() %>%
#   dplyr::filter(
#     account_name != "CREDITCARD Account"
#   ) %>%
#   dplyr::mutate(
#     amount =  dplyr::if_else(
#       condition = transaction_type == "debit",
#       true      = as.double(amount * -1),
#       false     = as.double(amount)
#     ),
#     date = as.Date(date, "%m/%d/%Y")
#   ) %>%
#   dplyr::select(date, amount, category) %>%
#   dplyr::left_join(
#     budgets_parent_child_raw,
#     by = c("category" = "child")
#   ) %>%
#   dplyr::mutate(
#     category =  dplyr::if_else(
#       condition = (parent %in% override_budgets),
#       true = parent,
#       false = category
#     )
#   ) %>%
#   dplyr::select(!parent)
#
#
# # Export-----------------------------------------------------------------------
# usethis::use_data(transactions, overwrite = TRUE)
# usethis::use_data(transactions, internal = TRUE, overwrite = TRUE)
