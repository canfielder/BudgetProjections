# # Load and processes the category name look-up table
# # Import ----------------------------------------------------------------------
# file_path <- here::here("data-raw", "budgets.xlsx")
# budget_default_raw <- readxl::read_xlsx(
#   path  = file_path,
#   sheet = "default"
# )
#
# # Processing ------------------------------------------------------------------
# ## Wide format
# category_key <- budget_default_raw %>%
#   janitor::clean_names() %>%
#   dplyr::select(category) %>%
#   dplyr::mutate(
#     category_clean = janitor::make_clean_names(category)
#   )
#
# # Export-----------------------------------------------------------------------
# usethis::use_data(category_key, overwrite = TRUE)
# usethis::use_data(c, internal = TRUE, overwrite = TRUE)
