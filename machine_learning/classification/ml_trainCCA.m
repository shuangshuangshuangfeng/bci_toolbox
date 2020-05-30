function [model] = ml_trainCCA(features, alg)
%ML_TRAINCCA Summary of this function goes here
%   Detailed explanation goes here
% created 03-26-2018
% last modification -- -- --
% Okba Bekhelifi, <okba.bekhelif@univ-usto.dz>

% checking classifier's options/params
if(~isfield(alg, 'options'))
    alg.options.harmonics = 2;
end

[samples, ~, ~] = size(features.signal); % 信号大小
[frqs, idle_ind] = utils_get_frequencies(features.stimuli_frequencies);  % Y特征
stimuli_count = length(frqs); %N
reference_signals = cell(1, stimuli_count);

for stimulus=1:stimuli_count
    reference_signals{stimulus} = refsig(frqs(stimulus),...
                                         features.fs, ...
                                         samples, ...
                                         alg.options.harmonics);
end

if(strcmp(alg.options.mode, 'sync') && ~isempty(idle_ind))
    model.idle_ind = idle_ind;
else
    model.idle_ind = [];
end

model.alg.learner = 'CCA';
model.ref = reference_signals;
model.mode = alg.options.mode;

end

