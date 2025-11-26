import pandas as pd
import numpy as np

df = pd.read_csv('C:\\Users\\HP\\Desktop\\Coffee\\data\\cleaned\\coffee_filled.csv', sep=';')
num_cols = ["price_per_100g", "total_score", "agtron_ground", "agtron_roast"]

#Z-score
df_z = df[num_cols].apply(lambda x: (x - x.mean()) / x.std())

#позначити аномалії
df["is_anomaly"] = (df_z.abs() > 3).any(axis=1)

anomalies = df[df["is_anomaly"]]
print(anomalies)