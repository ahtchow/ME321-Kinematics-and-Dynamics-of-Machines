function A = get_A_matrix(theta_2, theta_d, r3, theta_3, R)

%{

The following function will determine the coefficients matrix A for the system of linear equations. 

Input: theta_2 = [0 ... 2π], theta_d, r3, theta_3, R = = [r1, r2, r_bc, r4]

Output: A 

%}

% Unpack Lengths
r2 = R(2);
rbc = R(3);
b3 = rbc/2;

% Determining Coefficients
M34 = r2 * sind(theta_2);
M35 = -r2 * cosd(theta_2);

M46 = cosd(theta_d);
M56 = sind(theta_d);

M65 = -b3 * cosd(theta_3);
M64 = b3 * sind(theta_3);
M66 = r3 - b3;

M76 = cosd(theta_3 - 90);
M86 = sind(theta_3 - 90);

% Polupate the matrix with your hand derivations:

A = [ ...
     1  0  0   -1    0    0    0   0;...
     0  1  0    0   -1    0    0   0;...
     0  0  1  M34  M35    0    0   0;...
     0  0  0    1    0  M46    0   0;...
     0  0  0    0    1  M56    0   0;...
     0  0  0  M64  M65  M66    0   0;...
     0  0  0    0    0  M76   -1   0;...
     0  0  0    0    0  M86    0  -1 ...
    ];

end