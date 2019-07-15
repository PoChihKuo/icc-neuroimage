% detect all .mat files in datafolder
datafolder='data';
dirInfo = dir(fullfile(datafolder,'*.mat'));
datafiles = struct2cell(dirInfo);
datafiles = datafiles(1,:); % we only need the first field: filename
if isempty(datafiles),
    error('There is no data file in %s \n', datafolder); 
end

nReplicates=1;
nSubj = length(datafiles); %number of subjects



iterator_vector = 0:nReplicates; % 0 means process original brain data, 1~nReplicates means process shuffled brain data
T_all = cell(1,length(iterator_vector)); % T_all is a row vector


 for s = 1:nSubj,
     fprintf('Combine subject %d...\n',s);
        brainData=load(fullfile(datafolder,datafile)); %brainData is a (Tp x runs x nBrainVoxels) matrix
        fields = fieldnames(brainData);
        brainData=brainData.(fields{1});
        [Tp nRuns nBrainVoxels] = size(brainData); % InfoData.bdata is a (Tp x runs x nBrainVoxels) matrix
     
     if s==1,
         allBrainData = zeros(Tp*nRuns, nSubj, nBrainVoxels); % allocate memory for allBrainData
     end     
     allBrainData(:,s,:) = reshape(brainData,Tp*nRuns,1,nBrainVoxels);
 end

for i = 1:length(iterator_vector),
    
    % iter = 0 => no shuffling, process original data
    % iter > 0 => do shuffling, process shuffled data
    iter = iterator_vector(i);
    
    if iter==0,
        fprintf('----------- Processing original data -----------\n');
        resultFolder = fullfile('resultForOriginalData');
    else
        rep = iter;
        fprintf('----------- Processing data for replicate %d -----------\n',rep);        
        resultFolder = fullfile(['resultForShuffledData_iter' num2str(rep)]);       
    end
    
    if ~exist(resultFolder,'dir'), mkdir(resultFolder); end
    
    %--------------------------------------------------------------------------
    % Step 1: Intraclass correlation (ICC or ICC*) among all subjects treating each
    %         subject as a run.
    % Step 2: Variances of ICC or ICC*.
    %--------------------------------------------------------------------------
       
    if iter ~= 0,
        fprintf('Shuffle combined data...\n');
        shuffledAllBrainData = shuffle(allBrainData);
        
        saveShuffledBrainData = 1;
        if saveShuffledBrainData,
            writeShuffledDataToFile(shuffledAllBrainData,resultFolder);
        end
    end
    
    
    %--------------------------------------------------------------------------
    %Step 3: Meta analysis by pooling individual ICCs and variances together.
    %--------------------------------------------------------------------------
    %--------------------------------------------------------------------------
    % Step 4: Compute t-values of ICCs (each voxel has one t-value).
    %--------------------------------------------------------------------------     
    
    
    fprintf('Conduct Meta analysis by pooling individual ICCs and variances together...\n');
    [meta_ICC_value meta_ICC_variance] = iccMetaAnalysis(ICC_value_all, ICC_variance_all);    
    folderName = fullfile(resultFolder, 'MetaAnalysis');       
    writeICCMetaResultToFile(meta_ICC_value, meta_ICC_variance,folderName);    
    
    %--------------------------------------------------------------------------
    % Step 4: Compute t-values of ICCs (each voxel has one t-value).
    %--------------------------------------------------------------------------
    fprintf('Compute t-values of ICCs...\n');
    T = iccMetaAnalysis_method2(ICC_value_all, ICC_variance_all);  
    folderName = fullfile(resultFolder, 'T_value');
    writeTValueToFile(T, folderName);
    
    T_all{i} = T;        
    
    TValueFolder = fullfile('T_all');
     if ~exist(TValueFolder,'dir'), mkdir(TValueFolder); end
    writeTAllValueToFile(T_all, TValueFolder);
    
    empiricalT = T_all{1};
    shuffledT = T_all(2:end); 
    
    fprintf('Compute p-values for t-values by comparing with phase-randomized t-value distribution\n');
    tail=1; %1:one-tail, 2:two-tail
    P = computeP(empiricalT, shuffledT,tail);
   
   
   PValueFolder = fullfile('P');
     if ~exist(PValueFolder,'dir'), mkdir(PValueFolder); end
   writePValueToFile(P, PValueFolder);
    
    
end
