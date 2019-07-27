% Author: Jose Reinaldo da C.S.A.V.S Neto
% University of Brasilia
%
% Test for the Neural Network models
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
