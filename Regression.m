[num, ~, ~] = xlsread('Regression_data.xlsx');
datalength = length(num);

CI = num(1:datalength, 1);
ghcnew = num(1:datalength, 2);
I = num(1:datalength, 4);

zdata = I'; % Measurement
data = [CI'; ghcnew';];
a0 =  [2.36, -6.2, 6.22, -2.63, -0.58, 1];      % Starting guess
% The function you want to fit, a0=initial guess, data=inputs, the correct
% data
[a,resnorm] = lsqcurvefit(@myfun_SUNY, a0, data,zdata);