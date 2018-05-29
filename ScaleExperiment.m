fileID = fopen('timedata.txt','w');

for j=1:297
    disp(j)
    path='C:\Users\MINJUN KWAK\Documents\github\Saliency_Detect_CSVT2014\BenchmarkIMAGES\BenchmarkIMAGES\';
    ifile = strcat(path,'i', num2str(j), '.jpg');
    uiImg = imread(ifile);
    [iSizeH iSizeW] = size(uiImg);
    iSizeW = iSizeW/3;

    nK       = 8;   % the number of cluster
    nAlpha   = 15;  % parameter alpha

    fprintf(fileID,'Feature extraction\t\t\t\t'); t0=clock; t1=clock;
    uiFeature = FeatureExtraction(uiImg);
    elapse = etime(clock,t0); fprintf(fileID,'%.3fs elapsed\n',elapse);

    %%% Compactness extraction
    fprintf(fileID,'Compactness extraction\t\t\t'); t0=clock;
    uiComp = Compactness(uiFeature, nK, nAlpha);
    elapse = etime(clock,t0); fprintf(fileID,'%.3fs elapsed\n',elapse);

    for i=64:8:256

       

        scale1 = 64;
        scale2 = i;


        nBeta    = 300; % parameter beta
        nEpsilon = 0.5; % parameter epsilon 

        %disp(i);

        uiF1 = imresize(uiFeature, [scale1,scale1], 'nearest');
        uiF2= imresize(uiFeature, [scale2,scale2], 'nearest');

        %%% Saliency calcuation at the coarse scale
        %fprintf('Saliency calculation (coarse)\t'); t0=clock;
        uiSal1 = SalMeasure1(uiF1, uiComp, nBeta);
        %elapse = etime(clock,t0); fprintf('%.3fs elapsed\n',elapse);

        %%% Saliency calcuation at the medium scale
        %fprintf('Saliency calculation \t'); t0=clock;
        t0=clock;
        uiSal2 = SalMeasure2(uiF2, uiComp, uiSal1, nBeta, nEpsilon);
        elapse = etime(clock,t0); fprintf(fileID,'%d %.3fs elapsed\n',i,elapse);

        elapse = etime(clock,t1);
        %fprintf('%.3fs elapsed totally!!\n',elapse);

        uiOut1 = imresize(uiSal2, [iSizeH iSizeW], 'bicubic');
        
        
        path='C:\Users\MINJUN KWAK\Documents\github\Saliency_Detect_CSVT2014\BenchmarkIMAGES\BenchmarkIMAGES\';
        sfile1 = strcat(path,num2str(j),'-', num2str(i), '.png');
        
        imwrite(uiOut1, sfile1);

    end
end

fclose(fileID);
