function [posteriorSpace] = UpdateBelief( priorSpace, currentState, Fapplied, Generalization )
%UPDATEBELIEF Summary of this function goes here
%   Detailed explanation goes here

%% Define global and other constant variables

global Vx; global Vy; global Fres;
global Fx; global Fy;
global Likely_sigmas;

posteriorSpace = priorSpace; 
%%%likelihood = compLikelihood(Fapplied);  % 1st index: Fy; 2nd index: Fx

%% Update current state in with/without generalization
%%% Three percentage comments have been made by Pranshul

GF = compGF(currentState);

if (Generalization == true)
    strtVx = 1; 
    endVx  = length(Vx);
    strtVy = 1;
    endVy  = length(Vy);
else
    [indX, indY] = findStateInd(currentState);
    strtVx = indX;
    endVx  = indX;
    strtVy = indY;
    endVy  = indY;
end

%for indX = strtVx:endVx   Incorrect (Pranshul)
for indX = strtVx:endVx
%    for indY = strtVy:endVy  Incorrect (pranshul)
    for indY = strtVy:endVy
        Gcoef = GF(indX, indY); % 1st index: Vx; 2nd index: Vy
%         Gcoef = 1;
%%%        stateLikelihood = likelihood * Gcoef;  % TODO: replace with Gcoef.

%%%        priorBelief = buildPriorBelief(indX, indY, priorSpace); % 1st index: Fy; 2nd index: Fx 
%  
%         disp('in update: before')
%         priorSpace(:,1,indX,indY)
        
%%%        posteriorBelief = stateLikelihood * 10 .* priorBelief; %  1st index: Fy; 2nd index: Fx

%%%        pState = sum(posteriorBelief(:)) * Fres^2;            
%%%        posteriorBelief = posteriorBelief/pState;

        
        
%         figure; 
%         subplot(311); surf(priorBelief); shading interp; view(2); axis tight
%         subplot(312); surf(stateLikelihood); shading interp; view(2); axis tight
%         subplot(313); surf(posteriorBelief); shading interp; view(2); axis tight
%         


%%%         pFx      = sum(posteriorBelief, 2)';
%%%         pFx      = pFx/sum(pFx);
%%%         Fx_mu    = sum(Fx.*pFx);
%%%         Fx_ex2   = sum(Fx.^2.*pFx);
%%%         Fx_sigma = Fx_ex2 - Fx_mu;
         
 
%%%         pFy      = sum(posteriorBelief, 1);
%%%         pFy      = pFy/sum(pFy);
%%%         Fy_mu    = sum(Fy.*pFy);
%%%         Fy_ex2   = sum(Fy.^2.*pFy);
%%%         Fy_sigma = Fy_ex2 - Fy_mu;


%         figure;
%         subplot(121); plot(Fx, pFx);
%         subplot(122); plot(Fy, pFy);

%       Sensory information    (Pranshul added)
        Fx_mu_sense  = Fapplied(1);
        Fy_mu_sense  = Fapplied(2);
        Fx_var_sense = (2 - Gcoef) * Likely_sigmas(1,1);
        Fy_var_sense = (2 - Gcoef) * Likely_sigmas(2,2);
    
        
%       Prior information (Pranshul added)
        Fx_mu_prior  = squeeze(priorSpace(1, 1, indX, indY));
        Fy_mu_prior  = squeeze(priorSpace(2, 1, indX, indY));
        Fx_var_prior  = squeeze(priorSpace(1, 2, indX, indY));
        Fy_var_prior  = squeeze(priorSpace(2, 2, indX, indY));

%       calculation of new parameters: http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.583.3007&rep=rep1&type=pdf
            
        % (Bashiri):
        % 1. Gcoef cannot be added like this!
        % 2. we need the variance (std ^ 2), so i removed the sqrt.

        if Gcoef > 0.7
            Fx_mu_prior  = (Fx_mu_sense * Fx_var_prior + Fx_mu_prior * Fx_var_sense)/(Fx_var_sense + Fx_var_prior);
            Fy_mu_prior  = (Fy_mu_sense * Fy_var_prior + Fy_mu_prior * Fy_var_sense)/(Fy_var_sense + Fy_var_prior);
            Fx_var_prior = (Fx_var_sense * Fx_var_prior)/(Fx_var_sense + Fx_var_prior);
            Fy_var_prior = (Fy_var_sense * Fy_var_prior)/(Fy_var_sense + Fy_var_prior);
        end
        
        if Fx_var_prior < 0.2
            Fx_var_prior = .2;
        end
        if Fy_var_prior < 0.2
            Fy_var_prior = .2;
        end

        posteriorSpace(1,1,indX,indY) = Fx_mu_prior;
        posteriorSpace(1,2,indX,indY) = Fx_var_prior;
        posteriorSpace(2,1,indX,indY) = Fy_mu_prior;
        posteriorSpace(2,2,indX,indY) = Fy_var_prior;
        
    end
end

end

