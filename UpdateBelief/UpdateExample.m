%%
% This code contains an example of updating the brior for every state
% we need to creat a 4D matrix which coontains every state in 
%
% This piece of code must be able to update and viualize the state space,
% as well as the force distribution of each state
%
%%
% Since we are assuming Gaussian distributions, we eill represent any
% Gaussian distribution using a mean and variance.So, our state space for 
% mean, as well as variance, would have 4 dimensions: (2, 2, Vx, Vy). 
% The "2" is because we have mean, and variance, for Fx and Fy (multivariate Gaussian)

% Example: a specific point in state space would have a specific Vx and Vy,
% and for this specific state we have a 2D distribution of force (X and Y).

% let's try out a gaussian
fx = -5:0.1:5; fx_mu = 3; fx_sigma = 1;
fy = -5:0.1:5; fy_mu = 0; fy_sigma = 1;
F = Gauss2d( fx, fx_mu, fx_sigma, fy, fy_mu, fy_sigma);

figure; % two different ways to display the distribution
subplot(121); surf(fx, fy, F); xlabel('F_x'); ylabel('F_y');
subplot(122); imagesc(fx, fy, F); xlabel('F_x'); ylabel('F_y'); axis xy

%% 

% what are informations that we need to create out state space?
% 1) Maximum and minimum speeds that human exhibit during experiment
% 2) State variable resolution, we could use 0.01! i dont know

Vmin = -5;
Vmax = 5;
Vres = 0.1;
Vx = Vmin:Vres:Vmax; Vy = Vx;
Vsize   = length(Vx);
% /////////////////////////////////////////////////////////////////

% Now, each state needs its own force distribution, so what do we need?
% 1) Max force and min force that subjects exhibit
% 2) Force resolution
% 3) The prior (i.e., the mean for the force distribution)
% 4) Uncertainty in sensory input (the variance in our likelihood)

Fmin = -5;
Fmax = 5;
Fres = 0.1;
Fx = Fmin:Fres:Fmax; Fy = Fx;

% This is what is saved in our implicit memory (assumption)
% These are initially adjusted to whatever we have been training for, 
% it can also be based on textual cue! so we retrieve another set of the
memory     = retrieve_memory(1);
experiment = Exp_params(1);

sspace = zeros(2, 2, Vsize, Vsize);
sspace(:,1,:,:) = memory.Fmus;
sspace(:,2,:,:) = memory.Fsigmas;

% let's change some of the sigma:
% sspace(:, 2, 30:70, 30:70) = 0.5;
sspace(:, 2, :, :) = 0.1;

% Compute ideal force field values for each state
idealF = compIdealF(experiment.compF, Vx, Vy); 

%% Display the state space

sspace_image = showSpace(idealF, sspace);
figure; imagesc(Vx, Vy, sspace_image); xlabel('V_x'); ylabel('V_y'); axis xy
colorbar;

% Display the prior for state with index (50, 50)
% this needs a function!