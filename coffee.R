library(dplyr)
library(ggplot2)

# спрацювало (Error in read.table(file = file, header = header, sep = sep, quote = quote, : more columns than column names)
coffee <- read.csv('cleaned_top-rated-coffee-pp100g(enc).csv')

# якщо не працює, написати повний шлях
coffee <- read.csv("C://Users//HP//Desktop//Coffee//cleaned_top-rated-coffee-pp100g(enc).csv")

# увага на роздільник
coffee <- read.csv("cleaned_top-rated-coffee-pp100g(enc).csv", header = TRUE, sep = ";", fill = TRUE)

# продивитись перші рядки таблиці
readLines("cleaned_top-rated-coffee-pp100g(enc).csv", n = 10)

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



# порахувати, де найбільше записів + графік (цей графік стосується roaster_country)
country_counts <- as.data.frame(table(df$Country))
ggplot(country_counts, aes(x = reorder(Var1, -Freq), y = Freq)) +
  geom_bar(stat = "identity", fill = "pink") +
  labs(x = "Країна", y = "Кількість", title = "Кількість кави по країнах") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

names(df)
df <- read.csv("cleaned_top-rated-coffee-pp100g(enc).csv", sep=";", header=FALSE, stringsAsFactors = FALSE)

# вказати назви колонок вручну
colnames(df) <- c("coffee_name",	"total_score",	"roaster_location",	"coffee_origin",	"roast_level",	"est._price",	"agtron_ground",	"agtron_roast",	"price_per_100g",	"price_per_ounce",	"origin_country",	"clean_location",	"Country")
names(df)
head(df)
# гіпотеза: найдорожчі види кави пов'язані з регіонами: Гватемала та Ефіопія