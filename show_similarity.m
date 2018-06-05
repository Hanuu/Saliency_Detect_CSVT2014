% image256 = imread('f0013256.png');
% image248 = imread('f0013248.png');
% image64 = imread('f001364.png');
% 
% score=similarity(image256,image64,1);
% fprintf('%f\n',score);
% 
% score=similarity(image256,image248,1);
% fprintf('%f\n',score);

fileID = fopen('similarity_data.txt','w');
for i=1:92
    fprintf('%d\n',i);
    for j=64:8:248
        image1=imread(strcat('BenchmarkIMAGES\BenchmarkIMAGES\',num2str(i),'-',num2str(j),'.png'));
        image2=imread(strcat('BenchmarkIMAGES\BenchmarkIMAGES\',num2str(i),'-',num2str(j+8),'.png'));

        score=similarity(image1,image2,1);
        fprintf('%f %f %f\n',j,j+8,score);

    end
    image1=imread(strcat('BenchmarkIMAGES\BenchmarkIMAGES\',num2str(i),'-',num2str(64),'.png'));
    image2=imread(strcat('BenchmarkIMAGES\BenchmarkIMAGES\',num2str(i),'-',num2str(256),'.png'));

    score=similarity(image1,image2,1);
    fprintf('%f %f %f\n',64,256,score);
end


fclose(fileID);
