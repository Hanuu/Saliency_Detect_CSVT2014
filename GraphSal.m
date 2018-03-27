function GraphSal(fname, fext)
ifile = strcat(fname, '.', fext);
sfile1 = strcat(fname, 's1', '.png');
sfile2 = strcat(fname, 's2', '.png');
sfile3 = strcat(fname, 's3', '.png');

uiImg = imread(ifile);
[iSizeH iSizeW] = size(uiImg);
iSizeW = iSizeW/3;

scale1 = 64;
scale2 = 128;
scale3 = 256;

nK       = 8;   % the number of cluster
nAlpha   = 15;  % parameter alpha
nBeta    = 300; % parameter beta
nEpsilon = 0.5; % parameter epsilon 

%%% Feature extraction
fprintf('Feature extraction\t\t\t\t'); t0=clock; t1=clock;
uiFeature = FeatureExtraction(uiImg);
elapse = etime(clock,t0); fprintf('%.3fs elapsed\n',elapse);

%%% Compactness extraction
fprintf('Compactness extraction\t\t\t'); t0=clock;
uiComp = Compactness(uiFeature, nK, nAlpha);
elapse = etime(clock,t0); fprintf('%.3fs elapsed\n',elapse);

uiF1 = imresize(uiFeature, [scale1,scale1], 'nearest');
uiF2 = imresize(uiFeature, [scale2,scale2], 'nearest');
uiF3 = imresize(uiFeature, [scale3,scale3], 'nearest');

%%% Saliency calcuation at the coarse scale
fprintf('Saliency calculation (coarse)\t'); t0=clock;
uiSal1 = SalMeasure1(uiF1, uiComp, nBeta);
elapse = etime(clock,t0); fprintf('%.3fs elapsed\n',elapse);

%%% Saliency calcuation at the medium scale
fprintf('Saliency calculation (medium)\t'); t0=clock;
uiSal2 = SalMeasure2(uiF2, uiComp, uiSal1, nBeta, nEpsilon);
elapse = etime(clock,t0); fprintf('%.3fs elapsed\n',elapse);

%%% Saliency calcuation at the fine scale
fprintf('Saliency calculation (fine)\t\t'); t0=clock;
uiSal3 = SalMeasure2(uiF3, uiComp, uiSal2, nBeta, nEpsilon);
elapse = etime(clock,t0); fprintf('%.3fs elapsed\n',elapse);

elapse = etime(clock,t1);
fprintf('%.3fs elapsed totally!!\n',elapse);

uiOut1 = imresize(uiSal1, [iSizeH iSizeW], 'bicubic');
uiOut2 = imresize(uiSal2, [iSizeH iSizeW], 'bicubic');
uiOut3 = imresize(uiSal3, [iSizeH iSizeW], 'bicubic');

imwrite(uiOut1, sfile1);
imwrite(uiOut2, sfile2);
imwrite(uiOut3, sfile3);

end