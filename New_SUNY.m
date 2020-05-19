[num, ~, ~] = xlsread('Regression_data.xlsx');
datalength = length(num);

CI = num(1:datalength, 1);
ghcnew = num(1:datalength, 2);

a1 = -4.52;
a2 = 12.56;
a3 = -12.89;
a4 = 5.93;
a5 = -2;
a6 = 1;

ktm = a1.*CI.^5 + a2.*CI.^4 + a3.*CI.^3 + a4.*CI.^2 + a5.*CI + a6;
I = ktm .* ghcnew .* (0.0001 .* ktm .* ghcnew + 0.9);