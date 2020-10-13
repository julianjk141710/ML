function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
addOnes1 = ones(size(X, 1), 1);
newX = [addOnes1 X];
hiddenLayer2 = sigmoid(newX * Theta1');
addOnes2 = ones(size(hiddenLayer2, 1), 1);
newHiddenLayer2 = [addOnes2 hiddenLayer2];
outputLayer = sigmoid(newHiddenLayer2 * Theta2');

for i = 1:m
    for k = 1:num_labels
        if y(i) == k
            J = J - log(outputLayer(i, k));
        else
            J = J - log(1 - outputLayer(i, k));
        end
    end
end
J = J / m;
Theta1RowSize = size(Theta1, 1);
Theta1ColSize = size(Theta1, 2);

Theta2RowSize = size(Theta2, 1);
Theta2ColSize = size(Theta2, 2);

Theta1Sum = 0;
Theta2Sum = 0;
ThetaSum = 0; 
for j = 1 : Theta1RowSize
    for k = 2 : Theta1ColSize
        Theta1Sum = Theta1Sum + Theta1(j, k)^2; 
    end
end

for j = 1 : Theta2RowSize
    for k = 2 : Theta2ColSize
        Theta2Sum = Theta2Sum + Theta2(j, k)^2; 
    end
end

ThetaSum = (Theta1Sum + Theta2Sum) * lambda / (2 * m);
J = J + ThetaSum;

Delta1 = 0;
Delta2 = 0;
for t = 1 : m
    %step1
    a1 = [1 X(t,:)];
    z2 = a1 * Theta1';
    a2 = sigmoid(z2);
    a2 = [1 a2];
    z3 = a2 * Theta2';
    a3 = sigmoid(z3);
    %step2
    tempa = 1 : num_labels;
    tempb = y(t);
    tempa = (tempa == tempb);
    delta3 = a3 - tempa;
    %step3
    delta2 = (delta3 * Theta2(:,2:end)) .* sigmoidGradient(z2);
    %step4

    Delta1 = Delta1 + delta2' * a1;
    Delta2 = Delta2 + delta3' * a2;
end
Theta1_grad = Delta1 ./ m;
Theta2_grad = Delta2 ./ m;

for i = 1 : size(Theta1_grad, 1)
    for j = 2 : size(Theta1_grad, 2)
        Theta1_grad(i, j) = Theta1_grad(i, j) + Theta1(i, j) * lambda / m;
    end
end
for i = 1 : size(Theta2_grad, 1)
    for j = 2 : size(Theta2_grad, 2)
        Theta2_grad(i, j) = Theta2_grad(i, j) + Theta2(i, j) * lambda / m;
    end
end









% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
