import numpy as np
import matplotlib.pyplot as plt
from PIL import Image

path="BenchmarkIMAGES\BenchmarkIMAGES\i"
x=[]
y=[]

with open("timedata_2.txt","r") as fr:
    lines=fr.readlines()

    for i in range(1,298):
        im = Image.open(path+str(i)+'.jpg')
        width, height = im.size
        x.append(float(lines[2+28*i-28][25:31]))
        y.append(min(height,width))
        print(i,lines[2+28*i-28][25:32],max(width,height),min(width,height))


fit=np.polyfit(x,y,1)

fit_fn=np.poly1d(fit)
fig=plt.figure()
plt.plot(x,y,"yo",x,fit_fn(x),"--k")
plt.show()

fig.savefig("Resolution-Compactness Time linear fitting graph")