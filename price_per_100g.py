# відкрити файл
import pandas as pd
import re as re
df = pd.read_csv("top-rated-coffee-fixed.csv", sep=";", on_bad_lines="skip")

column_to_show = ["est._price"]

# витягнути ціну (перше число у рядку)
def extract_price(text: str) -> float:
    numbers = re.findall(r"\d+\.?\d*", str(text))
    if numbers:
        return float(numbers[0])
    return None

# витягнути вагу (останнє число у рядку)
def extract_quantity(text: str) -> float:
    numbers = re.findall(r"\d+\.?\d*", str(text))
    if numbers:
        return float(numbers[-1])
    return None

# конвертація у грами
def unit_to_grams(qty: float, text: str) -> float:
    text = str(text).lower()
    if "gram" in text or " g" in text or "ml flask" in text or "ml bottle" in text:
        return qty
    elif "ounce" in text or "oz" in text:
        return round(qty * 28.3495, 2)
    elif "kg" in text:
        return round(qty * 1000, 2)
    else:
        return None

# рахує ціну за 100 г
def price_per_100g(text: str) -> float:
    price = extract_price(text)
    qty = extract_quantity(text)
    grams = unit_to_grams(qty, text)
    if price is None or grams is None or grams == 0:
        return None
    return round((price / grams) * 100, 2)

# нові колонки у dataframe
df["price_per_100g"] = df["est._price"].apply(price_per_100g)

print(df.head())

# зберегти новий файл з колонкою
cols = list(df.columns)
cols.remove("price_per_100g")
cols.insert(8, "price_per_100g")
df = df[cols]
df.to_csv("top-rated-coffee-pp100g.csv", index=False)