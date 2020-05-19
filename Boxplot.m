[num, ~, ~] = xlsread('TP_Regression_SUNY.xlsx');
datalength = length(num);

I = num(1:datalength, 13);
I_estimation = num(1:datalength, 14);

error = (I_estimation - I) ./ I;
error_200 = error;
error_200(I<50|I>200) = [];
error_400 = error;
error_400(I<200|I>400) = [];
error_600 = error;
error_600(I<400|I>600) = [];
error_800 = error;
error_800(I<600|I>800) = [];
error_1000 = error;
error_1000(I<800|I>1000) = [];