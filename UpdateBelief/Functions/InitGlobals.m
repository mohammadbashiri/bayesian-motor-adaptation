function [ ] = InitGlobals()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global Vmin; Vmin = -5;
global Vmax; Vmax = 5;
global Vres; Vres = 0.1;

global Vx; Vx = Vmin:Vres:Vmax;
global Vy; Vy = Vx;

global Fmin; Fmin = -50;
global Fmax; Fmax = 50;
global Fres; Fres = 0.1;

global Fx; Fx = Fmin:Fres:Fmax;
global Fy; Fy = Fx;

sensory_sigma = 50;
gen_sigma = 5;
global Likely_sigmas; Likely_sigmas = [sensory_sigma 0; 0 sensory_sigma];
global GF_sigmas; GF_sigmas = [gen_sigma 0; 0 gen_sigma];

global m; m = 0.150; % hand mass [kg]

end

