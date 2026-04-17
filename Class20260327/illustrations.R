rm(list=ls())
library(tidyverse)

# CLT
n <- 100000 # 100000
sims <- 500
dta  <- data.frame("index" = rep(1:sims, each= n), "result" = rchisq(sims * n, 1))
hist(dta$result)


sigma <- sqrt(2)
mu <- 1
dta <- dta %>% group_by(index) %>% 
  summarise(xbar = sqrt(n) * mean(result - mu)/sigma)
hist(dta$xbar)
quantile(dta$xbar, .975)

# Endogeneity
n <- 50
x <- rnorm(n)
u <- rnorm(n) + x
y <- x + u
reg <- lm(y ~ x)
uhat <- residuals(reg)
round(cov(x, u)) == 0
round(cov(x, uhat)) == 0
