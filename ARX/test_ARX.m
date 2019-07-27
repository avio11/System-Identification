% Author: Jose Reinaldo da C.S.A.V.S Neto
% University of Brasilia
%
% Test for the ARX models
clear all

% System to be identified
N = 400;
mu = 0;
sigma = 0.1^2;
u = normrnd(0,1,[1,N]);
e = normrnd(mu,sigma,[1,N]);
y(1:2) = 0;
for i=3:N
    y(i) = 0.5*y(i-1) + 0.3*y(i-2) + 0.7*u(i-1) + 0.9*u(i-2) + e(i);
end
u = u';
y = y';

% ARX model parameters
ny = 2;
nu = 2;

clc

% LASSO training (Working)
theta_LASSO = LASSO( y, u, ny, nu );

% Ridge Regression (working)
theta_Ridge = Ridge( y, u, ny, nu );

% Batch Least Squares (Working)
theta_BLS = BLS( y, u, ny, nu );

% Gradient Descent (working)
theta_GDS = GDS( y, u, ny, nu );

% % Elastic Net (Upcoming work)
% theta_Elastic = Elastic_net(y, u, ny, nu );

% Multilayer Perceptron Neural Network
q_neuron = 8; % Number of neurons in hidden layer
m = max(abs(y));
[net, y_net] = MLP( y/m, u/m, ny, nu, q_neuron);
plot(y);
hold on
plot(y_net*m);
title('MLP system identification');
legend('Real system output', 'Neural net output');
hold off

% Print trained coefficients
fprintf('Real system:\t y(k) = 0.0000 + 0.5000y(k-1) + 0.3000y(k-2) + 0.7000u(k-1) + 0.9000u(k-2)\n');
fprintf('BLS model:\t\t y(k) = %.4f + %.4fy(k-1) + %.4fy(k-2) + %.4fu(k-1) + %.4fu(k-2)\n', theta_BLS(1), theta_BLS(2), theta_BLS(3), theta_BLS(4), theta_BLS(5));
fprintf('GDS model:\t\t y(k) = %.4f + %.4fy(k-1) + %.4fy(k-2) + %.4fu(k-1) + %.4fu(k-2)\n', theta_GDS(1), theta_GDS(2), theta_GDS(3), theta_GDS(4), theta_GDS(5));
fprintf('LASSO model:\t y(k) = %.4f + %.4fy(k-1) + %.4fy(k-2) + %.4fu(k-1) + %.4fu(k-2)\n', theta_LASSO(1), theta_LASSO(2), theta_LASSO(3), theta_LASSO(4), theta_LASSO(5));
fprintf('Ridge model:\t y(k) = %.4f + %.4fy(k-1) + %.4fy(k-2) + %.4fu(k-1) + %.4fu(k-2)\n', theta_Ridge(1), theta_Ridge(2), theta_Ridge(3), theta_Ridge(4), theta_Ridge(5));
