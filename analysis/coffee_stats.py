import numpy as np
import pandas as pd
import statistics as statistics
df = pd.read_csv('coffee-cleaned.csv', sep=';')

# check column names
#print(df.columns.tolist())
# look through "price_per_100g" column ignoring Nan
#print(df["price_per_100g"].dropna())

# check the cheapest coffee
min_val = np.min(df["price_per_100g"].dropna())
print('min:', min_val)

max_val = np.max(df["price_per_100g"].dropna())
print('max:', max_val)

mean = np.mean(df['price_per_100g'].dropna())
print('mean:', mean)

median = np.median(df['price_per_100g'].dropna())
print('median:', median)

mode = statistics.mode(df['price_per_100g'].dropna())
print('mode:', mode)

range = max_val - min_val
print('range:', range)

five_num = [
    float(df['price_per_100g'].quantile(0)), 
    float(df['price_per_100g'].quantile(0.25)), 
    float(df['price_per_100g'].quantile(0.5)), 
    float(df['price_per_100g'].quantile(0.75)), 
    float(df['price_per_100g'].quantile(1))]
print(five_num)

describe = df['price_per_100g'].describe()
print(describe)

IQR = float(df['price_per_100g'].quantile(0.75)) - float(df['price_per_100g'].quantile(0.25))
print('IQR:', IQR)

variance = np.var(df['price_per_100g'].dropna())
print('variance:', variance)

deviation = np.std(df['price_per_100g'].dropna())
print('standart deviation:', deviation)

abs_median_devs = abs(df['price_per_100g'].median() - df['price_per_100g'])
abs_median_devs = abs_median_devs.median()
print('abs_median_devs:', abs_median_devs)

skewness = df['price_per_100g'].skew()
print('skewness:', skewness)

kurtosis = df['price_per_100g'].kurt()
print('kurtosis:', kurtosis)