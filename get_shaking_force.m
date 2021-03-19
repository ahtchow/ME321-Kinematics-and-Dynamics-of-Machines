function [Fs,Fs_angle] = get_shaking_force(F21x,F21y, F41x, F41y)

%{

The following function will calculate the shaking force with respect to the wall. 

Input: F21x, F21y, F41x, F41y

Output: Fs, Fs_angle

%}

Fsx = F21x + F41x;
Fsy = F21y + F41y;

% Magnitude
Fs = sqrt( (Fsx).^2 + (Fsy).^2 );

Fs_angle = zeros(size(Fsx));

% Direction relative to 0 degrees
for i = 1:length(Fsx)

   if Fsy(i) >= 0 % Q1 and Q2
       Fs_angle(i) = acosd( Fsx(i) / Fs(i) );
       
   else % Q3 and Q4
       Fs_angle(i) = 360 - acosd( Fsx(i) / Fs(i) );

   end
    
end

end