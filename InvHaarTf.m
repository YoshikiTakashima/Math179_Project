function out = InvHaarTf(in)
%INVHAARTF Inverse Haar wavelet transform
%   only works on array input size 2^k
numIter = log2(max(size(in)));
if (ceil(numIter) - floor(numIter)) > 0
    error('Array input is not length 2^k');
end

out = in;
scratch = zeros(size(out));

for pow = 0:numIter - 1
    for i = 1:(2^pow)
        scratch(2*i - 1)    = out(i) + out(2^pow + i); 
        scratch(2*i)        = out(i) - out(2^pow + i);
    end
    out(1:(2^(pow + 1))) = scratch(1:(2^(pow + 1)));
end
end

