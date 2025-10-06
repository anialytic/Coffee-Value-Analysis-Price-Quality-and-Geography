import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('coffee-cleaned.csv', sep=';')

top_countries = df["origin_country_clean"].value_counts().head(5).index
df_top = df[df["origin_country_clean"].isin(top_countries)]

# create boxplot
#plt.figure(figsize=(8, 6)) creates empty figure
df_top.boxplot(column="price_per_100g", by="origin_country_clean")

#boxplot&lable title
plt.title("Price distribution by country (Top 5 countries)")
plt.suptitle("")
plt.ylabel("Price")
plt.xlabel("Country")
plt.show()
