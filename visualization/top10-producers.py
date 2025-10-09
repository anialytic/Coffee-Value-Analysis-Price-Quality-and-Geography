import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

df = pd.read_csv("coffee-cleaned.csv", sep=';')

#count coffee brands per country, group by countries, ignore countries with less then 20
df_counts = df.groupby('origin_country_clean')['coffee_name'].nunique().reset_index()
df_counts = df_counts.sort_values('coffee_name', ascending=False).head(10)

#color palette
color = plt.cm.copper_r(df_counts['coffee_name'] / df_counts['coffee_name'].max())

#figure parameters 
plt.figure(figsize=(10,6), dpi=125)

#plot
plt.bar(df_counts['origin_country_clean'], df_counts['coffee_name'], color=color, width=0.6)

#figure&labels titles
plt.title('Top-10 Coffee-Producing Countries by Number of Brands', fontdict={'fontsize': 20})
plt.xlabel('Countries')
plt.ylabel('Number of Coffee Brands')
plt.xticks(rotation=45)


plt.tight_layout()

#add source text
plt.figtext(0.95, 0.01, 'Source:https://www.coffeereview.com/highest-rated-coffees/', ha = 'right', fontsize=9, color = 'gray')

plt.show()

#plt.legend()
#plt.savefig('mygraph.png', dpi=150)