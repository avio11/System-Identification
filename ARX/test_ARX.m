% Author: Jose Reinaldo da C.S.A.V.S Neto
% University of Brasilia
%
% Test for the ARX models
clear all
clc

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

% LASSO training (Not Working)
theta_LASSO = LASSO( y, u, ny, nu );

% Ridge Regression (Upcoming work)
theta_Ridge = Ridge( y, u, ny, nu );

% Batch Least Squares (Working)
theta_BLS = BLS( y, u, ny, nu );

% Gradient Descent (Upcoming work)
theta_GDS = GDS( y, u, ny, nu );

% % Elastic Net (Upcoming work)
% theta_Elastic = Elastic_net(y, u, ny, nu );