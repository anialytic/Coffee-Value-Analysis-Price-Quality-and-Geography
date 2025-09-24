import pandas as pd
df = pd.read_csv('coffee-cleaned.csv', sep=';', quotechar='"', engine='python')

# перевірка колонок
#print(df.columns)

# заміна , на .
df['price_per_100g'] = df['price_per_100g'].astype(str).str.replace(",", ".").astype(float)

# на числ формат
df['price_per_100g'] = pd.to_numeric(df['price_per_100g'], errors='coerce')

# перевірка
#print(df["price_per_100g"].head())

# збереження
df.to_csv('coffee_fixed.csv', index=False)
