library(tidyverse)
library(lubridate)
library(quantmod)   
library(broom)
library(ggplot2)

# CPI, all urban consumers
symbol <- "CPIAUCSL"
start_date <- as.Date("2015-01-01")
getSymbols(symbol, src = "FRED", from = start_date, auto.assign = TRUE)
cpi_xts <- get(symbol)
df <- tibble(
  date = index(cpi_xts),
  cpi = as.numeric(coredata(cpi_xts))
)

# Add date
origin <- ymd("1995-02-01")
df <- df %>%
  mutate(
    year = year(date),
    month = month(date),
    age = (year(date) - year(origin)) * 12 + (month(date) - month(origin))) %>%
  select(date, cpi, age)

# Plots
ggplot(df, aes(x = date)) +
  geom_line(aes(y = cpi), color = "blue", alpha = .3) +
  geom_line(aes(y = age), color = "green", alpha = .3) +
  labs(y = "CPI/Age", x = "Date") +
  theme_minimal()

ggplot(df, aes(x = age, y = cpi)) +
  geom_point(alpha = 0.1) +
  labs(x = "Age", y = "CPI") +
  theme_minimal()

# --- Regresión lineal cpi ~ age ---
fit <- lm(cpi ~ age, data = df)
summary(fit)

