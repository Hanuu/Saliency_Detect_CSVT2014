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

def average_graph(i,lines,y):
    temp_y=[]
    # temp_y=[]
    for line in lines:
        scale,second,elasped=line.split(" ")
        # temp_y.append(int(scale))
        temp_y.append(float(second[:-1]))
    for iter_x in range(len(y)):
        y[iter_x]+=temp_y[iter_x]
        # y[iter_x]+=temp_y[iter_x]
    return y

with open("timedata_2.txt","r",encoding="utf8") as fr:
    lines=fr.readlines()
    # graph_by_i(1,lines[3:28])
    y=[0 for i in range(25)]
    # y=[0 for i in range(25)]
    for iterate in range(1,298):
        # graph_by_i(iterate,lines[3+28*iterate-28:28*iterate])
        average_graph(iterate,lines[3+28*iterate-28:28*iterate],y)

    for y_index in range(len(y)):
        y[y_index]/=297
    fig=plt.figure()
    plt.title("Average Time-scale of MIT300 dataset")
    ax1=fig.add_subplot(111)
    ax1.set_xlabel("scale")
    ax1.plot([i for i in range(64,264,8)],y)
    ax1.set_ylabel("average time")

    fig.savefig("time-scale-graph/average-time-scale-graph")