function [Gm] = vecG(m)
% construct the transformation matrix Gm where vecX = G*vechX.
%
iidx = m*m;
jidx = m*(m+1)/2;
Gm = zeros(iidx, jidx);

% construct the diagonal blocks.
xidx = 0;
yidx = 0;
for k = 1:m
    diagG = diag(diag(ones(m+1-k)), 1-k);
    Gm(xidx+1:xidx+m, yidx+1:yidx+m+1-k) = diagG(1:m, 1:m+1-k);
    %Gm(xidx+1, k) = 1;
    xidx = xidx + m;
    yidx = yidx + m+1-k;
end
Gm = Gm(1:iidx, 1:jidx);

% construct lower triangular part by block design.
yidx = 0;
for k = 1:m-1
    xidx = m*k;
    for j = k+1:m
        block_mtx = zeros(m, m+1-k);
        block_mtx(k, j+1-k) = 1;
        Gm(xidx+1:xidx+m, yidx+1:yidx+m+1-k) = block_mtx(1:m, 1:m+1-k);
        xidx = xidx + m;
    end
    yidx = yidx + m+1-k;
end
