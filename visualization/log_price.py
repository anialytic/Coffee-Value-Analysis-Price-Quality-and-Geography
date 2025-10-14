import pandas as pd
import numpy as np

df = pd.read_csv('coffee-cleaned.csv', sep=';')

df['log_price'] = np.log1p(df['price_per_100g'])
print((df['price_per_100g'].describe()).dropna())
print((df['log_price'].describe()).dropna())

import matplotlib.pyplot as plt

plt.figure()
df['price_per_100g'].hist(bins=100)
plt.title("До логарифмування")
plt.xlabel("price_per_100g")

plt.figure()
df['log_price'].hist(bins=100)
plt.title("Після логарифмування (log1p)")
plt.xlabel("log(price_per_100g)")
plt.show()