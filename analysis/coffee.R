library(dplyr)
library(ggplot2)

# увага на роздільник
coffee <- read.csv("coffee-cleaned.csv", header = TRUE, sep = ";", fill = TRUE)

# продивитись перші рядки таблиці
readLines("coffee-cleaned.csv", n = 10)

# подивитись директорію
getwd()

# описова статистика
# середнє (середня ціна за 100 г)
mean(coffee$price_per_100g)    # NA
# перевірка типу значень
class(coffee$price_per_100g)    # [1] "numeric"
# виправити на числове значення з текстового
mean(as.numeric(coffee$price_per_100g), na.rm = TRUE)     # [1] 329.1343 In mean(as.numeric(coffee$price_per_100g), na.rm = TRUE):NAs introduced by coercion
# TODO: перевірити, чому такий результат, можливо, пропущенні значення
# медіана по ціні за 100 г
median(coffee$price_per_100g, na.rm = TRUE) # [1] "10.575"
# мінімальна ціна за 100 г
min(coffee$price_per_100g, na.rm = TRUE)    # [1] "0.22"
# TODO: як уникнути порожнього значення
# максимальна ціна за 100 г
max(coffee$price_per_100g, na.rm = TRUE)    #[1] "6000" 
# діапазон (мін, макс)
range(coffee$price_per_100g, na.rm = TRUE)  # [1] "0.22"      "6000"
# дисперсія
var(coffee$price_per_100g, na.rm = TRUE)    # [1] 75088.86
# стандартне відхилення
sd(coffee$price_per_100g, na.rm = TRUE)     # [1] 274.0235
# швидкий опис
summary(coffee$price_per_100g)   

# вивести топ-10 найдорожчих видів кави
coffee %>%
    slice_max(n=10, price_per_100g) %>%
    arrange(desc(price_per_100g))



# порахувати, де найбільше записів + графік (цей графік стосується roaster_country)
country_counts <- as.data.frame(table(df$Country))
ggplot(country_counts, aes(x = reorder(Var1, -Freq), y = Freq)) +
  geom_bar(stat = "identity", fill = "pink") +
  labs(x = "Країна", y = "Кількість", title = "Кількість кави по країнах") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# гіпотеза: найдорожчі види кави пов'язані з регіонами: Гватемала та Ефіопія
# Н0: ціни в Гватемалі/Ефіопії не відрізняються від інших країн
# Н1: ціни там вищі
# Результат: Н0, Н1 частково підтверджується, але найдорощі лоти часто з Панами,Еквадору

# середнє, медіана, максимум. найвища середня у Тайвані, 
coffee %>%
  group_by(origin_country_clean) %>%
  summarise(
    mean_price = mean(price_per_100g, na.rm = TRUE),
    median_price = median(price_per_100g, na.rm = TRUE),
    max_price = max(price_per_100g, na.rm = TRUE),
    n = n()
  ) %>%
  arrange(desc(median_price))

# Коробкова візуалізація за Гватемалою, Ефіопією, Тайванем
#у Гватемали та Ефіопії є екстримальні значення(ексклюзивні лоти), які тягнуть вгору
coffee %>%
  filter(origin_country_clean %in% c("Guatemala", "Ethiopia", "Taiwan")) %>%
  ggplot(aes(x = origin_country_clean, y = price_per_100g)) +
  geom_boxplot() +
  labs(title = "Coffee prices in Guatemala and Ethiopia",
       x = "Country of Origin",
       y = "Price per 100g")

# t-test, p-value. на 95% на 6.63 доларів дорожча з Гватемали, Ефіопії
coffee %>%
  mutate(region = ifelse(origin_country_clean %in% c("Guatemala", "Ethiopia"),
                         "Guatemala/Ethiopia", "Other")) %>%
  t.test(price_per_100g ~ region, data = ., alternative = "greater")

# зріз топових лотів. найдорожча кава Панама, Еквадор
coffee %>%
  slice_max(order_by = price_per_100g, n = 10) %>%
  select(coffee_name, origin_country_clean, price_per_100g)

# коробкова діаграма цін по країнам (топ 5)
top_countries <- names(sort(table(coffee$origin_country_clean), decreasing = TRUE))[1:5]
df_top <- coffee[coffee$origin_country_clean %in% top_countries, ]
df_clean <- subset(df_top, origin_country_clean != "" & !is.na(origin_country_clean) & !is.na(price_per_100g))

ggplot(df_clean, aes(x = origin_country_clean, y = price_per_100g)) +
  geom_boxplot(fill = "pink") +
  labs(title = "Price distribution (Top 5 countries)",
       x = "Country",
       y = "Price") +
  theme_minimal()

