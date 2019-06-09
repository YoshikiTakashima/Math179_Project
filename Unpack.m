function unpackedImage = Unpack(image,marginRatio, marginParam)
%UNPACK Summary of this function goes here
%   Detailed explanation goes here


imageSize = size(image);
marginSize = round(imageSize(1,1) * marginRatio);
rMarginWidth = round(imageSize(1,2) / 2);
realMarginRatio = 1 - cos(pi*marginRatio);
rMarginHeight = round(imageSize(1,1) * realMarginRatio * marginParam);

topR = image(1:rMarginHeight,1:rMarginWidth,:);
top = Resize(topR, [marginSize,imageSize(1,2)]);

bottomR = image(1:rMarginHeight,(rMarginWidth+1):imageSize(1,2),:);
bottom = Resize(bottomR,[marginSize,imageSize(1,2)]);

middleR = image((rMarginHeight+1):imageSize(1,1),:,:);
mid = Resize(middleR, [imageSize(1,1) - (2*marginSize), imageSize(1,2)]);

unpackedImage = zeros(imageSize, 'uint8');

unpackedImage(1:marginSize,:,:) = top;
unpackedImage((imageSize(1,1) - marginSize+1):imageSize(1,1),:,:) = bottom;
unpackedImage((marginSize+1):(imageSize(1,1) - marginSize),:,:)= mid;
end

