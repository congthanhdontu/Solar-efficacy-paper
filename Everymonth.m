function F = Everymonth(data)
norpix_Everymonth = data(:, 1);
data_time = data(:, 2);
data_length = length(norpix_Everymonth);

six = norpix_Everymonth((rem(data_time,24)<=6)&(rem(data_time,24)>=5.5));
seven = norpix_Everymonth((rem(data_time,24)<=7)&(rem(data_time,24)>=6.5));
eight = norpix_Everymonth((rem(data_time,24)<=8)&(rem(data_time,24)>=7.5));
nine = norpix_Everymonth((rem(data_time,24)<=9)&(rem(data_time,24)>=8.5));
ten = norpix_Everymonth((rem(data_time,24)<=10)&(rem(data_time,24)>=9.5));
eleven = norpix_Everymonth((rem(data_time,24)<=11)&(rem(data_time,24)>=10.5));
twelve = norpix_Everymonth((rem(data_time,24)<=12)&(rem(data_time,24)>=11.5));
thirteen = norpix_Everymonth((rem(data_time,24)<=13)&(rem(data_time,24)>=12.5));
fourteen = norpix_Everymonth((rem(data_time,24)<=14)&(rem(data_time,24)>=13.5));
fifteen = norpix_Everymonth((rem(data_time,24)<=15)&(rem(data_time,24)>=14.5));
sixteen = norpix_Everymonth((rem(data_time,24)<=16)&(rem(data_time,24)>=15.5));
seventeen = norpix_Everymonth((rem(data_time,24)<=17)&(rem(data_time,24)>=16.5));
eighteen = norpix_Everymonth((rem(data_time,24)<=18)&(rem(data_time,24)>=17.5));

six(isinf(six)) = min(six);
seven(isinf(seven)) = min(seven);
eight(isinf(eight)) = min(eight);
nine(isinf(nine)) = min(nine);
ten(isinf(ten)) = min(ten);
eleven(isinf(eleven)) = min(eleven);
twelve(isinf(twelve)) = min(twelve);
thirteen(isinf(thirteen)) = min(thirteen);
fourteen(isinf(fourteen)) = min(fourteen);
fifteen(isinf(fifteen)) = min(fifteen);
sixteen(isinf(sixteen)) = min(sixteen);
seventeen(isinf(seventeen)) = min(seventeen);
eighteen(isinf(eighteen)) = min(eighteen);

max_six = max(six);
min_six = min(six);
max_seven = max(seven);
min_seven = min(seven);
max_eight = max(eight);
min_eight = min(eight);
max_nine = max(nine);
min_nine = min(nine);
max_ten = max(ten);
min_ten = min(ten);
max_eleven = max(eleven);
min_eleven = min(eleven);
max_twelve = max(twelve);
min_twelve = min(twelve);
max_thirteen = max(thirteen);
min_thirteen = min(thirteen);
max_fourteen = max(fourteen);
min_fourteen = min(fourteen);
max_fifteen = max(fifteen);
min_fifteen = min(fifteen);
max_sixteen = max(sixteen);
min_sixteen = min(sixteen);
max_seventeen = max(seventeen);
min_seventeen = min(seventeen);
max_eighteen = max(eighteen);
min_eighteen = min(eighteen);

CI_max = ones(data_length,1);
CI_max = CI_max-1;
for k = 1:data_length
    if (rem(data_time(k),24)<=6)&&(rem(data_time(k),24)>=5.5)
        CI_max(k,1) = max_six;
    elseif (rem(data_time(k),24)<=7)&&(rem(data_time(k),24)>=6.5)
        CI_max(k,1) = max_seven; 
    elseif (rem(data_time(k),24)<=8)&&(rem(data_time(k),24)>=7.5)
        CI_max(k,1) = max_eight;
    elseif (rem(data_time(k),24)<=9)&&(rem(data_time(k),24)>=8.5)
        CI_max(k,1) = max_nine;
    elseif (rem(data_time(k),24)<=10)&&(rem(data_time(k),24)>=9.5)
        CI_max(k,1) = max_ten;
    elseif (rem(data_time(k),24)<=11)&&(rem(data_time(k),24)>=10.5)
        CI_max(k,1) = max_eleven;
    elseif (rem(data_time(k),24)<=12)&&(rem(data_time(k),24)>=11.5)
        CI_max(k,1) = max_twelve;
    elseif (rem(data_time(k),24)<=13)&&(rem(data_time(k),24)>=12.5)
        CI_max(k,1) = max_thirteen;  
    elseif (rem(data_time(k),24)<=14)&&(rem(data_time(k),24)>=13.5)
        CI_max(k,1) = max_fourteen;
    elseif (rem(data_time(k),24)<=15)&&(rem(data_time(k),24)>=14.5)
        CI_max(k,1) = max_fifteen;
    elseif (rem(data_time(k),24)<=16)&&(rem(data_time(k),24)>=15.5)
        CI_max(k,1) = max_sixteen;
    elseif (rem(data_time(k),24)<=17)&&(rem(data_time(k),24)>=16.5)
        CI_max(k,1) = max_seventeen;
    elseif (rem(data_time(k),24)<=18)&&(rem(data_time(k),24)>=17.5)
        CI_max(k,1) = max_eighteen;
    end
end

CI_min = ones(data_length,1);
CI_min = CI_min-1;
for k = 1:data_length
    if (rem(data_time(k),24)<=6)&&(rem(data_time(k),24)>=5.5)
        CI_min(k,1) = min_six;
    elseif (rem(data_time(k),24)<=7)&&(rem(data_time(k),24)>=6.5)
        CI_min(k,1) = min_seven;
    elseif (rem(data_time(k),24)<=8)&&(rem(data_time(k),24)>=7.5)
        CI_min(k,1) = min_eight;
    elseif (rem(data_time(k),24)<=9)&&(rem(data_time(k),24)>=8.5)
        CI_min(k,1) = min_nine;
    elseif (rem(data_time(k),24)<=10)&&(rem(data_time(k),24)>=9.5)
        CI_min(k,1) = min_ten;
    elseif (rem(data_time(k),24)<=11)&&(rem(data_time(k),24)>=10.5)
        CI_min(k,1) = min_eleven;
    elseif (rem(data_time(k),24)<=12)&&(rem(data_time(k),24)>=11.5)
        CI_min(k,1) = min_twelve;
    elseif (rem(data_time(k),24)<=13)&&(rem(data_time(k),24)>=12.5)
        CI_min(k,1) = min_thirteen;
    elseif (rem(data_time(k),24)<=14)&&(rem(data_time(k),24)>=13.5)
        CI_min(k,1) = min_fourteen;
    elseif (rem(data_time(k),24)<=15)&&(rem(data_time(k),24)>=14.5)
        CI_min(k,1) = min_fifteen;
    elseif (rem(data_time(k),24)<=16)&&(rem(data_time(k),24)>=15.5)
        CI_min(k,1) = min_sixteen;
    elseif (rem(data_time(k),24)<=17)&&(rem(data_time(k),24)>=16.5)
        CI_min(k,1) = min_seventeen;
    elseif (rem(data_time(k),24)<=18)&&(rem(data_time(k),24)>=17.5)
        CI_min(k,1) = min_eighteen;
    end
end

CI = (norpix_Everymonth-CI_min)./(CI_max-CI_min);                                     
CI(isnan(CI)) = 0;
CI(isinf(CI)) = 0;

F = CI;
end
