function [ ] = print_term_coeff( full_model, theta, str, ny, nu )

    fprintf('\n\nCoefficients for NARX %s model\n', str);

    % Print of parameters and respective terms
    fprintf('\t\t\t\t\t[');
    for i=1:ny
        fprintf('\ty[k-%d]', i);
    end
    for i=1:nu
        fprintf('\tu[k-%d]', i);
    end
    fprintf(']\n');
    for i=1:size(full_model,1)
       fprintf('%.4f\t\t\t\t[', theta(i));
       for j=1:size(full_model,2)
           fprintf('\t\t%d ', full_model(i,j));
       end
       fprintf(']\n');
    end
end