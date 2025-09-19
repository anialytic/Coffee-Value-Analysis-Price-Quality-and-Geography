import pandas as pd

df = pd.read_csv("coffee-cleaned.csv", sep=';', na_values=["NULL"])

print(df.isna().sum())
print(df.dtypes)
print("Duplicates:", df.duplicated().sum())

