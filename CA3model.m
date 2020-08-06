% Chromatic Acclimation Model
% Modified from Stomp et al 2008 by R. Lovindeer & F. Primeau

%% Description of Constants & Variables
% L, loss rate (/h)
% zm, max depth (cm)
% pmax, max specific growth rate (/h)
% phi, photosynthetic efficiency (cells/umol)
% alpha_color, acclimation to color (dimensionless)
% Kbg, background absorption (/cm), calculated ...
    %(log(In.white)-log(Out.white))/3;

%% Initial & Calculated Values
load('CA3MODEL.mat')

data.light = data.In.green;
Nv0 = [10E6;10E6;10E6;0.5]; % cells/cm^3 [G,R,flex pico, v0.01g, 0.9r]
data.nz = 6;
data.L = data.L/(60*60);         % converted to /s
data.pmax = data.pmax/(60*60);   % converted to /s
data.z = linspace(0,data.zm,data.nz);
tspan = [0,(60*60*24*50)]; % model span, seconds

[T,Nv] = ode45(@(t,Nv) dNvdt(t,Nv,data),tspan,Nv0);

N = Nv(:,1:3);              % number density 
Td = T/(60*60*24);          % seconds to days

Abs = A(Nv,data);           % absorption per cm

figure(1)
plot(Td,N,'LineWidth',3)
legend('green pico','red pico','flexible pico')
title('Density in continuous light')
xlabel('Time, days')
ylabel('Cell density, cells cm^-3')

figure(2) 
plot(Td,Abs,'LineWidth',3)
legend('green pico','red pico','flexible pico')
title('Absorption in continuous light')
xlabel('Time, days')
ylabel('Absorption, cm^-1')

figure(3)
plot(Td,Nv(:,4),'LineWidth',3)
title('v - chromatic acclimation parameter')
