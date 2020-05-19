[num, ~, ~] = xlsread('Regression_data_Zhang.xlsx');
datalength = length(num);

CC = num(1:datalength, 1);
altitude = num(1:datalength, 2);
temp = num(1:datalength, 3);
RH = num(1:datalength, 4);
WS = num(1:datalength, 5);
I = num(1:datalength, 6);

zdata = I'; % Measurement
data = [CC'; altitude'; temp'; RH'; WS'];
a0 =  [0.5598, 0.4982, -0.6762, 0.02842, -0.00317, 0.014, -17.853, 0.843];      % Starting guess
% The function you want to fit, a0=initial guess, data=inputs, the correct
% data
[a,resnorm] = lsqcurvefit(@myfun_Zhang, a0, data, zdata);