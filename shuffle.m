function [shuffledBrainData] = shuffle(brainData)
% [shuffledBrainData] = shuffle(brainData)
% Input
%   brainData is a (Tp x nRuns x nBrainVoxels) matrix
% Output
%   shuffledBrainData is a (Tp x nRuns x nBrainVoxels) matrix
%

[Tp nRuns nBrainVoxels]= size(brainData);

shuffleMethod = 'spm';
parallelMethod = 0;

switch shuffleMethod,
        
    case 'spm',
        % support_spm_phase_shuffling
        
        if parallelMethod==0,
            % no parallel processing
            shuffledBrainData = zeros(Tp, nRuns, nBrainVoxels);
            for v = 1:nBrainVoxels,
                for r = 1:nRuns,
                    shuffledBrainData(:,r,v)  = support_spm_phase_shuffling(brainData(:,r,v));
                end
            end
        elseif parallelMethod==1,
            % use parfor
            shuffledBrainData = zeros(Tp, nRuns, nBrainVoxels);
            parfor v = 1:nBrainVoxels,
                shuffledBrainData(:,:,v)  = par_support_spm_phase_shuffling(brainData(:,:,v));
            end
        elseif parallelMethod==2,
            %remove for-loop
            
            %comment out the following line to speed up program
            %shuffledBrainData = zeros(Tp, nRuns*nBrainVoxels);%shuffledBrainData is a (Tp nRuns*nBrainVoxels) matrix
            
            brainData = reshape(brainData,[Tp nRuns*nBrainVoxels]);%brainData is now a (Tp nRuns*nBrainVoxels) matrix
            
            shuffledBrainData = par_support_spm_phase_shuffling(brainData);
            shuffledBrainData = reshape(shuffledBrainData,[Tp nRuns nBrainVoxels]);
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

%{
P1=P(1:176);
P2=P(177:352);
Q1=support_spm_phase_shuffling(P1');
Q2=support_spm_phase_shuffling(P2');
Q1=Q1';
Q2=Q2';
Q=[Q1 Q2];
Q_perm1 = P1(randperm(length(P1)));
Q_perm2 = P2(randperm(length(P2)));
Q_perm=[Q_perm1 Q_perm2];
%}
