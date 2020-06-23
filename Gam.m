function [x,y] = Gam(Irradiance,data)
% [x,y] = Gam(Irradiance,data)

kgp = data.k.gp; %light absorption k, by green pico, gp...
krp = data.k.rp;
kpe = data.k.pe;
kpc = data.k.pc;
kchl = data.k.chl;
    
integrals = 0.0001*[kgp,krp,kpe,kpc,kchl].'*Irradiance; %converted to cm^2 for cancelation
x = integrals(1:2,:); % fixed picos
y = integrals(3:5,:); % components of flex pico
 
end