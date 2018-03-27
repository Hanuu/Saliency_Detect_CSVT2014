function uiSal = SalMeasure1(uiFeature, uiComp, nBeta)

[iSizeH iSizeW] = size(uiFeature);
iPatchH = iSizeH/8;
iPatchW = iSizeW/(8*3);
numPatch = iPatchW*iPatchH;

iPatch = PatchRepresentation(uiFeature);

uiCompRes = imresize(uiComp, [iPatchH iPatchW]);
iCompRes = single(uiCompRes);

mEdge = zeros(numPatch, numPatch);
mP = zeros(numPatch, numPatch);
mOut = zeros(iPatchH, iPatchW);
v_D = sqrt(400^2+300^2);


% edge weight definition
for i=1:iPatchH
for j=1:iPatchW
    node1 = (i-1)*iPatchW+j;
    for node2=node1+1:numPatch
        ci = floor((node2-1)/iPatchW)+1;
        cj = mod(node2-1,iPatchW)+1;
        wComp12 = 1 + (iCompRes(ci,cj)-iCompRes(i,j))/512;
        wComp21 = 1 + (iCompRes(i,j)-iCompRes(ci,cj))/512;
        v_dist = exp(-nBeta*sqrt((i-ci)^2+(j-cj)^2)/(v_D));
        eWeight = v_dist*norm((iPatch{i,j}-iPatch{ci,cj})/255);
        mEdge(node1,node2) = wComp12*eWeight;
        mEdge(node2,node1) = wComp21*eWeight;
    end
    mEdge(node1,node1) = 0;
end
end


mSum = sum(mEdge,2);
for i=1:numPatch
    mP(i,:) = mEdge(i,:)/mSum(i);
end

mEq = mP^500;

for i=1:iPatchH
for j=1:iPatchW
    mOut(i,j) = mEq(iPatchW*(i-1)+j,iPatchW*(i-1)+j);
end
end

maxOut = max(max(mOut));
minOut = min(min(mOut));

uiOut = uint8(255*(mOut-minOut)/(maxOut-minOut));
uiSal = imresize(uiOut, [iSizeH iSizeW/3], 'bicubic');

end