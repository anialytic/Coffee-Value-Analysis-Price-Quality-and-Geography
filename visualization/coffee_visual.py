import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

df = pd.read_csv("coffee-cleaned.csv", sep=';')

#count "coffee_name", group by "origin_country_clean", ignore countries with less then 20
counts = df.groupby("origin_country_clean").size()
counts = counts[counts >= 20]

#parameters 
plt.figure(figsize=(10,6), dpi=100)
counts.plot(kind='bar', color='pink')

#plt.plot(x,y, label='2x', color='pink', linewidth=2, marker='.', markersize=10, markeredgecolor='brown', linestyle='--')
#x2 = np.arange(0,4.5,0.5)
#plt.plot(x2, x2**2, 'r--', label='x^2')

#figure&vector title
plt.title('Amount coffee per country', fontdict={'fontsize': 20})
plt.xlabel('Countries')
plt.ylabel('Coffee count')
plt.xticks(rotation=45)
plt.tight_layout
plt.show()

#plt.legend()
#plt.savefig('mygraph.png', dpi=150)