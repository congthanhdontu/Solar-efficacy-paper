[num, ~, ~] = xlsread('Regression_data_Zhang.xlsx');
datalength = length(num);

CC = num(1:datalength, 1);
altitude = num(1:datalength, 2);
temp = num(1:datalength, 3);
RH = num(1:datalength, 4);
WS = num(1:datalength, 5);

c0 = 5.81;
c1 = 5.17;
c2 = -7.05;
c3 = 0.11;
c4 = -0.03;
c5 = 0.03;
d = -185.84;
k_coefficient = 8.79;

I_gh = (1355 .* sin(pi/180.*altitude) .* (c0 + c1.*CC + c2.*CC.^2 + c3.*temp + c4.*RH + c5.*WS) + d) ./ k_coefficient;