# гіпотеза: чим більший ступінь обсмажування, тим дорожча кава
# H0: немає зв'язку між ступенем обсмажування та ціною
# H1: є зв'язок між ступенем обсмажування та ціною

install.packages(c("tidyverse", "Hmisc", "corrplot", "GGally", "psych", "ggcorrplot"))

library(tidyverse)   
library(Hmisc)      
library(corrplot) 
library(GGally)
library(psych)       
library(ggcorrplot)

head(df)      
str(df)        
summary(df)

str(df$roast_level)
str(df$total_score)

#замінти текстові значення на числов
df$total_score <- gsub(",", ".", df$total_score)
df$total_score <- as.numeric(df$total_score)   

#почистити порожні дані
df <- df %>%
  mutate(
    roast_level = na_if(roast_level, ""),          
    roast_level = ifelse(roast_level == "roast_level", NA, roast_level)
  )

df$roast_level <- as.factor(df$roast_level)

#які рівні обсмаження мають вищий/нижчий середній бал
df %>%
  group_by(roast_level) %>%
  summarise(
    n = n(),
    mean_score = mean(total_score, na.rm = TRUE),
    sd_score = sd(total_score, na.rm = TRUE)
  ) %>%
  arrange(desc(n))

# anova
anova_result <- aov(total_score ~ roast_level, data = df)
summary(anova_result)

TukeyHSD(anova_result)

ggplot(df, aes(x = roast_level, y = total_score, fill = roast_level)) +
  geom_boxplot() +
  theme_minimal() +
  labs(
    title = "Розподіл Total Score за Roast Level",
    x = "Рівень обсмаження",
    y = "Загальний бал"
  )

# кореляція між оцінкою якості та ціною (низький коефіцієнт кореляцій)
cor(coffee$price_per_100g, coffee$total_score, use = "complete.obs")

ggplot(coffee, aes(x = total_score, y = price_per_100g)) +
  geom_point(color = "pink") +
  geom_smooth(method = "lm", se = FALSE, color = "violet") +
  labs(title = "Зв'язок між оцінкою якості і ціною за 100г (у доларах США)",
       x = "Оцінка якості",
       y = "Ціна за 100 г (у доларах США)")

# кореляція між ціною за 100 г та іншими показниками (низький коефіцієнт)
cor(coffee$agtron_roast, coffee$price_per_100g, use = "complete.obs")
cor(coffee$agtron_ground, coffee$price_per_100g, use = "complete.obs")
cor(coffee$total_score, coffee$agtron_roast, use = "complete.obs")
cor(coffee$total_score, coffee$agtron_ground, use = "complete.obs")


plot(coffee)
plot(coffee$agtron_ground, coffee$agtron_roast, 
     col = "#cc0000",
     pch = 19, 
     main ="Coffee: agtron_ground vs. agtron_roast", 
     xlab = "Agtron ground", 
     ylab = "Agtron roast")

cor(coffee$agtron_ground, coffee$agtron_roast, use = "complete.obs")

install.packages("lars")
library(lars)
X <- as.matrix(coffee[, c("agtron_ground", "agtron_roast", "total_score")])
y <- coffee$price_per_100g
lars_model <- lars(X, y)
summary(lars_model)
plot(lars_model)
# check an error
str(X)
sum(is.na(X))
sum(is.na(y))
# sum was > 0, needs to be cleaned
data_clean <- na.omit(data.frame(X, y))
X_clean <- as.matrix(data_clean[, c("agtron_ground", "agtron_roast", "total_score")])
y_clean <- data_clean$y
sum(is.na(X_clean))
sum(is.na(y_clean))
#new attempt
lars_model <- lars(X_clean, y_clean)
plot(lars_model)
summary(lars_model)


install.packages("glmnet")
library(glmnet)
X <- model.matrix(price_per_100g ~ agtron_ground + agtron_roast + total_score, coffee)[, -1]
y <- coffee$price_per_100g
lasso_model <- glmnet(X, y, alpha = 1)
#different amount of rows
data_clean <- na.omit(data.frame(X, y))
nrow(X)
length(y)
X <- as.matrix(coffee[, c("agtron_ground", "agtron_roast", "total_score")])
y <- coffee$price_per_100g
#clean rows
coffee_clean <- na.omit(coffee[, c("agtron_ground", "agtron_roast", "total_score", "price_per_100g")])
X_clean <- as.matrix(coffee_clean[, c("agtron_ground", "agtron_roast", "total_score")])
y_clean <- coffee_clean$price_per_100g
nrow(X_clean)
length(y_clean)
lasso_model <- glmnet(X_clean, y_clean, alpha = 1)
plot(lasso_model)
cv_lasso <- cv.glmnet(X_clean, y_clean, alpha = 1)
coef(cv_lasso, s = "lambda.min")