function writeICCMetaResultToFile(meta_ICC_value, meta_ICC_variance, resultFolder)
% writeMetaResultToFile(meta_ICC_value, meta_ICC_variance, resultFolder)
%
% 2014/08/14,JDLee, modified
% 2014/08/15,JDLee, modified

if ~exist(resultFolder,'dir'), mkdir(resultFolder); end

save(fullfile(resultFolder,'meta_ICC_value.mat'), 'meta_ICC_value');
save(fullfile(resultFolder,'meta_ICC_variance.mat'), 'meta_ICC_variance');

end