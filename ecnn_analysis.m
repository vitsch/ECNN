%
function ecnn_analysis(Net)
% 
Ncr = cell2mat(Net(:,3));
[eBmin,ropt] = min(Ncr); % % ropt is the optimal net size
H = zeros(1,5);
for i = 1:ropt
  I = Net{i,1};
  b = find(I==1);
  A = I(b+1:end);
  for j = 1:length(A)
    H(A(j)) = H(A(j)) + 1;
  end
end
H = H/sum(H);
fprintf('\nVariable Usage:\n');
for i = 2:length(H)
  fprintf('  %1i) %4.3f\n', i-1, H(i));
end
return