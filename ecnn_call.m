%
% Script ECCN Tutorial: Tasks 1 - 3
%
% Task 1
[XA,XB,XC,YA,YB,YC] = ecnn_data(0); % Load data
Net = ecnn_train(XA,XB,YA,YB,0.0001,1.1,100,true); % Train ECNN
Z = ecnn_test(Net,XC,YC); % Test ECNN
plot_class_boundaries(Net,XC,YC,Z); % Plots 
% Task 2
ecnn_analysis(Net); % Feature Importance Analysis
% Task 3 
% learning_rate(kappa,XB,XA,YA,YB,0.0001,100) % Learning Rate
return
