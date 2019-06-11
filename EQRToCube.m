function [top, bot, front, back, right,left] = EQRToCube(image)
%EQRTOCUBE Converts equirectangular image to cube images.
%   Detailed explanation goes here
[H,W,C] = size(image);
faceSide = floor(sqrt((H*W)/ 6));
normalize = @(p) ((p - (faceSide/2)) / (faceSide/2));

mapH = @(y) min(H,max(1, round(H*((y + (pi/2)) / pi)))); 
mapW = @(x) min(W,max(1, round(W*((x + pi) / (2*pi)))));

top = zeros([faceSide, faceSide, C], 'uint8');
bot = zeros([faceSide, faceSide, C], 'uint8');
front = zeros([faceSide, faceSide, C], 'uint8');
back = zeros([faceSide, faceSide, C], 'uint8');
right = zeros([faceSide, faceSide, C], 'uint8');
left = zeros([faceSide, faceSide, C], 'uint8');

fixed = 1; % fix z = 1: top.
for i = 1:faceSide
    for j = 1:faceSide
        [theta,phi,~] = cart2sph(normalize(i),normalize(j),fixed);
        h = mapH(-phi);
        w = mapW(theta);
        top(i,j,:) = image(h,w,:);
    end
end
top = rot90(top);

fixed = -1; % fix z = -1: bottom
for i = 1:faceSide
    for j = 1:faceSide
        [theta,phi,~] = cart2sph(normalize(i),normalize(j),fixed);
        h = mapH(-phi);
        w = mapW(theta);
        bot(i,j,:) = image(h,w,:);
    end
end
bot = flip(rot90(bot, -1),2);

fixed = 1; % fix x = 1: front
for i = 1:faceSide
    for j = 1:faceSide
        [theta,phi,~] = cart2sph(normalize(i),fixed,normalize(j));
        h = mapH(-phi);
        w = mapW(theta);
        front(i,j,:) = image(h,w,:);
    end
end
front = flip(rot90(front),2);

fixed = -1; % fix x = -1: back
for i = 1:faceSide
    for j = 1:faceSide
        [theta,phi,~] = cart2sph(normalize(i),fixed,normalize(j));
        h = mapH(-phi);
        w = mapW(theta);
        back(i,j,:) = image(h,w,:);
    end
end
back = rot90(back);

fixed = 1; % fix y = 1: left
for i = 1:faceSide
    for j = 1:faceSide
        [theta,phi,~] = cart2sph(fixed,normalize(i),normalize(j));
        h = mapH(-phi);
        w = mapW(theta);
        left(i,j,:) = image(h,w,:);
    end
end
left = rot90(left);

fixed = -1; % fix y = -1: right
for i = 1:faceSide
    for j = 1:faceSide
        [theta,phi,~] = cart2sph(fixed,normalize(i),normalize(j));
        h = mapH(-phi);
        w = mapW(theta);
        right(i,j,:) = image(h,w,:);
    end
end
right = flip(rot90(right,-1),1);

end







