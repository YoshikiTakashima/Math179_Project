function out = HaarTf(in)
%HAARTF Does 1D Haar wavelet transform on any array of length 2^k
%   First index is Approximation, the indices after are detail.

numIter = log2(max(size(in)));
if (ceil(numIter) - floor(numIter)) > 0
    error('Array input is not length 2^k');
end

out = in;
scratch1 = zeros(ceil(size(in) / 2));
scratch2 = zeros(ceil(size(in) / 2));

for pow = numIter:-1:1
    for i = 1:2:(2^pow)
        scratch1(ceil(i / 2)) = (out(i) + out(i+1)) / 2;
        scratch2(ceil(i / 2)) = (out(i) - out(i+1)) / 2;
    end
    out(1:(2^(pow - 1))) = scratch1(1:(2^(pow - 1)));
    out((2^(pow - 1) + 1):(2^pow)) = scratch2(1:(2^(pow - 1)));
end
end

