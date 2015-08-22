# ECNN
Evolving Cascade Neural Network (ECNN) Matlab script
 with Ripley's benchmark

Written by V. Schetinin "A Learning Algorithm for Evolving Cascade
Neural Networks". Neural Proc Letters, 17, 2003, available on http://arxiv.org/abs/cs/0504055

Abstract. A new learning algorithm for Evolving Cascade Neural Networks 
(ECNNs) is described. An ECNN starts to learn with one input node and then
adding new inputs as well as new hidden neurons evolves it. The trained 
ECNN has a nearly minimal number of input and hidden neurons as well as
connections. The algorithm was successfully applied to classify artifacts
and normal segments in clinical electroencephalograms (EEGs). The EEG 
segments were visually labeled by EEG-viewer. The trained ECNN has 
correctly classified 96.69% of the testing segments. It is slightly 
better than a standard fully connected neural network. 

Parameters:
  XA1 is the training data 
  XB1 is the validtaion data
  YA1 is the training target vector
  YB1 is the validation target vector
  delta1 = 0.001 is the error gradient goal
  kappa1 = 1.0 is the learning rate
  kmax1 = 100 maximal number of training epochs
  f_show_train = 1 to show the ECNN error on the DB
   
 RUN:
 1. [XA,XB,XC,YA,YB,YC]=ecnn_data(0); 
     to download the data with n dummy var
 2. Net1=ecnn_train(XA,XB,YA,YB,0.001,1.,100,1);
     Here Net1 is the trained ECNN 
 3. Z=ecnn_test(Net1,XC,YC); 
     to test the trained ECNN

 Calls functions:
   set_global_vars
   unit_train
   fit_unit_weights
   eccn_add_unit   
