function output = Hocaso(phi,delta)
%Calcula el �ngulo horario del ocaso de un objeto dada su declinaci�n, y la
%latitud del observatorio.
%Output en grados.
output = acosd(-tand(phi) * tand(delta));
end
