function [C_info] = solve_C(r2, theta_2, theta_2_dot, theta_2_ddot, r_bc, link3_info)

%{

The following function solve displacement, linear velocity and acceleration for point C. 

Input: theta_2 = [0 ... 2π], R = [r1, r2, r4] , theta_2_dot, theta_2_ddot, rbc
       link3_info = [r3, theta_3, r3_dot, theta_3_dot, r3_ddot, theta_3_ddot]
Output: C_info = [c_displacement, c_velocity, c_acceleration]

See derivation...

Rx = ( -r_bc * cos(θ3)) - (r2 * cos(θ2))
Ry = ( r_bc * sin(θ3)) + (r2 * sin(θ2))

Vx = ( (r_bc * θ3_dot * sin(θ3)) + (r2 * θ2_dot * sin(θ2)) )
Vy = ( (r_bc * θ3_dot * cos(θ3)) + (r2 * θ2_dot * cos(θ2)) )

Ax = ( (r_bc * θ3_ddot * sin(θ3)) + (r_bc * θ3_dot^2 * cos(θ3)) ...
        + (r2 * θ2_ddot * sin(θ2)) + (r2 * θ2_dot^2 * cos(θ2)) )
Ay = ( (r_bc * θ3_ddot * cos(θ3)) - (r_bc * θ3_dot^2 * sin(θ3)) ...
        + (r2 * θ2_ddot * cos(θ2)) - (r2 * θ2_dot^2 * sin(θ2)) )

%}

% Info about theta_3 is solved in solve_kinematically() function
theta_3 = link3_info(2,:);
theta_3_dot = link3_info(4,:);
theta_3_ddot = link3_info(6,:);

% Position of C
Rx = (-r_bc * cosd(theta_3)) - (r2 * cosd(theta_2));
Ry = (r_bc * sind(theta_3)) + (r2 * sind(theta_2));
R = sqrt( Rx.^2 + Ry.^2 );
R_angle = 180 - acosd(Rx ./ R); % Take obtuse angle

% Velocity of C
Vx = ( (r_bc * theta_3_dot .* sind(theta_3)) + (r2 * theta_2_dot .* sind(theta_2)) );
Vy = ( (r_bc * theta_3_dot .* cosd(theta_3)) + (r2 * theta_2_dot .* cosd(theta_2)) );
V = sqrt( Vx.^2 + Vy.^2 );

% Acceleration of C
Ax = ( (r_bc * theta_3_ddot .* sind(theta_3)) + (r_bc * (theta_3_dot).^2 .* cosd(theta_3)) ...
        + (r2 * theta_2_ddot .* sind(theta_2)) + (r2 * (theta_2_dot).^2 .* cosd(theta_2)) );
Ay = ( (r_bc * theta_3_ddot .* cosd(theta_3)) - (r_bc * (theta_3_dot).^2 .* sind(theta_3)) ...
        + (r2 * theta_2_ddot .* cosd(theta_2)) - (r2 * (theta_2_dot).^2 .* sind(theta_2)) );
A = sqrt( Ax.^2 + Ay.^2 );


% Calculating Direction for Velocity and Acceleration w.r.t x axis

V_angle = 0 * ones(size(theta_2)); % Take obtuse angle

% Adjust Direction for Positive East and Positive North
Vx = -Vx;
   

for i = 1:length(theta_2)
   
   if Vx(i) >= 0 && Vy(i) >= 0
       V_angle(i) = asind( Vy(i) / V(i) );
       
   elseif Vx(i) < 0 && Vy(i) >= 0
       V_angle(i) = 180 - acosd( Vy(i) / V(i) );
       
    elseif Vx(i) >= 0 && Vy(i) < 0
       V_angle(i) = 360 - acosd( Vx(i) / V(i) );
       
    else    
       V_angle(i) = 180 + acosd( Vx(i) / V(i) );
   end
    

end
    

    
C_info = [R; R_angle; V; V_angle; A; V_angle;];
end

