% Author: Jose Reinaldo da C.S.A.V.S Neto
% University of Brasilia
%
% Batch Least Squares for nonlinear NARX models
function [ theta ] = BLS( y, u, ny, nu, nl )
    % Build regressor matrix P
    P = build_NARX_regressor( y, u, ny, nu, nl );
    
    % Compute BLS parameters
    theta = pinv(P'*P)*P'*y(max(nu,ny)+1:length(y));
end
