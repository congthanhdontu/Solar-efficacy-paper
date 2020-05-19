function F = myfun_SUNY(x,data)
CI = data(1, :);
ghcnew = data(2, :);
F = (x(1).*CI.^5 + x(2).*CI.^4 + x(3).*CI.^3 + x(4).*CI.^2 + x(5).*CI + 1) .* ghcnew .* (0.0001 .* (x(1).*CI.^5 + x(2).*CI.^4 + x(3).*CI.^3 + x(4).*CI.^2 + x(5).*CI + 1) .* ghcnew + 0.9);
end
