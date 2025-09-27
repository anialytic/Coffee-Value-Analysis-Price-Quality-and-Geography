library(dplyr)
library(ggplot2)

# спрацювало (Error in read.table(file = file, header = header, sep = sep, quote = quote, : more columns than column names)
coffee <- read.csv('coffee-cleaned.csv')

# якщо не працює, написати повний шлях
coffee <- read.csv("C://Users//HP//Desktop//Coffee//coffee-cleaned.csv")

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