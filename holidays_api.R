library(pacman)

p_load(
  tidyverse,
  jsonlite,
  httr,
  usethis
)

holidays_url <- "https://holidays18.p.rapidapi.com/holidays/find?country=US&year=2024"
responce = GET(
  holidays_url,
  add_headers(
    "x-rapidapi-host" = Sys.getenv("rapidapi_host"),
    "x-rapidapi-key" = Sys.getenv("rapidapi_key")
  )
)

data = content(responce, as="text", encoding = "UTF-8")
data_json <- fromJSON(data)
holidays <- data_json |>
  as_tibble() |>
  select(date, name)
holidays

write_csv(holidays, "holidays.csv")
