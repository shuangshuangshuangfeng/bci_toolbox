function [results, output, model] = run_analysis_SSVEP(set, approach, report)
%RUN_ANALYSIS_SSVEP Summary of this function goes here
%   Detailed explanation goes here
%operations:
%                  - load train/test data， 训练数据/测试数据
%                  - spatial filtering  空间过滤器
%                  - feature extraction on train data 训练数据的特征提取
%                  - train classifier  训练分类器
%                  - feature extraction on test data  测试数据的特征提取
%                  - predict test data classes  测试数据类别预测
%                  - display/plot classification and characters detection
%                  results 显示分类结果
% Arguments:
%     In:
%         set : STR dataset title, from the set of available and epoched
%               datasets.
%
%         approach : STRUCT [1x1] analysis approach to be run.
%                  approach.features STRUCT [1x1]
%                           approach.features.alg : STR features extraction
%                                                     method.
%                           approach.features.alg.options (optional) STR
%                                               feature extrraction method
%                                               parameters.
%                  approach.classifier: STRUCT [1x1] machine learning
%                  method to be used.
%                                     approach.classifier.learner: STR
%                                     classifier to be used from the set of
%                                     classifiers available.
%                                     approach.classifier.option : STRUCT
%                                                         learners options.
%                                     this field may contain regularization
%                                     methods and other specific
%                                     parameters depending on the model to
%                                     be trained.
%                  approach.cv: STRUCT [1x1] cross validation
%                               approach.cv.method: STR cross-validation
%                                 technique to be used from the set of
%                                 available methods.
%                               approach.cv.nfolds: DOUBLE number of folds
%                               for train/validation split.
%     Returns:
%         results : STRUCT 1x1
%                  results.phrase : CHAR [NxM] [repetition trials] matriix
%                      of characters detected per repetition
%                  results.correct : [Lx1] DOUBLE vector of rate of
%                      correct detected characters per repetition.
%         output : STRUCT 1x1 classification results/performance
%                output.accuracy: DOUBLE correct classification rate
%                output.y: DOUBLE [1xN] [1 epochs_count] classifier
%                           binary classes output.
%                output.score: DOUBLE [1xN] [1 epochs_count] classifier's
%                               decision function output.
%                output.trueClasses: DOUBLE [1xN] [1 epochs_count] true
%                                    target labels.
%                output.confusion: DOUBLE [2x2] confusion matrix.
%                output.sensitivity: DOUBLE classifier's sensitivity.
%                output.specificity: DOUBLE classifier's specificicty.
%                output.fpr: DOUBLE classifier's false positive rate.
%                output.false_detection: DOUBLE classifier's false detection.
%                output. precision: DOUBLE classifier's precision.
%                output.hf_difference: DOUBLE classifier's hf difference.
%                output.kappa: DOUBLE classifier's kappa coefficient.
%                output.subject: STR subject id for the current data.
%                output.alg: STRUCT [1x1]
%                           output.alg.learner : STR classification algorithm
%                           output.alg.regularizer: (optional) STR regularization
%                                                   method for the alg.learner.
%                output.events: DOUBLE | INT16 [Nx1] [epochs_count 1]
%                                 stimulus presented to the subject.
%         model : STRUCT [1x1] trained classifier parameters, depending on
%         the algorithms the struct may contain weights and bias for linear
%         models and other specific attributes for non-linear models.See
%         specific models functions in machine_learning/classification
%         folder.
%
% Example :
%      call inside define_approach_SSVEP script.
%     [results, output, model] = run_analysis_ERP(set, approach);
% See also define_approach_SSVEP.m

% created 03-21-2018
% last modified : -- -- --
% Okba Bekhelifi, <okba.bekhelif@univ-usto.dz>

if(~isfield(set, 'mode'))
    set.mode = 'SM';
end

switch(set.mode)
    case 'BM'
        [results, output, model] = run_analysis_SSVEP_eval_Batch(set, approach);       
    case 'SM'
        % TODO
        [results, output, model] = run_analysis_SSVEP_eval_Single(set, approach);        
    otherwise
        error('Incorrect Data evaluation mode');
end
%% Reports
if(report)
    set.windowLength = output{3};
    report_analysis_SSVEP(set, approach, results);
end
end