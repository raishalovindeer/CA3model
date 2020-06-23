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

data.In = In;
v = 0.5; % <-starting position 0.01 green, 0.90 red
data.light = data.In.green;
Nv0 = [10E6;10E6;10E6;v]; % cells/cm^3 [G,R,flex pico, v]
data.nz = 6;
data.k = k;
data.kbg = kbg;
data.zm = zm;
data.L = L/(60*60);         % converted to /s
data.pmax = pmax/(60*60);   % converted to /s
data.phi_fp = phi_fp;
data.phi_rp = phi_rp;
data.phi_gp = phi_gp;
data.alpha_green = alpha_green;
data.alpha_red = alpha_red;
z = linspace(0,zm,data.nz);
data.z = z;
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
