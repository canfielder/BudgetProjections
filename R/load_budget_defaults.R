# # Load and budget defaults data
#
# # Import ----------------------------------------------------------------------
# file_path <- here::here("data-raw", "budgets.xlsx")
# budget_defaults_raw <- readxl::read_xlsx(
#   path  = file_path,
#   sheet = "default"
# )
#
#
# # Processing ------------------------------------------------------------------
# budget_defaults <- budget_defaults_raw %>%
#   janitor::clean_names()
#
#
# # Export-----------------------------------------------------------------------
# usethis::use_data(budget_defaults, overwrite = TRUE)
# usethis::use_data(budget_defaults, internal = TRUE, overwrite = TRUE)
