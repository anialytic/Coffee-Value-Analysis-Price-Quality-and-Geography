import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

x = [0,1,2,3,4]
y = [0,2,4,6,8]

plt.figure(figsize=(5,3), dpi=300)
plt.plot(x,y, label='2x', color='pink', linewidth=2, marker='.', markersize=10, markeredgecolor='brown', linestyle='--')

x2 = np.arange(0,4.5,0.5)
plt.plot(x2, x2**2, 'r--', label='x^2')

plt.title('title', fontdict={'fontsize': 20})
plt.xlabel('x-label')
plt.ylabel('y-label')

plt.xticks([0,1,2,3,4])
plt.yticks([0,2,4,6,8,10])

plt.legend()

plt.show()

plt.savefig('mygraph.png', dpi=300)