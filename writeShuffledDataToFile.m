function writeShuffledDataToFile(shuffledBrainData, resultFolder)
%  writeShuffledDataToFile(shuffledBrainData, resultFolder)
%
% 2014/08/14,JDLee, modified

if ~exist(resultFolder,'dir'), mkdir(resultFolder); end

save(fullfile(resultFolder,'shuffledBrainData.mat'), 'shuffledBrainData');

end