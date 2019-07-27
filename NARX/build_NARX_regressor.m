% Author: Jose Reinaldo da C.S.A.V.S. Neto
% University of Brasilia
% Function to create ARX regressor matrix "P"
function [ P, full_model ] = build_NARX_regressor( y, u, ny, nu, nl )

full_model = [];
P = [];

% Generate all parameter combinations (input, output, error)
aux_p_index = variable_for_loop(1, zeros(1,ny+nu), ny+nu, nl);
for i=1:size(aux_p_index,1)
    full_model = [full_model;unique(perms(aux_p_index(i,:)), 'rows')];
end
full_model = [zeros(1,ny+nu);full_model]; % Adding constant term to the NARX model

% Generate Regressor Matrix
for i=max(ny,nu)+1:length(y)
    xi = [y(i-1:-1:i-nu);u(i-1:-1:i-ny)];
    for j=1:size(full_model,1)
        P(i-max(nu,ny),j) = prod(xi'.^full_model(j,:));
    end
end

end

% Nested FOR loops function of variable size
function [ aux ] = variable_for_loop(iteracao, estrutura, tam, nl)

aux = [];

for i=1:size(estrutura,1)
    if iteracao ~= 1
        for j=0:estrutura(i,iteracao-1)
            estrutura(i,iteracao) = j;
            if(sum(estrutura(i,:))<=nl)
                aux = [aux;estrutura(i,:)];
            end
        end
    else
        for j=1:nl
            estrutura(i,iteracao) = j;
            aux = [aux;estrutura(i,:)];
        end
    end
end
if iteracao ~= tam
    aux = variable_for_loop(iteracao+1, aux, tam, nl);
end

end