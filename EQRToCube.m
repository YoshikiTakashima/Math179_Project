function [faces,labels] = EQRToCube(image)
%EQRTOCUBE Converts equirectangular image to cube images.
%   Detailed explanation goes here
s = size(image);
sizeOriginal = s(1,1)*s(1,2);
faceSide = floor(sqrt(sizeOriginal / 6));

faces = repmat(zeros([faceSide, faceSide, 3]),6,1);
labels = ['top';'bot';'front';'back';'right';'left'];

fNum = 1; % top face.
fixed = 1; % fix z = 1.
for i = 1:faceSide
    for j = 1:faceSide
    end
end

end

