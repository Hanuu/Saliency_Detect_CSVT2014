import matplotlib.pyplot as plt

def graph_by_256(i,lines):
    fig=plt.figure()
    plt.title("MIT dataset performance graph"+str(i+1))
    x=[]
    y=[]
    switch=0
    for line in lines:
        if switch==0:
            line=line[1:]
            switch=1
        scale,benchmark,similarity=line.split(" ")
        x.append(int(scale))
        y.append(float(similarity))
    ax1=fig.add_subplot(111)
    ax1.set_xlabel("scale")
    ax1.plot(x,y,label=str(i))
    ax1.set_ylabel("similarity")
    # plt.show()
    fig.savefig("scale-similarity-graph/"+"MIT_"+str(i+1)+"_scale-similarity_graph")


with open("similarity_by_256.txt","r") as fr:
    lines=fr.readlines()
    for i in range(297):
        graph_by_256(i,lines[1+25*i:25*i+24])
        print(i)