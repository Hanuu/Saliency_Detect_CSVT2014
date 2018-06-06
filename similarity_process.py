with open("similarity_processed.txt","w") as fw:
    with open("similarity_data.txt","r") as fr:
        lines=fr.readlines()
        for i in range(298):
            delta=0
            for scale in range(25):
                a=lines[i*26+scale+1].split(" ")
                delta+=float(a[2])
            fw.write(str(i+1)+" " +str(delta/25)+" ")
            a=lines[i*26+25].split(" ")
            fw.write(a[2])