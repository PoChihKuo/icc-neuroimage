function writeThresholdTToFile(thresholdT,thresholdT01,thresholdT0, resultFolder)
% writeThresholdPToFile(thresholdT, resultFolder)
%
% 2014/08/14,Mike, modified

if ~exist(resultFolder,'dir'), mkdir(resultFolder); end

save(fullfile(resultFolder,'thresholdT.mat'), 'thresholdT');
save(fullfile(resultFolder,'thresholdT0.mat'), 'thresholdT0');
save(fullfile(resultFolder,'thresholdT01.mat'), 'thresholdT01');


end