#' #' Budget Projections - Wrapper Function
#' #'
#' #' Generates future budget projections based on past transactions, past monthly
#' #' budget levels, future transactions, estimated future transactions, and
#' #' known budget balances.
#' #'
#' #' * Past transaction data is and exported CSV from Mint.com.
#' #' * Future transaction data is manually maintained in this package.
#' #' * Past budgets are manually document in this project, and reflect the
#' #'  budget levels used in Mint.com for their respective months.
#' #' * Default budget data is manually maintained in this package.
#' #' * Budget balances on January 1, 2021 were calculated in the notebook
#' #'  **baseline_budget_balances**, maintained in this package.
#' #'
#' #' @param start_date Defaults to January 1, 2021. (character string,
#' #'  formatted as YYYY-MM-DD)
#' #' @param end_date  Defaults to one year past the current date. (character
#' #'  string, formatted as YYYY-MM-DD)
#' #' @noRd
#'
#' budget_projections_wrapper <- function(
#'   start_date = "2021-01-01",
#'   end_date = NA
#' ){
#'
#'   # Import --------------------------------------------------------------------
#'   # Transactions
#'   past_trans_raw <- import_csv(path_past_transactions)
#'   future_trans_raw <- import_csv(path_future_transactions)
#'
#'   # Budgets
#'   past_bgt_raw <- import_xlsx(
#'     file  = path_past_budgets,
#'     sheet = sheet_past_budgets
#'       )
#'   bgt_default_raw <- import_xlsx(
#'     file  = path_default_budgets,
#'     sheet =  sheet_default_budgets
#'     )
#'   bgt_parent_child_raw <- import_xlsx(
#'     file = path_parent_child_budgets,
#'     sheet = sheet_parent_child_budgets
#'     )
#'   bgt_baseline <- readRDS(path_budget_balance)
#'
#'   # Processing ----------------------------------------------------------------
#'   # Transactions
#'   past_trans <- process_past_transactions(past_trans_raw, bgt_parent_child_raw)
#'   future_trans <- process_future_transactions(future_trans_raw)
#'
#'   # Budgets
#'   category_key <- create_category_key_lookup(bgt_baseline)
#'   past_bgt_wide <- process_past_budgets_wide(past_bgt_raw)
#'   past_bgt_long <- process_past_budgets_long(past_bgt_raw, category_key)
#'
#'   # Analysis ------------------------------------------------------------------
#'   # Future budgets
#'   future_bgt_long <- future_budgets_table(
#'     end_date       = end_date,
#'     budget_history = past_bgt_wide,
#'     budget_default = bgt_default_raw,
#'     category_key   = category_key
#'   )
#'
#'   # Available Funds - Total
#'   funds_complete <- available_funds(
#'     past_transactions       = past_trans,
#'     future_transactions     = future_trans,
#'     past_budgets            = past_bgt_long,
#'     future_budgets          = future_bgt_long,
#'     budget_balance_baseline = bgt_baseline
#'   )
#'
#'   # Available funds - budget categories only
#'   fund_projections(
#'     available_funds = funds_complete,
#'     category_key    = category_key,
#'     start_date      = start_date,
#'     end_date        = end_date
#'   )
#' }
