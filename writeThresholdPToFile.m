function writeThresholdPToFile(thresholdP, resultFolder)
% writeThresholdPToFile(thresholdP, resultFolder)
%
% 2014/08/14,JDLee, modified

if ~exist(resultFolder,'dir'), mkdir(resultFolder); end

save(fullfile(resultFolder,'thresholdP.mat'), 'thresholdP');

end