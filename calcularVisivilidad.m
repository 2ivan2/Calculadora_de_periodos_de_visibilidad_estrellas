function [inferior_1,superior_1, inferior_2, superior_2] = calcularVisivilidad(TSidereoOrtoSol, TSidereoOcasoSol, TSidereoOrtoObj, TSidereoOcasoObj, alpha_sol)
    %Se devuelven los angulos horarios
    tiempos = [TSidereoOrtoObj TSidereoOcasoObj TSidereoOrtoSol TSidereoOcasoSol];
    [~, indices] = sort(tiempos);
    %Ponemos el primero el orto del objeto observado en los indices para
    %simplificar el número de casos a tratar
    i = 1; inferior_2 = -1; superior_2 = -1;
    while i <= 4
        if indices(i)==1
            patron = [indices(i:4) indices(1:i - 1)];
            break;
        end
        i = i+1;
    end
    if isequal(patron, [1 2 3 4])
        inferior_1 = mod(TSidereoOrtoObj - alpha_sol, 360);
        superior_1 = mod(TSidereoOcasoObj - alpha_sol, 360);
    elseif isequal(patron, [1 2 4 3])
        inferior_1 = -1;
        superior_1 = -1;
    elseif isequal(patron, [1 3 2 4])
        inferior_1 = mod(TSidereoOrtoObj - alpha_sol,360);
        superior_1 = mod(TSidereoOrtoSol - alpha_sol, 360);
    elseif isequal(patron, [1 3 4 2])
        inferior_1 = mod(TSidereoOrtoObj - alpha_sol, 360);
        superior_1 = mod(TSidereoOrtoSol - alpha_sol, 360);
        inferior_2 = mod(TSidereoOcasoSol - alpha_sol, 360);
        superior_2 = mod(TSidereoOcasoObj - alpha_sol, 360);
    elseif isequal(patron, [1 4 2 3])
        inferior_1 = mod(TSidereoOcasoSol- alpha_sol, 360);
        superior_1 = mod(TSidereoOcasoObj - alpha_sol, 360);
    elseif isequal(patron, [1 4 3 2])
        inferior_1 = mod(TSidereoOcasoSol - alpha_sol, 360);
        superior_1 = mod(TSidereoOrtoSol - alpha_sol, 360);
    end
end

