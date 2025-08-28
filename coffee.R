library(dplyr)
library(ggplot2)
# не спрацювало
coffee <- read.csv('top-rated-coffee-clean.csv')

# спочатку не спрацювало, увага на роздільник
coffee <- read.csv("top-rated-coffee-clean.csv", header = TRUE, sep = ";", fill = TRUE)

# продивитись перші рядки таблиці
readLines("top-rated-coffee-clean.csv", n = 10)