%
function [XA,XB,XC,YA,YB,YC] = ecnn_data(dummy_vars)
%
% load Ripley data 
% dummy_vars = {0, 1, 2} is the number of noise variables in the data
%
load ripl_tr % train data
n = size(ripl_tr,1);
IA = [1:3:n 2:3:n]; % Indeces of samples of DA (train)
IB = 3:3:n;         % Indeces of samples of DB (validation)
XA = ripl_tr(IA,1:2);
XB = ripl_tr(IB,1:2);
YA = ripl_tr(IA,3);
YB = ripl_tr(IB,3);
XA = [ones(size(XA,1),1) XA];
XB = [ones(size(XB,1),1) XB];
load ripl_te       % test data
XC = ripl_te(:,1:2);
XC = [ones(size(XC,1),1) XC];
YC = ripl_te(:,3);
if dummy_vars == 1 || dummy_vars == 2
    VarA = 5*randn(length(YA),dummy_vars);
    VarB = 5*randn(length(YB),dummy_vars);
    VarC = 5*randn(length(YC),dummy_vars);
    XA = [XA VarA];
    XB = [XB VarB];
    XC = [XC VarC];   
elseif dummy_vars ~= 0
  sprintf('dummy_vars is out of range {1,2}.')
end 
return
