function [results, output, model] = run_analysis_SSVEP_eval_Single(set, approach)
%RUN_ANALYSIS_SSVEP_EVAL_SINGLE Summary of this function goes here
%   Detailed explanation goes here
% created 07-11-2018
% last modified : -- -- --
% Okba Bekhelifi, <okba.bekhelif@univ-usto.dz>
nSubj = utils_fetch_Set_Folder(set);
interSubject_results = zeros(2, nSubj);
% results = zeros(2, nSubj);
eval_duration = 1; % 1 second time for evaluation

% 每个受试者数据进行训练和测试
for subj = 1:nSubj
    set.subj = subj;
    trainEEG = dataio_read_SSVEP(set,'train'); %获取训练数据
    testEEG = dataio_read_SSVEP(set, 'test'); %获取测试数据
    samples = size(trainEEG.epochs.signal,1); %样本数(有多少个epoch)
    windowLength = samples/trainEEG.fs;  % 频率时间窗大小
    disp(['Analyising data from subject:' ' ' trainEEG.subject.id]);
    %% Train & Test
    if (~isfield(approach, 'features')) % 判断是否有"feature"字段，若没有：
        features = trainEEG.epochs;
        features.fs = trainEEG.fs;
        features.stimuli_frequencies = trainEEG.paradigm.stimuli;
        test_features = testEEG.epochs;
    else
        approach.features.options.mode = 'estimate';
        features = extractSSVEP_features(trainEEG, approach);
        approach = utils_augment_approach(approach, features.af);
        approach.features.mode = 'transform';
        test_features = extractSSVEP_features(testEEG, approach);
    end
    clear trainEEG testEEG
    model = ml_trainClassifier(features, approach.classifier, approach.cv); % 获得模型
    output_train = ml_applyClassifier(features, model); %进行分类训练
    clear features
    output_test = ml_applyClassifier(test_features, model); %测试
    clear test_features
    %% Display & plot results
    interSubject_results(1, subj) = output_train.accuracy;
    interSubject_results(2, subj) = output_test.accuracy;
    output ={output_train, output_test, windowLength};
    %     accuracy, kappa, alg
    results(subj).train_acc = output_train.accuracy;
    results(subj).test_acc = output_test.accuracy;
    % ITR
    n_targets = length(unique(output_train.y));
    evaluation_time = eval_duration + windowLength;
    results(subj).itr = evaluation_ITR(n_targets, output_test.accuracy, evaluation_time);
    disp(['Accuracy on Train set: ' num2str(output_train.accuracy)]);
    disp(['Accuracy on Test set: ' num2str(output_test.accuracy)]);
    disp( ['Accuracy on Total data: ' num2str(mean(interSubject_results(:, subj)))]);
    disp(['ITR : ' num2str(results(subj).itr)]);
    disp(repmat('-',1,50))
end
disp(['Average accuracy on ' set.title ' ' num2str(mean(interSubject_results(2,:)))]);
end

