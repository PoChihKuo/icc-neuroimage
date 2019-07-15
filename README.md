# icc-neuroimage
The code for two-stage analysis using ICC.

This is the project to calculate ICC and Mcnemar test from time series.
Please refer to our paper for details of the methods.

An example data is given in the "data" folder containing a fMRI example "example_data.mat".
The format of the example data is Time X Run X Locations.

The ouput will be created in the "P", "T_all", "resultForOriginalData", "resultForShuffledData_iterx" folders 

/P: the ICC p-value for each location.
/T_all: the T values for original and shuffled data.
/resultForOriginalData: the ICC value, ICC variance, T_value, MetaICC value, and MetaICC variance using original data.
/resultForShuffledData_iterx: the ICC value, ICC variance, T_value, MetaICC value, and MetaICC variance using x-th shuffled data (x=1,2,...N, N is the number of shuffled data).

Script_inter_subject_ICC: The script to calculate inter-subject ICC 
Script_intra_subject_ICC: The script to calculate intra-subject ICC 

computeAndSaveP: Compute and save P value using original and suffled data
computeP: Compute P values by 1-tail or two-tail test.
iccMetaAnalysis: Pool the icc vlaues in intra-subject ICC analysis.
Mcnemar_test:  Fisher’s mid-p test form the observed joint probability.
shuffle: shuffle the originl time series using phase-randomization method.


