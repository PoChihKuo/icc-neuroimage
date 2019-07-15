function [shuffledBrainData] = shuffle(brainData)
% [shuffledBrainData] = shuffle(brainData)
% Input
%   brainData is a (Tp x nRuns x nBrainVoxels) matrix
% Output
%   shuffledBrainData is a (Tp x nRuns x nBrainVoxels) matrix
%

[Tp nRuns nBrainVoxels]= size(brainData);

shuffleMethod = 'phase';

switch shuffleMethod,
        
    case 'phase',
        % support_spm_phase_shuffling
            shuffledBrainData = zeros(Tp, nRuns, nBrainVoxels);
            for v = 1:nBrainVoxels,
                for r = 1:nRuns,
                    shuffledBrainData(:,r,v)  = phase_shuffling(brainData(:,r,v));
                end
            end     

    case 'permute', 
        
        for nr=1:nRuns
            shuffledBrainData(:,nr,:) = brainData(randperm(Tp),nr,:);
        end

    case 'wavelet', 
        brainData = reshape(brainData,[Tp nRuns*nBrainVoxels]);%brainData is now a (Tp nRuns*nBrainVoxels) matrix
        shuffledBrainData = zeros(Tp, nRuns*nBrainVoxels);
        for v = 1:nRuns*nBrainVoxels,
            P = brainData(:,v); % P is a Tp x 1 matrix
            %Q_emd = hilbert_phase_reorder(P,0); % Q_emd is a column vector
            Q_emd = wavelet_permute(P);
            shuffledBrainData(:,v)  = Q_emd;
        end
        shuffledBrainData = reshape(shuffledBrainData,[Tp nRuns nBrainVoxels]);
        
end

end
