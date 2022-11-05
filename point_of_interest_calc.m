%% Script to use associated simulink block to compare vaccuum vs air
%% statistics within bounds and generate look-up table 

clc;
clear all;

%% Model parameters

m = 0.032;
g = 9.81;
radius_projectile = 16.8 / 2;  % from 17mm projectile info
air_viscosity = 1.81e-5;
medium_viscosity = air_viscosity;
limiting_v = 30;               % velocity limit of referee system
ground_level = -1;
aor = 10;                      % angle of release
vx = limiting_v * cosd(aor);
vy = limiting_v * sind(aor);

%% Simulation parameters

t_final = 10;
t_step_size = 0.001;

error = [];
angle = [];

%%  Running the simulation with different parameters

aor_upper_limit = 30;
aor_lower_limit = -10;

poi = 5;

for aor_x = linspace(aor_lower_limit, aor_upper_limit, 50)

aor = aor_x;
vx = limiting_v * cosd(aor);
vy = limiting_v * sind(aor);

medium_viscosity = air_viscosity;

sim_results = sim("ballistic_model.slx");

x_ = sim_results.simout.Data(:, 1);
y_ = sim_results.simout.Data(:, 2);

[y_d, v_d] = intersection_y_plane(x_, y_, poi);

% changing viscosity
medium_viscosity = 0;

% re-running to get new data
sim_results = sim("ballistic_model.slx");

x = sim_results.simout.Data(:, 1);
y = sim_results.simout.Data(:, 2);

[y_nd, v_nd] = intersection_y_plane(x,y,poi);

if(v_d == 0 | v_nd == 0)
    error(end+1) = -1;
else
    error(end+1) = y_nd - y_d;
end
angle(end+1) = aor_x;

end

%% Results of Analysis

plot(angle, error, "rx");
grid on;
xlabel("Angle (degrees)");
ylabel("Error (m)");
title(sprintf("Error b/w no drag and drag models at %d m with angle sweep [-10, 30]", poi));