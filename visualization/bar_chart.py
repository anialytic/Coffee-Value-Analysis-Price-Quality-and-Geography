import pandas as pd
import numpy as np
import matplotlib.pyplot as matplotlib

df = pd.read_csv('C:\\Users\\HP\\Desktop\\Coffee\\data\\cleaned\\coffee_filled.csv', sep = ';')

plt.bar(df['origin_country'], df['coffee-name'])
plt.xlabel('Origin country')
plt.ylabel('Units')
plt.title('Top Coffee Producers')
plt.legend()
plt.show()