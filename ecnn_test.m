%
function Z = ecnn_test(Net,XC,YC)
%
Ncr = cell2mat(Net(:,3));
[crm,nof_units] = min(Ncr);
for i = 1:nof_units
  I = Net{i,1};
  W = Net{i,2};
  XC = [XC XC(:,I)*W]; 
end
Z = XC(:,end);
if nargin > 2
  test_er = mean(Z > 0.5 ~= YC);
  fprintf('\nTest error = %5.3f\n', test_er)
end
return