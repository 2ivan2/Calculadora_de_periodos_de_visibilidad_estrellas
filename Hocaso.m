function output = Hocaso(phi,delta)
%Calcula el ángulo horario del ocaso de un objeto dada su declinación, y la
%latitud del observatorio.
%Output en grados.
output = acosd(-tand(phi) * tand(delta));
end
