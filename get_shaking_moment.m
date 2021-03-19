function Ms = get_shaking_moment(F41x, F41y, M21, r1, r4)

%{

The following function will calculate the shaking moment with respect to the wall. 

Input: F41x, F41y, M21, r1, r4

Output: Ms

%}

% Convert to meters from cm
r1 = r1/100;
r4 = r4/100;

Ms = M21 - (F41x * r4) - (F41y * r1);

end