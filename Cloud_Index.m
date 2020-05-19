myFiles = dir(fullfile('Notfun','*.png'));
Sat = ones(1, 1);
Sat_length = 0;

%% Convert Photos to Pixels
for k = 1:length(myFiles)
  if myFiles(k).bytes >= 100000
      Sat_length = Sat_length + 1;
      baseFileName = myFiles(k).name;
      Sat(Sat_length, 1) = str2double(baseFileName(1:4)); % Year
      Sat(Sat_length, 2) = str2double(baseFileName(5:6)); % Month
      Sat(Sat_length, 3) = str2double(baseFileName(7:8)); % Day
      Sat(Sat_length, 4) = str2double(baseFileName(10:11)); % Hour
      Sat(Sat_length, 5) = str2double(baseFileName(12:13)); % Minute
      sat_image = imread(fullfile('Notfun', baseFileName));
      sat_image = imcrop(sat_image, [351 139 6 6]);                      
      [rows, columns, color_channels] = size(sat_image);                    
      if color_channels > 1
          gray_image = rgb2gray(sat_image);
      else
          gray_image = sat_image;
      end
      gray_image = double(gray_image);
      t = 0;
      total = 0;
      for t1 = 1:7
          for t2 = 1:7
              t = t + 1;
              total = total + gray_image(t1, t2);
          end
      end
      Sat(Sat_length, 6) = total / t;      
  end
end

%% Derive cloud index
Latitude = 25.04;                                                          
LongitudeSTD = 8*15;                                                       
LongitudeLOC = 121.507;                                                   
elevation = 5;

Y = Sat(1:Sat_length, 1);
M = Sat(1:Sat_length, 2);
D = Sat(1:Sat_length, 3);
H = Sat(1:Sat_length, 4);
norpix = Sat(1:Sat_length, 6);

% The first normalization using altitude angle
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
data_time_2018 = (1 - yearfrac(data_number_2018, data_number_2018f, 3)) .* 8760 + H_2018 - 24;
data_time_2018 = round(data_time_2018);
data_number_2019 = datenum(Y_2019, M_2019, D_2019);
data_number_2019f = datenum(2019, 12, 31);
data_time_2019 = (1 - yearfrac(data_number_2019, data_number_2019f, 3)) .* 8760 + H_2019 - 24;
data_time_2019 = round(data_time_2019);

data_length_2018 = length(Y_2018);
data_length_2019 = length(Y_2019);

n_2019 = ceil(data_time_2019 / 24);
tloc_2019 = rem(data_time_2019, 24);
tloc_2019(tloc_2019==0) = 24;
B_2019 = 360 .* ((n_2019 - 81) ./ 364) .* pi ./ 180;
Et_2019 = 9.87 .* sin(2 .* B_2019) - 7.53 .* cos(B_2019) - 1.5 .* sin(B_2019);
tsol_2019 = tloc_2019 - (LongitudeSTD - LongitudeLOC) ./ 15 + Et_2019 ./ 60;
omega_2019 = (tsol_2019 - 12) .* 15;
delta_2019 = 23.45 * sin(pi / 180 .* 360 * (284 + n_2019) / 365);
altitude_2019 = 180/pi.*(asin(cos(pi/180.*Latitude).*cos(pi/180.*delta_2019).*cos(pi/180.*omega_2019)...
    +sin(pi/180.*Latitude).*sin(pi/180.*delta_2019)));
altitude_2019(altitude_2019<5, :) = 0;

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
altitude_2018(altitude_2018<5, :) = 0;
altitude = [altitude_2018; altitude_2019];
norpix_1 = norpix ./ sin(pi/180.*altitude);

% The second normalization
norpix_2018_09 = norpix_1((Y==2018)&(M==9));
data_time_2018_09 = data_time_2018(M_2018==9);
data_Everymonth = [norpix_2018_09, data_time_2018_09];
CI_2018_09 = Everymonth(data_Everymonth);

norpix_2018_10 = norpix_1((Y==2018)&(M==10));
data_time_2018_10 = data_time_2018(M_2018==10);
data_Everymonth = [norpix_2018_10, data_time_2018_10];
CI_2018_10 = Everymonth(data_Everymonth);

norpix_2018_11 = norpix_1((Y==2018)&(M==11));
data_time_2018_11 = data_time_2018(M_2018==11);
data_Everymonth = [norpix_2018_11, data_time_2018_11];
CI_2018_11 = Everymonth(data_Everymonth);

norpix_2018_12 = norpix_1((Y==2018)&(M==12));
data_time_2018_12 = data_time_2018(M_2018==12);
data_Everymonth = [norpix_2018_12, data_time_2018_12];
CI_2018_12 = Everymonth(data_Everymonth);

norpix_2019_01 = norpix_1((Y==2019)&(M==1));
data_time_2019_01 = data_time_2019(M_2019==1);
data_Everymonth = [norpix_2019_01, data_time_2019_01];
CI_2019_01 = Everymonth(data_Everymonth);

norpix_2019_02 = norpix_1((Y==2019)&(M==2));
data_time_2019_02 = data_time_2019(M_2019==2);
data_Everymonth = [norpix_2019_02, data_time_2019_02];
CI_2019_02 = Everymonth(data_Everymonth);

norpix_2019_03 = norpix_1((Y==2019)&(M==3));
data_time_2019_03 = data_time_2019(M_2019==3);
data_Everymonth = [norpix_2019_03, data_time_2019_03];
CI_2019_03 = Everymonth(data_Everymonth);

norpix_2019_04 = norpix_1((Y==2019)&(M==4));
data_time_2019_04 = data_time_2019(M_2019==4);
data_Everymonth = [norpix_2019_04, data_time_2019_04];
CI_2019_04 = Everymonth(data_Everymonth);

norpix_2019_05 = norpix_1((Y==2019)&(M==5));
data_time_2019_05 = data_time_2019(M_2019==5);
data_Everymonth = [norpix_2019_05, data_time_2019_05];
CI_2019_05 = Everymonth(data_Everymonth);

norpix_2019_06 = norpix_1((Y==2019)&(M==6));
data_time_2019_06 = data_time_2019(M_2019==6);
data_Everymonth = [norpix_2019_06, data_time_2019_06];
CI_2019_06 = Everymonth(data_Everymonth);

norpix_2019_07 = norpix_1((Y==2019)&(M==7));
data_time_2019_07 = data_time_2019(M_2019==7);
data_Everymonth = [norpix_2019_07, data_time_2019_07];
CI_2019_07 = Everymonth(data_Everymonth);
