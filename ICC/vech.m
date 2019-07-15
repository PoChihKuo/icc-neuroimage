function [vech_mtx] = vech(mtx)
% half-vectorized mtx
% note that vec(mtx) = mtx(:)
%
if nonzeros(mtx) == mtx(:)
    % a shortcut.
    vech_mtx = nonzeros(tril(mtx));
else
    % by definition.
    m = length(mtx);
    vech = [];
    for i = 1:m
        vech = [vech ;mtx(i:m, i)];
    end
    vech_mtx = vech;
end