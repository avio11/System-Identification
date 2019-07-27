% Author: Jose Reinaldo da C.S.A.V.S Neto
% University of Brasilia
%
% Test for the NARX models
clear all

% System to be identified
N = 400;
mu = 0;
sigma = 0.1^2;
u = normrnd(0,1,[1,N]);
e = normrnd(mu,sigma,[1,N]);
y(1:2) = 0;
for i=3:N
    y(i) = 0.5 * y(i-1) + u(i-2) + 0.1 * (u(i-2)^2) + y(i-1)*u(i-1) + e(i);
end
u = u';
y = y';

% NARX model parameters
ny = 2;
nu = 2;
nl = 2;
clc
M = factorial(ny+nu+nl)/(factorial(ny+nu)*factorial(nl))-1; % Number of NARX terms excluding trivial all coefficients are zeroes case
fprintf('There are %d terms in the full NARX model', M+1);


% Batch Least Squares (Working)
[theta_BLS, full_model] = BLS( y, u, ny, nu, nl );
print_term_coeff(full_model, theta_BLS, 'Batch Least Squares', ny, nu);

% % Gradient Descent (Upcoming work)
% [theta_GDS, full_model] = GDS( y, u, ny, nu, nl );
% print_term_coeff(full_model, theta_GDS, 'Gradient Descent', ny, nu);

% LASSO training (Upcoming work)
[theta_LASSO, full_model] = LASSO( y, u, ny, nu, nl );
print_term_coeff(full_model, theta_LASSO, 'LASSO', ny, nu);

% Ridge Regression (Working)
[theta_Ridge, full_model] = Ridge( y, u, ny, nu, nl );
print_term_coeff(full_model, theta_Ridge, 'Ridge Regression', ny, nu);


% % Elastic Net (Upcoming work)
% theta_Elastic = Elastic_net(y, u, ny, nu );

