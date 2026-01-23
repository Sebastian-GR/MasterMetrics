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
rm(list=ls())

# 2. Load packages
library(ggplot2)
library(tidyverse)
library(stargazer)

# 3. Load data
dta <- read.csv(unz("data/raw/dec25pub.zip", "dec25pub.csv"))
nrow(dta) # May be useful to work with subsample in first contact with data
View(head(dta))


# 4. Your code here
# Basic EDA

# Dictionary is key to understand variable names and meanings
# https://www2.census.gov/programs-surveys/cps/datasets/2025/basic/2025_Basic_CPS_Public_Use_Record_Layout_plus_IO_Code_list.txt
# E.g., sex: pesex (1=male, 2=female)

dta <- dta %>%
  rename(
    income = pternwa,
    age = prtage,
    sex = pesex,
    race = ptdtrace,
    full = prhrusl,
    educ1 = pehgcomp,
    educ2 = pecyc
  ) %>% 
  select(income, age, sex, race, full, educ1, educ2)

dta <- dta %>% mutate(
    educ = case_when(
      educ1 == 1 ~ 0,
      educ1 == 2 ~ 2.5,
      educ1 == 3 ~ 5.5,
      educ1 == 4 ~ 7.5,
      educ1 == 5 ~ 9,
      educ1 == 6 ~ 10,
      educ1 == 7 ~ 11,
      educ1 == 8 ~ 12,
      educ2 == 1 ~ 12,
      educ2 == 2 ~ 13,
      educ2 == 3 ~ 14,
      educ2 == 4 ~ 15,
      educ2 == 5 ~ 16,
      TRUE ~ NA_real_
    )
)
  
dta <- dta %>% 
    filter(income > 0 & age >= 30 & age <= 60 & full == 4) %>% 
    select(income, age, sex, race, educ)
nrow(dta)

# EDA
summary(dta)
quantile(dta$income, probs = c(0.99), na.rm = TRUE)
hist(dta$income, col = "lightblue")

dta <- dta %>% filter(income <= 288461) # See dictionary

hist(dta$educ, col = "lightblue")

ggplot(dta, aes(x=educ, y=income)) +
  geom_point(alpha=0.3) +
  geom_smooth(method = "lm", se=FALSE, color="blue") +
  labs(title="Scatter plot of income vs education with regression line",
       x="Years of education",
       y="Annual income (USD)") +
  theme_minimal()

dta <- dta %>% filter(educ > 8)

ggplot(dta, aes(x=educ, y=income)) +
  geom_point(alpha=0.3) +
  geom_smooth(method = "lm", se=FALSE, color="blue") +
  labs(title="Scatter plot of income vs education with regression line",
       x="Years of education",
       y="Annual income (USD)") +
  theme_minimal()
# Export processed data
write_csv(dta, "data/made/cps_processed.csv")

# Regression
dta <- read.csv("data/made/cps_processed.csv")
model <- lm(income ~ educ, data = dta)
summary(model)

stargazer(model, type = "html", 
          out = "output/tables/educ_regression.html",
          omit.stat = c("ser"),
          dep.var.labels = "",
          covariate.labels = c("Education", "Constant"),
          column.labels = c("Income"),
          digits = 0,
          single.row = F)
