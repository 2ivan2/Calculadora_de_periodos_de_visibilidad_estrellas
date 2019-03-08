function [alpha_sol,delta_sol] = posicionEcuatorialHorariaSol(fecha_inicio)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
epsilon = 23.5;

x = datenum(fecha_inicio) - datenum(fecha_inicio.Year, 3, 21);
if x < 0
   x = datenum(fecha_inicio) - datenum(fecha_inicio.Year - 1, 3, 21);
end
lambda = (360 / 365.25) * x;
delta_sol = asind(sind(epsilon) * sind(lambda));

alpha_sol = acosd(cosd(lambda) / cosd(delta_sol));
%Calculamos alpha para que este en el cuadrante adecuado (en el mismo que lambda)
if lambda > 180
    alpha_sol = 360 - alpha_sol;
end
end

