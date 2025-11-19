import pandas as pd

csv = input('Enter the file.csv name: ')
sep = input('Please enter separator: ') 

df = pd.read_csv(csv, sep=sep, na_values=["NULL

#print missing values
print(df.isna().sum())

#print data types
print(df.dtypes)

#count duplicates
print("Duplicates:", df.duplicated().sum())

