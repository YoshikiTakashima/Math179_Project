function [cImage, sB, sA] = NonUnifCompression(image,sigWidth,top,bot)
%NONUNIFCOMPRESSION Compresses 2D mat by the a bell curve. Require 2^k.
%   Eliminates least significant haar coefficients via rowwise bell curve.
%   Parts of the code copied over from HW#4.
[H,W,~] = size(image);
% rectSide = ceil(min([H,W]) / 32);

scaleH = @(i) ((i-(H/2))/(H/2))*sigWidth; %shift and scale i to fit sigmoid
sigmoid = @(x) 1 / (1 + exp(-x));
sigmoidDeriv = @(x) (sigmoid(x)*(1 - sigmoid(x))); %sigmoidDeriv(0) = 1/4
thresh = @(i) 1 - ((top - bot)*(4*sigmoidDeriv(scaleH(i))) + bot);
rectSize = [8,8];

sB = 0;
sA = 0;

raw = cast(image,'int16');
for i = 1:rectSize(1):H
    th = thresh(i);
    for j = 1:rectSize(2):W
        haarImg = raw(i:(i+(rectSize(1) - 1)),j:(j+(rectSize(2) - 1)));
        for x = 1:rectSize(2)
            haarImg(:,x) = HaarTf(haarImg(:,x));
        end
        for y = 1:rectSize(1)
            haarImg(y,:) = HaarTf(haarImg(y,:));
        end
        
        sB = sB + nnz(haarImg); %Before compression
        
        values = sort(abs(nonzeros(haarImg)));
        s = size(values);
        if max(s) > 1 && min(s) > 0 %added later && min(s) > 0
            numToDelete = min(s(1,1),ceil(th * max(size(values))));
            epsilon = values(numToDelete,1);
            if values(numToDelete,1) < values(s(1,1),1)
                haarImg((-epsilon) <= haarImg & haarImg <= epsilon) = 0;
            else
                epsilon = values(numToDelete,1);
                haarImg((-epsilon) < haarImg & haarImg < epsilon) = 0;
            end
        end
        sA = sA + nnz(haarImg); %After compression
        
        raw(i:(i+(rectSize(1) - 1)),j:(j+(rectSize(2) - 1))) = haarImg;
    end
end

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

