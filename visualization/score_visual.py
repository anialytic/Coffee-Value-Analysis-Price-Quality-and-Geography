import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("coffee-cleaned.csv", sep=';')
scores = df["total_score"]

#plot histogram
plt.figure(figsize=(8,6))
plt.hist(scores, bins=10, color="pink", edgecolor="brown") 

#labels 
plt.xlabel("Coffee Quality Score")
plt.ylabel("Number of coffee")
plt.title("Distribution of Coffee Quality (Histogram)")

#limit range
plt.xticks(range(93,100)) 
plt.xlim(93, 100) 
plt.show()