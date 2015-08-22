
function learning_rate(kappa,XB,XA,YA,YB,delta,kmax)
%
% kappa = {1.0, 1.5, 2.0}
%
figure(3)
W = [-0.1770; -0.0381; 0.0482];
[ErA ErB k] = fit_unit_weights_plot(kappa,XB,XA,YA,YB,delta,kmax,W);
plot(1:k,ErB,'b',1:k,ErA,'r')
title(sprintf('Learning Rate, kappa=%3.2f',kappa))
xlabel('Training epochs,k')
ylabel('Error')
legend('e_B', 'e_A')
grid on
return