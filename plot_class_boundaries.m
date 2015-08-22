%
function plot_class_boundaries(Net,XC,YC,Z1)
%
x = -1.25:0.1:1.25;
y = -.5:0.1:1.5;
[X,Y] = meshgrid(x,y);
X = X(:);
Y = Y(:);
XG = [ones(size(X)) X Y];
nd = size(XC,2)-3;
if nd > 0
  XG = [XG ones(size(X,1),nd)];
end
Z = ecnn_test(Net,XG);
Z = reshape(Z,length(y),length(x));
figure(2)
contour(x,y,Z,0.5,'-k','LineWidth',2);
hold on
scatter(XC(:,2),XC(:,3),10,YC);
hold off
e = mean((Z1 > 0.5) ~= YC);
title(sprintf('Class Boundary, e_C=%5.3f',e));
xlabel('x_1');
ylabel('x_2');
grid on
return