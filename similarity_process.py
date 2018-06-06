import matplotlib.pyplot as plt

with open("similarity_processed.txt","w") as fw:
    with open("similarity_data.txt","r") as fr:
        lines=fr.readlines()
        for i in range(297):
            delta=0
            for scale in range(25):
                a=lines[i*26+scale+1].split(" ")
                delta+=float(a[2])
            fw.write(str(i+1)+" " +str(delta/25)+" ")
            a=lines[i*26+25].split(" ")
            fw.write(a[2])

with open("similarity_processed.txt","r") as fr:
    lines=fr.readlines()
    i=[]
    delta_average=[]
    total_diff=[]
    for line_index in range(len(lines)):
        a,b,c=lines[line_index].split(" ")
        i.append(int(a))
        delta_average.append(float(b))
        total_diff.append(float(c))
    fig=plt.figure()
    plt.title("Average delta time vs total difference time")


    ax1=fig.add_subplot(111)
    ax1.bar(i,delta_average)

    ax2=fig.add_subplot(111)
    ax2.bar(i,total_diff)
    # plt.legend(mode="expand")
    fig.set_size_inches(18.5, 10.5)
    plt.show()