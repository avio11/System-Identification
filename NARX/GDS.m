% Author: Jose Reinaldo da C.S.A.V.S Neto
% University of Brasilia
%
% Gradient Descent for nonlinear NARX models
function [ theta ] = GDS( y, u, ny, nu )
    % Build regressor matrix P
    P = build_ARX_regressor( y, u, ny, nu );
    
    % Gradient Descent parameters
    alpha = 0.1;
    m = length(y(max(ny,nu):length(y)));
    iterations = 500;
    theta = zeros( ny+nu+1,1 );
    
    % Compute model parameters by Gradient Descent
    for it=1:iterations
        h_theta = P*theta;
        for i=1:length(theta)
            theta(i) = theta(i) - alpha*(1/m)*sum((h_theta - y(max(ny,nu)+1:length(y)))'*P(:,i));
        end
    end
end
