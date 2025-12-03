library(dplyr)
library(ggplot2)

coffee <- read.csv("C://Users//HP//Desktop//Coffee//data//cleaned//coffee_filled.csv", header = TRUE, sep = ';')

head(coffee)

# описова статистика
mean(coffee$price_per_100g)   
class(coffee$price_per_100g)  
median(coffee$price_per_100g, na.rm = TRUE) 
min(coffee$price_per_100g, na.rm = TRUE)    
max(coffee$price_per_100g, na.rm = TRUE)
range(coffee$price_per_100g, na.rm = TRUE) 
var(coffee$price_per_100g, na.rm = TRUE)  
sd(coffee$price_per_100g, na.rm = TRUE)   
summary(coffee$price_per_100g)   

# вивести топ-10 найдорожчих видів кави
coffee %>%
    slice_max(n=10, price_per_100g) %>%
    arrange(desc(price_per_100g))

# порахувати, де найбільше записів + графік (цей графік стосується roaster_country)
country_counts <- as.data.frame(table(coffee$roaster_country))
ggplot(country_counts, aes(x = reorder(Var1, -Freq), y = Freq)) +
  geom_bar(stat = "identity", fill = "pink") +
  labs(x = "Країна", y = "Кількість", title = "Кількість кави по країнах") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Н0: середня ціна в Гватемалі та Ефіопії не відрізняються від інших країн
# Н1: середня ціна в Гватемалі Та Ефіопії вищі
# Результат: Н0

# середнє, медіана, максимум. найвища середня у Тайвані, 
coffee %>%
  group_by(origin_country) %>%
  summarise(
    mean_price = mean(price_per_100g, na.rm = TRUE),
    median_price = median(price_per_100g, na.rm = TRUE),
    max_price = max(price_per_100g, na.rm = TRUE),
    n = n()
  ) %>%
  arrange(desc(mean_price))

# Коробкова візуалізація за Гватемалою, Ефіопією, Тайванем
#у Гватемали та Ефіопії є екстримальні значення(ексклюзивні лоти), які тягнуть вгору
coffee %>%
  filter(origin_country %in% c("Guatemala", "Ethiopia", "Taiwan")) %>%
  ggplot(aes(x = origin_country, y = price_per_100g)) +
  geom_boxplot() +
  labs(title = "Coffee prices in Guatemala and Ethiopia",
       x = "Country of Origin",
       y = "Price per 100g")

#try one more time (difference is significant, price depends on origin_country)
anova_model <- aov(price_per_100g ~ origin_country, data = coffee)
summary(anova_model)
# Perform Tukey HSD post-hoc test (if ANOVA is significant)
TukeyHSD(anova_model)

#filter signficant results
tukey <- TukeyHSD(anova_model)
tukey_table <- as.data.frame(tukey$origin_country)
tukey_table$comparison <- rownames(tukey_table)
significant <- tukey_table[tukey_table$`p adj` < 0.05, ]
significant_sorted <- significant[order(significant$`p adj`), ]
significant_sorted
plot(TukeyHSD(anova_model), las=2)

# t-test, p-value. на 95% на 6.63 доларів дорожча з Гватемали, Ефіопії
coffee %>%
  mutate(region = ifelse(origin_country %in% c("Guatemala", "Ethiopia"),
                         "Guatemala/Ethiopia", "Other")) %>%
  t.test(price_per_100g ~ region, data = ., alternative = "greater")

# зріз топових лотів. найдорожча кава Панама, Еквадор
coffee %>%
  slice_max(order_by = price_per_100g, n = 10) %>%
  select(coffee_name, origin_country, price_per_100g)

# коробкова діаграма цін по країнам (топ 5)
top_countries <- names(sort(table(coffee$origin_country), decreasing = TRUE))[1:5]
df_top <- coffee[coffee$origin_country %in% top_countries, ]
df_clean <- subset(df_top, origin_country != "" & !is.na(origin_country) & !is.na(price_per_100g))

ggplot(df_clean, aes(x = origin_country, y = price_per_100g)) +
  geom_boxplot(fill = "pink") +
  labs(title = "Price distribution (Top 5 countries)",
       x = "Country",
       y = "Price") +
  theme_minimal()

#correlation analysis
cor(coffee$total_score, coffee$agtron_roast, use = "complete.obs")
cor(coffee$total_score, coffee$agtron_ground, use = "complete.obs")
cor(coffee$total_score, coffee$price_per_100g, use = "complete.obs")
cor(coffee$agtron_roast, coffee$price_per_100g, use = "complete.obs")
cor(coffee$agtron_ground, coffee$price_per_100g, use = "complete.obs")

#try one more time
numeric_coffee <- coffee[sapply(coffee, is.numeric)]
cor_matrix <- round(cor(numeric_coffee), 2)
cor_matrix

heatmap(cor_matrix, 
        symm = TRUE,      
        col = colorRampPalette(c("pink", "white", "lightblue"))(20),
        margins = c(6,6),
        main = "Correlation between all variables")

#best price/score relation
coffee |> 
  mutate(value_index = `total_score` / `price_per_100g`) |>
  arrange(desc(value_index))

#heatmap(country/roast_level)
ggplot(coffee, aes(`origin_country`, `roast_level`)) +
  geom_jitter(alpha = 0.5) +
  geom_violin(fill="lightblue") +
  theme(axis.text.x = element_text(angle=45, hjust=1))


cor.test(coffee$agtron_roast, coffee$total_score, method = "spearman")