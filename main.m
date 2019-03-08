clear;
%---------------------------------------------------------------------
%Tipo = 1 indica mirar a una fecha, tipo = 2 un rango de fechas
tipo = 1;

%---------------------------------------------------------------------
%Fechas de inicio validas para tipo=1 y tipo=2
fecha_inicio = datetime(2018, 12, 21);
%Fechas de fin validas para tipo=2
fecha_fin = datetime(2019, 12, 21);

%---------------------------------------------------------------------
%Datos sobre el objeto que se quiere observar:
alpha = 187.2779153; %Ascensión recta del objeto que desea observar
delta = 2.052388568; %Declinación del objeto que desea observar

%---------------------------------------------------------------------
%Datos sobre el observatorio desde donde se realiza la observación:
phi = 20.7075; %Latitud geográfica del observatorio
lambda = -156.2560; %Longitud geográfica del observatorio

%---------------------------------------------------------------------
titulo = strcat("Visibilidad en Haleakala entre el ", datestr(fecha_inicio), " y el ", datestr(fecha_fin));
if tipo==1
    fecha_fin = fecha_inicio;
    titulo = strcat("Visibilidad en Haleakala el ", datestr(fecha_inicio));
end

X = fecha_inicio-1;
Y = [0 0 0 0 0 0 0];

for i = 0:datenum(fecha_fin) - datenum(fecha_inicio)
    fecha_aux = fecha_inicio + i;
    %i1 es el limite inferior y s1 el superior del posible primer intervalo
    %observado, y i2 y s2 lo mismo para un posible segundo intervalo
    %observado. Esto ocurrira, por ejemplo cuando el intervalo del orto y
    %ocaso del objeto a observar incluyan al del orto y ocaso del sol.
    [i1, s1, i2, s2] = AngulosHorariosYTSidereos(fecha_aux, phi, lambda, delta, alpha);
    X = [X fecha_aux];
    
    %Debido a la simplificacion que hicimos en la funcion calculo de
    %visibilidad tendremos que tener en cuenta donde cae el cero, para
    %que se pueda plotear de la manera correcta.
    if i2 == -1
        %Dos casos según donde caiga el cero
        if i1 > s1
            Y = [Y; 0 s1 i1-s1 24-i1 0 0 0];
        else
            Y = [Y; i1 s1-i1 24-s1 0 0 0 0];
        end
    else
        %Tres casos según donde caiga el cero
        if i1 > s1
            Y = [Y; 0 s1 i2-s1 s2-i2 i1-s2 24-i1 0];
        elseif s1 > i2
              Y = [Y; i2 s2-i2 i1-s2 s1-i1 24-s1 0 0];
        elseif i2 > s2
            Y = [Y; 0 s2 i1-s2 s1-i1 i2-s1 24-i2 0];
        else    %Caso en el que estan bien colocados
            Y = [Y; i1 s1-i1 i2-s1 s2-i2 24-s2 0 0];
        end
    end
end

X = [X fecha_fin+1];
Y = [Y;0 0 0 0 0 0 0];

a = bar(X,Y,'stack','FaceColor','r');
title(titulo);
legend("Periodo no visible", "Periodo visible");
ylabel("Hora (TU)");
xlabel("Fecha (Dia-Mes-Año)");
ylim([0 24])
xlim([fecha_inicio-1 fecha_fin+1])

%Modificamos los colores del bar
for i = 1:7
    if mod(i,2)==0
    a(i).FaceColor = "g";
    else
        a(i).FaceColor = "black";
    end
end