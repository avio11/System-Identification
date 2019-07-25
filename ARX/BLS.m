% Batch Least Squares for linear ARX models
function [ theta ] = BLS( y, u, ny, nu )
    % Build regressor matrix P
    P = build_ARX_regressor( y, u,ny, nu );
    
    % Compute BLS parameters
    theta = pinv(P'*P)*P'*y(max(nu,ny)+1:length(y));
end
