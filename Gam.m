function [x,y] = Gam(Irradiance,data)
% [x,y] = Gam(Irradiance,data)
    
integrals = 0.0001*[data.k(:,1:5)].'*Irradiance; %converted to cm^2 for cancelation
x = integrals(1:2,:); % fixed picos
y = integrals(3:5,:); % components of flex pico
end