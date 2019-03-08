function [i1, s1, i2, s2] = AngulosHorariosYTSidereos(fecha_inicio, phi, lambda, delta, alpha)

[alpha_sol,delta_sol] = posicionEcuatorialHorariaSol(fecha_inicio);

HocSol = Hocaso(phi, delta_sol);
HorSol = Horto(HocSol);
HocObj = Hocaso(phi, delta);
HorObj = Horto(HocObj);

TSidereoOrtoSol = TSidereo(HorSol, alpha_sol);
TSidereoOcasoSol = TSidereo(HocSol, alpha_sol);
TSidereoOrtoObj = TSidereo(HorObj, alpha);
TSidereoOcasoObj = TSidereo(HocObj, alpha);

[i1, s1, i2, s2] = calcularVisivilidad(TSidereoOrtoSol, TSidereoOcasoSol, TSidereoOrtoObj, TSidereoOcasoObj, alpha_sol);
if i2 == -1
    i1 =  mod(i1 + 180 - lambda,360)*(24/360);
    s1 = mod(s1 + 180 - lambda,360)*(24/360);
else
    i1 = mod(i1 + 180 - lambda,360)*(24/360);
    s1 = mod(s1 + 180 - lambda,360)*(24/360);
    i2 = mod(i2 + 180 - lambda,360)*(24/360);
    s2 = mod(s2 + 180 - lambda,360)*(24/360);
end
end

