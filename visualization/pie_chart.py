import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('C:\\Users\\HP\\Desktop\\Coffee\\data\\cleaned\\coffee_filled.csv', sep=';')

top5 = df['origin_country'].value_counts().head(5)

plt.figure(figsize=(8, 8))
plt.pie(
    top5.values,
    labels=top5.index,        
    autopct='%1.1f%%',          
    startangle=90                
)
plt.title('Top 5 Coffee Producers')
plt.legend(top5.index, title='Countries', loc='best')
plt.tight_layout()

plt.figtext(0.95, 0.01, 'Source:https://www.coffeereview.com/highest-rated-coffees/', ha = 'right', fontsize=9, color = 'gray')


plt.show()
