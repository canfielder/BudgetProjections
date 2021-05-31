#' Budget balance on a know start date
#'
#' Balances for each budget category on a defined date. These balances are
#' calculated in the notebook **internal_data.Rmd** in the **data-raw**
#' folder.
#'
#' @format A data frame with 17 rows and 3 variables:
#' \describe{
#'   \item{date}{date of budget balance, character expressed in YYYY-MM-DD}
#'   \item{amount}{balance of budget balance, in US dollars}
#'   \item{category}{budget category, character}
#'   ...
#' }
"baseline_funds"


#' Budget balances on May 15, 2021
#'
#' Budget balances on May 15, 2021.
#'
#' @format A data frame with 17 rows and 3 variables:
#' \describe{
#'   \item{category}{budget category, character}
#'   \item{balance}{balance of budget balance, in US dollars}
#'   ...
#' }
"budget_balance"


#' Monthly budget levels
#'
#' The amount allocated to every budget category, recorded on a monthly basis.
#'
#' @format A data frame with 18 variables:
#' \describe{
#'   \item{date}{date of budget allotment, with the full date representing
#'    the month that date is in, character expressed in YYYY-MM-DD}
#'   \item{routine_maintenance}{Monthly budget allotment for the Routine
#'    Maintenance category, in US dollars}
#'   \item{service_parts}{Monthly budget allotment for the Service Parts
#'    category, in US dollars}
#'   \item{entertainment}{Monthly budget allotment for the Entertainment
#'    category, in US dollars}
#'   \item{donation}{Monthly budget allotment for the Donation
#'    category, in US dollars}
#'   \item{gift}{Monthly budget allotment for the Gift
#'    category, in US dollars}
#'   \item{running_events}{Monthly budget allotment for the Running Events
#'    category, in US dollars}
#'   \item{home_goods_large}{Monthly budget allotment for the Home Goods -
#'    Large category, in US dollars}
#'   \item{home_goods_small}{Monthly budget allotment for the Home Goods -
#'    Small category, in US dollars}
#'   \item{home_supplies}{Monthly budget allotment for the Home Supplies
#'    category, in US dollars}
#'   \item{flex_spending}{Monthly budget allotment for the Flex Spending
#'    category, in US dollars}
#'   \item{personal_care}{Monthly budget allotment for the Personal Care
#'    category, in US dollars}
#'   \item{athletic_apparel}{Monthly budget allotment for the Athletic
#'    Apparel category, in US dollars}
#'   \item{bike_maintenance}{Monthly budget allotment for the Bike Maintenance
#'    category, in US dollars}
#'   \item{electronics_software}{Monthly budget allotment for the Electronics
#'    & Software category, in US dollars}
#'   \item{sporting_goods}{Monthly budget allotment for the Sporting Goods
#'    category, in US dollars}
#'   \item{fashion_apparel}{Monthly budget allotment for the Fashion
#'    Apparel category, in US dollars}
#'   \item{travel}{Monthly budget allotment for the Travel category, in
#'    US dollars}
#'   ...
#' }
"budget_monthly_wide"


#' Category label key
#'
#' Look-up table for connecting the budget category labels with same labels
#' processed by the **janitor::make_clean_names()** function.
#'
#' @format A data frame with 17 rows and 2 variables:
#' \describe{
#'   \item{category}{budget category label, character}
#'   \item{category_clean}{budget category label processed with
#'    **janitor::make_clean_names()**, character}
#'   ...
#' }
"category_key"


#' Default budget monthly levels
#'
#' Default monthly values.
#'
#' @format A data frame with 17 rows and 2 variables:
#' \describe{
#'   \item{category}{budget category, character}
#'   \item{amount}{balance of budget balance, in US dollars}
#'   ...
#' }
"budget_defaults"


#' Future transactions
#'
#' Anticipated future transactions.
#'
#' @format A data frame with 3 variables:
#' \describe{
#'   \item{date}{date of budget balance, character expressed in YYYY-MM-DD}
#'   \item{amount}{balance of budget balance, in US dollars}
#'   \item{category}{budget category, character}
#'   ...
#' }
"future_transactions"


#' Transactions
#'
#'Past transactions
#'
#' @format A data frame with 3 variables:
#' \describe{
#'   \item{date}{date of budget balance, character expressed in YYYY-MM-DD}
#'   \item{amount}{balance of budget balance, in US dollars}
#'   \item{category}{budget category, character}
#'   ...
#' }
"transactions"
