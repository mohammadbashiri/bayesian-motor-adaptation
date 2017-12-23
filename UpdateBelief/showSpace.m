function [ sspace_image ] = showSpace( sspace )
%SHOWSPACE Summary of this function goes here
%   Detailed explanation goes here
Vsize = size(sspace, 3);
sspace_image = zeros(Vsize, Vsize);

for indVx = 1:Vsize
    for indVy = 1:Vsize
        
        F = sspace(:,:,indVx, indVy);
        sspace_image(indVx, indVy) = max(F(:));
        
    end
end

end

