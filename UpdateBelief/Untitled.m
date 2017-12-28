step = 0.1;
Vx = -5:step:5;
Vy = Vx;

currentState = [0,0];
likelihood = zeros(length(Vx), length(Vy));
posterior = zeros(length(Vx), length(Vy));
Pv = 0;
for indx = 1:length(Vx)
    for indy = 1:length(Vy)
        
        % compute likelihood
        mu = [Vx(indx), Vy(indy)];
        sigma = [1 0;0 1];
        likelihood(indx, indy) = mvnpdf(currentState, mu, sigma);
        
%         prior_mu = [sspace(1,1,indx, indy), sspace(2,1,indx, indy)];
%         prior_sigma = [sspace(1,2,indx, indy) 0; 0 sspace(2,2,indx, indy)];
%         
%         % compute normalizaton factors
%         Pv = Pv + liklihood(indx, indy) *...
%              mvnpdf([Fx(indx) Fy(indy)], prior_mu, prior_sigma)...
%              * step^2;
%                                               
%         posterior(indx, indy) = likelihood(indx, indy) * mvnpdf([Fx(indx) Fy(indy)], prior_mu, prior_sigma);                                     
        
    end
end
% posterior = poterior / Pv;

surf(Vx, Vy, likelihood);
