%% Script to use associated simulink block to compare vaccuum vs air
%% statistics within bounds and generate look-up table 

clc;
clear all;

%% Model parameters

m = 0.032;
g = 9.81;
radius_projectile = 16.8 / 2;
air_viscosity = 1.81e-5;
medium_viscosity = air_viscosity;
limiting_v = 30;
ground_level = -1;
aor = -10;
vx = limiting_v * cosd(aor);
vy = limiting_v * sind(aor);

%% Simulation parameters

t_final = 10;
t_step_size = 0.001;

%%  Running the simulation with different parameters
medium_viscosity = air_viscosity;

sim_results = sim("ballistic_model.slx");

x_ = sim_results.simout.Data(:, 1);
y_ = sim_results.simout.Data(:, 2);

% changing viscosity
medium_viscosity = 0;

% re-running to get new data
sim_results = sim("ballistic_model.slx");

x = sim_results.simout.Data(:, 1);
y = sim_results.simout.Data(:, 2);

plot(x_, y_);
hold on;
plot(x,y);
grid on;
xlabel("x (m)");
ylabel("y (m)");
title("Checking the projectile path of RM ball")
legend("non-zero drag", "zero drag");
axis([0 max(x) ground_level 10])