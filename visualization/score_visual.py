import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_csv("coffee-cleaned.csv", sep=';')
scores = df["total_score"]

#plot histogram
plt.figure(figsize=(9,6))
n, bins, patches = plt.hist(scores, bins=15, color="#A6705D", edgecolor="#A6705D", alpha=0.8)

#add mean
mean_score = scores.mean()
plt.axvline(mean_score, color='#402927', linestyle='--', linewidth=2, label=f'Mean = {mean_score:.2f}')

#title and labels
plt.title("Distribution of Coffee Quality Scores", fontsize=16, fontweight='bold')
plt.xlabel("Coffee Quality Score", fontsize=13)
plt.ylabel("Number of Samples", fontsize=13)

# limits
plt.xlim(scores.min()-0.5, scores.max()+0.5)
plt.xticks(np.arange(int(scores.min()), int(scores.max())+1, 1))

# grin&legend
plt.grid(True, linestyle='--', alpha=0.6)
plt.legend()

#add source text
plt.figtext(0.95, 0.01, 'Source:https://www.coffeereview.com/highest-rated-coffees/', ha = 'right', fontsize=9, color = 'gray')

plt.show()