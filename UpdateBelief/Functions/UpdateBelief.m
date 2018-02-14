function [posteriorSpace] = UpdateBelief( priorSpace, currentState, Fapplied, Generalization )

% Define global and other constant variables
global Vx; global Vy; global Fres;
global Fx; global Fy;
global Likely_sigmas;

posteriorSpace = priorSpace; 

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

for indX = strtVx:endVx
    for indY = strtVy:endVy
        Gcoef = GF(indX, indY); % 1st index: Vx; 2nd index: Vy

        % Sensory information
        Fx_mu_sense  = Fapplied(1);
        Fy_mu_sense  = Fapplied(2);
        Fx_var_sense = (2 - Gcoef) * Likely_sigmas(1,1);
        Fy_var_sense = (2 - Gcoef) * Likely_sigmas(2,2);
    
        % Prior information
        Fx_mu_prior  = squeeze(priorSpace(1, 1, indX, indY));
        Fy_mu_prior  = squeeze(priorSpace(2, 1, indX, indY));
        Fx_var_prior  = squeeze(priorSpace(1, 2, indX, indY));
        Fy_var_prior  = squeeze(priorSpace(2, 2, indX, indY));

        % Gcoef_boundary = ((max(Vx) - abs(currentState(1))) + (max(Vy) - abs(currentState(2))))/(2*mean(max(Vx), max(Vy)));
        Gcoef_boundary = ((50 - abs(currentState(1))) + (50 - abs(currentState(2))))/100;
%         Gcoef_boundary = 0.7;
        if Gcoef > Gcoef_boundary
            Fx_mu_prior  = (Fx_mu_sense * Fx_var_prior + Fx_mu_prior * Fx_var_sense)/(Fx_var_sense + Fx_var_prior);
            Fy_mu_prior  = (Fy_mu_sense * Fy_var_prior + Fy_mu_prior * Fy_var_sense)/(Fy_var_sense + Fy_var_prior);
            Fx_var_prior = (Fx_var_sense * Fx_var_prior)/(Fx_var_sense + Fx_var_prior);
            Fy_var_prior = (Fy_var_sense * Fy_var_prior)/(Fy_var_sense + Fy_var_prior);
        end
        
        % limit the update of posterior
        if Fx_var_prior < 0.2
            Fx_var_prior = .2;
        end
        if Fy_var_prior < 0.2
            Fy_var_prior = .2;
        end

        % update the state space
        posteriorSpace(1,1,indX,indY) = Fx_mu_prior;
        posteriorSpace(1,2,indX,indY) = Fx_var_prior;
        posteriorSpace(2,1,indX,indY) = Fy_mu_prior;
        posteriorSpace(2,2,indX,indY) = Fy_var_prior;
        
    end
end

end

