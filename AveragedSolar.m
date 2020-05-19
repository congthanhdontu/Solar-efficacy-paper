clear all

[num_measurement,~,~] = xlsread('1-Year_Measurement.xlsx');
datalength_measurement = length(num_measurement);

Y_0 = num_measurement(1:datalength_measurement, 1);
M_0 = num_measurement(1:datalength_measurement, 2);
D_0 = num_measurement(1:datalength_measurement, 3);
H_0 = num_measurement(1:datalength_measurement, 4);
Minute_0 = num_measurement(1:datalength_measurement, 5);
I_gh_0 = num_measurement(1:datalength_measurement, 6);
I_gh_1 = num_measurement(1:datalength_measurement, 6);
I_gh_0(I_gh_0<0) = 0;

Y_0(I_gh_1>2000) = [];
M_0(I_gh_1>2000) = [];
D_0(I_gh_1>2000) = [];
H_0(I_gh_1>2000) = [];
Minute_0(I_gh_1>2000) = [];
I_gh_0(I_gh_1>2000) = [];
datalength_measurement = length(I_gh_0);
Y_measurement = ones(1, 1);
M_measurement = ones(1, 1);
D_measurement = ones(1, 1);
H_measurement = ones(1, 1);
Minute_measurement = ones(1, 1);
I_gh_measurement = ones(1, 1);
k = 0;
for i = 1:datalength_measurement
    if (Minute_0(i, 1) == 0) && (i > 59)
        count = 0;
        total = 0;
        for j = (i-10):(i+10)
            count = count + 1;
            total = total + I_gh_0(j, 1);
        end
        average = total / count;
        k = k + 1;
        Y_measurement(k, 1) = Y_0(i, 1);
        M_measurement(k, 1) = M_0(i, 1);
        D_measurement(k, 1) = D_0(i, 1);
        H_measurement(k, 1) = H_0(i, 1);
        Minute_measurement(k, 1) = Minute_0(i, 1);
        I_gh_measurement(k, 1) = average;      
    end
end