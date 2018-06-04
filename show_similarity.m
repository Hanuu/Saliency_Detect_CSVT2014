% image256 = imread('f0013256.png');
% image248 = imread('f0013248.png');
% image64 = imread('f001364.png');
% 
% score=similarity(image256,image64,1);
% fprintf('%f\n',score);
% 
% score=similarity(image256,image248,1);
% fprintf('%f\n',score);

for j=64:8:248
    image1=imread(strcat('f0013',num2str(j),'.png'));
    image2=imread(strcat('f0013',num2str(j+8),'.png'));
    
    score=similarity(image1,image2,1);
    fprintf('%f %f %f\n',j,j+8,score);

end
