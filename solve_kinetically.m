function [solution_vector] = solve_kinetically(theta_2, theta_2_dot, theta_2_ddot, link3_info, R, phy_prop)


% SOLVE_KINETICALLY Summary of this function goes here
%   Detailed explanation goes here


% Calculate mass of each link

diameter = phy_prop(1);
density = phy_prop(2);
face_area = pi * (diameter/2)^2;
r2 = R(2);
rbc = R(3);
r3 = link3_info(1, :);

m2 = face_area * r2;
mbc = face_area * rbc;
m4 = phy_prop(3);

% Calculate Moment of Inertia of each link
Io2 = (1/3) * m2 * r2.^2;
Ig3 = (1/12) * mbc * r3.^2;

% Calculate Midpoint of each link
b2 = r2/2;
b3 = rbc/2;

% Info about theta_3 is solved in solve_kinematically() function
theta_3 = link3_info(2,:);
theta_3_dot = link3_info(4,:);
theta_3_ddot = link3_info(6,:);


% Solving Link 2

Ag3x = (-r2 * theta_2_ddot * sind(theta_2)) + (-r2 * (theta_2_dot)^2 * cosd(theta_2)) ...
        + ( -b3 * theta_3_ddot .* sind(theta_3) ) + ( -b3 * (theta_3_dot).^2 .* cosd(theta_3));

Ag3y = (r2 * theta_2_ddot * cosd(theta_2)) + (-r2 * (theta_2_dot)^2 * sind(theta_2)) ...
        + ( b3 * theta_3_ddot .* cosd(theta_3) ) + ( -b3 * (theta_3_dot).^2 .* sind(theta_3));
    
M2Ag3x = m2 * Ag3x;
M2Ag3y = m2 * Ag3y;
Io2_theta_2_ddot = Io2 * theta_2_ddot; 


end

