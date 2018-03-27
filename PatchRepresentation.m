function iPatch = PatchRepresentation(uiFeature)

[iSizeH iSizeW] = size(uiFeature);
iPatchH = iSizeH/8;
iPatchW = iSizeW/(8*3);

iPatch = cell(iPatchH, iPatchW);

iRG = single(uiFeature(:,:,1));
iBY = single(uiFeature(:,:,2));
iIT = single(uiFeature(:,:,3));

for i=1:iPatchH
for j=1:iPatchW
    dPatch(1:8,1:8)   = iRG((i-1)*8+1:(i-1)*8+8, (j-1)*8+1:(j-1)*8+8);
    dPatch(1:8,9:16)  = iBY((i-1)*8+1:(i-1)*8+8, (j-1)*8+1:(j-1)*8+8);
    dPatch(1:8,17:24) = iIT((i-1)*8+1:(i-1)*8+8, (j-1)*8+1:(j-1)*8+8);
    
    iPatch{i,j} = dPatch(:);
end
end

end