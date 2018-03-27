function uiFeature = FeatureExtraction(uiImg)

[iSizeH iSizeW] = size(uiImg);
iSizeW = iSizeW/3;

iR = single(uiImg(:,:,1));
iG = single(uiImg(:,:,2));
iB = single(uiImg(:,:,3));

% nR, nG, nB are normalized colors
nR = zeros(iSizeH, iSizeW, 'single');
nG = zeros(iSizeH, iSizeW, 'single');
nB = zeros(iSizeH, iSizeW, 'single');

iIT = (iR+iG+iB)/3;
maxIT = max(max(iIT));

for i=1:iSizeH
for j=1:iSizeW
    if iIT(i,j) > maxIT*0.1
        nR(i,j) = iR(i,j)/iIT(i,j);
        nG(i,j) = iG(i,j)/iIT(i,j);
        nB(i,j) = iB(i,j)/iIT(i,j);
    else
        nR(i,j) = 0;
        nG(i,j) = 0;
        nB(i,j) = 0;
    end
end
end

% ibtR, ibtG, ibtB, ibtY are broadly-tuned colors
ibtR = max(0, nR - (nG+nB)/2);
ibtG = max(0, nG - (nB+nR)/2);
ibtB = max(0, nB - (nR+nG)/2);
ibtY = max(0, (nR+nG)/2 - abs(nR-nG)/2 - nB);

iRG = ibtR - ibtG;
iBY = ibtB - ibtY;

maxRG = max(max(iRG));
maxBY = max(max(iBY));
minRG = min(min(iRG));
minBY = min(min(iBY));

iRG = 255*(iRG-minRG)/(maxRG-minRG);
iBY = 255*(iBY-minBY)/(maxBY-minBY);

uiFeature(:,:,1) = uint8(iRG);
uiFeature(:,:,2) = uint8(iBY);
uiFeature(:,:,3) = uint8(iIT);

end