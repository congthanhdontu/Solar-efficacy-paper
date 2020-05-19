[num_est, ~, ~] = xlsread('Taipei_estimation.xlsx');
[num_mea, ~, ~] = xlsread('Taipei_measurement.xlsx');
[num_zhang, ~, ~] = xlsread('Taipei_Zhang_estimation.xlsx');

datalength_est = length(num_est);
datalength_mea = length(num_mea);
datalength_zhang = length(num_zhang);

Y_est = num_est(1:datalength_est, 1);
M_est = num_est(1:datalength_est, 2);
D_est = num_est(1:datalength_est, 3);
H_est = num_est(1:datalength_est, 4);
Minute_est = ones(datalength_est, 1);
Minute_est = Minute_est - 1;
pixel = num_est(1:datalength_est, 5);
CI = num_est(1:datalength_est, 6);
airmass = num_est(1:datalength_est, 7);
altitude = num_est(1:datalength_est, 8);
zenith = num_est(1:datalength_est, 9);
I_etrn = num_est(1:datalength_est, 10);
I_gh_est = num_est(1:datalength_est, 11);
nor_pixel = num_est(1:datalength_est, 12);
CI_nor_est = num_est(1:datalength_est, 13);
I_gh_nor_est = num_est(1:datalength_est, 14);
ghcnew = num_est(1:datalength_est, 15);

Y_mea = num_mea(1:datalength_mea, 1);
M_mea = num_mea(1:datalength_mea, 2);
D_mea = num_mea(1:datalength_mea, 3);
H_mea = num_mea(1:datalength_mea, 4);
Minute_mea = num_mea(1:datalength_mea, 5);
I_gh_mea = num_mea(1:datalength_mea, 6);

Y_zhang = num_zhang(1:datalength_zhang, 1);
M_zhang = num_zhang(1:datalength_zhang, 2);
D_zhang = num_zhang(1:datalength_zhang, 3);
H_zhang = num_zhang(1:datalength_zhang, 4);
Minute_zhang = ones(datalength_zhang, 1);
Minute_zhang = Minute_zhang - 1;
temp = num_zhang(1:datalength_zhang, 5);
RH = num_zhang(1:datalength_zhang, 6);
WS = num_zhang(1:datalength_zhang, 7);
CC = num_zhang(1:datalength_zhang, 8);
I_gh_zhang = num_zhang(1:datalength_zhang, 10);

file_est = table(Y_est, M_est, D_est, H_est, Minute_est, pixel, CI, airmass, altitude, zenith, I_etrn, I_gh_est, nor_pixel, CI_nor_est, I_gh_nor_est, ghcnew, ...
             'VariableNames', {'Year', 'Month', 'Day', 'Hour', 'Minute', 'Pixel', 'Cloud_Index', 'Airmass', 'Altitude', 'Zenith', 'I_etrn', 'I_gh_estimation', 'nor_pixel', 'Cloud_Index_Normalized', 'I_gh_estimation_normalized', 'ghcnew'});
file_mea = table(Y_mea, M_mea, D_mea, H_mea, Minute_mea, I_gh_mea,  ...
             'VariableNames', {'Year', 'Month', 'Day', 'Hour', 'Minute', 'I_gh_measurement'});
file_zhang = table(Y_zhang, M_zhang, D_zhang, H_zhang, Minute_zhang, temp, RH, WS, CC, I_gh_zhang, ...
             'VariableNames', {'Year', 'Month', 'Day', 'Hour', 'Minute', 'Temp', 'RH', 'WS', 'CC', 'I_gh_zhang'});
[est_mea, ia, ib] = innerjoin(file_est, file_mea);
[time_matching, ic, id] = innerjoin(est_mea, file_zhang);