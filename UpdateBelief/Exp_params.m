function [ params ] = Exp_params( ind )
% Exp_params returns the parameters for a specific experiment
% if no arguement is given the default experiment parameters are returned


% we initialize a struct array. each struct contains the parameters of a
% specific experiment:

% Example: params(1).name contains the name of the 1st experiment setup
%          params(2).rotMat containes the rotation function of the 
%          experiment 2

errmsg = 'Too many The function only gets the index';
assert (nargin < 2, errmsg);    
    

% Experiment 1 parameters
params(1).type    = 'CW';


% Experiment 2 parameters
params(2).type    = 'CCW';




if ~nargin
    % if no arguement was given return experiment 1's parameters
    params = params(1);
elseif nargin > 1
    
else
    params = params(ind);
end

end

