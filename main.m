clc
clear
close all

%{

The following code will alnalyze the mechanical system with respect to θ_2 

Independant Variable: θ2
Dependant VariableS: θ3, R3

1. Displacement of point C
2. angular velocities and accelerations of all links,
3. Linear velocities and accelerations of point C,
4. Polar plots ofthe forces at all joints and the shaking force,
5. Shaking moment applied from the mechanism to the base

%}

%%%%%%%%%%%%%
% Constants %
%%%%%%%%%%%%%

r1 = 4;
r2 = 5;
r_bc = 20; 
r4 = 12;
R = [r1, r2, r_bc, r4]; % list containing known link lengths
image_num = 1; % ignore, this is the nameing convention for saved plots

theta_1 = 0;
theta_2 = 0:1:360; % Theta two is a list of values from 0 to 360 degrees
theta_4 = 90;

theta_2_dot = 40;
theta_2_ddot = 0;

link_diameter = 0.5;
density = 2.7/15.432; % gr/cm^3 -> g/cm^3
m4 = 5/15.432; % gr -> g
phy_prop = [link_diameter, density, m4];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solving Kinematically (Chp. 5) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

link3_info = solve_kinematically(theta_2, R, theta_2_dot, theta_2_ddot);

% Unpacking link3_info, a list containing [r3 , θ3, r3_dot, theta_3_dot, r3_ddot, theta_3_ddot]

r3 = link3_info(1,:);
theta_3 = link3_info(2,:);
r3_dot = link3_info(3,:);
theta_3_dot = link3_info(4,:);
r3_ddot = link3_info(5,:);
theta_3_ddot = link3_info(6,:);

% θ2 vs θ3_dot
plot(theta_2, theta_3_dot, '-b');
title('Angle of Link 2 (θ2) vs. Angular Velocity of Link 3 (rad/s)');
grid('on');
xlabel('Angle of Link 2 (°)');
ylabel('Angular Velocity of Link 3 (rad/s)');
ax = gca; % Save image
ttl = sprintf('plots/plot_%d.png', image_num);
exportgraphics(ax,ttl);
image_num = image_num +1;

% θ2 vs θ3_ddot
plot(theta_2, theta_3_ddot, '-m');
title('Angle of Link 2 (θ2) vs. Angular Acceletation of Link 3 (rad/s^s)');
grid('on');
xlabel('Angle of Link 2 (°)');
ylabel('Angular Acceletation of Link 3 (rad/s^s)');
ax = gca; % Save image
ttl = sprintf('plots/plot_%d.png', image_num);
exportgraphics(ax,ttl);
image_num = image_num +1;

%%%%%%%%%%%%%%%%%%%%%
%  Solving Point C  %
%%%%%%%%%%%%%%%%%%%%%

[C_info, v_d_pts, a_d_pts] = solve_C(r2, theta_2, theta_2_dot, theta_2_ddot, r_bc, link3_info);

% θ2 vs Displacement of Point C
plot(theta_2, C_info(1,:), '-b');
title('Angle of Link 2 (θ2) vs. Displacement of Point C (Rc)');
grid('on');
xlabel('Angle of Link 2 (°)');
ylabel('Displacement of Point C (cm)');
ax = gca; % Save image
ttl = sprintf('plots/plot_%d.png', image_num);
exportgraphics(ax,ttl);
image_num = image_num +1;

% θ2 vs Direction Angle of Point C
plot(theta_2, C_info(2,:), '-m');
title('Angle of Link 2 (θ2) vs. Direction Angle of Point C (θc)');
grid('on');
xlabel('Angle of Link 2 (°)');
ylabel('Displacement of Point C (°)');
ax = gca; % Save image
ttl = sprintf('plots/plot_%d.png', image_num);
exportgraphics(ax,ttl);
image_num = image_num +1;

% θ2 vs Velocity of Point C
plot(theta_2, C_info(3,:), '-b');
title('Angle of Link 2 (θ2) vs. Velocity of Point C (Rc)');
grid('on');
xlabel('Angle of Link 2 (°)');
ylabel('Velocity of Point C (cm/s)');
ax = gca; % Save image
ttl = sprintf('plots/plot_%d.png', image_num);
exportgraphics(ax,ttl);
image_num = image_num +1;

% θ2 vs Direction of Velocity for Point C
plot(theta_2, C_info(4,:), '-m');
title('Angle of Link 2 (θ2) vs. Direction of Velocity for Point C');
grid('on');
xlabel('Angle of Link 2 (°)');
ylabel('Direction of Velocity for Point C (°)');
for i = 1:length(v_d_pts)
    xline(v_d_pts(i),'--')
end
ax = gca; % Save image
ttl = sprintf('plots/plot_%d.png', image_num);
exportgraphics(ax,ttl);
image_num = image_num +1;

% θ2 vs Acceleration of Point C
plot(theta_2, C_info(5,:), '-b');
title('Angle of Link 2 (θ2) vs. Acceleration of Point C (Rc)');
grid('on');
xlabel('Angle of Link 2 (°)');
ylabel('Acceleration of Point C (cm/s^2)');
ax = gca; % Save image
ttl = sprintf('plots/plot_%d.png', image_num);
exportgraphics(ax,ttl);
image_num = image_num +1;

% θ2 vs Direction of Acceleration for Point C
plot(theta_2, C_info(6,:), '-m');
title('Angle of Link 2 (θ2) vs. Direction of Acceleration for Point C');
grid('on');
xlabel('Angle of Link 2 (°)');
ylabel('Direction of Acceleration for Point C (°)');
for i = 1:length(a_d_pts)
    xline(a_d_pts(i),'--')
end
ax = gca; % Save image
ttl = sprintf('plots/plot_%d.png', image_num);
exportgraphics(ax,ttl);
image_num = image_num +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solving Kinetically (Chp. 5) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%solution_vector = solve_kinetically(theta_2, theta_2_dot, theta_2_ddot, link3_info, R, phy_prop);



