% Ridge regression for linear ARX models
function [ theta ] = Ridge( y, u, ny, nu )
    % Parameters of the Ridge Regression
    lambda = 1;
    
    % Build ARX regressor matrix
    P = build_ARX_regressor(y, u, ny, nu);
    
    % Compute Ridge parameters
    theta = pinv(P'*P+lambda*eye(size(P,2)))*P'*y(max(nu,ny)+1:length(y));
end

