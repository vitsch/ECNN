%
function [ErA ErB k] = fit_unit_weights_plot(kappa,...
  XB,XA,YA,YB,delta,kmax,W)
%
I = [1 2 3];
ErB = zeros(kmax+1,1);
ErA = zeros(kmax+1,1);
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
  ErA(k) = mean(eta.^2);
  ErB(k) = erB1;
end
ErB = ErB(1:k);
ErA = ErA(1:k);
return