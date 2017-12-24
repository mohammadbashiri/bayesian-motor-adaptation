function [ sspace_image ] = showSpace( sspace )
%SHOWSPACE Summary of this function goes here
%   Detailed explanation goes here
Vsize = size(sspace, 3);
sspace_image = zeros(Vsize, Vsize);

for indVx = 1:Vsize
    for indVy = 1:Vsize
        
        mu    = [sspace(1,1,indVx, indVy), sspace(2,1,indVx, indVy)];
        Sigma = [sspace(1,2,indVx, indVy) 0; 0 sspace(2,2,indVx, indVy)];
        sspace_image(indVx, indVy) = mvnpdf(mu, mu, Sigma);
        
    end
end

end

