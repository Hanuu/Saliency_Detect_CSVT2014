import numpy as np
import matplotlib.pyplot as plt
import plotly.plotly as py
from PIL import Image
from scipy.optimize import curve_fit
from matplotlib import pylab


# path="BenchmarkIMAGES\BenchmarkIMAGES\i"
def exponenial_func(x, a, b, c):
    return a*np.exp(-b*x)+c

with open("timedata_2.txt","r") as fr:
    lines=fr.readlines()
    x = [j for j in range(64, 264, 8)]
    y = [0 for j in range(64,264,8)]

    for i in range(1,298):
        for time in range(1,26):
            y[time-1]=(float(lines[2+28*i-28+time].split(" ")[1][:-1]))
    for y_index in range(len(y)):
        y[y_index]/=297
    popt, pcov = curve_fit(exponenial_func, x, y, p0=(1, 1e-6, 1))
    xx = np.linspace(64, 256, 8)
    yy = exponenial_func(xx, *popt)
    # if popt[2]<0:
    #     equation=str(popt[0])[:6]+"*"+"exp("+str(-popt[1])[:6]+"*x)"+str(popt[2])[:6]
    # else:
    #     equation = str(popt[0])[:6] + "*" + "exp(" + str(-popt[1])[:6] + "*x)+" + str(popt[2])[:6]
    # print(popt)
    # print(equation)

    plt.plot(x, y, 'o', xx, yy)
    # pylab.title(str(i)+" "+equation)
    ax = plt.gca()
    fig = plt.gcf()
    plt.show()
    # fig.savefig("scale-fitting-graph\exponential_fitting"+str(i))
    # with open("scale-fitting-data.txt","a") as fw:
    #     fw.write(equation+'\n')
    #     print(popt,equation)