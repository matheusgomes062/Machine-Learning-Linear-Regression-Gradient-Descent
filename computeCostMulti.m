function J = computeCostMulti(X, y, theta)
%   COMPUTECOSTMULTI Compute cost for linear regression with multiple variables
%   J = COMPUTECOSTMULTI(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;

% This is vectorized version of J's computation
% Note that we are using element-wise square ( .^ ) instead of matrix
% multiplicationi ( ^ ).
% page 13
J = 1/(2 * m) * sum((X*theta - y) .^ 2);



% =========================================================================

end
