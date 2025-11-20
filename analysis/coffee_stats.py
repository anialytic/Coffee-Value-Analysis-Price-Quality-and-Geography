import numpy as np
import pandas as pd
import statistics as statistics

csv = input('Please enter csv-file name:')
sep = input('Please enter separator:')
df = pd.read_csv(csv, sep=sep)

# check column names
#print(df.columns.tolist())
# look through "price_per_100g" column ignoring Nan
#print(df["price_per_100g"].dropna())

column=input('Please enter the column name: ')

# check the cheapest coffee
min_val = np.min(df[column].dropna())
print('min:', min_val)

max_val = np.max(df[column].dropna())
print('max:', max_val)

mean = np.mean(df[column].dropna())
print('mean:', mean)

median = np.median(df[column].dropna())
print('median:', median)

mode = statistics.mode(df[column].dropna())
print('mode:', mode)

range = max_val - min_val
print('range:', range)

five_num = [
    float(df[column].quantile(0)), 
    float(df[column].quantile(0.25)), 
    float(df[column].quantile(0.5)), 
    float(df[column].quantile(0.75)), 
    float(df[column].quantile(1))]
print(five_num)

describe = df[column].describe()
print(describe)

IQR = float(df[column].quantile(0.75)) - float(df[column].quantile(0.25))
print('IQR:', IQR)

variance = np.var(df[column].dropna())
print('variance:', variance)

deviation = np.std(df[column].dropna())
print('standart deviation:', deviation)

abs_median_devs = abs(df[column].median() - df[column])
abs_median_devs = abs_median_devs.median()
print('abs_median_devs:', abs_median_devs)

skewness = df[column].skew()
print('skewness:', skewness)

kurtosis = df[column].kurt()
print('kurtosis:', kurtosis)