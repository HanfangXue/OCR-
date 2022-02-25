function y = features2class(x,classification_data)
%% Get the training data and labels
[m, ~] = size(classification_data);
X = classification_data(1:m-1,:);
Y = classification_data(m,:);
%% Train multiclass model using SVM learners
t = templateSVM('standardize',1);
SVM_model = fitcecoc(X',Y','learners',t);
y = predict(SVM_model, x');
%% Classification tree
% tree_model = ClassificationTree.fit(X', Y');
% y = predict(tree_model, x');
%% Ensemble methods
% ensemble_model = fitensemble(X',Y','AdaBoostM2' ,100,'tree','type','classification');
% y = predict(ensemble_model, x');
