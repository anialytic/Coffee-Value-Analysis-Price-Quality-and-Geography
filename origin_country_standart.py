import pandas as pd
import numpy as np

df = pd.read_csv("cleaned_top-rated-coffee-pp100g(enc).csv", sep=";", quotechar='"', na_values=["NULL"])

# з колонки coffee_origin імпортувати останнє значення до колонки origin_country
#df['origin_country'] = df['origin_country'].fillna(
#    df['coffee_origin'].apply(lambda x: str(x).split(",")[-1].strip()if pd.notnull(x) else np.nan)
#)

country_map = {
    "Colombia": "Colombia",
    "Ethiopia": "Ethiopia",
    "Taiwan": "Taiwan",
    "Peru": "Peru",
    "Tanzania": "Tanzania",
    "Ecuador": "Ecuador",
    "Rica": "Costa Rica",
    "Brazil": "Brazil",
    "Kenya": "Kenya",
    "Rwanda": "Rwanda",
    "Guatemala": "Guatemala",
    "Panama": "Panama",
    "Mexico": "Mexico",
    "Yemen": "Yemen",
    "Indonesia": "Indonesia",
    "Salvador": "El Salvador",
    "Honduras": "Honduras",
    "Nicaragua": "Nicaragua",
    "Bolivia": "Bolivia",
    "China": "China",
    "India": "India",
    "Papua New Guinea": "Papua New Guinea",
    "HawaiвЂ™i": "United States",
    "Hawai'i": "United States",
    "Hawaii": "United States",
    "Big Island of Hawai'i": "United States",
    "вЂњBig IslandвЂќ of HawaiвЂ™i": "United States",
    "вЂњBig IslandвЂќ of HawaiК»i": "United States",
    '"Big Island" of HawaiвЂ™i': "United States",
    '"Big Island" of Hawaii': "United States",
    "Big Island of HawaiвЂi": "United States",
    "southwestern corner of the \"Big Island\" of Hawaii": "United States",
    "Guatemala and other undisclosed origins": "Guatemala",
    "other undisclosed origins": None,
    "Island": None,
    "Apaneca Ilamatepec mountain range": "El Salvador",
    "Africa": None,
    "southern": None,
    "Not disclosed": None,
    "Congo": "Democratic Republic of the Congo",  # уточнено
    "Republic": None,
    "south-central Ethiopia.": "Ethiopia",
    "Kenya.": "Kenya",
    "Ethiopia.": "Ethiopia",
    "western Panama.": "Panama",
    "south-central Kenya.": "Kenya",
    "Not disclosed.": None,
    "Rwanda.": "Rwanda",
    "Ecuador.": "Ecuador",
    "southern Ethiopia.": "Ethiopia",
    "Brazil.": "Brazil",
    "Indonesia.": "Indonesia",
    "northern Burundi.": "Burundi",
    "El Salvador.": "El Salvador",
    "southwest Ethiopia.": "Ethiopia",
    "Costa Rica.": "Costa Rica",
    "Panama.": "Panama",
    "central Guatemala.": "Guatemala",
    "far western Panama.": "Panama",
    "Colombia.": "Colombia",
    "Sumatra.": "Indonesia",
    "central Kenya.": "Kenya",
    "Central America.": None,
    "Southern and/or western Ethiopia.": "Ethiopia",
    "central Costa Rica.": "Costa Rica",
    "western Kenya.": "Kenya",
    "west-central Colombia.": "Colombia",
    "western Ethiopia.": "Ethiopia",
    "other undisclosed origins.": None,
    "northwestern Guatemala.": "Guatemala",
    "southern Colombia.": "Colombia",
    "southwestern Tanzania.": "Tanzania",
    "undisclosed.": None,
    "Northeastern El Salvador.": "El Salvador",
    "western Colombia.": "Colombia"
}
# застосування словника
df['origin_country_clean'] = df['origin_country'].map(country_map)

# видалення рядків без валідної країни
#df_clean = df[df['origin_country_clean'].notnull()]

# Перегляд результату
#print(df['origin_country_clean'].head(50))

df.to_csv("coffee_cleaned.csv", index=False)