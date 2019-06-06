function a = AdjustSize2K(fileName)
%ADJUSTSIZE2K Summary of this function goes here
%   Detailed explanation goes here
a = 0;

Img = imread(fileName);

[H,W,~] = size(Img);
HExp2 = 2^(floor(log2(H)));
WExp2 = 2^(floor(log2(W)));
Img = imresize(Img, [HExp2,WExp2]);

imwrite(Img, fileName);
end

