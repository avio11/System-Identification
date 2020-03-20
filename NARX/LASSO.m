% Author: Jose Reinaldo da C.S.A.V.S Neto
% University of Brasilia
%
% LASSO for nonlinear NARX models (not implemented yet)
function [ theta, full_model ] = LASSO( y, u, ny, nu, nl )
    % Parameters of the LASSO
        theta = zeros(ny+nu+1,1);     % Coeficients of the model
        lambda = 2;
        iterations = 100;
        
    % Generate regressor matrix P
        [P, full_model] = build_NARX_regressor(y,u,ny,nu,nl);
        
    % Train ARX model via LASSO coordinate descent
    for it = 1:iterations
        for j = 1:ny+nu+1
            % STEP 1 - calculate rho(j)
            rho(j) = P(:,j)' * ( y(max(nu,ny)+1:length(y)) - P*theta + theta(j)*P(:,j) );

            % STEP 2 - calculate z(j)
            z(j) = P(:,j)'*P(:,j);

            % STEP 3 - Update theta(j)
            theta(j) = wthresh(rho(j),'s', lambda)/z(j);
%             fprintf('theta(%d) = %f\n', j, theta(j));    
        end
    end
end

