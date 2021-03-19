function [solution_vector] = solve_kinetically(theta_2, theta_2_dot, theta_2_ddot, link3_info, R, phy_prop)

%{

The following function will analyze the mechanical system kinetically 
with respect to θ2. Solve for summation of forces and moments for the RHS
of matrix.

Input: theta_2 = [0 ... 2π], theta_2_dot, theta_2_ddot,
                 link3_info = [r3, theta_3, r3_dot, theta_3_dot, r3_ddot, theta_3_ddot],
                 R = [r1, r2, r_bc, r4], phy_prop = [link_diameter, density, m4]

Output: solution_vector = [M2Ag2x; M2Ag2y; Io2_theta_2_ddot; MbcAg3x; ...
                           MbcAg3y; Ig3_theta_3_ddot; M4Ag4x; M4Ag4y];
%}

% Calculate mass of each link using physical properties
diameter = phy_prop(1);
density = phy_prop(2);
face_area = pi * (diameter/2)^2;
r2 = R(2);
rbc = R(3);
r3 = link3_info(1, :);

m2 = face_area * r2 * density;
mbc = face_area * rbc * density;

% Calculate Moment of Inertia of each link
Io2 = (1/3) * m2 * r2^2;
Ig3 = (1/12) * mbc * rbc^2;

% Calculate Midpoint Length of each link
b2 = r2/2;
b3 = rbc/2;

% Info about theta_3 is solved in solve_kinematically() function
theta_3 = link3_info(2,:);
theta_3_dot = link3_info(4,:);
theta_3_ddot = link3_info(6,:);

%%%%%%%%%%%%%%%%%%
% Solving Link 2 %
%%%%%%%%%%%%%%%%%%

Ag2x = (-b2 * theta_2_ddot * sind(theta_2)) + ( -b2 * (theta_2_dot)^2 * cosd(theta_2));
Ag2y = ( b2 * theta_2_ddot * cosd(theta_2)) + ( -b2 * (theta_2_dot)^2 * sind(theta_2));
    
M2Ag2x = m2 * Ag2x;
M2Ag2y = m2 * Ag2y;
Io2_theta_2_ddot = (Io2 * theta_2_ddot) * ones(size(theta_2)); % Make a vector making size theta_2


%%%%%%%%%%%%%%%%%%
% Solving Link 3 %
%%%%%%%%%%%%%%%%%%

Ag3x = (-r2 * theta_2_ddot * sind(theta_2)) + (-r2 * (theta_2_dot)^2 * cosd(theta_2)) ...
        + ( -b3 * theta_3_ddot .* sind(theta_3) ) + ( -b3 * (theta_3_dot).^2 .* cosd(theta_3));

Ag3y = (r2 * theta_2_ddot * cosd(theta_2)) + (-r2 * (theta_2_dot)^2 * sind(theta_2)) ...
        + ( b3 * theta_3_ddot .* cosd(theta_3) ) + ( -b3 * (theta_3_dot).^2 .* sind(theta_3));
    
MbcAg3x = mbc * Ag3x;
MbcAg3y = mbc * Ag3y;

Ig3_theta_3_ddot = (Ig3 * theta_3_ddot); 

%%%%%%%%%%%%%%%%%%
% Solving Link 4 %
%%%%%%%%%%%%%%%%%%

% Link Four is assumed to be not accelerating

M4Ag4x = zeros(size(theta_2));
M4Ag4y = zeros(size(theta_2));

solution_vector = [M2Ag2x; M2Ag2y; Io2_theta_2_ddot; MbcAg3x; ...
                    MbcAg3y; Ig3_theta_3_ddot; M4Ag4x; M4Ag4y];
end

