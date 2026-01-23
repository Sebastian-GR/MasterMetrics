# Class material: Basic R code structure and example

# A typical structure
# 0. Set working directory (for this class or single scripts projects)
# 1. Clear environment
# 2. Load packages
# 3. Load data
# 4. Your code here

# Example 1: scatter plot with regression line. Simulated data.
# 0. Set working directory (for this class or single scripts projects)
setwd("G:/My Drive/Econometría y estadística/Material mío/Switala/Class 1")

# 1. Clear environment
rm(list = ls());gc()

# 2. Load packages
# Install packages if not already installed, then load them
# install.packages("ggplot2")
# install.packages("haven")
# install.packages("binsreg")
# install.packages("dplyr")
library(ggplot2)
library(haven)
library(binsreg)
library(dplyr)

# 3. Load data
dta <- read.csv("data/made/simulated_data.csv")
dta <- readRDS("data/made/simulated_data.rds")
dta <- read_dta("data/made/simulated_data.dta")

# 4. Your code here
summary(dta)
ggplot(dta, aes(x=x, y=y)) +
  geom_point() +
  geom_smooth(method = "lm", se=FALSE, color="blue") +
  labs(title="Scatter plot of y vs x with regression line",
       x="Independent variable (x)",
       y="Dependent variable (y)") +
  theme_minimal()
ggsave("output/figures/example_scatter_plot.png")


# Binscatter using binsreg package
dta <- dta %>% filter(!is.na(y))
binsreg(y = dta$y, x = dta$x, 
  nbins = 20,
  line = c(3,3),  # force linear fit
  plotxrange = c(min(dta$x), max(dta$x)),
  plotyrange = c(min(dta$y), max(dta$y)))

# Manual binscatter
bin_data <- dta %>%
  mutate(bin = ntile(x, 20)) %>%
  group_by(bin) %>%
  summarise(x_mean = mean(x), y_mean = mean(y), .groups = 'drop')

ggplot(bin_data, aes(x = x_mean, y = y_mean)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "lightblue") +
  theme_minimal()
ggsave("output/figures/example_binscatter_plot.png")


# Regression using lm()
model <- lm(y ~ x, data = dta)
summary(model)


# Export regression table using stargazer
stargazer(model, type = "html", 
          out = "output/tables/ugly_example_regression.html")


stargazer(model, type = "html", 
          out = "output/tables/example_regression.html",
          omit.stat = c("ser"),
          dep.var.labels = "",
          covariate.labels = c("X", "Constant"),
          column.labels = c("Y"),
          digits = 3,
          single.row = TRUE)
