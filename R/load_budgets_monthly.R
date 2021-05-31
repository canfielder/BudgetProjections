# # Load and process montly budget levels, wide format
# # Import ----------------------------------------------------------------------
# file_path <- here::here("data-raw", "budgets.xlsx")
# budget_monthly_wide_raw <- readxl::read_xlsx(
#   path  = file_path,
#   sheet = "by_month"
# )
#
# # Processing ------------------------------------------------------------------
# ## Wide format
# budget_monthly_wide <- budget_monthly_wide_raw %>%
#   janitor::clean_names() %>%
#   dplyr::select(!c("month", "year")) %>%
#   dplyr::select(date, everything())
#
#
# # Export-----------------------------------------------------------------------
# usethis::use_data(budget_monthly_wide, overwrite = TRUE)
# usethis::use_data(budget_monthly_wide, internal = TRUE, overwrite = TRUE)
