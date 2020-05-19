function F = myfun_Zhang(x,data)
CC = data(1, :);
altitude = data(2, :);
temp = data(3, :);
RH = data(4, :);
WS = data(5, :);
F = (1355 .* sin(pi/180.*altitude) .* (x(1) + x(2).*CC + x(3).*CC.^2 + x(4).*temp + x(5).*RH + x(6).*WS) + x(7)) ./ x(8);
end
