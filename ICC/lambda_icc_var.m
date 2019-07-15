function flag = lambda_icc_var(tmatrix)
% lambda_icc_var.m
% load test_tmatrix.mat

% fid = fopen('lambda_icc_var_relitest.csv', 'w');
% fprintf(fid, 'index\tlambda\t\t\t\ticc\tvar(icc)\ticc*\tvar(icc*)\n');

m = length(tmatrix);
lambda = cell(1, m); flag = zeros(1, m);

for i = 1:m
    lambda{i} = sum(tmatrix{i})/sum(tmatrix{i}(:));
    if ~isempty(find(lambda{i} < 0, 1))
        flag(i) = 1;
    else
        flag(i) = 0;
    end
end

flag = find(flag);
% flag = intersect(ReliData.rindx, flag);
% n = length(flag);
% icc = zeros(1, n); var_icc = zeros(1, n);
% icc_star = zeros(1, n); var_icc_star = zeros(1, n);
% for i = 1:n
%     icc(i) = rr_icc_val(tmatrix{flag(i)});
%     var_icc(i) = varGaussian(tmatrix{flag(i)}, InfoData.tp, 0);
%     icc_star(i) = rr_icc_star_val(tmatrix{flag(i)});
%     var_icc_star(i) = varGaussian(tmatrix{flag(i)}, InfoData.tp, 1);
%     fprintf(fid, '%d\t%12.8f\t%12.8f\t%12.8f\t%12.8f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\n', flag(i), lambda{flag(i)}(1), lambda{flag(i)}(2), lambda{flag(i)}(3), lambda{flag(i)}(4), icc(i), var_icc(i), icc_star(i), var_icc_star(i));
% end
