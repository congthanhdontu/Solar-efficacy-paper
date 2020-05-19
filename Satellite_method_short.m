Location = 'Taipei_Result_v4.xlsx';
[num,~,~] = xlsread(Location);

Latitude = 25.04;                                                          
LongitudeSTD = 8*15;                                                       
LongitudeLOC = 121.507;                                                   
elevation = 5;

data_length = length(num);
month = num(1:data_length, 2);
CI = num(1:data_length, 8);
CI(CI<0) = 0;
m = num(1:data_length, 11);
zenith = num(1:data_length, 13);
I_etrn = num(1:data_length, 14);

fh1 = exp(-elevation/8000);
fh2 = exp(-elevation/1250);
cg1 = 0.0000509*elevation+0.868;
cg2 = 0.0000392*elevation+0.0387;

ghcnew_9 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(5.5-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_9(month~=9) = [];

ghcnew_10 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(4.3-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_10(month~=10) = [];

ghcnew_11 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(3.7-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_11(month~=11) = [];

ghcnew_12 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(3.6-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_12(month~=12) = [];

ghcnew_1 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(3.8-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_1(month~=1) = [];

ghcnew_2 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(4.2-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_2(month~=2) = [];

ghcnew_3 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(4.8-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_3(month~=3) = [];

ghcnew_4 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(5.2-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_4(month~=4) = [];

ghcnew_5 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(5.4-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_5(month~=5) = [];

ghcnew_6 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(6.4-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_6(month~=6) = [];

ghcnew_7 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(6.3-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_7(month~=7) = [];

ghcnew = [ghcnew_9;ghcnew_10;ghcnew_11;ghcnew_12;ghcnew_1;ghcnew_2;ghcnew_3;ghcnew_4;ghcnew_5;ghcnew_6;ghcnew_7];
ktm = 2.36*CI.^5-6.2*CI.^4+6.22*CI.^3-2.63*CI.^2-0.58*CI+1;
I_gh = ktm.*ghcnew.*(0.0001.*ktm.*ghcnew+0.9);
I_gh(isnan(I_gh)) = 0;

