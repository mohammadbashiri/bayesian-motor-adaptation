function [ params ] = Exp_params( varargin )
% Exp_params returns the parameters for a specific experiment
% if no arguement is given the default experiment parameters are returned


% we initialize a struct array. each struct contains the parameters of a
% specific experiment:

% Example: params(1).name contains the name of the 1st experiment setup
%          params(2).rotMat containes the rotation function of the 
%          experiment 2

% I have initiated the function accepting variable number of arguements,
% maybe for later is useful. but for now we will limit the number of
% inputs.
errmsg = strcat('\nToo many arguements. The function only gets one input.',...
                '\n\nExample: \n \t exp = Exp_params(2)',...
                '\n\nThis saves the parameters of experiemnt 2 in exp');
assert (length(varargin) < 2, sprintf(errmsg));    
    

% Experiment 1 parameters
params(1).type    = 'CW';


% Experiment 2 parameters
params(2).type    = 'CCW';



ind = varargin{1};
if ~nargin
    % if no arguement was given return experiment 1's parameters
    params = params(1);
elseif nargin > 1
    
else
    params = params(ind);
end

end

