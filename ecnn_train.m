%
function Net1 = ecnn_train(XA1,XB1,YA1,YB1,delta1,...
  kappa1,kmax1,f_show_train)

% Evolving Cascade Neural Network (ECNN) with Ripley's benchmar
%
% Written by V. Schetiin "A Learning Algorithm for Evolving Cascade
% Neural Networks". Neural Proc Lectter, 17, 2003, 
% available on http://arxiv.org/abs/cs/0504055
%
% Abstract. A new learning algorithm for Evolving Cascade Neural Networks 
% (ECNNs) is described. An ECNN starts to learn with one input node and then
% adding new inputs as well as new hidden neurons evolves it. The trained 
% ECNN has a nearly minimal number of input and hidden neurons as well as
% connections. The algorithm was successfully applied to classify artifacts
% and normal segments in clinical electroencephalograms (EEGs). The EEG 
% segments were visually labeled by EEG-viewer. The trained ECNN has 
% correctly classified 96.69% of the testing segments. It is slightly 
% better than a standard fully connected neural network. 
%
% Parameters:
%  XA1 is the training data 
%  XB1 is the validtaion data
%  YA1 is the training target vector
%  YB1 is the validation target vector
%  delta1 = 0.001 is the error gradient goal
%  kappa1 = 1.0 is the learning rate
%  kmax1 = 100 maximal number of training epochs
%  f_show_train = 1 to show the ECNN error on the DB
%   
% RUN:
% 1. [XA,XB,XC,YA,YB,YC]=ecnn_data(0); 
%     to download the data with n dummy var
% 2. Net1=ecnn_train(XA,XB,YA,YB,0.001,1.,100,1);
%     Here Net1 is the trained ECNN 
% 3. Z=ecnn_test(Net1,XC,YC); 
%     to test the trained ECNN
%
% Calls functions:
%   set_global_vars
%   unit_train
%   fit_unit_weights
%   eccn_add_unit   
%
global m Cm rmax net_delta Net 
set_global_vars(XA1,XB1,YA1,YB1,delta1,kappa1,kmax1)
r = 1;
[W,Cr] = unit_train(r); % Create Pools W and Cr
[cmin,imin] = min(Cr);
I = [[] Cm{imin}]; % [] means no hidden units
eccn_add_unit(W{imin},I,cmin,r);  
cmin1 = cmin - 2*net_delta;
while (r <= rmax) && (abs(cmin - cmin1) > net_delta) 
  fprintf('%2i, cmin=%7.5f\n',r,cmin1)
  cmin = cmin1;
  r = r + 1;
  [W,Cr] = unit_train(r);
  [cmin1,imin] = min(Cr);
  I = [(m + 2):(m + r) Cm{imin}];
  eccn_add_unit(W{imin},I,cmin1,r);  
end
if f_show_train
  Ncr = cell2mat(Net(:,3));
  [crm,cri] = min(Ncr);
  figure(1)
  plot(Ncr)
  title(sprintf('ECNN error on validation: e_B=%5.3f, size=%2i',crm,cri))
  ylabel(sprintf('Error, e_B'));
  xlabel('Number of units, r');
  grid on
end
Net1 = Net;
return

function set_global_vars(XA1,XB1,YA1,YB1,delta1,kappa1,kmax1)
global XA XB YA YB delta kappa kmax m Net rmax Cm ...
       nof_units pool_size net_delta
rmax = 50;
pool_size = 5;
net_delta = 0.0002;
m = size(XA1,2) - 1; % nof input variables
delta = delta1;
kappa = kappa1;
kmax = kmax1;
Net = cell(rmax,3); % [I W erB]
XA = XA1;
XB = XB1;
YA = YA1;
YB = YB1;
C1 = num2cell([ones(1,m); 1 + (1:m)]',2);
Cmb = combnk(1:m,2) + 1;
C2 = num2cell([ones(size(Cmb,1),1) Cmb],2);
Cm = [C1;C2];
nof_units = size(Cm,1); % candidates pool size
fprintf('\nm=%i,Delta=%7.5f,kappa=%4.2f,kmax=%2i\n',m,delta,kappa,kmax);
return

function [W1,Cr1] = unit_train(r)
global Cm nof_units m pool_size
if r == 1
  nofun = m;
else 
  nofun = nof_units;
end
W1 = cell(nofun,1);
Cr1 = zeros(nofun,1);
for i = 1:nofun
  I = [(m + 2):(m + r) Cm{i}];
  Cp = zeros(pool_size,1);
  Wp = zeros(length(I),pool_size);
  for j = 1:pool_size
    [Wp(:,j),Cp(j)] = fit_unit_weights(I);  
  end
  [cb,ib] = min(Cp); % best candidate
  W1{i} = Wp(:,ib);
  Cr1(i) = cb;
end
return

function [W,erB1] = fit_unit_weights(I)
global XB XA YA YB kappa delta kmax
W = 0.1*randn(length(I),1);
W = W/sum(W.^2);
erB1 = mean((XB(:,I)*W - YB).^2);
erB = (erB1 + 2*delta);
eta = XA(:,I)*W - YA;
U1 = [kappa*XA(:,I)/(sum(sum(XA(:,I).^2)))]';
k = 0;
while (abs(erB - erB1) > delta) && (k <= kmax)
  W = W - U1*eta;
  eta = XA(:,I)*W - YA;
  erB = erB1;
  erB1 = mean((XB(:,I)*W - YB).^2);
  k = k+1;
end
return

function eccn_add_unit(W,I,erB,r)
global XA XB Net
XA = [XA XA(:,I)*W];
XB = [XB XB(:,I)*W];
Net{r,1} = I;
Net{r,2} = W;
Net{r,3} = erB;
return
