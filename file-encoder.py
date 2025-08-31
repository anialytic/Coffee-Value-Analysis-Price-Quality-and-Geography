import pandas as pd

# шлях до csv-файлу
input_file = "top-rated-coffee-clean.csv"
output_file = "top-rated-coffee-fixed.csv"

# відкрити файл з utf-8, якщо не вийде — з latin1
try:
    df = pd.read_csv(input_file, encoding="utf-8")
    print("Файл відкрито з кодуванням utf-8")
except UnicodeDecodeError:
    df = pd.read_csv(input_file, encoding="latin1")
    print("Файл відкрито з кодуванням latin1")

# перевірка
print(df.head())

# зберігання у правильному кодуванні
#df.to_csv(output_file, encoding="utf-8", index=False)
#print(f"Виправлений файл збережено як '{output_file}'")