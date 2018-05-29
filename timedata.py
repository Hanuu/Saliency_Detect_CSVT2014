with open('timedata.txt','r',encoding="utf8") as fr:
    lines=fr.readlines()
    print(lines)

    i=1
    j=0
    while i<=297:
        a=0
        with open("timedata_2.txt","a",encoding="utf8") as fw:
            fw.write(str(i)+"\n")
        while a<27:
            with open("timedata_2.txt","a",encoding="utf8") as fw:
                fw.write(lines[j])
                j+=1
            a+=1
        i+=1
        print(i)