% Author: Jose Reinaldo da C.S.A.V.S. Neto
% University of Brasilia
% Function to create ARX regressor matrix "P"
function [ P ] = build_ARX_regressor( y, u, ny, nu )
    aux = -max(ny,ny);
    for i=max(ny,nu)+1:length(y)
        for j=1:ny+nu
            if j<=ny
                P(i+aux,j) = y(i-j);
            else
                P(i+aux,j) = u(i-j+ny);
            end
        end
    end
   
    P = [ones(length(y)-max(ny,nu),1) P];
end