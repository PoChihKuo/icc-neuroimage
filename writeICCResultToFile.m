function writeICCResultToFile(ICC_value, ICC_variance, resultFolder)
% writeICCResultToFile(ICC_value, ICC_variance, resultFolder)
%
% 2014/08/14,JDLee, modified

if ~exist(resultFolder,'dir'), mkdir(resultFolder); end

save(fullfile(resultFolder,'ICC_value.mat'), 'ICC_value');
save(fullfile(resultFolder,'ICC_variance.mat'), 'ICC_variance');

end