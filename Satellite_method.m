Location = 'Taipei_Result_v4.xlsx';
[num,~,~] = xlsread(Location);

Latitude = 25.04;                                                          
LongitudeSTD = 8*15;                                                       
LongitudeLOC = 121.507;                                                   
elevation = 5;

data_length = length(num);
Y = num(1:data_length, 1);
M = num(1:data_length, 2);
D = num(1:data_length, 3);
H = num(1:data_length, 4);
CI = num(1:data_length, 9);

Y_2018 = Y(Y==2018);
M_2018 = M(Y==2018);
D_2018 = D(Y==2018);
H_2018 = H(Y==2018);
Y_2019 = Y(Y==2019);
M_2019 = M(Y==2019);
D_2019 = D(Y==2019);
H_2019 = H(Y==2019);

data_number_2018 = datenum(Y_2018, M_2018, D_2018);
data_number_2018f = datenum(2018, 12, 31);
data_time_2018 = (1-yearfrac(data_number_2018, data_number_2018f, 3)) .* 8760 + H_2018 - 24;
data_time_2018 = round(data_time_2018);
data_number_2019 = datenum(Y_2019, M_2019, D_2019);
data_number_2019f = datenum(2019, 12, 31);
data_time_2019 = (1-yearfrac(data_number_2019, data_number_2019f, 3)) .* 8760 + H_2019 - 24;
data_time_2019 = round(data_time_2019);

data_length_2018 = length(Y_2018);
data_length_2019 = length(Y_2019);

i_2018 = 2 * pi .* data_time_2018 ./ 365;
i_2019 = 2 * pi .* data_time_2019 ./ 365;

I_etrn_2019 = ones(data_length_2019, 1) .* 1367 .* (1.00011 + 0.034221 * cos(i_2019) + 0.00128 * sin(i_2019) ...
    + 0.000719 * cos(2*i_2019) + 0.000077 * sin(2*i_2019));                                 %extraterrestrial radiation normal to the sun (W/m^2)

I_etrn_2018 = ones(data_length_2018, 1) .* 1367 .* (1.00011 + 0.034221 * cos(i_2018) + 0.00128 * sin(i_2018) ...
    + 0.000719 * cos(2*i_2018) + 0.000077 * sin(2*i_2018));                                 %extraterrestrial radiation normal to the sun (W/m^2)

%% Solar altitude angle
n_2019 = ceil(data_time_2019/24);
tloc_2019 = rem(data_time_2019, 24);
tloc_2019(tloc_2019==0) = 24;
B_2019 = 360.*((n_2019-81)./364).*pi./180;
Et_2019 = 9.87.*sin(2.*B_2019)-7.53.*cos(B_2019)-1.5.*sin(B_2019);
tsol_2019 = tloc_2019-(LongitudeSTD-LongitudeLOC)./15+Et_2019./60;
omega_2019 = (tsol_2019-12).*15;
delta_2019 = 23.45*sin(pi/180.*360*(284+n_2019)/365);
altitude_2019 = 180/pi.*(asin(cos(pi/180.*Latitude).*cos(pi/180.*delta_2019).*cos(pi/180.*omega_2019)...
    +sin(pi/180.*Latitude).*sin(pi/180.*delta_2019)));
altitude_2019(altitude_2019<2,:) = 0;
zenith_2019 = 90-altitude_2019;
I_etrn_2019(altitude_2019<2,:) = 0;

n_2018 = ceil(data_time_2018/24);
tloc_2018 = rem(data_time_2018, 24);
tloc_2018(tloc_2018==0) = 24;
B_2018 = 360.*((n_2018-81)./364).*pi./180;
Et_2018 = 9.87.*sin(2.*B_2018)-7.53.*cos(B_2018)-1.5.*sin(B_2018);
tsol_2018 = tloc_2018-(LongitudeSTD-LongitudeLOC)./15+Et_2018./60;
omega_2018 = (tsol_2018-12).*15;
delta_2018 = 23.45*sin(pi/180.*360*(284+n_2018)/365);
altitude_2018 = 180/pi.*(asin(cos(pi/180.*Latitude).*cos(pi/180.*delta_2018).*cos(pi/180.*omega_2018)...
    +sin(pi/180.*Latitude).*sin(pi/180.*delta_2018)));
altitude_2018(altitude_2018<2,:) = 0;
zenith_2018 = 90-altitude_2018;
I_etrn_2018(altitude_2018<2,:) = 0;

altitude = [altitude_2018; altitude_2019];
I_etrn = [I_etrn_2018; I_etrn_2019];
zenith = [zenith_2018; zenith_2019];
data_time = [data_time_2018; data_time_2019];

%% Calculate global horizontal irradiance
m0 = (sin(pi/180.*altitude) + 0.50572.*(altitude+6.07995).^(-1.6364)).^(-1);
m = m0.*exp(-0.0001184.*elevation);                                        % Air mass

fh1 = exp(-elevation/8000);
fh2 = exp(-elevation/1250);
cg1 = 0.0000509*elevation+0.868;
cg2 = 0.0000392*elevation+0.0387;

ghcnew_9 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(5.5-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_9((data_time<5838)|(data_time>6545)) = [];

ghcnew_10 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(4.3-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_10((data_time<6558)|(data_time>7289)) = [];

ghcnew_11 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(3.7-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_11((data_time<7302)|(data_time>8009)) = [];

ghcnew_12 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(3.6-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_12((data_time<8023)|(data_time>8753)) = [];

ghcnew_1 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(3.8-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_1((data_time<7)|(data_time>737)) = [];

ghcnew_2 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(4.2-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_2((data_time<751)|(data_time>1410)) = [];

ghcnew_3 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(4.8-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_3((data_time<1423)|(data_time>2154)) = [];

ghcnew_4 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(5.2-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_4((data_time<2166)|(data_time>2874)) = [];

ghcnew_5 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(5.4-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_5((data_time<2886)|(data_time>3618)) = [];

ghcnew_6 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(6.4-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_6((data_time<3629)|(data_time>4338)) = [];

ghcnew_7 = cg1.*I_etrn.*cos(pi/180.*zenith)...
    .*exp(-cg2.*m.*(fh1+fh2.*(6.3-1))).*exp(0.01.*m.^1.8);                 % Clear-sky global irradiance
ghcnew_7((data_time<4350)|(data_time>4832)) = [];

ghcnew = [ghcnew_9;ghcnew_10;ghcnew_11;ghcnew_12;ghcnew_1;ghcnew_2;ghcnew_3;ghcnew_4;ghcnew_5;ghcnew_6;ghcnew_7];
ktm = 2.36*CI.^5-6.2*CI.^4+6.22*CI.^3-2.63*CI.^2-0.58*CI+1;
I_gh = ktm.*ghcnew.*(0.0001.*ktm.*ghcnew+0.9);
I_gh(isnan(I_gh)) = 0;

