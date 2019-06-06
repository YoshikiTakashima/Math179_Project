function D = DataSize(M)
%DATASIZE Calculates the data size of the matrix.
%   This is the number of non-zero entries. 
%   Max of them if multiple channels.
s = size(M);
if nnz(s) == 2
    D = nnz(M);
else
    a = zeros([1,s(3)]);
    for i = 1:s(3)
        a(i) = nnz(M(:,:,i));
    end
    D = max(a);
end
end

