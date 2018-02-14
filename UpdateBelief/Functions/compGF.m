function GF = compGF( currentState )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

global Vx; global Vy; global GF_sigmas;

[indX, indY] = findStateInd(currentState);

currentStateX = Vx(indX);
currentStateY = Vy(indY);

GF_mus = [currentStateX, currentStateY];

[VX, VY] = meshgrid(Vx, Vy);
GF = mvnpdf([VX(:), VY(:)], GF_mus, GF_sigmas);

GF = reshape(GF, length(Vy), length(Vx))';
GF = GF/max(GF(:)); % normalization between 0 and 1

end