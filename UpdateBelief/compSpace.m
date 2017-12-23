function [ sspace ] = compSpace( Fmin, Fmax, Fres, Vmin, Vmax, Vres, Fmus, Fsigmas )
%COMPSPACE Summary of this function goes here
%   Detailed explanation goes here

Fx = Fmin:Fres:Fmax; 
Fy = Fx; Fsize = length(Fx);

Vx = Vmin:Vres:Vmax;
Vy = Vx; Vsize = length(Vx);

sspace = zeros(Fsize, Fsize, Vsize, Vsize);

for indVx = 1:length(Vx)
    for indVy = 1:length(Vy)
        
        F = Gauss2d( Fx, Fmus(1, indVx, indVy), Fsigmas(1, indVx, indVy),...
                     Fy, Fmus(2, indVx, indVy), Fsigmas(2, indVx, indVy));
        
        sspace(:,:,indVx, indVy) = F;
        
    end
end
        
end

