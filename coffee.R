library(dplyr)
library(ggplot2)

# спрацювало (Error in read.table(file = file, header = header, sep = sep, quote = quote, : more columns than column names)
coffee <- read.csv('top-rated-coffee-pp100g(enc).csv')

# якщо не працює, написати повний шлях
coffee <- read.csv("C://Users//HP//Desktop//Coffee//top-rated-coffee-pp100g(enc).csv")

# увага на роздільник
coffee <- read.csv("top-rated-coffee-pp100g(enc).csv", header = TRUE, sep = ";", fill = TRUE)

# продивитись перші рядки таблиці
readLines("top-rated-coffee-pp100g(enc).csv", n = 10)

# подивитись директорію
getwd()

# описова статистика
# середнє (середня ціна за 100 г)
# перша проблема: значення не числові
mean(coffee$price_per_100g)   
# перевірка типу значень
class(coffee$price_per_100g)    # [1] "character"
# виправити на числове значення з текстового
mean(as.numeric(coffee$price_per_100g), na.rm = TRUE)     # [1] 329.1343 In mean(as.numeric(coffee$price_per_100g), na.rm = TRUE):NAs introduced by coercion
# TODO: перевірити, чому такий результат, можливо, пропущенні значення
# медіана по ціні за 100 г
median(coffee$price_per_100g, na.rm = TRUE) # [1] "39,68"
# мінімальна ціна за 100 г
min(coffee$price_per_100g, na.rm = TRUE)    # [1] ""(до , na.rm = TRUE)   
# TODO: як уникнути порожнього значення
# максимальна ціна за 100 г
max(coffee$price_per_100g, na.rm = TRUE)    #[1] "99,21"(до , na.rm = TRUE)  
# діапазон (мін, макс)
range(coffee$price_per_100g, na.rm = TRUE)  # [1] ""      "99,21"(до , na.rm = TRUE)
# дисперсія
var(coffee$price_per_100g, na.rm = TRUE)    # [1] NA(до , na.rm = TRUE), після: [1] 493511.8
# стандартне відхилення
sd(coffee$price_per_100g, na.rm = TRUE)     # [1] NA(до , na.rm = TRUE), після: [1] 702.504
# швидкий опис
summary(coffee$price_per_100g)   

# вивести топ-10 найдорожчих видів кави
coffee %>%
    slice_max(n=10, price_per_100g) %>%
    arrange(desc(price_per_100g))

# гіпотеза: найдорожчі види кави пов'язані з регіонами: Гватемала та Ефіопія