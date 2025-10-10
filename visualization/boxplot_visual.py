import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

df = pd.read_csv('coffee-cleaned.csv', sep=';')

data = df['price_per_100g']
countries = df["origin_country_clean"].value_counts().head(5).index
df_top = df[df["origin_country_clean"].isin(countries)]

# create boxplot
#plt.figure(figsize=(8, 6)) creates empty figure
df_top.boxplot(column="price_per_100g", by="origin_country_clean", grid=True)

#boxplot&lable title
plt.title("Price distribution by country (Top 5 countries)")
plt.suptitle("")
plt.ylabel("Coffee Price per 100 g (USD)")
plt.xlabel("Coffee Producing Countries")
plt.grid(True, linestyle="--", alpha=0.6)

plt.tight_layout()

#add source text
plt.figtext(0.95, 0.01, 'Source:https://www.coffeereview.com/highest-rated-coffees/', ha = 'right', fontsize=9, color = 'gray')

plt.show()
