function [ updated_sspace ] = UpdateBelief( currentVx, currentVy, Vx, Vy, sspace, appForce, gen )
% UPDATEBELIEF updates the belief

% INPUT:
%   - Prior (state space)
%   - current state (velocity, x component)
%   - current state (velocity, y component)
%   - Vx vector
%   - Vy vector

% OUTPUT:
%   - Updated state spae

step           = abs(Vx(1)-Vx(2));
currentState   = [currentVx, currentVy];
likelihood     = zeros(length(Vx), length(Vy));
posterior      = zeros(length(Vx), length(Vy));
updated_sspace = zeros(size(sspace));

for indx = 1:length(Vx)
    for indy = 1:length(Vy)
        
        % compute likelihood
        mu = [Vx(indx), Vy(indy)];
        sigma = [1 0;0 1]; % sigma represent the uncertainty in our inference!
        likelihood(indx, indy) = mvnpdf(currentState, mu, sigma);
        
        prior_mu = [sspace(1,1,indx, indy), sspace(2,1,indx, indy)];
        prior_sigma = [sspace(1,2,indx, indy) 0; 0 sspace(2,2,indx, indy)];
        
        % compute normalizaton factor
        Pv = Pv + liklihood(indx, indy) *...
             mvnpdf([Fx(indx) Fy(indy)], prior_mu, prior_sigma)...
             * step^2;
        
        % compute posterior
        posterior(indx, indy) = likelihood(indx, indy) * mvnpdf([Fx(indx) Fy(indy)],...
                                prior_mu, prior_sigma);                                     
        
    end
end
% posterior = poterior / Pv; % this posterior is only for a one state
% we should find the index of the state (or the closest state), and update
% its mu and sigma according to the posterior!

% generalization is left to be completed.
% for this purpose we can define a Gaussian, which must be normalized
% between 0 and 1. 

% surf(Vx, Vy, likelihood);
end

