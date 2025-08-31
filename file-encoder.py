import pandas as pd

# шлях до файлу
input_file = "top-rated-coffee-clean.csv"
output_file = "top-rated-coffee-clean_fixed.csv"

# відкрити файл з utf-8, якщо не вийде — latin1
try:
    df = pd.read_csv(input_file, encoding="utf-8", sep=';', on_bad_lines='skip')
    print("Файл відкрито з кодуванням utf-8")
except UnicodeDecodeError:
    df = pd.read_csv(input_file, encoding="latin1", sep=';', on_bad_lines='skip')
    print("Файл відкрито з кодуванням latin1")

# перевірка
print(df.head())

# збереження
#df.to_csv(output_file, encoding="utf-8", sep=';', index=False)
#print(f"Виправлений файл збережено як '{output_file}'")
