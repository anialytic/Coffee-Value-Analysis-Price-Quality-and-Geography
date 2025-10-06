import numpy as np
import pandas as pd
df = pd.read_csv('coffee-cleaned.csv', sep=';')

# check column names
#print(df.columns.tolist())
# look through "price_per_100g" column ignoring Nan
#print(df["price_per_100g"].dropna())

# check the cheapest coffee
min_val = np.min(df["price_per_100g"].dropna())
print(min_val)

max_val = np.max(df["price_per_100g"].dropna())
print(max_val)