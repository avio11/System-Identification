% LASSO for linear ARX models
function [ theta ] = LASSO( y, u, ny, nu )
    % Parameters of the LASSO
        theta = zeros(ny+nu+1,1);     % Coeficients of the model
        lambda = 1;
        iterations = 5;
        
    % Generate regressor matrix P
        P = build_ARX_regressor(y,u,ny,nu);
        
    % Train ARX model via LASSO coordinate descent
    for it = 1:iterations
        for j = 1:ny+nu+1
            % STEP 1 - calculate rho(j)
            rho(j) = P(:,j)' * ( y(max(nu,ny)+1:length(y)) - P*theta + theta(j)*P(:,j) );

            % STEP 2 - calculate z(j)
            z(j) = P(:,j)'*P(:,j);

            % STEP 3 - Update theta(j)
            theta(j) = wthresh(rho(j),'s', lambda);
%             fprintf('theta(%d) = %f\n', j, theta(j));    
        end
    end
end

