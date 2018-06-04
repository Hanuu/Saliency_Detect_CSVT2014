from PIL import Image

path="BenchmarkIMAGES\BenchmarkIMAGES\i"

with open("timedata_2.txt","r") as fr:
    lines=fr.readlines()

    for i in range(1,298):
        im = Image.open(path+str(i)+'.jpg')
        width, height = im.size
        print(i,lines[2+28*i-28][25:32],max(width,height),min(width,height))