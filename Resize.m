function newImage = Resize(image,newImageSize)
%RESIZE Resizes the image using nearest neighbor method
%
ratios = size(image);
if max(size(ratios)) > 2
    newImageSize = [newImageSize, ratios(1,3)];
end
ratios(1,1) = ratios(1,1) / newImageSize(1,1);
ratios(1,2) = ratios(1,2) / newImageSize(1,2);

newImage = zeros(newImageSize, 'uint8');
for i = 1:newImageSize(1,1)
    for j = 1:newImageSize(1,2)
        iInOriginal = max(round(ratios(1,1) * i),1);
        jInOriginal = max(round(ratios(1,2) * j),1);
        newImage(i,j,:) = image(iInOriginal,jInOriginal,:);
    end
end
end

