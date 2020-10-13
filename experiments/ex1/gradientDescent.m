function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESCENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);


    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %
##for iter = 1:num_iters
##    H = X * theta
##   T = [0 ; 0];
##   for i = 1 : m,
##      T = T + (H(i) - y(i)) * X(i, :)';
##   end
##
##   theta = theta - alpha * T / m;
## 
##    
##
##    % ============================================================
##
##    % Save the cost J in every iteration    
##    J_history(iter) = computeCost(X, y, theta);
##
##end
##
##end
for iter = 1 : num_iters
   theta = theta - alpha * X' * (X * theta - y) / m
##   J_history(iter) = computeCost(X, y, theta);
endfor
fprintf('梯度下降1500次后的theta:\n')
