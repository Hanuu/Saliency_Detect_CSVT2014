ifile = strcat('f0013', '.', 'jpg');
uiImg = imread(ifile);
[iSizeH iSizeW] = size(uiImg);
iSizeW = iSizeW/3;

nK       = 8;   % the number of cluster
nAlpha   = 15;  % parameter alpha
    
fprintf('Feature extraction\t\t\t\t'); t0=clock; t1=clock;
uiFeature = FeatureExtraction(uiImg);
elapse = etime(clock,t0); fprintf('%.3fs elapsed\n',elapse);

%%% Compactness extraction
fprintf('Compactness extraction\t\t\t'); t0=clock;
uiComp = Compactness(uiFeature, nK, nAlpha);
elapse = etime(clock,t0); fprintf('%.3fs elapsed\n',elapse);

for i=64:8:256
  
    sfile1 = strcat('f0013', num2str(i), '.png');
    
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
    elapse = etime(clock,t0); fprintf('%d %.3fs elapsed\n',i,elapse);
    
    
    
    elapse = etime(clock,t1);
    %fprintf('%.3fs elapsed totally!!\n',elapse);

    uiOut1 = imresize(uiSal2, [iSizeH iSizeW], 'bicubic');

	imwrite(uiOut1, sfile1);

end