import matplotlib.pyplot as plt

def graph_by_i(i,lines):
    fig=plt.figure()
    plt.title("MIT dataset time-scale graph"+str(i))
    x=[]
    y=[]
    for line in lines:
        scale,second,elasped=line.split(" ")
        x.append(int(scale))
        y.append(float(second[:-1]))
    ax1=fig.add_subplot(111)
    ax1.set_xlabel("scale")
    ax1.plot(x,y,label=str(i))
    ax1.set_ylabel("time(second)")

    # plt.show()
    fig.savefig("time-scale-graph/"+"MIT_"+str(i)+"_time-scale_graph")


with open("timedata_2.txt","r",encoding="utf8") as fr:
    lines=fr.readlines()
    # graph_by_i(1,lines[3:28])
    for iterate in range(1,298):
        graph_by_i(iterate,lines[3+28*iterate-28:28*iterate])
