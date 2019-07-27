% Author: Jose Reinaldo da C.S.A.V.S Neto
% University of Brasilia
%
% Create Multi-Layer Perceptron Neural Network model 
function [ net, y_net ] = MLP( y, u, ny, nu, q_neuron )
    % Define network structure
    net.iw = rand(q_neuron, ny+nu);    % Weigth from input to hidden layer connections
    net.lw = rand(q_neuron, 1);        % Weigth from hidden to output layer connections
    net.b = cell(2,1);                  % Bias for hidden and output layer neurons
    net.b{1} = zeros(q_neuron,1);
    net.b{2} = 0;
    phi = @tansig;
    
    % Define training parameter
    eta = 0.1;
    
    % Prepare inputs to neural network
    I = build_ARX_regressor( y, u, ny, nu );
    I = I(:, 2:size(I,2));
    
    % Train network structure through error backpropagation
    for i=1:size(I,1)
        H = phi(net.iw*I(i,:)' + net.b{1}); % output of neurons on hidden layer
        O = H'*net.lw + net.b{2};           % output of neuron on output layer
        E = (O - y(i+max(ny,nu)));         % Error between neural network model and real system
        delta_lw = E*H;
        delta_iw = E*net.lw.*H.*(1-H)*I(i,:);
        delta_b{2} = E;
        delta_b{1} = E*net.lw.*H.*(1-H);
        
        net.iw = net.iw - eta*delta_iw;
        net.lw = net.lw - eta*delta_lw;
        net.b{1} = net.b{1} - eta*delta_b{1};
        net.b{2} = net.b{2} - eta*delta_b{2};
    end
    
    % Simulation
    for i=1:size(I,1)
        y_net(i+max(ny,nu)) = phi(net.iw*I(i,:)'+net.b{1})'*net.lw + net.b{2};
    end

end