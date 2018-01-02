%% We'll start by simulating a point mass in 2D and apply a force on it and see the trajectory
clear all;
% NOTE: everthing is represented in rows -> [x, y]

% define mass ad force
m  = 0.150;          % [kg] -> average mass of the hand

% force field
angle = -90;
type = 'NULL'; % 'FORCEFIELD'

% Position Information
startPos  = [0, 0];
targetPos = [0, 10];

% forces
F_error        = [0 0];
F_hand         = [0 0];
F_jerk         = [0 0];
F_forcefield   = [0 0];
F_adapt        = [0 0];
F_total        = [0 0];

% simulation params
dt     = 0.1;    % [s]  -> step size
period = 10; % [s]
N      = ceil(period/dt); 

r         = zeros(N,2); % initial position
r_actual  = zeros(N,2);
v         = zeros(N,2); % initial speed
v_actual  = zeros(N,2);
a         = zeros(N,2); % initial acceleration
a_actual  = zeros(N,2);
adapt_coef = 0; 

% here is were the loop should be implemented
figure; grid; hold on

for i = 2:N

    t = dt*i;
    
    % Minimizing total jerk:
    tau    = t/period;
    r(i,:) = startPos + (startPos-targetPos) .* ...
             (15*tau^4 - 6*tau^5 - 10*tau^3);
    v(i,:) = (startPos-targetPos) .* (60*tau^3/period - 30*tau^4/period ...
              - 30*tau^2/period);
    a(i,:) = (startPos-targetPos) .* (180*tau^2/period^2 - ...
              120*tau^3/period^2 - 60*tau/period^2);

    adapt_coef = adapt_coef + 1/N;
    F_adapt = -adapt_coef*F_forcefield;
    F_jerk  = m.*a(i-1,:);
    F_error = 20.*(r(i-1,:) - r_actual(i-1,:))+ 1.*(v(i-1,:) - v_actual(i-1,:));
    F_hand  = F_jerk + F_error + F_adapt;
    F_total = F_hand + F_forcefield;
    
    a_T = 0.01*F_total./m;
    
    v_actual(i,:) = v_actual(i-1,:) + a_T*dt;  % 1st equation of motion
    r_actual(i,:) = r_actual(i-1,:) + v_actual(i-1,:)*dt + a_T*dt^2;
    a_actual(i,:) = (v_actual(i,:) - v_actual(i-1,:))/dt;

    % draw the trajectory
    scatter(r_actual(i,1), r_actual(i,2), 'o'); xlim([-10,10]); ylim([-5,15]);
    % draw the start and target points
    scatter(startPos(1), startPos(2), 'filled', 'k');
    scatter(targetPos(1), targetPos(2), 'filled', 'r');
    % draw the force direction
    F_forcefield = 20*rotateMat(v_actual(i-1,:), angle); %(rand(1,2)-0.5)./10
end

figure;
plot(sqrt(r_actual(:,1).^2 + r_actual(:,2).^2)); hold on
plot(sqrt(v_actual(:,1).^2 + v_actual(:,2).^2));
plot(sqrt(a_actual(:,1).^2 + a_actual(:,2).^2))
