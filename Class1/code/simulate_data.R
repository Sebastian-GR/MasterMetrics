setwd("G:/My Drive/Econometría y estadística/Material mío/Switala/Class 1")

rm(list = ls())
set.seed(12345)
n <- 1000
u <- rnorm(n, 0, 40)
x <- rnorm(n, 1, 1)
selector <- runif(n)

y <- 1 + 2 * x + u
dta <- data.frame(cbind(y,x))
dta$y <- ifelse(selector > .95, NA, y)

write.csv(dta, "data/made/simulated_data.csv", row.names = FALSE)
saveRDS(dta, "data/made/simulated_data.rds")

library(haven)
write_dta(dta, "data/made/simulated_data.dta")

summary(lm(y~x))


# # Class
# # Part 0
# Relative directories. Good practices.
# Structure (data, code, output). Never overwrite raw data.
# 
# 
# # Part a
# Import data. Basic EDA. NAs and detection. Discuss important of EDA for safety.
# Mention potential problems such as importing commas, points, headers. Formats (dta, csv, rds, txt, xls, xlsx).
# Export a plot. Export a table.
# ARE THEY GONNA USE LATEX?
# 
# # Part b
# If there's time, regressions.