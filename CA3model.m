% Chromatic Acclimation Model
% Modified from Stomp et al 2008 by R. Lovindeer & F. Primeau

%% Description of Constants & Variables
% L, loss rate (/h)
% zm, water column depth (cm)
% pmax, species max specific growth rate (/h)
% phi, photosynthetic efficiency (cells/umol)
% alpha_color, acclimation parameter to a color (dimensionless)
% Kbg (/cm) = (log(In.white)-log(Out.white))/3; % (/cm)

%% Initial & Calculated Values
load('CA3MODEL.mat')

v = 0.5; %<- UPDATE to start at opposite color, 0.01 green, 0.90 red
data.light = data.In.green;
Nv0 = [10E6;10E6;10E6;v]; %population density cells/cm^3 of G, R & flex pico, v
nz = 6;
data.k = k;
data.kbg = kbg;
data.In = In;
data.zm = zm;
data.L = L/(60*60);         %converted to /s
data.pmax = pmax/(60*60);   %converted to /s
data.phi_fp = phi_fp;
data.phi_rp = phi_rp;
data.phi_gp = phi_gp;
data.alpha_green = alpha_green;
data.alpha_red = alpha_red;
z = linspace(0,zm,nz);
data.z = z;
tspan = [0,(60*60*24*50)]; % timespan of model in seconds

[T,Nv] = ode45(@(t,Nv) dNvdt(t,Nv,data),tspan,Nv0);

N = Nv(:,1:3);              %number density 
Td = T/(60*60*24);          %converts time to days

Abs = A(Nv,data);           %converts N to total light absorption per cm, A

figure(1)
plot(Td,N,'LineWidth',3)
legend('green pico','red pico','flexible pico')
title('Continuous green light')
xlabel('Time, days')
ylabel('Cell density, cells/cm^3')

figure(2) 
plot(Td,Abs,'LineWidth',3)
legend('green pico','red pico','flexible pico')
title('Continuous green light')
xlabel('Time, days')
ylabel('Total light absorption per cm')

figure(3)
plot(Td,Nv(:,4),'LineWidth',3)
title('v - chromatic acclimation parameter')
