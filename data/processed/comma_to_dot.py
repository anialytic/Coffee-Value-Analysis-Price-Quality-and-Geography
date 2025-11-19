import pandas as pd

csv = input('Please enter csv-file name: ')
sep = input('Plase enter separator: ')

df = pd.read_csv(csv, sep=sep, quotechar='"', engine='python')

# перевірка колонок
#print(df.columns)
column = input('Please enter column name: ')

# заміна , на .
df[column] = df[column].astype(str).str.replace(",", ".").astype(float)

# на числ формат
df[column] = pd.to_numeric(df[column], errors='coerce')

# перевірка
#print(df["price_per_100g"].head())

# збереження
df.to_csv('dot.fixed.csv', index=False)
