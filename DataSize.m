function D = DataSize(image)
%DATASIZE Calculates the data size of the 2D matrix.
%   This is the number of non-zero entries. 
%   Max of them if multiple channels.
[H,W,~] = size(image);
rectSide = ceil(min([H,W]) / 32);
rectSize = [rectSide,rectSide];
D = 0;
for i = 1:rectSize(1):H
    for j = 1:rectSize(2):W
        haarImg = image(i:(i+(rectSize(1) - 1)),j:(j+(rectSize(2) - 1)));
        for x = 1:rectSize(2)
            haarImg(:,x) = HaarTf(haarImg(:,x));
        end
        for y = 1:rectSize(1)
            haarImg(y,:) = HaarTf(haarImg(y,:));
        end
        
        D = D + nnz(haarImg);
    end
end
end

