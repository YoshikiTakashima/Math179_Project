function repackedImage = Repack(image,marginRatio,marginParam)
%REPACK Repacks the image according to the MPEG-OMAF format. 
%   0 <= marginRatio <0.5
imageSize = size(image);
marginSize = round(imageSize(1,1) * marginRatio);
rMarginWidth = round(imageSize(1,2) / 2);
realMarginRatio = 1 - cos(pi*marginRatio);
rMarginHeight = round(imageSize(1,1) * realMarginRatio * marginParam);

top = image(1:marginSize,:,:);
topR = Resize(top,[rMarginHeight,rMarginWidth]);

bottom = image((imageSize(1,1) - marginSize+1):imageSize(1,1),:,:);
bottomR = Resize(bottom,[rMarginHeight,imageSize(1,2) - rMarginWidth]);

middle = image((marginSize+1):(imageSize(1,1) - marginSize),:,:);
middleR = Resize(middle, [imageSize(1,1) - rMarginHeight,imageSize(1,2)]);

repackedImage = zeros(imageSize, 'uint8');

repackedImage(1:rMarginHeight,1:rMarginWidth,:) = topR;
repackedImage(1:rMarginHeight,(rMarginWidth+1):imageSize(1,2),:) = bottomR;
repackedImage((rMarginHeight+1):imageSize(1,1),:,:) = middleR;
end

