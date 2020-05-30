function [data] = dataio_read_SSVEP_Batch(set, datatype)
%DATAIO_READ_SSVEP_BATCH Summary of this function goes here
%   Detailed explanation goes here
% created 07-12-2017
% last modified : -- -- --
% Okba Bekhelifi, <okba.bekhelif@univ-usto.dz>

path = 'D:\workspace_matlab\bic_toolbox_mygit\bci_toolbox\datasets\epochs\';
switch upper(set)
    
    case 'SSVEP_EXOSKELETON'
        ssvep_exoskeleton = [path 'ssvep_exoskeleton\BM\'];
        if (strcmp(datatype,'train'))
            data = load([ssvep_exoskeleton 'trainEEG.mat']);
            data = data.trainEEG;
        else
            data = load([ssvep_exoskeleton 'testEEG.mat']);
            data = data.testEEG;
        end
        
    case 'SSVEP_DEMO'
        ssvep_demo = [path 'demo_ssvep\'];
        if (strcmp(datatype,'train'))
            data = load([ssvep_demo 'trainEEG.mat']);
            data = data.trainEEG;
        else
            data = load([ssvep_demo 'testEEG.mat']);
            data = data.testEEG;
        end
        
    case 'SSVEP_TSINGHUA'
        ssvep_tsinghua = [path 'ssvep_tsinghua_jfpm\BM\'];
        if (strcmp(datatype,'train'))
            data = load([ssvep_tsinghua 'trainEEG.mat']);
            data = data.trainEEG;
        else
            data = load([ssvep_tsinghua 'testEEG.mat']);
            data = data.testEEG;
        end
        
    case 'SSVEP_SANDIEGO'
        ssvep_sandiego = [path 'ssvep_sandiego\BM\'];
        if (strcmp(datatype,'train'))
            data = load([ssvep_sandiego 'trainEEG.mat']);
            data = data.trainEEG;
        else
            data = load([ssvep_sandiego 'testEEG.mat']);
            data = data.testEEG;
        end      
                
    otherwise
        error('Incorrect SSVEP Dataset');        
end
end

