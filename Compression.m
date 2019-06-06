function [cImage, diff] = Compression(image,compRatio)
%COMPRESSION Compresses 2D mat by the percent. Require 2^k.
%   Eliminates least significant "percent" of haar coefficients.
%   Parts of the code copied over from HW#4.
[H,W,~] = size(image);
rectSide = ceil(min([H,W]) / 32);
rectSize = [rectSide,rectSide];

raw = cast(image,'int16');
for i = 1:rectSize(1):H
    for j = 1:rectSize(2):W
        haarImg = raw(i:(i+(rectSize(1) - 1)),j:(j+(rectSize(2) - 1)));
        for x = 1:rectSize(2)
            haarImg(:,x) = HaarTf(haarImg(:,x));
        end
        for y = 1:rectSize(1)
            haarImg(y,:) = HaarTf(haarImg(y,:));
        end
        raw(i:(i+(rectSize(1) - 1)),j:(j+(rectSize(2) - 1))) = haarImg;
    end
end
v1 = DataSize(raw);
values = sort(abs(nonzeros(raw)));
numToDelete = ceil((1 - (1/compRatio)) * DataSize(raw));
epsilon = values(numToDelete,1);
raw(raw > -epsilon & raw < epsilon) = 0;
v2 = DataSize(raw);
diff = (v1 - v2) / v1;
for i = 1:rectSize(1):H
    for j = 1:rectSize(2):W
        filteredMat = raw(i:(i+(rectSize(1) - 1)),j:(j+(rectSize(2) - 1)));
        for y = 1:rectSize(1)
            filteredMat(y,:) = InvHaarTf(filteredMat(y,:));
        end
        for x = 1:rectSize(2)
            filteredMat(:,x) = InvHaarTf(filteredMat(:,x));
        end
        raw(i:(i+(rectSize(1) - 1)),j:(j+(rectSize(2) - 1))) = filteredMat;
    end
end     
cImage = cast(raw, 'uint8');

end

