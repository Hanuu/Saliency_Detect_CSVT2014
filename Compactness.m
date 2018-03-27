function uiComp = Compactness(uiFeature, nRegion, nAlpha)

uiFeatureQuant = uiFeature;

[iSizeH iSizeW] = size(uiFeature);
iSizeW = iSizeW/3;

cImg(1:3,1:iSizeH,1:iSizeW) = 0;    % each compactness map
oImg(1:iSizeH,1:iSizeW) = 0;        % result image (compactness map)
nMinObj = iSizeW*iSizeH*0.03;       % min. object size
nLevel = 256;                       % the number of bin

mHistogram(1:3,1:nLevel) = 0;       % K-Means array
mCoordI = cell(3,nLevel);           % i-coordinate array
mCoordJ = cell(3,nLevel);           % j-coordinate array
mCompactness(1:3,1:nRegion) = 0;    % compactness

% histogram & corresponding coordinates array generation
for i=1:iSizeH
for j=1:iSizeW
    for ch=1:3
        val = single(uiFeature(i,j,ch)) + 1;
        mHistogram(ch,val) = mHistogram(ch,val) + 1;
        mCoordI{ch,val}(mHistogram(ch,val)) = i;
        mCoordJ{ch,val}(mHistogram(ch,val)) = j;
    end
end
end

% centroids array generation
mCentI(1:3,1:nLevel) = 0;
mCentJ(1:3,1:nLevel) = 0;
for lv=1:nLevel
for ch=1:3
    if mHistogram(ch,lv) ~= 0
        mCentI(ch,lv) = mean(mCoordI{ch,lv});
        mCentJ(ch,lv) = mean(mCoordJ{ch,lv});
    else
        mCentI(ch,lv) = iSizeH/2;
        mCentJ(ch,lv) = iSizeW/2;
    end
end
end

% initial cluster setting
CLUSTER(1:3,1:nLevel) = 0;
for ch=1:3
for lv=1:nLevel       
    CLUSTER(ch,lv) = floor((lv-1)*nRegion/nLevel)+1;
    
end
end
KMEANS(1:3,1:nRegion,1:3) = 0;  % KMEANS(ch,#_of_clusters,indices)
                                % idx1: x-coord
                                % idx2: y-coord
                                % idx3: level                   
for ch=1:3
    CntReg(1:nRegion) = 0.001;
    SumReg(1:nRegion,1:3) = 0;
    for lv=1:nLevel
        IdxReg = CLUSTER(ch,lv);
        if mHistogram(ch,lv) ~= 0
            CntReg(IdxReg) = CntReg(IdxReg) + 1;
            SumReg(IdxReg,1) = SumReg(IdxReg,1) + mCentI(ch,lv);
            SumReg(IdxReg,2) = SumReg(IdxReg,2) + mCentJ(ch,lv);
            SumReg(IdxReg,3) = SumReg(IdxReg,3) + lv*max(iSizeW,iSizeH)/256;
        end
    end
    for r=1:nRegion
        KMEANS(ch,r,1) = SumReg(r,1)/CntReg(r);
        KMEANS(ch,r,2) = SumReg(r,2)/CntReg(r);
        KMEANS(ch,r,3) = SumReg(r,3)/CntReg(r);
    end
end


% K-means clustering
for ch=1:3
for iter=1:100
    KMEANS0(ch,:,:) = KMEANS(ch,:,:);
    for lv=1:nLevel        
        SumErr = 10000000;
        for r=1:nRegion
            if mHistogram(ch,lv) ~=0
                Err = abs( KMEANS(ch,r,1) - mCentI(ch,lv) ) + ...
                      abs( KMEANS(ch,r,2) - mCentJ(ch,lv) ) + ...
                      abs( KMEANS(ch,r,3) - lv*max(iSizeW,iSizeH)/256);
                
                if Err < SumErr
                    CLUSTER(ch,lv) = r;
                    SumErr = Err;
                end
            end
        end
    end
        
    CntReg(1:nRegion) = 0.001;
    SumReg(1:nRegion,1:3) = 0;
    for lv=1:nLevel
        IdxReg = CLUSTER(ch,lv);
        if mHistogram(ch,lv) ~=0
            CntReg(IdxReg) = CntReg(IdxReg) + 1;
            SumReg(IdxReg,1) = SumReg(IdxReg,1) + mCentI(ch,lv);
            SumReg(IdxReg,2) = SumReg(IdxReg,2) + mCentJ(ch,lv);
            SumReg(IdxReg,3) = SumReg(IdxReg,3) + lv*max(iSizeW,iSizeH)/256;
        end
    end
    for r=1:nRegion
        KMEANS(ch,r,1) = SumReg(r,1)/CntReg(r);
        KMEANS(ch,r,2) = SumReg(r,2)/CntReg(r);
        KMEANS(ch,r,3) = SumReg(r,3)/CntReg(r);
    end
    
    if sum(abs(KMEANS0(ch,:,:)-KMEANS(ch,:,:))) == 0
        break;
    end    
end
end


mQHistogram(1:3,1:nRegion) = 0;
mQCoordI = cell(3,nRegion);
mQCoordJ = cell(3,nRegion);
mQPixVal(1:3,1:nRegion) = 0;
mQPixCnt(1:3,1:nRegion) = 0.001;
for i=1:iSizeH
for j=1:iSizeW
    for ch=1:3
        val = single(uiFeature(i,j,ch))+1;
        for r=1:nRegion            
            if CLUSTER(ch,val) == r
                mQHistogram(ch,r) = mQHistogram(ch,r) + 1;
                mQCoordI{ch,r}(mQHistogram(ch,r)) = i;
                mQCoordJ{ch,r}(mQHistogram(ch,r)) = j;
                mQPixVal(ch,r) = mQPixVal(ch,r) + val;
                mQPixCnt(ch,r) = mQPixCnt(ch,r) + 1;
            end            
        end        
    end            
end
end

for r=1:nRegion
for ch=1:3
    if mQHistogram(ch,r) >= nMinObj
        istd = std(mQCoordI{ch,r},1);
        jstd = std(mQCoordJ{ch,r},1);
        mCompactness(ch,r) = exp(-nAlpha*(istd+jstd)/sqrt(iSizeW^2+iSizeH^2));
    else
        mCompactness(ch,r) = 0;
    end
    
    mQPixVal(ch,r) = mQPixVal(ch,r)/mQPixCnt(ch,r);
end
end


for i=1:iSizeH
for j=1:iSizeW 
    for ch=1:3
        val = single(uiFeature(i,j,ch))+1;
        for r=1:nRegion            
            if CLUSTER(ch,val) == r
                oImg(i,j) = oImg(i,j) + mCompactness(ch,r);
                cImg(ch,i,j) = cImg(ch,i,j) + mCompactness(ch,r);
                uiFeatureQuant(i,j,ch) = mQPixVal(ch,r);
            end
        end
    end
end
end


omax = max(max(oImg));          
omin = min(min(oImg));
uiComp = 255*(oImg-omin)/(omax-omin);

end