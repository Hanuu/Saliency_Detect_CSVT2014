
fileID = fopen('similarity_by_256.txt','w');
for i=1:297
    fprintf('%d\n',i);
    fprintf(fileID,'%d\n ',i);
    image2 = imread(strcat('BenchmarkIMAGES\BenchmarkIMAGES\',num2str(i),'-',num2str(256),'.png'));
    for j=64:8:248
        image1=imread(strcat('BenchmarkIMAGES\BenchmarkIMAGES\',num2str(i),'-',num2str(j),'.png'));

        score=similarity(image1,image2,1);
        fprintf(fileID,'%d %d %f\n',j,256,score);
        fprintf('%d %d %f\n',j,256,score);
    end
end

fclose(fileID);
