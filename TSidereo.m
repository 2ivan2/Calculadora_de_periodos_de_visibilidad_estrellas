function output = TSidereo(H, alpha)
%Tiempo sidereo
%Output en grados.
output = mod(H + alpha, 360);
end
